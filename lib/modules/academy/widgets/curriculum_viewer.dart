import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/academy_models.dart';

/// Widget for viewing course curriculum with expandable sections
class CurriculumViewer extends ConsumerStatefulWidget {
  const CurriculumViewer({
    super.key,
    required this.sections,
    this.onTopicTap,
    this.showProgress = false,
    this.studentProgress,
  });

  final List<CourseSection> sections;
  final Function(CourseTopic topic, CourseSection section)? onTopicTap;
  final bool showProgress;
  final StudentProgress? studentProgress;

  @override
  ConsumerState<CurriculumViewer> createState() => _CurriculumViewerState();
}

class _CurriculumViewerState extends ConsumerState<CurriculumViewer> {
  final Set<String> _expandedSections = {};

  @override
  void initState() {
    super.initState();
    // Expand the first section by default
    if (widget.sections.isNotEmpty) {
      _expandedSections.add(widget.sections.first.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (widget.sections.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.library_books_outlined,
                  size: 48,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 16),
                Text(
                  'No curriculum available',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.library_books,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Course Curriculum',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (widget.showProgress && widget.studentProgress != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '${widget.studentProgress!.progressPercentage.toStringAsFixed(0)}% Complete',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.sections.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final section = widget.sections[index];
              final isExpanded = _expandedSections.contains(section.id);
              
              return CurriculumSection(
                section: section,
                isExpanded: isExpanded,
                onToggle: () => _toggleSection(section.id),
                onTopicTap: (topic) => widget.onTopicTap?.call(topic, section),
                showProgress: widget.showProgress,
                completedTopicIds: widget.studentProgress?.completedTopicIds ?? [],
              );
            },
          ),
        ],
      ),
    );
  }

  void _toggleSection(String sectionId) {
    setState(() {
      if (_expandedSections.contains(sectionId)) {
        _expandedSections.remove(sectionId);
      } else {
        _expandedSections.add(sectionId);
      }
    });
  }
}

/// Individual curriculum section widget
class CurriculumSection extends StatelessWidget {
  const CurriculumSection({
    super.key,
    required this.section,
    required this.isExpanded,
    required this.onToggle,
    this.onTopicTap,
    this.showProgress = false,
    this.completedTopicIds = const [],
  });

  final CourseSection section;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Function(CourseTopic topic)? onTopicTap;
  final bool showProgress;
  final List<String> completedTopicIds;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final totalTopics = section.topics.length;
    final completedTopics = showProgress 
        ? section.topics.where((topic) => 
            topic.isCompleted || completedTopicIds.contains(topic.id)).length
        : section.completedTopics;
    
    final completionPercentage = totalTopics > 0 ? (completedTopics / totalTopics) : 0.0;

    return Column(
      children: [
        InkWell(
          onTap: onToggle,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section.title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${section.topics.length} lessons',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (showProgress) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: completionPercentage,
                                backgroundColor: colorScheme.surfaceVariant,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  colorScheme.primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '$completedTopics/$totalTopics',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                if (completionPercentage == 1.0)
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            color: colorScheme.surfaceVariant.withOpacity(0.3),
            child: Column(
              children: section.topics.map((topic) {
                final topicIndex = section.topics.indexOf(topic);
                final isCompleted = topic.isCompleted || 
                    completedTopicIds.contains(topic.id);
                
                return CurriculumTopic(
                  topic: topic,
                  index: topicIndex + 1,
                  isCompleted: isCompleted,
                  onTap: () => onTopicTap?.call(topic),
                  showProgress: showProgress,
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}

/// Individual curriculum topic widget
class CurriculumTopic extends StatelessWidget {
  const CurriculumTopic({
    super.key,
    required this.topic,
    required this.index,
    required this.isCompleted,
    this.onTap,
    this.showProgress = false,
  });

  final CourseTopic topic;
  final int index;
  final bool isCompleted;
  final VoidCallback? onTap;
  final bool showProgress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
      leading: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isCompleted 
              ? Colors.green 
              : colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: isCompleted
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                )
              : Text(
                  index.toString(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
      title: Text(
        topic.title,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
          decoration: isCompleted ? TextDecoration.lineThrough : null,
          color: isCompleted 
              ? colorScheme.onSurfaceVariant 
              : colorScheme.onSurface,
        ),
      ),
      subtitle: Row(
        children: [
          Icon(
            _getTopicIcon(topic.type),
            size: 14,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 4),
          Text(
            topic.time,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          if (topic.type != 'video') ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _getTypeColor(topic.type).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                topic.type.toUpperCase(),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: _getTypeColor(topic.type),
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isCompleted && showProgress)
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 16,
            ),
          if (topic.url.isNotEmpty)
            IconButton(
              onPressed: onTap,
              icon: Icon(
                Icons.play_circle_outline,
                color: colorScheme.primary,
              ),
              iconSize: 20,
            ),
        ],
      ),
    );
  }

  IconData _getTopicIcon(String type) {
    switch (type.toLowerCase()) {
      case 'video':
        return Icons.play_circle_outline;
      case 'quiz':
        return Icons.quiz_outlined;
      case 'assignment':
        return Icons.assignment_outlined;
      case 'reading':
        return Icons.article_outlined;
      case 'exercise':
        return Icons.fitness_center_outlined;
      default:
        return Icons.school_outlined;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'video':
        return Colors.blue;
      case 'quiz':
        return Colors.orange;
      case 'assignment':
        return Colors.red;
      case 'reading':
        return Colors.green;
      case 'exercise':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}

/// Curriculum overview summary
class CurriculumOverview extends StatelessWidget {
  const CurriculumOverview({
    super.key,
    required this.sections,
    this.studentProgress,
  });

  final List<CourseSection> sections;
  final StudentProgress? studentProgress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final totalLessons = sections.fold<int>(
      0, (sum, section) => sum + section.topics.length);
    final totalDuration = sections.fold<int>(
      0, (sum, section) => sum + section.totalDuration);
    final completedLessons = studentProgress?.completedLessons ?? 0;
    
    final completionPercentage = totalLessons > 0 
        ? (completedLessons / totalLessons) : 0.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course Overview',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildOverviewItem(
                  context,
                  icon: Icons.video_library_outlined,
                  label: 'Total Lessons',
                  value: totalLessons.toString(),
                  color: Colors.blue,
                ),
                _buildOverviewItem(
                  context,
                  icon: Icons.schedule_outlined,
                  label: 'Duration',
                  value: _formatDuration(totalDuration),
                  color: Colors.orange,
                ),
                _buildOverviewItem(
                  context,
                  icon: Icons.folder_outlined,
                  label: 'Sections',
                  value: sections.length.toString(),
                  color: Colors.green,
                ),
              ],
            ),
            if (studentProgress != null) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Text(
                'Your Progress',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: completionPercentage,
                      backgroundColor: colorScheme.surfaceVariant,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${(completionPercentage * 100).toStringAsFixed(0)}%',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '$completedLessons of $totalLessons lessons completed',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return Expanded(
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
            style: theme.textTheme.titleMedium?.copyWith(
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

  String _formatDuration(int totalMinutes) {
    if (totalMinutes == 0) return '0m';
    
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}