import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/academy_models.dart';
import '../providers/academy_providers.dart';
import '../widgets/index.dart';

/// Student progress tracking view
class StudentProgressView extends ConsumerWidget {
  const StudentProgressView({
    super.key,
    this.studentId,
  });

  final String? studentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.read(currentUserIdProvider);
    final actualStudentId = studentId ?? currentUserId;
    final progressAsync = ref.watch(studentProgressProvider(actualStudentId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Progress'),
        actions: [
          IconButton(
            onPressed: () => _showProgressReport(context, ref, actualStudentId),
            icon: const Icon(Icons.assessment),
          ),
        ],
      ),
      body: progressAsync.when(
        data: (progressList) => _buildProgressContent(context, ref, progressList),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => _buildErrorView(context, ref, error),
      ),
    );
  }

  Widget _buildProgressContent(
    BuildContext context,
    WidgetRef ref,
    List<StudentProgress> progressList,
  ) {
    if (progressList.isEmpty) {
      return _buildEmptyView(context);
    }

    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isWideScreen = screenSize.width > 1200;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress overview
          _buildProgressOverview(context, progressList),
          
          const SizedBox(height: 24),
          
          // Progress charts
          if (isWideScreen)
            _buildWideScreenCharts(context, progressList)
          else
            _buildNarrowScreenCharts(context, progressList),
          
          const SizedBox(height: 24),
          
          // Course progress list
          _buildCourseProgressList(context, ref, progressList),
        ],
      ),
    );
  }

  Widget _buildProgressOverview(
    BuildContext context,
    List<StudentProgress> progressList,
  ) {
    final theme = Theme.of(context);
    
    final totalCourses = progressList.length;
    final completedCourses = progressList.where((p) => p.progressPercentage >= 100).length;
    final inProgressCourses = progressList.where((p) => p.progressPercentage > 0 && p.progressPercentage < 100).length;
    final totalTimeSpent = progressList.fold<int>(0, (sum, p) => sum + p.timeSpent);
    final averageProgress = totalCourses > 0 
        ? progressList.fold<double>(0, (sum, p) => sum + p.progressPercentage) / totalCourses
        : 0.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Learning Overview',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildOverviewStat(
                    context,
                    'Total Courses',
                    totalCourses.toString(),
                    Icons.school,
                    Colors.blue,
                  ),
                ),
                Expanded(
                  child: _buildOverviewStat(
                    context,
                    'Completed',
                    completedCourses.toString(),
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildOverviewStat(
                    context,
                    'In Progress',
                    inProgressCourses.toString(),
                    Icons.trending_up,
                    Colors.orange,
                  ),
                ),
                Expanded(
                  child: _buildOverviewStat(
                    context,
                    'Time Spent',
                    _formatHours(totalTimeSpent),
                    Icons.schedule,
                    Colors.purple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: averageProgress / 100,
              backgroundColor: theme.colorScheme.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
            ),
            const SizedBox(height: 8),
            Text(
              'Overall Progress: ${averageProgress.toStringAsFixed(1)}%',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
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
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildWideScreenCharts(
    BuildContext context,
    List<StudentProgress> progressList,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ProgressChart(progress: progressList),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CompletionRateChart(
            completedCourses: progressList.where((p) => p.progressPercentage >= 100).length,
            totalCourses: progressList.length,
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowScreenCharts(
    BuildContext context,
    List<StudentProgress> progressList,
  ) {
    return Column(
      children: [
        ProgressChart(progress: progressList),
        const SizedBox(height: 16),
        CompletionRateChart(
          completedCourses: progressList.where((p) => p.progressPercentage >= 100).length,
          totalCourses: progressList.length,
        ),
      ],
    );
  }

  Widget _buildCourseProgressList(
    BuildContext context,
    WidgetRef ref,
    List<StudentProgress> progressList,
  ) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course Progress Details',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: progressList.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final progress = progressList[index];
                return _buildProgressItem(context, ref, progress);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem(
    BuildContext context,
    WidgetRef ref,
    StudentProgress progress,
  ) {
    final theme = Theme.of(context);
    final courseAsync = ref.watch(courseProvider(int.parse(progress.courseId)));

    return courseAsync.when(
      data: (course) {
        if (course == null) return const SizedBox.shrink();
        
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          leading: Container(
            width: 60,
            height: 40,
            decoration: BoxDecoration(
              color: _getCourseColor(course.color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getCourseIcon(course.logo),
              color: _getCourseColor(course.color),
            ),
          ),
          title: Text(
            course.courseTitle,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: progress.progressPercentage / 100,
                      backgroundColor: theme.colorScheme.surfaceVariant,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getCourseColor(course.color),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${progress.progressPercentage.toStringAsFixed(0)}%',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    '${progress.completedLessons}/${progress.totalLessons} lessons',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${_formatHours(progress.timeSpent)} spent',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (progress.completionDate != null) ...[
                    const SizedBox(width: 16),
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'Completed',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (progress.currentScore > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getScoreColor(progress.currentScore).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${progress.currentScore.toStringAsFixed(0)}%',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: _getScoreColor(progress.currentScore),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  // Navigate to course details
                  // context.push('/modules/academy/course-details/${course.id}');
                },
                icon: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ],
          ),
        );
      },
      loading: () => const ListTile(
        leading: CircularProgressIndicator(),
        title: Text('Loading...'),
      ),
      error: (error, stackTrace) => ListTile(
        leading: Icon(Icons.error, color: theme.colorScheme.error),
        title: Text('Error loading course'),
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_outlined,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No learning progress yet',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start learning by enrolling in your first course',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                // Navigate to course list
                // context.push('/modules/academy/courses');
              },
              icon: const Icon(Icons.explore),
              label: const Text('Explore Courses'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, WidgetRef ref, Object error) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load progress',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                final currentUserId = ref.read(currentUserIdProvider);
                ref.refresh(studentProgressProvider(currentUserId));
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  void _showProgressReport(BuildContext context, WidgetRef ref, String studentId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Progress Report'),
        content: const SizedBox(
          width: 400,
          height: 300,
          child: Center(
            child: Text('Detailed progress report will be available soon.'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Generate PDF report
            },
            child: const Text('Download PDF'),
          ),
        ],
      ),
    );
  }

  Color _getCourseColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'primary':
        return Colors.blue;
      case 'secondary':
        return Colors.purple;
      case 'error':
        return Colors.red;
      case 'warning':
        return Colors.orange;
      case 'info':
        return Colors.blue;
      case 'success':
        return Colors.green;
      default:
        return Colors.blue;
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

  Color _getScoreColor(double score) {
    if (score >= 90) return Colors.green;
    if (score >= 80) return Colors.lightGreen;
    if (score >= 70) return Colors.orange;
    if (score >= 60) return Colors.deepOrange;
    return Colors.red;
  }

  String _formatHours(int totalMinutes) {
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