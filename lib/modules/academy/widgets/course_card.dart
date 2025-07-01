import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/academy_models.dart';
import '../providers/academy_providers.dart';

/// A card widget that displays course information
class CourseCard extends ConsumerWidget {
  const CourseCard({
    super.key,
    required this.course,
    this.onTap,
    this.showProgress = false,
    this.showEnrollButton = true,
  });

  final Course course;
  final VoidCallback? onTap;
  final bool showProgress;
  final bool showEnrollButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final progressPercentage = showProgress 
        ? (course.completedTasks / course.totalTasks * 100).round()
        : 0;

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap ?? () {
          ref.read(selectedCourseNotifierProvider.notifier).selectCourse(course.id);
          context.push('/modules/academy/course-details/${course.id}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course thumbnail
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    course.tutorImg.startsWith('/')
                        ? 'assets/images${course.tutorImg}'
                        : course.tutorImg,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: _getCourseColor(course.color, colorScheme).withOpacity(0.1),
                        child: Icon(
                          _getCourseIcon(course.logo),
                          size: 48,
                          color: _getCourseColor(course.color, colorScheme),
                        ),
                      );
                    },
                  ),
                  // Category badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getCourseColor(course.color, colorScheme),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        course.tags,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  // Duration
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        course.time,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Course content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course title
                    Text(
                      course.courseTitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Description
                    Text(
                      course.desc,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Instructor info
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: AssetImage(
                            course.image.startsWith('/')
                                ? 'assets/images${course.image}'
                                : course.image,
                          ),
                          onBackgroundImageError: (exception, stackTrace) {},
                          child: course.image.isEmpty
                              ? Icon(
                                  Icons.person,
                                  size: 16,
                                  color: colorScheme.onPrimaryContainer,
                                )
                              : null,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            course.user,
                            style: theme.textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    // Progress bar (if showing progress)
                    if (showProgress) ...[
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Progress',
                                style: theme.textTheme.labelSmall,
                              ),
                              Text(
                                '$progressPercentage%',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: progressPercentage / 100,
                            backgroundColor: colorScheme.surfaceVariant,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getCourseColor(course.color, colorScheme),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${course.completedTasks}/${course.totalTasks} lessons',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                    
                    const SizedBox(height: 12),
                    
                    // Bottom row with rating, students, and action
                    Row(
                      children: [
                        // Rating
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber[600],
                        ),
                        const SizedBox(width: 2),
                        Text(
                          course.rating.toStringAsFixed(1),
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          ' (${course.ratingCount})',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        
                        const SizedBox(width: 12),
                        
                        // Students count
                        Icon(
                          Icons.people_outline,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${course.userCount}',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        
                        const Spacer(),
                        
                        // Action button
                        if (showEnrollButton)
                          _buildActionButton(context, ref, course),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, WidgetRef ref, Course course) {
    final theme = Theme.of(context);
    final isEnrolled = ref.watch(enrollmentStateProvider)[course.id] ?? course.isEnrolled;
    
    if (isEnrolled) {
      return TextButton(
        onPressed: () {
          ref.read(selectedCourseNotifierProvider.notifier).selectCourse(course.id);
          context.push('/modules/academy/course-details/${course.id}');
        },
        child: const Text('Continue'),
      );
    } else {
      return FilledButton.tonal(
        onPressed: () => _enrollInCourse(context, ref, course.id),
        style: FilledButton.styleFrom(
          minimumSize: const Size(80, 32),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text('Enroll'),
      );
    }
  }

  Future<void> _enrollInCourse(BuildContext context, WidgetRef ref, int courseId) async {
    final currentUserId = ref.read(currentUserIdProvider);
    final enrollmentNotifier = ref.read(enrollmentStateProvider.notifier);
    
    try {
      await enrollmentNotifier.enrollInCourse(currentUserId, courseId);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully enrolled in course!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to enroll: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Color _getCourseColor(String colorName, ColorScheme colorScheme) {
    switch (colorName.toLowerCase()) {
      case 'primary':
        return colorScheme.primary;
      case 'secondary':
        return colorScheme.secondary;
      case 'error':
        return colorScheme.error;
      case 'warning':
        return Colors.orange;
      case 'info':
        return Colors.blue;
      case 'success':
        return Colors.green;
      default:
        return colorScheme.primary;
    }
  }

  IconData _getCourseIcon(String logoName) {
    switch (logoName.toLowerCase()) {
      case 'angular':
        return Icons.architecture;
      case 'react':
        return Icons.code;
      case 'palette':
        return Icons.palette;
      case 'star':
        return Icons.star;
      case 'pencil':
        return Icons.edit;
      default:
        return Icons.school;
    }
  }
}

/// Compact course card for lists
class CompactCourseCard extends ConsumerWidget {
  const CompactCourseCard({
    super.key,
    required this.course,
    this.onTap,
  });

  final Course course;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        onTap: onTap ?? () {
          ref.read(selectedCourseNotifierProvider.notifier).selectCourse(course.id);
          context.push('/modules/academy/course-details/${course.id}');
        },
        leading: Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            color: _getCourseColor(course.color, colorScheme).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getCourseIcon(course.logo),
            color: _getCourseColor(course.color, colorScheme),
          ),
        ),
        title: Text(
          course.courseTitle,
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
              course.user,
              style: theme.textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  size: 14,
                  color: Colors.amber[600],
                ),
                const SizedBox(width: 2),
                Text(
                  course.rating.toStringAsFixed(1),
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  course.time,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getCourseColor(course.color, colorScheme),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            course.tags,
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Color _getCourseColor(String colorName, ColorScheme colorScheme) {
    switch (colorName.toLowerCase()) {
      case 'primary':
        return colorScheme.primary;
      case 'secondary':
        return colorScheme.secondary;
      case 'error':
        return colorScheme.error;
      case 'warning':
        return Colors.orange;
      case 'info':
        return Colors.blue;
      case 'success':
        return Colors.green;
      default:
        return colorScheme.primary;
    }
  }

  IconData _getCourseIcon(String logoName) {
    switch (logoName.toLowerCase()) {
      case 'angular':
        return Icons.architecture;
      case 'react':
        return Icons.code;
      case 'palette':
        return Icons.palette;
      case 'star':
        return Icons.star;
      case 'pencil':
        return Icons.edit;
      default:
        return Icons.school;
    }
  }
}