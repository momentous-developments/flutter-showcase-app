import 'package:freezed_annotation/freezed_annotation.dart';

part 'academy_models.freezed.dart';
part 'academy_models.g.dart';

/// Course model representing a course in the academy
@freezed
class Course with _$Course {
  const factory Course({
    required int id,
    required String courseTitle,
    required String desc,
    required String user,
    required String image,
    required String tutorImg,
    required int completedTasks,
    required int totalTasks,
    required int userCount,
    required int note,
    required int view,
    required String time,
    required String logo,
    required String color,
    required String tags,
    required double rating,
    required int ratingCount,
    @Default(false) bool isEnrolled,
    @Default(0.0) double price,
    @Default('') String currency,
    @Default('') String level,
    @Default('') String language,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}

/// Course details with expanded information
@freezed
class CourseDetails with _$CourseDetails {
  const factory CourseDetails({
    required String title,
    required String about,
    required String instructor,
    required String instructorAvatar,
    required String instructorPosition,
    required String skillLevel,
    required int totalStudents,
    required String language,
    required bool isCaptions,
    required String length,
    required int totalLectures,
    required List<String> description,
    required List<CourseSection> content,
    @Default(0.0) double price,
    @Default('USD') String currency,
    @Default(0) int enrolledStudents,
    @Default(4.5) double rating,
    @Default(0) int reviewCount,
  }) = _CourseDetails;

  factory CourseDetails.fromJson(Map<String, dynamic> json) => 
      _$CourseDetailsFromJson(json);
}

/// Course section with topics/lessons
@freezed
class CourseSection with _$CourseSection {
  const factory CourseSection({
    required String title,
    required String id,
    required List<CourseTopic> topics,
    @Default(0) int totalDuration,
    @Default(0) int completedTopics,
  }) = _CourseSection;

  factory CourseSection.fromJson(Map<String, dynamic> json) => 
      _$CourseSectionFromJson(json);
}

/// Individual course topic/lesson
@freezed
class CourseTopic with _$CourseTopic {
  const factory CourseTopic({
    required String title,
    required String time,
    required bool isCompleted,
    @Default('') String id,
    @Default('video') String type,
    @Default('') String url,
    @Default('') String description,
  }) = _CourseTopic;

  factory CourseTopic.fromJson(Map<String, dynamic> json) => 
      _$CourseTopicFromJson(json);
}

/// Student model
@freezed
class Student with _$Student {
  const factory Student({
    required String id,
    required String name,
    required String email,
    required String avatar,
    required DateTime joinDate,
    required List<String> enrolledCourses,
    required List<StudentProgress> progress,
    @Default(0) int totalCoursesCompleted,
    @Default(0) int totalHoursSpent,
    @Default(0.0) double averageScore,
    @Default([]) List<String> achievements,
    @Default('') String bio,
    @Default('') String phone,
  }) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);
}

/// Student progress for a specific course
@freezed
class StudentProgress with _$StudentProgress {
  const factory StudentProgress({
    required String courseId,
    required String studentId,
    required double progressPercentage,
    required int completedLessons,
    required int totalLessons,
    required DateTime lastAccessed,
    required DateTime startDate,
    @Default(0) int timeSpent, // in minutes
    @Default(0.0) double currentScore,
    @Default([]) List<String> completedTopicIds,
    DateTime? completionDate,
  }) = _StudentProgress;

  factory StudentProgress.fromJson(Map<String, dynamic> json) => 
      _$StudentProgressFromJson(json);
}

/// Instructor model
@freezed
class Instructor with _$Instructor {
  const factory Instructor({
    required String id,
    required String name,
    required String email,
    required String avatar,
    required String position,
    required String bio,
    required List<String> courseIds,
    required DateTime joinDate,
    @Default(0) int totalStudents,
    @Default(4.5) double rating,
    @Default(0) int reviewCount,
    @Default([]) List<String> specializations,
    @Default([]) List<String> qualifications,
    @Default('') String phone,
    @Default('') String linkedin,
    @Default('') String website,
  }) = _Instructor;

  factory Instructor.fromJson(Map<String, dynamic> json) => 
      _$InstructorFromJson(json);
}

/// Activity feed item
@freezed
class Activity with _$Activity {
  const factory Activity({
    required String id,
    required String type, // enrollment, completion, achievement, etc.
    required String title,
    required String description,
    required DateTime timestamp,
    required String userId,
    @Default('') String courseId,
    @Default('') String icon,
    @Default('info') String priority,
    Map<String, dynamic>? metadata,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) => 
      _$ActivityFromJson(json);
}

/// Course review model
@freezed
class Review with _$Review {
  const factory Review({
    required String id,
    required String courseId,
    required String studentId,
    required String studentName,
    required String studentAvatar,
    required double rating,
    required String comment,
    required DateTime createdAt,
    @Default(0) int helpfulCount,
    @Default(false) bool isVerifiedPurchase,
    DateTime? updatedAt,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}

/// Academy analytics/stats
@freezed
class AcademyStats with _$AcademyStats {
  const factory AcademyStats({
    required int totalCourses,
    required int totalStudents,
    required int totalInstructors,
    required double averageRating,
    required int totalCompletions,
    required int totalHoursWatched,
    @Default(0) int activeStudents,
    @Default(0) int newEnrollments,
    @Default(0.0) double completionRate,
    @Default(0.0) double revenueThisMonth,
    @Default([]) List<CategoryStats> categoryStats,
  }) = _AcademyStats;

  factory AcademyStats.fromJson(Map<String, dynamic> json) => 
      _$AcademyStatsFromJson(json);
}

/// Category statistics
@freezed
class CategoryStats with _$CategoryStats {
  const factory CategoryStats({
    required String category,
    required int courseCount,
    required int enrollmentCount,
    required double averageRating,
    @Default(0.0) double completionRate,
  }) = _CategoryStats;

  factory CategoryStats.fromJson(Map<String, dynamic> json) => 
      _$CategoryStatsFromJson(json);
}

/// Course filter criteria
@freezed
class CourseFilter with _$CourseFilter {
  const factory CourseFilter({
    @Default('') String searchQuery,
    @Default([]) List<String> categories,
    @Default([]) List<String> levels,
    @Default([]) List<String> languages,
    @Default(0.0) double minRating,
    @Default(double.infinity) double maxPrice,
    @Default('title') String sortBy,
    @Default(false) bool sortDescending,
    @Default(false) bool freeOnly,
    @Default(false) bool enrolledOnly,
  }) = _CourseFilter;

  factory CourseFilter.fromJson(Map<String, dynamic> json) => 
      _$CourseFilterFromJson(json);
}

/// Academy dashboard data
@freezed
class AcademyDashboard with _$AcademyDashboard {
  const factory AcademyDashboard({
    required AcademyStats stats,
    required List<Course> popularCourses,
    required List<Course> recentCourses,
    required List<Instructor> topInstructors,
    required List<Activity> recentActivities,
    required List<StudentProgress> userProgress,
    @Default([]) List<Course> recommendedCourses,
    @Default([]) List<String> upcomingDeadlines,
  }) = _AcademyDashboard;

  factory AcademyDashboard.fromJson(Map<String, dynamic> json) => 
      _$AcademyDashboardFromJson(json);
}