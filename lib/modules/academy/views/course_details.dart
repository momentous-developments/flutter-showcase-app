import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/academy_models.dart';
import '../providers/academy_providers.dart';
import '../widgets/index.dart';

/// Course details view with comprehensive course information
class CourseDetailsView extends ConsumerStatefulWidget {
  const CourseDetailsView({
    super.key,
    required this.courseId,
  });

  final int courseId;

  @override
  ConsumerState<CourseDetailsView> createState() => _CourseDetailsViewState();
}

class _CourseDetailsViewState extends ConsumerState<CourseDetailsView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  bool _isHeaderVisible = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final isVisible = _scrollController.offset < 200;
    if (isVisible != _isHeaderVisible) {
      setState(() => _isHeaderVisible = isVisible);
    }
  }

  @override
  Widget build(BuildContext context) {
    final courseDetailsAsync = ref.watch(courseDetailsProvider(widget.courseId));
    final courseAsync = ref.watch(courseProvider(widget.courseId));
    final theme = Theme.of(context);

    return Scaffold(
      body: courseDetailsAsync.when(
        data: (courseDetails) => courseAsync.when(
          data: (course) => _buildCourseContent(
            context,
            ref,
            courseDetails,
            course,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => _buildErrorView(context, ref, error),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => _buildErrorView(context, ref, error),
      ),
      floatingActionButton: !_isHeaderVisible
          ? FloatingActionButton.extended(
              onPressed: () => _scrollToTop(),
              label: const Text('Back to Top'),
              icon: const Icon(Icons.keyboard_arrow_up),
            )
          : null,
    );
  }

  Widget _buildCourseContent(
    BuildContext context,
    WidgetRef ref,
    CourseDetails? courseDetails,
    Course? course,
  ) {
    if (courseDetails == null || course == null) {
      return _buildNotFoundView(context);
    }

    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isWideScreen = screenSize.width > 1200;
    final currentUserId = ref.read(currentUserIdProvider);

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // App bar with course hero
        _buildSliverAppBar(context, ref, courseDetails, course),
        
        // Course content
        SliverToBoxAdapter(
          child: isWideScreen
              ? _buildWideScreenLayout(
                  context,
                  ref,
                  courseDetails,
                  course,
                  currentUserId,
                )
              : _buildNarrowScreenLayout(
                  context,
                  ref,
                  courseDetails,
                  course,
                  currentUserId,
                ),
        ),
      ],
    );
  }

  Widget _buildSliverAppBar(
    BuildContext context,
    WidgetRef ref,
    CourseDetails courseDetails,
    Course course,
  ) {
    final theme = Theme.of(context);

    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: AnimatedOpacity(
          opacity: _isHeaderVisible ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Text(
            courseDetails.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Course video/image
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.primary.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
            
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            
            // Course info overlay
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: AnimatedOpacity(
                opacity: _isHeaderVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getCourseColor(course.color).withOpacity(0.9),
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
                    const SizedBox(height: 8),
                    Text(
                      courseDetails.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'by ${courseDetails.instructor}',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Share course
            _shareCourse(courseDetails);
          },
          icon: const Icon(Icons.share),
        ),
        IconButton(
          onPressed: () {
            // Bookmark course
            _bookmarkCourse(ref, widget.courseId);
          },
          icon: const Icon(Icons.bookmark_border),
        ),
      ],
    );
  }

  Widget _buildWideScreenLayout(
    BuildContext context,
    WidgetRef ref,
    CourseDetails courseDetails,
    Course course,
    String currentUserId,
  ) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main content (70%)
          Expanded(
            flex: 70,
            child: Column(
              children: [
                _buildCourseOverview(context, courseDetails),
                const SizedBox(height: 24),
                _buildTabContent(context, ref, courseDetails, course),
              ],
            ),
          ),
          
          const SizedBox(width: 24),
          
          // Sidebar (30%)
          Expanded(
            flex: 30,
            child: Column(
              children: [
                _buildEnrollmentCard(context, ref, courseDetails, course),
                const SizedBox(height: 16),
                _buildInstructorCard(context, courseDetails),
                const SizedBox(height: 16),
                _buildCourseStats(context, courseDetails),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowScreenLayout(
    BuildContext context,
    WidgetRef ref,
    CourseDetails courseDetails,
    Course course,
    String currentUserId,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildEnrollmentCard(context, ref, courseDetails, course),
          const SizedBox(height: 16),
          _buildCourseOverview(context, courseDetails),
          const SizedBox(height: 16),
          _buildInstructorCard(context, courseDetails),
          const SizedBox(height: 16),
          _buildCourseStats(context, courseDetails),
          const SizedBox(height: 16),
          _buildTabContent(context, ref, courseDetails, course),
        ],
      ),
    );
  }

  Widget _buildCourseOverview(BuildContext context, CourseDetails courseDetails) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About this course',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              courseDetails.about,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            
            // What you'll learn
            Text(
              'What you\'ll learn',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: courseDetails.description.map((point) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          point,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(
    BuildContext context,
    WidgetRef ref,
    CourseDetails courseDetails,
    Course course,
  ) {
    final theme = Theme.of(context);

    return Card(
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Curriculum'),
              Tab(text: 'Reviews'),
              Tab(text: 'Q&A'),
            ],
          ),
          SizedBox(
            height: 600,
            child: TabBarView(
              controller: _tabController,
              children: [
                // Curriculum tab
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CurriculumOverview(sections: courseDetails.content),
                      const SizedBox(height: 16),
                      Expanded(
                        child: CurriculumViewer(
                          sections: courseDetails.content,
                          showProgress: course.isEnrolled,
                          onTopicTap: (topic, section) {
                            // Handle topic tap
                            _playTopic(topic);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Reviews tab
                _buildReviewsTab(context, ref, course.id.toString()),
                
                // Q&A tab
                _buildQATab(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnrollmentCard(
    BuildContext context,
    WidgetRef ref,
    CourseDetails courseDetails,
    Course course,
  ) {
    final theme = Theme.of(context);
    final isEnrolled = ref.watch(enrollmentStateProvider)[course.id] ?? course.isEnrolled;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Price and rating
            Row(
              children: [
                if (courseDetails.price > 0) ...[
                  Text(
                    '\$${courseDetails.price.toStringAsFixed(2)}',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ] else ...[
                  Text(
                    'Free',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      courseDetails.rating.toStringAsFixed(1),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      ' (${courseDetails.reviewCount})',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Enrollment button
            SizedBox(
              width: double.infinity,
              child: isEnrolled
                  ? FilledButton.icon(
                      onPressed: () {
                        // Continue learning
                        _continueLearning(context, course);
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Continue Learning'),
                    )
                  : FilledButton.icon(
                      onPressed: () => _enrollInCourse(context, ref, course.id),
                      icon: const Icon(Icons.school),
                      label: Text(
                        courseDetails.price > 0 ? 'Enroll Now' : 'Enroll for Free',
                      ),
                    ),
            ),
            
            if (isEnrolled) ...[
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {
                  // Download course materials
                },
                icon: const Icon(Icons.download),
                label: const Text('Download Materials'),
              ),
            ],
            
            const SizedBox(height: 20),
            
            // Course includes
            Text(
              'This course includes:',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _buildCourseIncludes(context, courseDetails),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseIncludes(BuildContext context, CourseDetails courseDetails) {
    final theme = Theme.of(context);
    
    final includes = [
      ('${courseDetails.length} on-demand video', Icons.play_circle_outline),
      ('${courseDetails.totalLectures} lectures', Icons.video_library),
      ('Certificate of completion', Icons.workspace_premium),
      ('Full lifetime access', Icons.all_inclusive),
      ('Access on mobile and TV', Icons.devices),
    ];

    return Column(
      children: includes.map((include) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Icon(
                include.$2,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                include.$1,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInstructorCard(BuildContext context, CourseDetails courseDetails) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Instructor',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                    courseDetails.instructorAvatar.startsWith('/')
                        ? 'assets/images${courseDetails.instructorAvatar}'
                        : courseDetails.instructorAvatar,
                  ),
                  onBackgroundImageError: (exception, stackTrace) {},
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseDetails.instructor,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        courseDetails.instructorPosition,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                // View instructor profile
              },
              child: const Text('View Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseStats(BuildContext context, CourseDetails courseDetails) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course Details',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _buildStatRow(
              context,
              'Students',
              courseDetails.enrolledStudents.toString(),
              Icons.people,
            ),
            _buildStatRow(
              context,
              'Language',
              courseDetails.language,
              Icons.language,
            ),
            _buildStatRow(
              context,
              'Skill Level',
              courseDetails.skillLevel,
              Icons.trending_up,
            ),
            _buildStatRow(
              context,
              'Lectures',
              courseDetails.totalLectures.toString(),
              Icons.video_library,
            ),
            _buildStatRow(
              context,
              'Duration',
              courseDetails.length,
              Icons.schedule,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab(BuildContext context, WidgetRef ref, String courseId) {
    final reviewsAsync = ref.watch(courseReviewsProvider(courseId));
    final theme = Theme.of(context);

    return reviewsAsync.when(
      data: (reviews) {
        if (reviews.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.rate_review_outlined,
                  size: 48,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 16),
                Text(
                  'No reviews yet',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Be the first to review this course',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: reviews.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final review = reviews[index];
            return _buildReviewItem(context, review);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text('Failed to load reviews'),
      ),
    );
  }

  Widget _buildReviewItem(BuildContext context, Review review) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(review.studentAvatar),
            onBackgroundImageError: (exception, stackTrace) {},
            child: review.studentAvatar.isEmpty
                ? Icon(
                    Icons.person,
                    color: theme.colorScheme.onPrimaryContainer,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      review.studentName,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < review.rating
                              ? Icons.star
                              : Icons.star_border,
                          size: 16,
                          color: Colors.amber,
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  review.comment,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      _formatDate(review.createdAt),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 16),
                    TextButton.icon(
                      onPressed: () {
                        // Mark review as helpful
                      },
                      icon: const Icon(Icons.thumb_up_outlined, size: 14),
                      label: Text('Helpful (${review.helpfulCount})'),
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQATab(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.quiz_outlined,
            size: 48,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Q&A Section',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ask questions and get answers from instructors and students',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              // Ask a question
            },
            icon: const Icon(Icons.add),
            label: const Text('Ask a Question'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, WidgetRef ref, Object error) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Details'),
      ),
      body: Center(
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
                'Failed to load course details',
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
                  ref.refresh(courseDetailsProvider(widget.courseId));
                  ref.refresh(courseProvider(widget.courseId));
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotFoundView(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Not Found'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 64,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                'Course not found',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'The course you\'re looking for doesn\'t exist or has been removed.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => context.push('/modules/academy/courses'),
                child: const Text('Browse Courses'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
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

  void _continueLearning(BuildContext context, Course course) {
    // Navigate to course player or next lesson
    context.push('/modules/academy/course-player/${course.id}');
  }

  void _shareCourse(CourseDetails courseDetails) {
    // Implement course sharing
  }

  void _bookmarkCourse(WidgetRef ref, int courseId) {
    // Implement course bookmarking
  }

  void _playTopic(CourseTopic topic) {
    // Navigate to topic player
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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inMinutes} minutes ago';
    }
  }
}