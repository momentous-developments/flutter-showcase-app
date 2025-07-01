import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/academy_models.dart';
import '../providers/academy_providers.dart';
import '../widgets/index.dart';

/// Academy dashboard view with analytics and overview
class AcademyDashboardView extends ConsumerWidget {
  const AcademyDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(academyDashboardProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: dashboardAsync.when(
        data: (dashboard) => _buildDashboardContent(context, ref, dashboard),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => _buildErrorView(context, ref, error),
      ),
    );
  }

  Widget _buildDashboardContent(
    BuildContext context,
    WidgetRef ref,
    AcademyDashboard dashboard,
  ) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isWideScreen = screenSize.width > 1200;
    final currentUserId = ref.read(currentUserIdProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome header
          _buildWelcomeHeader(context, dashboard.stats),
          
          const SizedBox(height: 24),
          
          // Quick stats cards
          _buildQuickStatsRow(context, dashboard.stats),
          
          const SizedBox(height: 24),
          
          // Main content grid
          if (isWideScreen)
            _buildWideScreenLayout(context, ref, dashboard, currentUserId)
          else
            _buildNarrowScreenLayout(context, ref, dashboard, currentUserId),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader(BuildContext context, AcademyStats stats) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back! 👋',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your learning journey continues. You\'re doing great!',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.trending_up,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${stats.completionRate.toStringAsFixed(1)}% completion rate',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.school,
                  color: Colors.white,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  '${stats.totalCourses}',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Courses',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatsRow(BuildContext context, AcademyStats stats) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.people,
            title: 'Total Students',
            value: _formatNumber(stats.totalStudents),
            subtitle: '${stats.activeStudents} active',
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.person_outline,
            title: 'Instructors',
            value: stats.totalInstructors.toString(),
            subtitle: 'Expert teachers',
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.star,
            title: 'Avg Rating',
            value: stats.averageRating.toStringAsFixed(1),
            subtitle: 'Course quality',
            color: Colors.amber,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.schedule,
            title: 'Hours Watched',
            value: _formatHours(stats.totalHoursWatched),
            subtitle: 'Total learning time',
            color: Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                    size: 20,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.trending_up,
                  color: color,
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWideScreenLayout(
    BuildContext context,
    WidgetRef ref,
    AcademyDashboard dashboard,
    String currentUserId,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column (60%)
        Expanded(
          flex: 60,
          child: Column(
            children: [
              // Popular courses
              _buildPopularCoursesSection(context, ref, dashboard.popularCourses),
              
              const SizedBox(height: 24),
              
              // Progress charts
              _buildProgressChartsSection(context, ref, dashboard.userProgress),
              
              const SizedBox(height: 24),
              
              // Top instructors
              _buildTopInstructorsSection(context, dashboard.topInstructors),
            ],
          ),
        ),
        
        const SizedBox(width: 24),
        
        // Right column (40%)
        Expanded(
          flex: 40,
          child: Column(
            children: [
              // Recent activity
              ActivityFeed(limit: 8),
              
              const SizedBox(height: 24),
              
              // Recent courses
              _buildRecentCoursesSection(context, ref, dashboard.recentCourses),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowScreenLayout(
    BuildContext context,
    WidgetRef ref,
    AcademyDashboard dashboard,
    String currentUserId,
  ) {
    return Column(
      children: [
        // Popular courses
        _buildPopularCoursesSection(context, ref, dashboard.popularCourses),
        
        const SizedBox(height: 24),
        
        // Recent activity
        ActivityFeed(limit: 6),
        
        const SizedBox(height: 24),
        
        // Progress charts
        _buildProgressChartsSection(context, ref, dashboard.userProgress),
        
        const SizedBox(height: 24),
        
        // Recent courses
        _buildRecentCoursesSection(context, ref, dashboard.recentCourses),
        
        const SizedBox(height: 24),
        
        // Top instructors
        _buildTopInstructorsSection(context, dashboard.topInstructors),
      ],
    );
  }

  Widget _buildPopularCoursesSection(
    BuildContext context,
    WidgetRef ref,
    List<Course> popularCourses,
  ) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Popular Courses',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => context.push('/modules/academy/courses'),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 280,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: popularCourses.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final course = popularCourses[index];
                  return SizedBox(
                    width: 300,
                    child: CourseCard(
                      course: course,
                      showProgress: false,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressChartsSection(
    BuildContext context,
    WidgetRef ref,
    List<StudentProgress> userProgress,
  ) {
    if (userProgress.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        ProgressChart(progress: userProgress),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CompletionRateChart(
                completedCourses: userProgress
                    .where((p) => p.progressPercentage >= 100)
                    .length,
                totalCourses: userProgress.length,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SkillRadarChart(
                skills: {
                  'Web Dev': 85,
                  'Design': 70,
                  'Mobile': 60,
                  'AI/ML': 45,
                  'DevOps': 55,
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTopInstructorsSection(
    BuildContext context,
    List<Instructor> topInstructors,
  ) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person_pin,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Top Instructors',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => context.push('/modules/academy/instructors'),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: topInstructors.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final instructor = topInstructors[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      instructor.avatar.startsWith('/')
                          ? 'assets/images${instructor.avatar}'
                          : instructor.avatar,
                    ),
                    onBackgroundImageError: (exception, stackTrace) {},
                    child: instructor.avatar.isEmpty
                        ? Icon(
                            Icons.person,
                            color: theme.colorScheme.onPrimaryContainer,
                          )
                        : null,
                  ),
                  title: Text(
                    instructor.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(instructor.position),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            instructor.rating.toStringAsFixed(1),
                            style: theme.textTheme.labelSmall,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${instructor.totalStudents} students',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: FilledButton.tonal(
                    onPressed: () {
                      // View instructor profile
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(80, 32),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('View'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentCoursesSection(
    BuildContext context,
    WidgetRef ref,
    List<Course> recentCourses,
  ) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.history,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Recently Added',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recentCourses.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final course = recentCourses[index];
                return CompactCourseCard(course: course);
              },
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
              'Failed to load dashboard',
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
              onPressed: () => ref.refresh(academyDashboardProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }

  String _formatHours(int totalHours) {
    if (totalHours >= 1000) {
      return '${(totalHours / 1000).toStringAsFixed(1)}K';
    } else {
      return totalHours.toString();
    }
  }
}