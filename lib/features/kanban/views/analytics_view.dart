import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/kanban_providers.dart';
import '../models/simple_models.dart';

class AnalyticsView extends ConsumerWidget {
  final String boardId;
  final ScrollController scrollController;
  
  const AnalyticsView({
    super.key,
    required this.boardId,
    required this.scrollController,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analytics = ref.watch(boardAnalyticsProvider(boardId));
    final boardAsync = ref.watch(currentBoardProvider);
    final columnsAsync = ref.watch(boardColumnsProvider(boardId));
    final membersAsync = ref.watch(boardMembersProvider(boardId));
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Icon(
                  Icons.analytics,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                boardAsync.maybeWhen(
                  data: (board) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Analytics',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        board?.title ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                  orElse: () => Text(
                    'Analytics',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overview Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'Total Tasks',
                          analytics.totalTasks.toString(),
                          Icons.list_alt,
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'Completed',
                          analytics.completedTasks.toString(),
                          Icons.check_circle,
                          Colors.green,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'Overdue',
                          analytics.overdueTasks.toString(),
                          Icons.warning,
                          Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'Completion Rate',
                          '${(analytics.completionRate * 100).toInt()}%',
                          Icons.trending_up,
                          Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  
                  // Column Statistics
                  Text(
                    'Column Distribution',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  columnsAsync.maybeWhen(
                    data: (columns) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: columns.map((column) {
                            final percentage = analytics.totalTasks > 0
                                ? column.tasks.length / analytics.totalTasks
                                : 0.0;
                            
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        column.title,
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      Text(
                                        '${column.tasks.length} tasks',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  LinearProgressIndicator(
                                    value: percentage,
                                    backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      column.color != null
                                          ? Color(int.parse(column.color!.replaceFirst('#', '0xFF')))
                                          : Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    orElse: () => const Center(child: CircularProgressIndicator()),
                  ),
                  const SizedBox(height: 32),
                  
                  // Team Performance
                  Text(
                    'Team Performance',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  membersAsync.maybeWhen(
                    data: (members) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: members.map((member) {
                            final completionRate = member.tasksAssigned > 0
                                ? member.tasksCompleted / member.tasksAssigned
                                : 0.0;
                            
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                backgroundImage: member.avatarUrl != null
                                    ? NetworkImage(member.avatarUrl!)
                                    : null,
                                child: member.avatarUrl == null
                                    ? Text(member.name[0])
                                    : null,
                              ),
                              title: Text(member.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${member.tasksCompleted} / ${member.tasksAssigned} tasks completed',
                                  ),
                                  const SizedBox(height: 4),
                                  LinearProgressIndicator(
                                    value: completionRate,
                                    backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                                  ),
                                ],
                              ),
                              trailing: Text(
                                '${(completionRate * 100).toInt()}%',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: _getPerformanceColor(context, completionRate),
                                    ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    orElse: () => const Center(child: CircularProgressIndicator()),
                  ),
                  const SizedBox(height: 32),
                  
                  // Recent Activity
                  Text(
                    'Recent Activity',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: analytics.recentActivities.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(32),
                            child: Center(
                              child: Text(
                                'No recent activity',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: analytics.recentActivities.length,
                            separatorBuilder: (context, index) => const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final activity = analytics.recentActivities[index];
                              return _buildActivityTile(context, activity);
                            },
                          ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildActivityTile(BuildContext context, Activity activity) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _getActivityColor(context, activity.type).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _getActivityIcon(activity.type),
          size: 20,
          color: _getActivityColor(context, activity.type),
        ),
      ),
      title: Text(activity.description),
      subtitle: Text(
        _formatTime(activity.createdAt),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }
  
  IconData _getActivityIcon(ActivityType type) {
    switch (type) {
      case ActivityType.taskCreated:
        return Icons.add_task;
      case ActivityType.taskUpdated:
        return Icons.edit;
      case ActivityType.taskDeleted:
        return Icons.delete;
      case ActivityType.taskMoved:
        return Icons.move_up;
      case ActivityType.taskAssigned:
        return Icons.person_add;
      case ActivityType.taskUnassigned:
        return Icons.person_remove;
      case ActivityType.taskCompleted:
        return Icons.check_circle;
      case ActivityType.taskReopened:
        return Icons.replay;
      case ActivityType.commentAdded:
        return Icons.comment;
      case ActivityType.attachmentAdded:
        return Icons.attach_file;
      case ActivityType.columnCreated:
        return Icons.view_column;
      case ActivityType.memberAdded:
        return Icons.group_add;
      default:
        return Icons.history;
    }
  }
  
  Color _getActivityColor(BuildContext context, ActivityType type) {
    switch (type) {
      case ActivityType.taskCreated:
      case ActivityType.columnCreated:
        return Colors.green;
      case ActivityType.taskDeleted:
      case ActivityType.columnDeleted:
        return Theme.of(context).colorScheme.error;
      case ActivityType.taskCompleted:
        return Colors.green;
      case ActivityType.taskMoved:
      case ActivityType.taskUpdated:
        return Theme.of(context).colorScheme.primary;
      case ActivityType.commentAdded:
        return Colors.blue;
      default:
        return Theme.of(context).colorScheme.onSurfaceVariant;
    }
  }
  
  Color _getPerformanceColor(BuildContext context, double rate) {
    if (rate >= 0.8) return Colors.green;
    if (rate >= 0.6) return Theme.of(context).colorScheme.primary;
    if (rate >= 0.4) return Colors.orange;
    return Theme.of(context).colorScheme.error;
  }
  
  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}