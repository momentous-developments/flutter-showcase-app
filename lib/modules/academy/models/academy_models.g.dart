// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academy_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseImpl _$$CourseImplFromJson(Map<String, dynamic> json) => _$CourseImpl(
      id: (json['id'] as num).toInt(),
      courseTitle: json['courseTitle'] as String,
      desc: json['desc'] as String,
      user: json['user'] as String,
      image: json['image'] as String,
      tutorImg: json['tutorImg'] as String,
      completedTasks: (json['completedTasks'] as num).toInt(),
      totalTasks: (json['totalTasks'] as num).toInt(),
      userCount: (json['userCount'] as num).toInt(),
      note: (json['note'] as num).toInt(),
      view: (json['view'] as num).toInt(),
      time: json['time'] as String,
      logo: json['logo'] as String,
      color: json['color'] as String,
      tags: json['tags'] as String,
      rating: (json['rating'] as num).toDouble(),
      ratingCount: (json['ratingCount'] as num).toInt(),
      isEnrolled: json['isEnrolled'] as bool? ?? false,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? '',
      level: json['level'] as String? ?? '',
      language: json['language'] as String? ?? '',
    );

Map<String, dynamic> _$$CourseImplToJson(_$CourseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseTitle': instance.courseTitle,
      'desc': instance.desc,
      'user': instance.user,
      'image': instance.image,
      'tutorImg': instance.tutorImg,
      'completedTasks': instance.completedTasks,
      'totalTasks': instance.totalTasks,
      'userCount': instance.userCount,
      'note': instance.note,
      'view': instance.view,
      'time': instance.time,
      'logo': instance.logo,
      'color': instance.color,
      'tags': instance.tags,
      'rating': instance.rating,
      'ratingCount': instance.ratingCount,
      'isEnrolled': instance.isEnrolled,
      'price': instance.price,
      'currency': instance.currency,
      'level': instance.level,
      'language': instance.language,
    };

_$CourseDetailsImpl _$$CourseDetailsImplFromJson(Map<String, dynamic> json) =>
    _$CourseDetailsImpl(
      title: json['title'] as String,
      about: json['about'] as String,
      instructor: json['instructor'] as String,
      instructorAvatar: json['instructorAvatar'] as String,
      instructorPosition: json['instructorPosition'] as String,
      skillLevel: json['skillLevel'] as String,
      totalStudents: (json['totalStudents'] as num).toInt(),
      language: json['language'] as String,
      isCaptions: json['isCaptions'] as bool,
      length: json['length'] as String,
      totalLectures: (json['totalLectures'] as num).toInt(),
      description: (json['description'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      content: (json['content'] as List<dynamic>)
          .map((e) => CourseSection.fromJson(e as Map<String, dynamic>))
          .toList(),
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? 'USD',
      enrolledStudents: (json['enrolledStudents'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 4.5,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$CourseDetailsImplToJson(_$CourseDetailsImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'about': instance.about,
      'instructor': instance.instructor,
      'instructorAvatar': instance.instructorAvatar,
      'instructorPosition': instance.instructorPosition,
      'skillLevel': instance.skillLevel,
      'totalStudents': instance.totalStudents,
      'language': instance.language,
      'isCaptions': instance.isCaptions,
      'length': instance.length,
      'totalLectures': instance.totalLectures,
      'description': instance.description,
      'content': instance.content,
      'price': instance.price,
      'currency': instance.currency,
      'enrolledStudents': instance.enrolledStudents,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
    };

_$CourseSectionImpl _$$CourseSectionImplFromJson(Map<String, dynamic> json) =>
    _$CourseSectionImpl(
      title: json['title'] as String,
      id: json['id'] as String,
      topics: (json['topics'] as List<dynamic>)
          .map((e) => CourseTopic.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDuration: (json['totalDuration'] as num?)?.toInt() ?? 0,
      completedTopics: (json['completedTopics'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$CourseSectionImplToJson(_$CourseSectionImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'topics': instance.topics,
      'totalDuration': instance.totalDuration,
      'completedTopics': instance.completedTopics,
    };

_$CourseTopicImpl _$$CourseTopicImplFromJson(Map<String, dynamic> json) =>
    _$CourseTopicImpl(
      title: json['title'] as String,
      time: json['time'] as String,
      isCompleted: json['isCompleted'] as bool,
      id: json['id'] as String? ?? '',
      type: json['type'] as String? ?? 'video',
      url: json['url'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$$CourseTopicImplToJson(_$CourseTopicImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'time': instance.time,
      'isCompleted': instance.isCompleted,
      'id': instance.id,
      'type': instance.type,
      'url': instance.url,
      'description': instance.description,
    };

_$StudentImpl _$$StudentImplFromJson(Map<String, dynamic> json) =>
    _$StudentImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String,
      joinDate: DateTime.parse(json['joinDate'] as String),
      enrolledCourses: (json['enrolledCourses'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      progress: (json['progress'] as List<dynamic>)
          .map((e) => StudentProgress.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCoursesCompleted:
          (json['totalCoursesCompleted'] as num?)?.toInt() ?? 0,
      totalHoursSpent: (json['totalHoursSpent'] as num?)?.toInt() ?? 0,
      averageScore: (json['averageScore'] as num?)?.toDouble() ?? 0.0,
      achievements: (json['achievements'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      bio: json['bio'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
    );

Map<String, dynamic> _$$StudentImplToJson(_$StudentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
      'joinDate': instance.joinDate.toIso8601String(),
      'enrolledCourses': instance.enrolledCourses,
      'progress': instance.progress,
      'totalCoursesCompleted': instance.totalCoursesCompleted,
      'totalHoursSpent': instance.totalHoursSpent,
      'averageScore': instance.averageScore,
      'achievements': instance.achievements,
      'bio': instance.bio,
      'phone': instance.phone,
    };

_$StudentProgressImpl _$$StudentProgressImplFromJson(
        Map<String, dynamic> json) =>
    _$StudentProgressImpl(
      courseId: json['courseId'] as String,
      studentId: json['studentId'] as String,
      progressPercentage: (json['progressPercentage'] as num).toDouble(),
      completedLessons: (json['completedLessons'] as num).toInt(),
      totalLessons: (json['totalLessons'] as num).toInt(),
      lastAccessed: DateTime.parse(json['lastAccessed'] as String),
      startDate: DateTime.parse(json['startDate'] as String),
      timeSpent: (json['timeSpent'] as num?)?.toInt() ?? 0,
      currentScore: (json['currentScore'] as num?)?.toDouble() ?? 0.0,
      completedTopicIds: (json['completedTopicIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      completionDate: json['completionDate'] == null
          ? null
          : DateTime.parse(json['completionDate'] as String),
    );

Map<String, dynamic> _$$StudentProgressImplToJson(
        _$StudentProgressImpl instance) =>
    <String, dynamic>{
      'courseId': instance.courseId,
      'studentId': instance.studentId,
      'progressPercentage': instance.progressPercentage,
      'completedLessons': instance.completedLessons,
      'totalLessons': instance.totalLessons,
      'lastAccessed': instance.lastAccessed.toIso8601String(),
      'startDate': instance.startDate.toIso8601String(),
      'timeSpent': instance.timeSpent,
      'currentScore': instance.currentScore,
      'completedTopicIds': instance.completedTopicIds,
      'completionDate': instance.completionDate?.toIso8601String(),
    };

_$InstructorImpl _$$InstructorImplFromJson(Map<String, dynamic> json) =>
    _$InstructorImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String,
      position: json['position'] as String,
      bio: json['bio'] as String,
      courseIds:
          (json['courseIds'] as List<dynamic>).map((e) => e as String).toList(),
      joinDate: DateTime.parse(json['joinDate'] as String),
      totalStudents: (json['totalStudents'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 4.5,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      specializations: (json['specializations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      qualifications: (json['qualifications'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      phone: json['phone'] as String? ?? '',
      linkedin: json['linkedin'] as String? ?? '',
      website: json['website'] as String? ?? '',
    );

Map<String, dynamic> _$$InstructorImplToJson(_$InstructorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
      'position': instance.position,
      'bio': instance.bio,
      'courseIds': instance.courseIds,
      'joinDate': instance.joinDate.toIso8601String(),
      'totalStudents': instance.totalStudents,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'specializations': instance.specializations,
      'qualifications': instance.qualifications,
      'phone': instance.phone,
      'linkedin': instance.linkedin,
      'website': instance.website,
    };

_$ActivityImpl _$$ActivityImplFromJson(Map<String, dynamic> json) =>
    _$ActivityImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      userId: json['userId'] as String,
      courseId: json['courseId'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      priority: json['priority'] as String? ?? 'info',
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ActivityImplToJson(_$ActivityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'description': instance.description,
      'timestamp': instance.timestamp.toIso8601String(),
      'userId': instance.userId,
      'courseId': instance.courseId,
      'icon': instance.icon,
      'priority': instance.priority,
      'metadata': instance.metadata,
    };

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      studentId: json['studentId'] as String,
      studentName: json['studentName'] as String,
      studentAvatar: json['studentAvatar'] as String,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      helpfulCount: (json['helpfulCount'] as num?)?.toInt() ?? 0,
      isVerifiedPurchase: json['isVerifiedPurchase'] as bool? ?? false,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'studentId': instance.studentId,
      'studentName': instance.studentName,
      'studentAvatar': instance.studentAvatar,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt.toIso8601String(),
      'helpfulCount': instance.helpfulCount,
      'isVerifiedPurchase': instance.isVerifiedPurchase,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$AcademyStatsImpl _$$AcademyStatsImplFromJson(Map<String, dynamic> json) =>
    _$AcademyStatsImpl(
      totalCourses: (json['totalCourses'] as num).toInt(),
      totalStudents: (json['totalStudents'] as num).toInt(),
      totalInstructors: (json['totalInstructors'] as num).toInt(),
      averageRating: (json['averageRating'] as num).toDouble(),
      totalCompletions: (json['totalCompletions'] as num).toInt(),
      totalHoursWatched: (json['totalHoursWatched'] as num).toInt(),
      activeStudents: (json['activeStudents'] as num?)?.toInt() ?? 0,
      newEnrollments: (json['newEnrollments'] as num?)?.toInt() ?? 0,
      completionRate: (json['completionRate'] as num?)?.toDouble() ?? 0.0,
      revenueThisMonth: (json['revenueThisMonth'] as num?)?.toDouble() ?? 0.0,
      categoryStats: (json['categoryStats'] as List<dynamic>?)
              ?.map((e) => CategoryStats.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AcademyStatsImplToJson(_$AcademyStatsImpl instance) =>
    <String, dynamic>{
      'totalCourses': instance.totalCourses,
      'totalStudents': instance.totalStudents,
      'totalInstructors': instance.totalInstructors,
      'averageRating': instance.averageRating,
      'totalCompletions': instance.totalCompletions,
      'totalHoursWatched': instance.totalHoursWatched,
      'activeStudents': instance.activeStudents,
      'newEnrollments': instance.newEnrollments,
      'completionRate': instance.completionRate,
      'revenueThisMonth': instance.revenueThisMonth,
      'categoryStats': instance.categoryStats,
    };

_$CategoryStatsImpl _$$CategoryStatsImplFromJson(Map<String, dynamic> json) =>
    _$CategoryStatsImpl(
      category: json['category'] as String,
      courseCount: (json['courseCount'] as num).toInt(),
      enrollmentCount: (json['enrollmentCount'] as num).toInt(),
      averageRating: (json['averageRating'] as num).toDouble(),
      completionRate: (json['completionRate'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$CategoryStatsImplToJson(_$CategoryStatsImpl instance) =>
    <String, dynamic>{
      'category': instance.category,
      'courseCount': instance.courseCount,
      'enrollmentCount': instance.enrollmentCount,
      'averageRating': instance.averageRating,
      'completionRate': instance.completionRate,
    };

_$CourseFilterImpl _$$CourseFilterImplFromJson(Map<String, dynamic> json) =>
    _$CourseFilterImpl(
      searchQuery: json['searchQuery'] as String? ?? '',
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      levels: (json['levels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      languages: (json['languages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      minRating: (json['minRating'] as num?)?.toDouble() ?? 0.0,
      maxPrice: (json['maxPrice'] as num?)?.toDouble() ?? double.infinity,
      sortBy: json['sortBy'] as String? ?? 'title',
      sortDescending: json['sortDescending'] as bool? ?? false,
      freeOnly: json['freeOnly'] as bool? ?? false,
      enrolledOnly: json['enrolledOnly'] as bool? ?? false,
    );

Map<String, dynamic> _$$CourseFilterImplToJson(_$CourseFilterImpl instance) =>
    <String, dynamic>{
      'searchQuery': instance.searchQuery,
      'categories': instance.categories,
      'levels': instance.levels,
      'languages': instance.languages,
      'minRating': instance.minRating,
      'maxPrice': instance.maxPrice,
      'sortBy': instance.sortBy,
      'sortDescending': instance.sortDescending,
      'freeOnly': instance.freeOnly,
      'enrolledOnly': instance.enrolledOnly,
    };

_$AcademyDashboardImpl _$$AcademyDashboardImplFromJson(
        Map<String, dynamic> json) =>
    _$AcademyDashboardImpl(
      stats: AcademyStats.fromJson(json['stats'] as Map<String, dynamic>),
      popularCourses: (json['popularCourses'] as List<dynamic>)
          .map((e) => Course.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentCourses: (json['recentCourses'] as List<dynamic>)
          .map((e) => Course.fromJson(e as Map<String, dynamic>))
          .toList(),
      topInstructors: (json['topInstructors'] as List<dynamic>)
          .map((e) => Instructor.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentActivities: (json['recentActivities'] as List<dynamic>)
          .map((e) => Activity.fromJson(e as Map<String, dynamic>))
          .toList(),
      userProgress: (json['userProgress'] as List<dynamic>)
          .map((e) => StudentProgress.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendedCourses: (json['recommendedCourses'] as List<dynamic>?)
              ?.map((e) => Course.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      upcomingDeadlines: (json['upcomingDeadlines'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AcademyDashboardImplToJson(
        _$AcademyDashboardImpl instance) =>
    <String, dynamic>{
      'stats': instance.stats,
      'popularCourses': instance.popularCourses,
      'recentCourses': instance.recentCourses,
      'topInstructors': instance.topInstructors,
      'recentActivities': instance.recentActivities,
      'userProgress': instance.userProgress,
      'recommendedCourses': instance.recommendedCourses,
      'upcomingDeadlines': instance.upcomingDeadlines,
    };
