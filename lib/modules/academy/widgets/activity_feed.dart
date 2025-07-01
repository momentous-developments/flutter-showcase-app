import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/academy_models.dart';
import '../providers/academy_providers.dart';

/// Widget that displays a feed of recent academy activities
class ActivityFeed extends ConsumerWidget {
  const ActivityFeed({
    super.key,
    this.limit = 10,
    this.showHeader = true,
  });

  final int limit;
  final bool showHeader;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesAsync = ref.watch(recentActivitiesProvider(limit: limit));
    final theme = Theme.of(context);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeader) ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.timeline,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Recent Activity',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      // Navigate to full activity page
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
          ],
          activitiesAsync.when(
            data: (activities) {
              if (activities.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.timeline_outlined,
                          size: 48,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No recent activity',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: activities.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final activity = activities[index];
                  return ActivityItem(activity: activity);
                },
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(32),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, stackTrace) => Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: theme.colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load activities',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => ref.refresh(recentActivitiesProvider(limit: limit)),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual activity item widget
class ActivityItem extends StatelessWidget {
  const ActivityItem({
    super.key,
    required this.activity,
  });

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _getActivityColor(activity.priority, colorScheme).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          _getActivityIcon(activity.type),
          size: 20,
          color: _getActivityColor(activity.priority, colorScheme),
        ),
      ),
      title: Text(
        activity.title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activity.description,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            timeago.format(activity.timestamp),
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      trailing: _buildActivityBadge(context, activity),
    );
  }

  Widget? _buildActivityBadge(BuildContext context, Activity activity) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    switch (activity.type) {
      case 'enrollment':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'New',
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      case 'completion':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Complete',
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      case 'achievement':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Badge',
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.amber[700],
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      default:
        return null;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case 'enrollment':
        return Icons.school_outlined;
      case 'completion':
        return Icons.check_circle_outline;
      case 'achievement':
        return Icons.emoji_events_outlined;
      case 'progress':
        return Icons.trending_up_outlined;
      case 'review':
        return Icons.star_outline;
      case 'certificate':
        return Icons.workspace_premium_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  Color _getActivityColor(String priority, ColorScheme colorScheme) {
    switch (priority) {
      case 'high':
        return colorScheme.error;
      case 'medium':
        return Colors.orange;
      case 'low':
        return colorScheme.primary;
      case 'success':
        return Colors.green;
      case 'warning':
        return Colors.amber;
      case 'info':
        return Colors.blue;
      default:
        return colorScheme.primary;
    }
  }
}

/// Compact activity feed for sidebars
class CompactActivityFeed extends ConsumerWidget {
  const CompactActivityFeed({
    super.key,
    this.limit = 5,
  });

  final int limit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesAsync = ref.watch(recentActivitiesProvider(limit: limit));
    final theme = Theme.of(context);

    return activitiesAsync.when(
      data: (activities) {
        if (activities.isEmpty) {
          return Center(
            child: Text(
              'No recent activity',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          );
        }

        return Column(
          children: activities.map((activity) {
            return CompactActivityItem(activity: activity);
          }).toList(),
        );
      },
      loading: () => const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      error: (error, stackTrace) => Center(
        child: Text(
          'Error loading activities',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.error,
          ),
        ),
      ),
    );
  }
}

/// Compact activity item for sidebar
class CompactActivityItem extends StatelessWidget {
  const CompactActivityItem({
    super.key,
    required this.activity,
  });

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _getActivityColor(activity.priority, colorScheme).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              _getActivityIcon(activity.type),
              size: 16,
              color: _getActivityColor(activity.priority, colorScheme),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  timeago.format(activity.timestamp),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case 'enrollment':
        return Icons.school_outlined;
      case 'completion':
        return Icons.check_circle_outline;
      case 'achievement':
        return Icons.emoji_events_outlined;
      case 'progress':
        return Icons.trending_up_outlined;
      case 'review':
        return Icons.star_outline;
      case 'certificate':
        return Icons.workspace_premium_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  Color _getActivityColor(String priority, ColorScheme colorScheme) {
    switch (priority) {
      case 'high':
        return colorScheme.error;
      case 'medium':
        return Colors.orange;
      case 'low':
        return colorScheme.primary;
      case 'success':
        return Colors.green;
      case 'warning':
        return Colors.amber;
      case 'info':
        return Colors.blue;
      default:
        return colorScheme.primary;
    }
  }
}

/// Activity statistics widget
class ActivityStats extends ConsumerWidget {
  const ActivityStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesAsync = ref.watch(recentActivitiesProvider(limit: 100));
    final theme = Theme.of(context);

    return activitiesAsync.when(
      data: (activities) {
        final stats = _calculateStats(activities);
        
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Activity Overview',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        context,
                        icon: Icons.school_outlined,
                        label: 'Enrollments',
                        value: stats['enrollments']?.toString() ?? '0',
                        color: Colors.blue,
                      ),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        context,
                        icon: Icons.check_circle_outline,
                        label: 'Completions',
                        value: stats['completions']?.toString() ?? '0',
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        context,
                        icon: Icons.emoji_events_outlined,
                        label: 'Achievements',
                        value: stats['achievements']?.toString() ?? '0',
                        color: Colors.amber,
                      ),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        context,
                        icon: Icons.trending_up_outlined,
                        label: 'Progress Updates',
                        value: stats['progress']?.toString() ?? '0',
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      error: (error, stackTrace) => Card(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Text(
              'Error loading stats',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Map<String, int> _calculateStats(List<Activity> activities) {
    final stats = <String, int>{};
    
    for (final activity in activities) {
      stats[activity.type] = (stats[activity.type] ?? 0) + 1;
    }
    
    return stats;
  }
}