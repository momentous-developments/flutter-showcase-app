import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/simple_models.dart';
import '../providers/kanban_providers.dart';

class AddTaskButton extends ConsumerStatefulWidget {
  final String columnId;
  final VoidCallback onTaskAdded;
  
  const AddTaskButton({
    super.key,
    required this.columnId,
    required this.onTaskAdded,
  });
  
  @override
  ConsumerState<AddTaskButton> createState() => _AddTaskButtonState();
}

class _AddTaskButtonState extends ConsumerState<AddTaskButton> {
  bool _isAdding = false;
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  
  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    if (_isAdding) {
      return Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Enter task title',
                  border: InputBorder.none,
                ),
                maxLines: 2,
                onSubmitted: (_) => _addTask(),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _cancel,
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: _addTask,
                    child: const Text('Add Task'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    
    return InkWell(
      onTap: () {
        setState(() {
          _isAdding = true;
        });
        // Wait for the widget to rebuild then focus
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _focusNode.requestFocus();
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        ),
        child: Row(
          children: [
            Icon(
              Icons.add,
              size: 20,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Text(
              'Add a task',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _addTask() async {
    final title = _controller.text.trim();
    if (title.isNotEmpty) {
      final boardId = ref.read(selectedBoardIdProvider);
      if (boardId != null) {
        final columns = ref.read(boardColumnsProvider(boardId)).value ?? [];
        final column = columns.firstWhere((c) => c.id == widget.columnId);
        
        final task = Task(
          id: '',
          boardId: boardId,
          columnId: widget.columnId,
          title: title,
          position: column.tasks.length,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        await ref.read(kanbanServiceProvider).createTask(task);
        ref.refresh(boardColumnsProvider(boardId));
        
        widget.onTaskAdded();
        _cancel();
      }
    }
  }
  
  void _cancel() {
    setState(() {
      _isAdding = false;
      _controller.clear();
    });
  }
}