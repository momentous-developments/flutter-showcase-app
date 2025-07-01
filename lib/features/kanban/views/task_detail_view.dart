import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/simple_models.dart';
import '../providers/kanban_providers.dart';
import '../widgets/member_avatar.dart';
import '../widgets/label_chip.dart';

class TaskDetailView extends ConsumerStatefulWidget {
  final Task task;
  final VoidCallback onClose;
  
  const TaskDetailView({
    super.key,
    required this.task,
    required this.onClose,
  });
  
  @override
  ConsumerState<TaskDetailView> createState() => _TaskDetailViewState();
}

class _TaskDetailViewState extends ConsumerState<TaskDetailView> {
  late Task _task;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _commentController = TextEditingController();
  bool _isEditingTitle = false;
  bool _isEditingDescription = false;
  
  @override
  void initState() {
    super.initState();
    _task = widget.task;
    _titleController.text = _task.title;
    _descriptionController.text = _task.description ?? '';
  }
  
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _commentController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: Center(
        child: Container(
          width: 800,
          height: MediaQuery.of(context).size.height * 0.9,
          margin: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.task_alt,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _isEditingTitle
                          ? TextField(
                              controller: _titleController,
                              autofocus: true,
                              style: Theme.of(context).textTheme.headlineSmall,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              onSubmitted: (_) => _saveTitle(),
                            )
                          : InkWell(
                              onTap: () => setState(() => _isEditingTitle = true),
                              child: Text(
                                _task.title,
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: widget.onClose,
                    ),
                  ],
                ),
              ),
              
              // Content
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main content
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Labels
                            if (_task.labelIds.isNotEmpty) ...[
                              _buildSection(
                                title: 'Labels',
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: _task.labelIds.map((labelId) {
                                    return TaskLabelChip(labelId: labelId);
                                  }).toList(),
                                ),
                              ),
                            ],
                            
                            // Description
                            _buildSection(
                              title: 'Description',
                              action: TextButton(
                                onPressed: () => setState(() => _isEditingDescription = true),
                                child: const Text('Edit'),
                              ),
                              child: _isEditingDescription
                                  ? Column(
                                      children: [
                                        TextField(
                                          controller: _descriptionController,
                                          autofocus: true,
                                          maxLines: 4,
                                          decoration: const InputDecoration(
                                            hintText: 'Add a description...',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                setState(() => _isEditingDescription = false);
                                                _descriptionController.text = _task.description ?? '';
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            const SizedBox(width: 8),
                                            FilledButton(
                                              onPressed: _saveDescription,
                                              child: const Text('Save'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : Text(
                                      _task.description ?? 'No description',
                                      style: TextStyle(
                                        color: _task.description == null
                                            ? Theme.of(context).colorScheme.onSurfaceVariant
                                            : null,
                                      ),
                                    ),
                            ),
                            
                            // Checklists
                            if (_task.checklists.isNotEmpty) ...[
                              ..._task.checklists.map((checklist) => _buildChecklist(checklist)),
                            ],
                            
                            // Activity/Comments
                            _buildSection(
                              title: 'Activity',
                              child: Column(
                                children: [
                                  // Add comment
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MemberAvatar(
                                        memberId: 'user1', // Current user
                                        size: 32,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: TextField(
                                          controller: _commentController,
                                          decoration: InputDecoration(
                                            hintText: 'Write a comment...',
                                            filled: true,
                                            fillColor: Theme.of(context).colorScheme.surfaceVariant,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide.none,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: const Icon(Icons.send),
                                              onPressed: _addComment,
                                            ),
                                          ),
                                          onSubmitted: (_) => _addComment(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  // Comments list
                                  ..._task.comments.map((comment) => _buildComment(comment)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Sidebar
                    Container(
                      width: 240,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                        border: Border(
                          left: BorderSide(
                            color: Theme.of(context).colorScheme.outlineVariant,
                          ),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Status
                            _buildSidebarSection(
                              title: 'Status',
                              child: DropdownButtonFormField<TaskStatus>(
                                value: _task.status,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  border: OutlineInputBorder(),
                                ),
                                items: TaskStatus.values.map((status) {
                                  return DropdownMenuItem(
                                    value: status,
                                    child: Text(_getStatusName(status)),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      _task = _task.copyWith(status: value);
                                    });
                                    _updateTask();
                                  }
                                },
                              ),
                            ),
                            
                            // Priority
                            _buildSidebarSection(
                              title: 'Priority',
                              child: DropdownButtonFormField<TaskPriority>(
                                value: _task.priority,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  border: OutlineInputBorder(),
                                ),
                                items: TaskPriority.values.map((priority) {
                                  return DropdownMenuItem(
                                    value: priority,
                                    child: Row(
                                      children: [
                                        _getPriorityIcon(priority),
                                        const SizedBox(width: 8),
                                        Text(_getPriorityName(priority)),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      _task = _task.copyWith(priority: value);
                                    });
                                    _updateTask();
                                  }
                                },
                              ),
                            ),
                            
                            // Assignees
                            _buildSidebarSection(
                              title: 'Assignees',
                              action: IconButton(
                                icon: const Icon(Icons.add, size: 20),
                                onPressed: _showAssigneeDialog,
                              ),
                              child: _task.assigneeIds.isEmpty
                                  ? Text(
                                      'No assignees',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                                      ),
                                    )
                                  : Column(
                                      children: _task.assigneeIds.map((memberId) {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: Row(
                                            children: [
                                              MemberAvatar(
                                                memberId: memberId,
                                                size: 24,
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  _getMemberName(memberId),
                                                  style: Theme.of(context).textTheme.bodySmall,
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.close, size: 16),
                                                onPressed: () => _removeAssignee(memberId),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                            ),
                            
                            // Due date
                            _buildSidebarSection(
                              title: 'Due Date',
                              child: InkWell(
                                onTap: _selectDueDate,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.outline,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: 16,
                                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          _task.dueDate != null
                                              ? _formatDate(_task.dueDate!)
                                              : 'Set due date',
                                          style: TextStyle(
                                            color: _task.dueDate == null
                                                ? Theme.of(context).colorScheme.onSurfaceVariant
                                                : null,
                                          ),
                                        ),
                                      ),
                                      if (_task.dueDate != null)
                                        IconButton(
                                          icon: const Icon(Icons.close, size: 16),
                                          onPressed: () {
                                            setState(() {
                                              _task = _task.copyWith(dueDate: null);
                                            });
                                            _updateTask();
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            
                            // Time tracking
                            _buildSidebarSection(
                              title: 'Time Tracking',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Spent:',
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                      Text(
                                        _formatTime(_task.timeSpent),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Estimated:',
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                      Text(
                                        _task.estimatedTime != null
                                            ? _formatTime(_task.estimatedTime!)
                                            : 'Not set',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            // Actions
                            const SizedBox(height: 24),
                            FilledButton.icon(
                              onPressed: _deleteTask,
                              icon: const Icon(Icons.delete),
                              label: const Text('Delete Task'),
                              style: FilledButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.error,
                                minimumSize: const Size(double.infinity, 40),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildSection({
    required String title,
    required Widget child,
    Widget? action,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (action != null) action,
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
  
  Widget _buildSidebarSection({
    required String title,
    required Widget child,
    Widget? action,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              if (action != null) action,
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
  
  Widget _buildChecklist(TaskChecklist checklist) {
    final completedCount = checklist.items.where((item) => item.isCompleted).length;
    final progress = checklist.items.isEmpty ? 0.0 : completedCount / checklist.items.length;
    
    return _buildSection(
      title: checklist.title,
      action: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${(progress * 100).toInt()}%',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.delete, size: 20),
            onPressed: () => _deleteChecklist(checklist.id),
          ),
        ],
      ),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          ),
          const SizedBox(height: 8),
          ...checklist.items.map((item) => CheckboxListTile(
                value: item.isCompleted,
                onChanged: (value) => _updateChecklistItem(checklist.id, item.id, value ?? false),
                title: Text(
                  item.title,
                  style: item.isCompleted
                      ? const TextStyle(decoration: TextDecoration.lineThrough)
                      : null,
                ),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              )),
        ],
      ),
    );
  }
  
  Widget _buildComment(Comment comment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MemberAvatar(
            memberId: comment.userId,
            size: 32,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _getMemberName(comment.userId),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatDate(comment.createdAt),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(comment.content),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  void _saveTitle() {
    setState(() {
      _isEditingTitle = false;
      _task = _task.copyWith(title: _titleController.text);
    });
    _updateTask();
  }
  
  void _saveDescription() {
    setState(() {
      _isEditingDescription = false;
      _task = _task.copyWith(description: _descriptionController.text);
    });
    _updateTask();
  }
  
  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      final comment = Comment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        taskId: _task.id,
        userId: 'user1', // Current user
        content: _commentController.text,
        createdAt: DateTime.now(),
      );
      
      setState(() {
        _task = _task.copyWith(comments: [..._task.comments, comment]);
        _commentController.clear();
      });
      _updateTask();
    }
  }
  
  void _updateChecklistItem(String checklistId, String itemId, bool isCompleted) {
    setState(() {
      _task = _task.copyWith(
        checklists: _task.checklists.map((checklist) {
          if (checklist.id == checklistId) {
            return checklist.copyWith(
              items: checklist.items.map((item) {
                if (item.id == itemId) {
                  return item.copyWith(
                    isCompleted: isCompleted,
                    completedAt: isCompleted ? DateTime.now() : null,
                  );
                }
                return item;
              }).toList(),
            );
          }
          return checklist;
        }).toList(),
      );
    });
    _updateTask();
  }
  
  void _deleteChecklist(String checklistId) {
    setState(() {
      _task = _task.copyWith(
        checklists: _task.checklists.where((c) => c.id != checklistId).toList(),
      );
    });
    _updateTask();
  }
  
  void _showAssigneeDialog() {
    // Show dialog to select assignees
  }
  
  void _removeAssignee(String memberId) {
    setState(() {
      _task = _task.copyWith(
        assigneeIds: _task.assigneeIds.where((id) => id != memberId).toList(),
      );
    });
    _updateTask();
  }
  
  void _selectDueDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _task.dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (date != null) {
      setState(() {
        _task = _task.copyWith(dueDate: date);
      });
      _updateTask();
    }
  }
  
  void _updateTask() async {
    await ref.read(kanbanServiceProvider).updateTask(_task.id, _task);
    ref.read(selectedTaskProvider.notifier).updateSelectedTask(_task);
    
    // Refresh the board
    final boardId = ref.read(selectedBoardIdProvider);
    if (boardId != null) {
      ref.refresh(boardColumnsProvider(boardId));
    }
  }
  
  void _deleteTask() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      await ref.read(kanbanServiceProvider).deleteTask(_task.id);
      
      // Refresh the board
      final boardId = ref.read(selectedBoardIdProvider);
      if (boardId != null) {
        ref.refresh(boardColumnsProvider(boardId));
      }
      
      widget.onClose();
    }
  }
  
  String _getStatusName(TaskStatus status) {
    switch (status) {
      case TaskStatus.todo:
        return 'To Do';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.inReview:
        return 'In Review';
      case TaskStatus.done:
        return 'Done';
      case TaskStatus.cancelled:
        return 'Cancelled';
    }
  }
  
  String _getPriorityName(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.urgent:
        return 'Urgent';
      case TaskPriority.high:
        return 'High';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.low:
        return 'Low';
    }
  }
  
  Widget _getPriorityIcon(TaskPriority priority) {
    IconData icon;
    Color color;
    
    switch (priority) {
      case TaskPriority.urgent:
        icon = Icons.arrow_upward;
        color = Theme.of(context).colorScheme.error;
        break;
      case TaskPriority.high:
        icon = Icons.arrow_upward;
        color = Colors.orange;
        break;
      case TaskPriority.medium:
        icon = Icons.remove;
        color = Theme.of(context).colorScheme.primary;
        break;
      case TaskPriority.low:
        icon = Icons.arrow_downward;
        color = Theme.of(context).colorScheme.outline;
        break;
    }
    
    return Icon(icon, size: 16, color: color);
  }
  
  String _getMemberName(String memberId) {
    // In a real app, we'd get this from the members provider
    final names = {
      'user1': 'John Doe',
      'user2': 'Jane Smith',
      'user3': 'Mike Johnson',
      'user4': 'Sarah Williams',
      'user5': 'Tom Brown',
    };
    return names[memberId] ?? 'Unknown';
  }
  
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
  
  String _formatTime(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    
    if (hours > 0) {
      return '${hours}h ${mins}m';
    }
    return '${mins}m';
  }
}