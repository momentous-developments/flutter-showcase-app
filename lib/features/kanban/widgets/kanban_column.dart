import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/simple_models.dart';
import '../providers/kanban_providers.dart';
import 'task_card.dart';
import 'add_task_button.dart';

class KanbanColumn extends ConsumerStatefulWidget {
  final BoardColumn column;
  final Function(ColumnUpdate) onColumnUpdate;
  final VoidCallback onColumnDelete;
  final Function(String taskId, String fromColumnId, String toColumnId, int position) onTaskMove;
  
  const KanbanColumn({
    super.key,
    required this.column,
    required this.onColumnUpdate,
    required this.onColumnDelete,
    required this.onTaskMove,
  });
  
  @override
  ConsumerState<KanbanColumn> createState() => _KanbanColumnState();
}

class _KanbanColumnState extends ConsumerState<KanbanColumn> {
  bool _isEditingTitle = false;
  late TextEditingController _titleController;
  
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.column.title);
  }
  
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final hoveredColumn = ref.watch(hoveredColumnProvider);
    final isHovered = hoveredColumn == widget.column.id;
    final hasTaskLimit = widget.column.taskLimit > 0;
    final isOverLimit = hasTaskLimit && widget.column.tasks.length > widget.column.taskLimit;
    
    return DragTarget<Task>(
      onWillAccept: (task) {
        if (task != null && task.columnId != widget.column.id) {
          ref.read(hoveredColumnProvider.notifier).state = widget.column.id;
          return true;
        }
        return false;
      },
      onLeave: (_) {
        ref.read(hoveredColumnProvider.notifier).state = null;
      },
      onAcceptWithDetails: (details) {
        final task = details.data;
        final position = _calculateDropPosition(details.offset);
        widget.onTaskMove(task.id, task.columnId, widget.column.id, position);
        ref.read(hoveredColumnProvider.notifier).state = null;
      },
      builder: (context, candidateData, rejectedData) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 320,
          decoration: BoxDecoration(
            color: widget.column.color != null
                ? Color(int.parse(widget.column.color!.replaceFirst('#', '0xFF'))).withOpacity(0.1)
                : Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHovered
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outlineVariant,
              width: isHovered ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column header
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: widget.column.color != null
                      ? Color(int.parse(widget.column.color!.replaceFirst('#', '0xFF'))).withOpacity(0.2)
                      : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _isEditingTitle
                              ? TextField(
                                  controller: _titleController,
                                  autofocus: true,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: (value) {
                                    _saveTitle();
                                  },
                                  onTapOutside: (_) {
                                    _saveTitle();
                                  },
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isEditingTitle = true;
                                    });
                                  },
                                  child: Text(
                                    widget.column.title,
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isOverLimit
                                ? Theme.of(context).colorScheme.error.withOpacity(0.2)
                                : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            widget.column.tasks.length.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isOverLimit
                                  ? Theme.of(context).colorScheme.error
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.more_horiz),
                          onSelected: (value) {
                            switch (value) {
                              case 'set_limit':
                                _showSetLimitDialog();
                                break;
                              case 'change_color':
                                _showColorPicker();
                                break;
                              case 'collapse':
                                widget.onColumnUpdate(
                                  ColumnUpdate(isCollapsed: !widget.column.isCollapsed),
                                );
                                break;
                              case 'delete':
                                widget.onColumnDelete();
                                break;
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'set_limit',
                              child: ListTile(
                                leading: Icon(Icons.format_list_numbered),
                                title: Text('Set Task Limit'),
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'change_color',
                              child: ListTile(
                                leading: Icon(Icons.color_lens),
                                title: Text('Change Color'),
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                            PopupMenuItem(
                              value: 'collapse',
                              child: ListTile(
                                leading: Icon(
                                  widget.column.isCollapsed
                                      ? Icons.expand_more
                                      : Icons.expand_less,
                                ),
                                title: Text(
                                  widget.column.isCollapsed ? 'Expand' : 'Collapse',
                                ),
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: ListTile(
                                leading: Icon(
                                  Icons.delete,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                title: Text(
                                  'Delete Column',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (hasTaskLimit) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            isOverLimit ? Icons.warning : Icons.info_outline,
                            size: 12,
                            color: isOverLimit
                                ? Theme.of(context).colorScheme.error
                                : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Limit: ${widget.column.taskLimit}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: isOverLimit
                                      ? Theme.of(context).colorScheme.error
                                      : Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              
              // Tasks
              if (!widget.column.isCollapsed) ...[
                Expanded(
                  child: ReorderableListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: widget.column.tasks.length + 1,
                    onReorder: (oldIndex, newIndex) {
                      if (oldIndex < widget.column.tasks.length && newIndex <= widget.column.tasks.length) {
                        _reorderTasks(oldIndex, newIndex);
                      }
                    },
                    itemBuilder: (context, index) {
                      if (index == widget.column.tasks.length) {
                        return AddTaskButton(
                          key: const ValueKey('add_task_button'),
                          columnId: widget.column.id,
                          onTaskAdded: () {},
                        );
                      }
                      
                      final task = widget.column.tasks[index];
                      return Padding(
                        key: ValueKey(task.id),
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TaskCard(
                          task: task,
                          onTap: () {
                            ref.read(selectedTaskProvider.notifier).selectTask(task);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ] else ...[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    '${widget.column.tasks.length} tasks',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
  
  void _saveTitle() {
    setState(() {
      _isEditingTitle = false;
    });
    if (_titleController.text.isNotEmpty && _titleController.text != widget.column.title) {
      widget.onColumnUpdate(ColumnUpdate(title: _titleController.text));
    } else {
      _titleController.text = widget.column.title;
    }
  }
  
  void _showSetLimitDialog() {
    final controller = TextEditingController(text: widget.column.taskLimit.toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Task Limit'),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Task limit (0 for no limit)',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final limit = int.tryParse(controller.text) ?? 0;
              widget.onColumnUpdate(ColumnUpdate(taskLimit: limit));
              Navigator.of(context).pop();
            },
            child: const Text('Set'),
          ),
        ],
      ),
    );
  }
  
  void _showColorPicker() {
    final colors = [
      '#E3F2FD', '#F3E5F5', '#FFF3E0', '#E8F5E9', '#E0F2F1',
      '#FFF8E1', '#FCE4EC', '#F3E5F5', '#EDE7F6', '#E8EAF6',
    ];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Column Color'),
        content: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: colors.map((color) {
            return InkWell(
              onTap: () {
                widget.onColumnUpdate(ColumnUpdate(color: color));
                Navigator.of(context).pop();
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(int.parse(color.replaceFirst('#', '0xFF'))),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: widget.column.color == color
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
                    width: widget.column.color == color ? 3 : 1,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              widget.onColumnUpdate(const ColumnUpdate(color: null));
              Navigator.of(context).pop();
            },
            child: const Text('Clear Color'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
  
  void _reorderTasks(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    
    final taskIds = widget.column.tasks.map((t) => t.id).toList();
    final taskId = taskIds.removeAt(oldIndex);
    taskIds.insert(newIndex, taskId);
    
    ref.read(kanbanServiceProvider).reorderTasks(widget.column.id, taskIds);
  }
  
  int _calculateDropPosition(Offset dropOffset) {
    // This is a simplified calculation
    // In a real implementation, you'd calculate based on the actual positions of tasks
    return widget.column.tasks.length;
  }
}