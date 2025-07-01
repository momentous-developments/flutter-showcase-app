import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/simple_models.dart';
import '../providers/kanban_providers.dart';
import 'member_avatar.dart';
import 'label_chip.dart';

class TaskCard extends ConsumerWidget {
  final Task task;
  final VoidCallback onTap;
  
  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDragging = ref.watch(draggedTaskProvider)?.id == task.id;
    
    return LongPressDraggable<Task>(
      data: task,
      onDragStarted: () {
        ref.read(draggedTaskProvider.notifier).state = task;
      },
      onDragEnd: (_) {
        ref.read(draggedTaskProvider.notifier).state = null;
      },
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 304, // Slightly smaller than column width
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: _buildCardContent(context, ref),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _buildCard(context, ref),
      ),
      child: _buildCard(context, ref),
    );
  }
  
  Widget _buildCard(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: _buildCardContent(context, ref),
        ),
      ),
    );
  }
  
  Widget _buildCardContent(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cover image
        if (task.coverImage != null) ...[
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(task.coverImage!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
        
        // Labels
        if (task.labelIds.isNotEmpty) ...[
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: task.labelIds.take(3).map((labelId) {
              return TaskLabelChip(labelId: labelId);
            }).toList(),
          ),
          const SizedBox(height: 8),
        ],
        
        // Title
        Text(
          task.title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        
        // Progress bar
        if (task.progress > 0) ...[
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: task.progress,
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            minHeight: 2,
          ),
        ],
        
        // Bottom row
        const SizedBox(height: 8),
        Row(
          children: [
            // Priority
            _buildPriorityIcon(context),
            
            // Due date
            if (task.dueDate != null) ...[
              const SizedBox(width: 8),
              _buildDueDate(context),
            ],
            
            const Spacer(),
            
            // Stats
            if (task.comments.isNotEmpty)
              _buildStatIcon(
                context,
                Icons.comment,
                task.comments.length.toString(),
              ),
            if (task.attachmentIds.isNotEmpty)
              _buildStatIcon(
                context,
                Icons.attach_file,
                task.attachmentIds.length.toString(),
              ),
            if (task.checklists.isNotEmpty)
              _buildStatIcon(
                context,
                Icons.check_box,
                '${_getCompletedChecklistItems()}/${_getTotalChecklistItems()}',
              ),
            
            // Assignees
            if (task.assigneeIds.isNotEmpty) ...[
              const SizedBox(width: 8),
              SizedBox(
                height: 24,
                child: Stack(
                  children: task.assigneeIds
                      .take(3)
                      .toList()
                      .asMap()
                      .entries
                      .map((entry) {
                    return Positioned(
                      left: entry.key * 16.0,
                      child: MemberAvatar(
                        memberId: entry.value,
                        size: 24,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
  
  Widget _buildPriorityIcon(BuildContext context) {
    IconData icon;
    Color color;
    
    switch (task.priority) {
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
  
  Widget _buildDueDate(BuildContext context) {
    final now = DateTime.now();
    final isOverdue = task.dueDate!.isBefore(now) && task.status != TaskStatus.done;
    final isDueSoon = task.dueDate!.difference(now).inDays <= 2 && !isOverdue;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isOverdue
            ? Theme.of(context).colorScheme.error.withOpacity(0.1)
            : isDueSoon
                ? Colors.orange.withOpacity(0.1)
                : Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today,
            size: 12,
            color: isOverdue
                ? Theme.of(context).colorScheme.error
                : isDueSoon
                    ? Colors.orange
                    : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 4),
          Text(
            _formatDueDate(task.dueDate!),
            style: TextStyle(
              fontSize: 12,
              color: isOverdue
                  ? Theme.of(context).colorScheme.error
                  : isDueSoon
                      ? Colors.orange
                      : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatIcon(BuildContext context, IconData icon, String count) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 2),
          Text(
            count,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
  
  String _formatDueDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);
    
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Tomorrow';
    } else if (difference.inDays == -1) {
      return 'Yesterday';
    } else if (difference.inDays > 0 && difference.inDays <= 7) {
      return '${difference.inDays} days';
    } else if (difference.inDays < 0) {
      return '${-difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}';
    }
  }
  
  int _getCompletedChecklistItems() {
    int completed = 0;
    for (final checklist in task.checklists) {
      completed += checklist.items.where((item) => item.isCompleted).length;
    }
    return completed;
  }
  
  int _getTotalChecklistItems() {
    int total = 0;
    for (final checklist in task.checklists) {
      total += checklist.items.length;
    }
    return total;
  }
}