import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/academy_models.dart';
import '../services/academy_service.dart';

part 'academy_providers.g.dart';

/// Academy service provider
@riverpod
AcademyService academyService(AcademyServiceRef ref) {
  return AcademyService();
}

/// Course filter provider
@riverpod
class CourseFilterNotifier extends _$CourseFilterNotifier {
  @override
  CourseFilter build() {
    return const CourseFilter();
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateCategories(List<String> categories) {
    state = state.copyWith(categories: categories);
  }

  void updateLevels(List<String> levels) {
    state = state.copyWith(levels: levels);
  }

  void updateLanguages(List<String> languages) {
    state = state.copyWith(languages: languages);
  }

  void updateMinRating(double rating) {
    state = state.copyWith(minRating: rating);
  }

  void updateMaxPrice(double price) {
    state = state.copyWith(maxPrice: price);
  }

  void updateSorting(String sortBy, bool descending) {
    state = state.copyWith(
      sortBy: sortBy,
      sortDescending: descending,
    );
  }

  void toggleFreeOnly() {
    state = state.copyWith(freeOnly: !state.freeOnly);
  }

  void toggleEnrolledOnly() {
    state = state.copyWith(enrolledOnly: !state.enrolledOnly);
  }

  void resetFilter() {
    state = const CourseFilter();
  }
}

/// Courses provider with filtering
@riverpod
Future<List<Course>> courses(CoursesRef ref) async {
  final service = ref.watch(academyServiceProvider);
  final filter = ref.watch(courseFilterNotifierProvider);
  
  try {
    final courses = await service.getCourses(filter: filter);
    
    // Apply additional client-side filtering/sorting if needed
    var filteredCourses = courses;
    
    // Apply sorting
    switch (filter.sortBy) {
      case 'title':
        filteredCourses.sort((a, b) => filter.sortDescending
            ? b.courseTitle.compareTo(a.courseTitle)
            : a.courseTitle.compareTo(b.courseTitle));
        break;
      case 'rating':
        filteredCourses.sort((a, b) => filter.sortDescending
            ? b.rating.compareTo(a.rating)
            : a.rating.compareTo(b.rating));
        break;
      case 'price':
        filteredCourses.sort((a, b) => filter.sortDescending
            ? b.price.compareTo(a.price)
            : a.price.compareTo(b.price));
        break;
      case 'popularity':
        filteredCourses.sort((a, b) => filter.sortDescending
            ? b.userCount.compareTo(a.userCount)
            : a.userCount.compareTo(b.userCount));
        break;
    }
    
    return filteredCourses;
  } catch (e) {
    throw Exception('Failed to load courses: $e');
  }
}

/// Single course provider
@riverpod
Future<Course?> course(CourseRef ref, int courseId) async {
  final courses = await ref.watch(coursesProvider.future);
  try {
    return courses.firstWhere((course) => course.id == courseId);
  } catch (e) {
    return null;
  }
}

/// Course details provider
@riverpod
Future<CourseDetails?> courseDetails(CourseDetailsRef ref, int courseId) async {
  final service = ref.watch(academyServiceProvider);
  
  try {
    return await service.getCourseDetails(courseId);
  } catch (e) {
    debugPrint('Failed to load course details: $e');
    return null;
  }
}

/// Academy dashboard provider
@riverpod
Future<AcademyDashboard> academyDashboard(AcademyDashboardRef ref) async {
  final service = ref.watch(academyServiceProvider);
  
  try {
    return await service.getDashboardData();
  } catch (e) {
    throw Exception('Failed to load dashboard data: $e');
  }
}

/// Student progress provider
@riverpod
Future<List<StudentProgress>> studentProgress(
  StudentProgressRef ref,
  String studentId,
) async {
  final service = ref.watch(academyServiceProvider);
  
  try {
    return await service.getStudentProgress(studentId);
  } catch (e) {
    throw Exception('Failed to load student progress: $e');
  }
}

/// Instructors provider
@riverpod
Future<List<Instructor>> instructors(InstructorsRef ref) async {
  final service = ref.watch(academyServiceProvider);
  
  try {
    return await service.getInstructors();
  } catch (e) {
    throw Exception('Failed to load instructors: $e');
  }
}

/// Course reviews provider
@riverpod
Future<List<Review>> courseReviews(
  CourseReviewsRef ref,
  String courseId,
) async {
  final service = ref.watch(academyServiceProvider);
  
  try {
    return await service.getCourseReviews(courseId);
  } catch (e) {
    throw Exception('Failed to load course reviews: $e');
  }
}

/// Recent activities provider
@riverpod
Future<List<Activity>> recentActivities(
  RecentActivitiesRef ref, {
  int limit = 20,
}) async {
  final service = ref.watch(academyServiceProvider);
  
  try {
    return await service.getRecentActivities(limit: limit);
  } catch (e) {
    throw Exception('Failed to load recent activities: $e');
  }
}

/// Enrollment state provider
@riverpod
class EnrollmentState extends _$EnrollmentState {
  @override
  Map<int, bool> build() {
    return {};
  }

  Future<void> enrollInCourse(String studentId, int courseId) async {
    final service = ref.read(academyServiceProvider);
    
    // Optimistically update state
    state = {...state, courseId: true};
    
    try {
      final success = await service.enrollInCourse(studentId, courseId);
      if (!success) {
        // Revert on failure
        state = {...state, courseId: false};
        throw Exception('Failed to enroll in course');
      }
      
      // Invalidate courses to refresh enrollment status
      ref.invalidate(coursesProvider);
    } catch (e) {
      // Revert on error
      state = {...state, courseId: false};
      rethrow;
    }
  }

  bool isEnrolled(int courseId) {
    return state[courseId] ?? false;
  }
}

/// Course progress update provider
@riverpod
class CourseProgressNotifier extends _$CourseProgressNotifier {
  @override
  Map<String, StudentProgress> build() {
    return {};
  }

  Future<void> updateProgress(StudentProgress progress) async {
    final service = ref.read(academyServiceProvider);
    
    // Optimistically update state
    final key = '${progress.studentId}_${progress.courseId}';
    state = {...state, key: progress};
    
    try {
      final success = await service.updateProgress(progress);
      if (!success) {
        // Remove on failure
        final newState = Map<String, StudentProgress>.from(state);
        newState.remove(key);
        state = newState;
        throw Exception('Failed to update progress');
      }
      
      // Invalidate related providers
      ref.invalidate(studentProgressProvider);
      ref.invalidate(academyDashboardProvider);
    } catch (e) {
      // Remove on error
      final newState = Map<String, StudentProgress>.from(state);
      newState.remove(key);
      state = newState;
      rethrow;
    }
  }

  StudentProgress? getProgress(String studentId, String courseId) {
    final key = '${studentId}_$courseId';
    return state[key];
  }
}

/// Review submission provider
@riverpod
class ReviewSubmissionNotifier extends _$ReviewSubmissionNotifier {
  @override
  bool build() {
    return false;
  }

  Future<void> submitReview(Review review) async {
    final service = ref.read(academyServiceProvider);
    
    state = true;
    
    try {
      final success = await service.submitReview(review);
      if (!success) {
        throw Exception('Failed to submit review');
      }
      
      // Invalidate course reviews to refresh
      ref.invalidate(courseReviewsProvider);
    } finally {
      state = false;
    }
  }
}

/// Selected course provider for navigation
@riverpod
class SelectedCourseNotifier extends _$SelectedCourseNotifier {
  @override
  int? build() {
    return null;
  }

  void selectCourse(int courseId) {
    state = courseId;
  }

  void clearSelection() {
    state = null;
  }
}

/// Popular courses provider (subset of all courses)
@riverpod
Future<List<Course>> popularCourses(PopularCoursesRef ref) async {
  final courses = await ref.watch(coursesProvider.future);
  
  // Sort by rating and user count, take top 6
  final sortedCourses = List<Course>.from(courses);
  sortedCourses.sort((a, b) {
    final scoreA = a.rating * a.userCount;
    final scoreB = b.rating * b.userCount;
    return scoreB.compareTo(scoreA);
  });
  
  return sortedCourses.take(6).toList();
}

/// User's enrolled courses provider
@riverpod
Future<List<Course>> enrolledCourses(
  EnrolledCoursesRef ref,
  String studentId,
) async {
  final courses = await ref.watch(coursesProvider.future);
  
  // Filter courses where user is enrolled
  // In a real app, this would come from the API
  return courses.where((course) => course.isEnrolled).toList();
}

/// Categories provider (derived from courses)
@riverpod
Future<List<String>> courseCategories(CourseCategoriesRef ref) async {
  final courses = await ref.watch(coursesProvider.future);
  
  final categories = courses.map((course) => course.tags).toSet().toList();
  categories.sort();
  
  return categories;
}

/// Course levels provider
@riverpod
List<String> courseLevels(CourseLevelsRef ref) {
  return ['Beginner', 'Intermediate', 'Advanced', 'Expert'];
}

/// Course languages provider
@riverpod
List<String> courseLanguages(CourseLanguagesRef ref) {
  return ['English', 'Spanish', 'French', 'German', 'Mandarin', 'Japanese'];
}

/// Current user ID provider (mock)
@riverpod
String currentUserId(CurrentUserIdRef ref) {
  return 'current_user'; // In a real app, this would come from auth
}

/// Loading states
@riverpod
class LoadingState extends _$LoadingState {
  @override
  Map<String, bool> build() {
    return {};
  }

  void setLoading(String key, bool isLoading) {
    state = {...state, key: isLoading};
  }

  bool isLoading(String key) {
    return state[key] ?? false;
  }
}

/// Error states
@riverpod
class ErrorState extends _$ErrorState {
  @override
  Map<String, String?> build() {
    return {};
  }

  void setError(String key, String? error) {
    state = {...state, key: error};
  }

  String? getError(String key) {
    return state[key];
  }

  void clearError(String key) {
    final newState = Map<String, String?>.from(state);
    newState.remove(key);
    state = newState;
  }
}