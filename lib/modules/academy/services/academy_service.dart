import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/academy_models.dart';

/// Service class for Academy API operations
class AcademyService {
  static const String baseUrl = 'http://localhost:8000/api/academy';
  static const Duration timeoutDuration = Duration(seconds: 30);

  // Singleton pattern
  static final AcademyService _instance = AcademyService._internal();
  factory AcademyService() => _instance;
  AcademyService._internal();

  /// Fetch all courses with optional filtering
  Future<List<Course>> getCourses({CourseFilter? filter}) async {
    try {
      var uri = Uri.parse('$baseUrl/courses');
      
      // Add query parameters for filtering
      if (filter != null) {
        final queryParams = <String, String>{};
        
        if (filter.searchQuery.isNotEmpty) {
          queryParams['search'] = filter.searchQuery;
        }
        if (filter.categories.isNotEmpty) {
          queryParams['categories'] = filter.categories.join(',');
        }
        if (filter.levels.isNotEmpty) {
          queryParams['levels'] = filter.levels.join(',');
        }
        if (filter.minRating > 0) {
          queryParams['min_rating'] = filter.minRating.toString();
        }
        if (filter.maxPrice != double.infinity) {
          queryParams['max_price'] = filter.maxPrice.toString();
        }
        if (filter.freeOnly) {
          queryParams['free_only'] = 'true';
        }
        
        uri = uri.replace(queryParameters: queryParams);
      }

      final response = await http.get(uri).timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Course.fromJson(json)).toList();
      } else {
        // Fallback to mock data
        return _getMockCourses(filter: filter);
      }
    } catch (e) {
      // Return mock data on error
      return _getMockCourses(filter: filter);
    }
  }

  /// Fetch course details by ID
  Future<CourseDetails?> getCourseDetails(int courseId) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/courses/$courseId'))
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return CourseDetails.fromJson(data);
      } else {
        return _getMockCourseDetails(courseId);
      }
    } catch (e) {
      return _getMockCourseDetails(courseId);
    }
  }

  /// Fetch academy dashboard data
  Future<AcademyDashboard> getDashboardData() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/dashboard'))
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AcademyDashboard.fromJson(data);
      } else {
        return _getMockDashboardData();
      }
    } catch (e) {
      return _getMockDashboardData();
    }
  }

  /// Fetch student progress
  Future<List<StudentProgress>> getStudentProgress(String studentId) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/students/$studentId/progress'))
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => StudentProgress.fromJson(json)).toList();
      } else {
        return _getMockStudentProgress(studentId);
      }
    } catch (e) {
      return _getMockStudentProgress(studentId);
    }
  }

  /// Fetch instructors
  Future<List<Instructor>> getInstructors() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/instructors'))
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Instructor.fromJson(json)).toList();
      } else {
        return _getMockInstructors();
      }
    } catch (e) {
      return _getMockInstructors();
    }
  }

  /// Fetch course reviews
  Future<List<Review>> getCourseReviews(String courseId) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/courses/$courseId/reviews'))
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Review.fromJson(json)).toList();
      } else {
        return _getMockReviews(courseId);
      }
    } catch (e) {
      return _getMockReviews(courseId);
    }
  }

  /// Enroll student in course
  Future<bool> enrollInCourse(String studentId, int courseId) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/enrollments'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'student_id': studentId,
              'course_id': courseId,
            }),
          )
          .timeout(timeoutDuration);

      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  /// Update course progress
  Future<bool> updateProgress(StudentProgress progress) async {
    try {
      final response = await http
          .put(
            Uri.parse('$baseUrl/progress/${progress.studentId}/${progress.courseId}'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(progress.toJson()),
          )
          .timeout(timeoutDuration);

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Submit course review
  Future<bool> submitReview(Review review) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/reviews'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(review.toJson()),
          )
          .timeout(timeoutDuration);

      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  /// Fetch recent activities
  Future<List<Activity>> getRecentActivities({int limit = 20}) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/activities?limit=$limit'))
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Activity.fromJson(json)).toList();
      } else {
        return _getMockActivities(limit);
      }
    } catch (e) {
      return _getMockActivities(limit);
    }
  }

  // Mock data methods for fallback
  List<Course> _getMockCourses({CourseFilter? filter}) {
    final mockCourses = [
      const Course(
        id: 1,
        courseTitle: 'Basics of Angular',
        desc: 'Introductory course for Angular and framework basics with TypeScript',
        user: 'Lauretta Coie',
        image: '/images/avatars/1.png',
        tutorImg: '/images/apps/academy/1.png',
        completedTasks: 19,
        totalTasks: 25,
        userCount: 18,
        note: 20,
        view: 83,
        time: '17h 34m',
        logo: 'angular',
        color: 'error',
        tags: 'Web',
        rating: 4.4,
        ratingCount: 8,
        price: 49.99,
        currency: 'USD',
        level: 'Beginner',
        language: 'English',
      ),
      const Course(
        id: 2,
        courseTitle: 'UI/UX Design Fundamentals',
        desc: 'Learn how to design a beautiful & engaging mobile app with Figma',
        user: 'Maybelle Zmitrovich',
        image: '/images/avatars/2.png',
        tutorImg: '/images/apps/academy/2.png',
        completedTasks: 48,
        totalTasks: 52,
        userCount: 14,
        note: 48,
        view: 43,
        time: '19h 17m',
        logo: 'palette',
        color: 'warning',
        tags: 'Design',
        rating: 4.9,
        ratingCount: 10,
        price: 79.99,
        currency: 'USD',
        level: 'Intermediate',
        language: 'English',
      ),
      const Course(
        id: 3,
        courseTitle: 'React Native Development',
        desc: 'Master React.js: Build dynamic web apps with front-end technology',
        user: 'Gertie Langwade',
        image: '/images/avatars/3.png',
        tutorImg: '/images/apps/academy/3.png',
        completedTasks: 87,
        totalTasks: 100,
        userCount: 19,
        note: 81,
        view: 88,
        time: '16h 16m',
        logo: 'react',
        color: 'info',
        tags: 'Web',
        rating: 4.8,
        ratingCount: 9,
        price: 99.99,
        currency: 'USD',
        level: 'Advanced',
        language: 'English',
      ),
    ];

    // Apply filtering if provided
    if (filter != null) {
      return mockCourses.where((course) {
        if (filter.searchQuery.isNotEmpty) {
          final searchLower = filter.searchQuery.toLowerCase();
          if (!course.courseTitle.toLowerCase().contains(searchLower) &&
              !course.desc.toLowerCase().contains(searchLower)) {
            return false;
          }
        }
        
        if (filter.categories.isNotEmpty && 
            !filter.categories.contains(course.tags)) {
          return false;
        }
        
        if (filter.minRating > course.rating) {
          return false;
        }
        
        if (filter.maxPrice < course.price) {
          return false;
        }
        
        if (filter.freeOnly && course.price > 0) {
          return false;
        }
        
        return true;
      }).toList();
    }

    return mockCourses;
  }

  CourseDetails _getMockCourseDetails(int courseId) {
    return const CourseDetails(
      title: 'UI/UX Basic Fundamentals',
      about: 'Learn web design in 1 hour with 25+ simple-to-use rules and guidelines — tons of amazing web design resources included!',
      instructor: 'Devonne Wallbridge',
      instructorAvatar: '/images/avatars/1.png',
      instructorPosition: 'Web Developer, Designer, and Teacher',
      skillLevel: 'All Level',
      totalStudents: 38815,
      language: 'English',
      isCaptions: true,
      length: '1.5 total hours',
      totalLectures: 19,
      description: [
        'The material of this course is also covered in my other course about web design and development with HTML5 & CSS3.',
        'Best web design course: If you\'re interested in web design, but want more than just a "how to use WordPress" course, I highly recommend this one.',
        'Very helpful to us left-brained people: I am familiar with HTML, CSS, jQuery, and Twitter Bootstrap, but I needed instruction in web design.'
      ],
      content: [
        CourseSection(
          title: 'Course Content',
          id: 'section1',
          topics: [
            CourseTopic(title: 'Welcome to this course', time: '2.4 min', isCompleted: true),
            CourseTopic(title: 'Watch before you start', time: '4.8 min', isCompleted: true),
            CourseTopic(title: 'Basic Design theory', time: '5.9 min', isCompleted: false),
            CourseTopic(title: 'Basic Fundamentals', time: '3.6 min', isCompleted: false),
            CourseTopic(title: 'What is ui/ux', time: '10.6 min', isCompleted: false),
          ],
        ),
      ],
      price: 49.99,
      currency: 'USD',
      rating: 4.8,
      reviewCount: 156,
    );
  }

  AcademyDashboard _getMockDashboardData() {
    return AcademyDashboard(
      stats: const AcademyStats(
        totalCourses: 150,
        totalStudents: 12500,
        totalInstructors: 45,
        averageRating: 4.6,
        totalCompletions: 8500,
        totalHoursWatched: 95000,
        activeStudents: 3200,
        newEnrollments: 450,
        completionRate: 68.0,
        revenueThisMonth: 125000.0,
      ),
      popularCourses: _getMockCourses().take(6).toList(),
      recentCourses: _getMockCourses().take(4).toList(),
      topInstructors: _getMockInstructors().take(4).toList(),
      recentActivities: _getMockActivities(10),
      userProgress: _getMockStudentProgress('current_user'),
    );
  }

  List<StudentProgress> _getMockStudentProgress(String studentId) {
    return [
      StudentProgress(
        courseId: '1',
        studentId: studentId,
        progressPercentage: 76.0,
        completedLessons: 19,
        totalLessons: 25,
        lastAccessed: DateTime.now().subtract(const Duration(hours: 2)),
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        timeSpent: 1054, // 17h 34m
        currentScore: 85.5,
      ),
      StudentProgress(
        courseId: '2',
        studentId: studentId,
        progressPercentage: 92.3,
        completedLessons: 48,
        totalLessons: 52,
        lastAccessed: DateTime.now().subtract(const Duration(hours: 5)),
        startDate: DateTime.now().subtract(const Duration(days: 45)),
        timeSpent: 1157, // 19h 17m
        currentScore: 91.2,
      ),
    ];
  }

  List<Instructor> _getMockInstructors() {
    return [
      Instructor(
        id: '1',
        name: 'Lauretta Coie',
        email: 'lauretta@academy.com',
        avatar: '/images/avatars/1.png',
        position: 'Senior Frontend Developer',
        bio: 'Expert in Angular and modern web development with 8+ years of experience.',
        courseIds: ['1', '12'],
        joinDate: DateTime.now().subtract(const Duration(days: 365)),
        totalStudents: 1250,
        rating: 4.8,
        reviewCount: 89,
        specializations: ['Angular', 'TypeScript', 'Web Development'],
      ),
      Instructor(
        id: '2',
        name: 'Maybelle Zmitrovich',
        email: 'maybelle@academy.com',
        avatar: '/images/avatars/2.png',
        position: 'UI/UX Design Lead',
        bio: 'Creative designer with expertise in Figma and user experience design.',
        courseIds: ['2', '8'],
        joinDate: DateTime.now().subtract(const Duration(days: 300)),
        totalStudents: 980,
        rating: 4.9,
        reviewCount: 67,
        specializations: ['UI/UX Design', 'Figma', 'Design Systems'],
      ),
    ];
  }

  List<Review> _getMockReviews(String courseId) {
    return [
      Review(
        id: '1',
        courseId: courseId,
        studentId: 'student1',
        studentName: 'John Doe',
        studentAvatar: '/images/avatars/4.png',
        rating: 5.0,
        comment: 'Excellent course! Very well structured and easy to follow.',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        helpfulCount: 12,
        isVerifiedPurchase: true,
      ),
      Review(
        id: '2',
        courseId: courseId,
        studentId: 'student2',
        studentName: 'Jane Smith',
        studentAvatar: '/images/avatars/5.png',
        rating: 4.5,
        comment: 'Great content and practical examples. Highly recommended!',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        helpfulCount: 8,
        isVerifiedPurchase: true,
      ),
    ];
  }

  List<Activity> _getMockActivities(int limit) {
    final activities = [
      Activity(
        id: '1',
        type: 'enrollment',
        title: 'New Enrollment',
        description: 'John Doe enrolled in Angular Basics',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        userId: 'john_doe',
        courseId: '1',
        icon: 'school',
        priority: 'info',
      ),
      Activity(
        id: '2',
        type: 'completion',
        title: 'Course Completed',
        description: 'Sarah Johnson completed UI/UX Design Fundamentals',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        userId: 'sarah_johnson',
        courseId: '2',
        icon: 'check_circle',
        priority: 'success',
      ),
      Activity(
        id: '3',
        type: 'achievement',
        title: 'Achievement Unlocked',
        description: 'Mike Brown earned the "Fast Learner" badge',
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
        userId: 'mike_brown',
        icon: 'emoji_events',
        priority: 'warning',
      ),
    ];

    return activities.take(limit).toList();
  }
}