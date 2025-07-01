// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academy_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$academyServiceHash() => r'038628bfc843b15d3eea2447475d3f7925d90bdd';

/// Academy service provider
///
/// Copied from [academyService].
@ProviderFor(academyService)
final academyServiceProvider = AutoDisposeProvider<AcademyService>.internal(
  academyService,
  name: r'academyServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$academyServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AcademyServiceRef = AutoDisposeProviderRef<AcademyService>;
String _$coursesHash() => r'cbf481d33769be3ef2ecf10bc35c6672a5aa805f';

/// Courses provider with filtering
///
/// Copied from [courses].
@ProviderFor(courses)
final coursesProvider = AutoDisposeFutureProvider<List<Course>>.internal(
  courses,
  name: r'coursesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$coursesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CoursesRef = AutoDisposeFutureProviderRef<List<Course>>;
String _$courseHash() => r'be1e704ad9885466972dbb0d6d4f8bd4091f9339';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Single course provider
///
/// Copied from [course].
@ProviderFor(course)
const courseProvider = CourseFamily();

/// Single course provider
///
/// Copied from [course].
class CourseFamily extends Family<AsyncValue<Course?>> {
  /// Single course provider
  ///
  /// Copied from [course].
  const CourseFamily();

  /// Single course provider
  ///
  /// Copied from [course].
  CourseProvider call(
    int courseId,
  ) {
    return CourseProvider(
      courseId,
    );
  }

  @override
  CourseProvider getProviderOverride(
    covariant CourseProvider provider,
  ) {
    return call(
      provider.courseId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'courseProvider';
}

/// Single course provider
///
/// Copied from [course].
class CourseProvider extends AutoDisposeFutureProvider<Course?> {
  /// Single course provider
  ///
  /// Copied from [course].
  CourseProvider(
    int courseId,
  ) : this._internal(
          (ref) => course(
            ref as CourseRef,
            courseId,
          ),
          from: courseProvider,
          name: r'courseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$courseHash,
          dependencies: CourseFamily._dependencies,
          allTransitiveDependencies: CourseFamily._allTransitiveDependencies,
          courseId: courseId,
        );

  CourseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.courseId,
  }) : super.internal();

  final int courseId;

  @override
  Override overrideWith(
    FutureOr<Course?> Function(CourseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseProvider._internal(
        (ref) => create(ref as CourseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        courseId: courseId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Course?> createElement() {
    return _CourseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseProvider && other.courseId == courseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, courseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CourseRef on AutoDisposeFutureProviderRef<Course?> {
  /// The parameter `courseId` of this provider.
  int get courseId;
}

class _CourseProviderElement extends AutoDisposeFutureProviderElement<Course?>
    with CourseRef {
  _CourseProviderElement(super.provider);

  @override
  int get courseId => (origin as CourseProvider).courseId;
}

String _$courseDetailsHash() => r'f5f1bd170ed533bc382e57590af7461ccb9e0074';

/// Course details provider
///
/// Copied from [courseDetails].
@ProviderFor(courseDetails)
const courseDetailsProvider = CourseDetailsFamily();

/// Course details provider
///
/// Copied from [courseDetails].
class CourseDetailsFamily extends Family<AsyncValue<CourseDetails?>> {
  /// Course details provider
  ///
  /// Copied from [courseDetails].
  const CourseDetailsFamily();

  /// Course details provider
  ///
  /// Copied from [courseDetails].
  CourseDetailsProvider call(
    int courseId,
  ) {
    return CourseDetailsProvider(
      courseId,
    );
  }

  @override
  CourseDetailsProvider getProviderOverride(
    covariant CourseDetailsProvider provider,
  ) {
    return call(
      provider.courseId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'courseDetailsProvider';
}

/// Course details provider
///
/// Copied from [courseDetails].
class CourseDetailsProvider extends AutoDisposeFutureProvider<CourseDetails?> {
  /// Course details provider
  ///
  /// Copied from [courseDetails].
  CourseDetailsProvider(
    int courseId,
  ) : this._internal(
          (ref) => courseDetails(
            ref as CourseDetailsRef,
            courseId,
          ),
          from: courseDetailsProvider,
          name: r'courseDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$courseDetailsHash,
          dependencies: CourseDetailsFamily._dependencies,
          allTransitiveDependencies:
              CourseDetailsFamily._allTransitiveDependencies,
          courseId: courseId,
        );

  CourseDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.courseId,
  }) : super.internal();

  final int courseId;

  @override
  Override overrideWith(
    FutureOr<CourseDetails?> Function(CourseDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseDetailsProvider._internal(
        (ref) => create(ref as CourseDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        courseId: courseId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CourseDetails?> createElement() {
    return _CourseDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseDetailsProvider && other.courseId == courseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, courseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CourseDetailsRef on AutoDisposeFutureProviderRef<CourseDetails?> {
  /// The parameter `courseId` of this provider.
  int get courseId;
}

class _CourseDetailsProviderElement
    extends AutoDisposeFutureProviderElement<CourseDetails?>
    with CourseDetailsRef {
  _CourseDetailsProviderElement(super.provider);

  @override
  int get courseId => (origin as CourseDetailsProvider).courseId;
}

String _$academyDashboardHash() => r'f4a74724035eec756a306df5ead58b7e9580fc92';

/// Academy dashboard provider
///
/// Copied from [academyDashboard].
@ProviderFor(academyDashboard)
final academyDashboardProvider =
    AutoDisposeFutureProvider<AcademyDashboard>.internal(
  academyDashboard,
  name: r'academyDashboardProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$academyDashboardHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AcademyDashboardRef = AutoDisposeFutureProviderRef<AcademyDashboard>;
String _$studentProgressHash() => r'553712c6ff311a33f89ef08c9bb34f8090e0400f';

/// Student progress provider
///
/// Copied from [studentProgress].
@ProviderFor(studentProgress)
const studentProgressProvider = StudentProgressFamily();

/// Student progress provider
///
/// Copied from [studentProgress].
class StudentProgressFamily extends Family<AsyncValue<List<StudentProgress>>> {
  /// Student progress provider
  ///
  /// Copied from [studentProgress].
  const StudentProgressFamily();

  /// Student progress provider
  ///
  /// Copied from [studentProgress].
  StudentProgressProvider call(
    String studentId,
  ) {
    return StudentProgressProvider(
      studentId,
    );
  }

  @override
  StudentProgressProvider getProviderOverride(
    covariant StudentProgressProvider provider,
  ) {
    return call(
      provider.studentId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'studentProgressProvider';
}

/// Student progress provider
///
/// Copied from [studentProgress].
class StudentProgressProvider
    extends AutoDisposeFutureProvider<List<StudentProgress>> {
  /// Student progress provider
  ///
  /// Copied from [studentProgress].
  StudentProgressProvider(
    String studentId,
  ) : this._internal(
          (ref) => studentProgress(
            ref as StudentProgressRef,
            studentId,
          ),
          from: studentProgressProvider,
          name: r'studentProgressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$studentProgressHash,
          dependencies: StudentProgressFamily._dependencies,
          allTransitiveDependencies:
              StudentProgressFamily._allTransitiveDependencies,
          studentId: studentId,
        );

  StudentProgressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.studentId,
  }) : super.internal();

  final String studentId;

  @override
  Override overrideWith(
    FutureOr<List<StudentProgress>> Function(StudentProgressRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StudentProgressProvider._internal(
        (ref) => create(ref as StudentProgressRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        studentId: studentId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<StudentProgress>> createElement() {
    return _StudentProgressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StudentProgressProvider && other.studentId == studentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, studentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StudentProgressRef
    on AutoDisposeFutureProviderRef<List<StudentProgress>> {
  /// The parameter `studentId` of this provider.
  String get studentId;
}

class _StudentProgressProviderElement
    extends AutoDisposeFutureProviderElement<List<StudentProgress>>
    with StudentProgressRef {
  _StudentProgressProviderElement(super.provider);

  @override
  String get studentId => (origin as StudentProgressProvider).studentId;
}

String _$instructorsHash() => r'062a33ab15fae0582e1331a80f3ecbd082145756';

/// Instructors provider
///
/// Copied from [instructors].
@ProviderFor(instructors)
final instructorsProvider =
    AutoDisposeFutureProvider<List<Instructor>>.internal(
  instructors,
  name: r'instructorsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$instructorsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InstructorsRef = AutoDisposeFutureProviderRef<List<Instructor>>;
String _$courseReviewsHash() => r'd82a991e405e207fd83742e2b1045b5c9e77f477';

/// Course reviews provider
///
/// Copied from [courseReviews].
@ProviderFor(courseReviews)
const courseReviewsProvider = CourseReviewsFamily();

/// Course reviews provider
///
/// Copied from [courseReviews].
class CourseReviewsFamily extends Family<AsyncValue<List<Review>>> {
  /// Course reviews provider
  ///
  /// Copied from [courseReviews].
  const CourseReviewsFamily();

  /// Course reviews provider
  ///
  /// Copied from [courseReviews].
  CourseReviewsProvider call(
    String courseId,
  ) {
    return CourseReviewsProvider(
      courseId,
    );
  }

  @override
  CourseReviewsProvider getProviderOverride(
    covariant CourseReviewsProvider provider,
  ) {
    return call(
      provider.courseId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'courseReviewsProvider';
}

/// Course reviews provider
///
/// Copied from [courseReviews].
class CourseReviewsProvider extends AutoDisposeFutureProvider<List<Review>> {
  /// Course reviews provider
  ///
  /// Copied from [courseReviews].
  CourseReviewsProvider(
    String courseId,
  ) : this._internal(
          (ref) => courseReviews(
            ref as CourseReviewsRef,
            courseId,
          ),
          from: courseReviewsProvider,
          name: r'courseReviewsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$courseReviewsHash,
          dependencies: CourseReviewsFamily._dependencies,
          allTransitiveDependencies:
              CourseReviewsFamily._allTransitiveDependencies,
          courseId: courseId,
        );

  CourseReviewsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.courseId,
  }) : super.internal();

  final String courseId;

  @override
  Override overrideWith(
    FutureOr<List<Review>> Function(CourseReviewsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseReviewsProvider._internal(
        (ref) => create(ref as CourseReviewsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        courseId: courseId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Review>> createElement() {
    return _CourseReviewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseReviewsProvider && other.courseId == courseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, courseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CourseReviewsRef on AutoDisposeFutureProviderRef<List<Review>> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _CourseReviewsProviderElement
    extends AutoDisposeFutureProviderElement<List<Review>>
    with CourseReviewsRef {
  _CourseReviewsProviderElement(super.provider);

  @override
  String get courseId => (origin as CourseReviewsProvider).courseId;
}

String _$recentActivitiesHash() => r'605e9c3c43e76f837fe4766953f51adb18ce7596';

/// Recent activities provider
///
/// Copied from [recentActivities].
@ProviderFor(recentActivities)
const recentActivitiesProvider = RecentActivitiesFamily();

/// Recent activities provider
///
/// Copied from [recentActivities].
class RecentActivitiesFamily extends Family<AsyncValue<List<Activity>>> {
  /// Recent activities provider
  ///
  /// Copied from [recentActivities].
  const RecentActivitiesFamily();

  /// Recent activities provider
  ///
  /// Copied from [recentActivities].
  RecentActivitiesProvider call({
    int limit = 20,
  }) {
    return RecentActivitiesProvider(
      limit: limit,
    );
  }

  @override
  RecentActivitiesProvider getProviderOverride(
    covariant RecentActivitiesProvider provider,
  ) {
    return call(
      limit: provider.limit,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'recentActivitiesProvider';
}

/// Recent activities provider
///
/// Copied from [recentActivities].
class RecentActivitiesProvider
    extends AutoDisposeFutureProvider<List<Activity>> {
  /// Recent activities provider
  ///
  /// Copied from [recentActivities].
  RecentActivitiesProvider({
    int limit = 20,
  }) : this._internal(
          (ref) => recentActivities(
            ref as RecentActivitiesRef,
            limit: limit,
          ),
          from: recentActivitiesProvider,
          name: r'recentActivitiesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recentActivitiesHash,
          dependencies: RecentActivitiesFamily._dependencies,
          allTransitiveDependencies:
              RecentActivitiesFamily._allTransitiveDependencies,
          limit: limit,
        );

  RecentActivitiesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.limit,
  }) : super.internal();

  final int limit;

  @override
  Override overrideWith(
    FutureOr<List<Activity>> Function(RecentActivitiesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RecentActivitiesProvider._internal(
        (ref) => create(ref as RecentActivitiesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Activity>> createElement() {
    return _RecentActivitiesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecentActivitiesProvider && other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RecentActivitiesRef on AutoDisposeFutureProviderRef<List<Activity>> {
  /// The parameter `limit` of this provider.
  int get limit;
}

class _RecentActivitiesProviderElement
    extends AutoDisposeFutureProviderElement<List<Activity>>
    with RecentActivitiesRef {
  _RecentActivitiesProviderElement(super.provider);

  @override
  int get limit => (origin as RecentActivitiesProvider).limit;
}

String _$popularCoursesHash() => r'5be6d74aba85ee1466a4c132e1574c8427602cad';

/// Popular courses provider (subset of all courses)
///
/// Copied from [popularCourses].
@ProviderFor(popularCourses)
final popularCoursesProvider = AutoDisposeFutureProvider<List<Course>>.internal(
  popularCourses,
  name: r'popularCoursesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$popularCoursesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PopularCoursesRef = AutoDisposeFutureProviderRef<List<Course>>;
String _$enrolledCoursesHash() => r'eb2d698a421c867ab8b6424327b6af4d7352908a';

/// User's enrolled courses provider
///
/// Copied from [enrolledCourses].
@ProviderFor(enrolledCourses)
const enrolledCoursesProvider = EnrolledCoursesFamily();

/// User's enrolled courses provider
///
/// Copied from [enrolledCourses].
class EnrolledCoursesFamily extends Family<AsyncValue<List<Course>>> {
  /// User's enrolled courses provider
  ///
  /// Copied from [enrolledCourses].
  const EnrolledCoursesFamily();

  /// User's enrolled courses provider
  ///
  /// Copied from [enrolledCourses].
  EnrolledCoursesProvider call(
    String studentId,
  ) {
    return EnrolledCoursesProvider(
      studentId,
    );
  }

  @override
  EnrolledCoursesProvider getProviderOverride(
    covariant EnrolledCoursesProvider provider,
  ) {
    return call(
      provider.studentId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'enrolledCoursesProvider';
}

/// User's enrolled courses provider
///
/// Copied from [enrolledCourses].
class EnrolledCoursesProvider extends AutoDisposeFutureProvider<List<Course>> {
  /// User's enrolled courses provider
  ///
  /// Copied from [enrolledCourses].
  EnrolledCoursesProvider(
    String studentId,
  ) : this._internal(
          (ref) => enrolledCourses(
            ref as EnrolledCoursesRef,
            studentId,
          ),
          from: enrolledCoursesProvider,
          name: r'enrolledCoursesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$enrolledCoursesHash,
          dependencies: EnrolledCoursesFamily._dependencies,
          allTransitiveDependencies:
              EnrolledCoursesFamily._allTransitiveDependencies,
          studentId: studentId,
        );

  EnrolledCoursesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.studentId,
  }) : super.internal();

  final String studentId;

  @override
  Override overrideWith(
    FutureOr<List<Course>> Function(EnrolledCoursesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EnrolledCoursesProvider._internal(
        (ref) => create(ref as EnrolledCoursesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        studentId: studentId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Course>> createElement() {
    return _EnrolledCoursesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EnrolledCoursesProvider && other.studentId == studentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, studentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EnrolledCoursesRef on AutoDisposeFutureProviderRef<List<Course>> {
  /// The parameter `studentId` of this provider.
  String get studentId;
}

class _EnrolledCoursesProviderElement
    extends AutoDisposeFutureProviderElement<List<Course>>
    with EnrolledCoursesRef {
  _EnrolledCoursesProviderElement(super.provider);

  @override
  String get studentId => (origin as EnrolledCoursesProvider).studentId;
}

String _$courseCategoriesHash() => r'3f429992016546b3dc761318e0f91043f7798aac';

/// Categories provider (derived from courses)
///
/// Copied from [courseCategories].
@ProviderFor(courseCategories)
final courseCategoriesProvider =
    AutoDisposeFutureProvider<List<String>>.internal(
  courseCategories,
  name: r'courseCategoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$courseCategoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CourseCategoriesRef = AutoDisposeFutureProviderRef<List<String>>;
String _$courseLevelsHash() => r'a3384d04483cb34027f8ab03c586dd20c7eb1f3a';

/// Course levels provider
///
/// Copied from [courseLevels].
@ProviderFor(courseLevels)
final courseLevelsProvider = AutoDisposeProvider<List<String>>.internal(
  courseLevels,
  name: r'courseLevelsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$courseLevelsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CourseLevelsRef = AutoDisposeProviderRef<List<String>>;
String _$courseLanguagesHash() => r'fd388b47a66eae34353fdebd61e431e8baaec9a9';

/// Course languages provider
///
/// Copied from [courseLanguages].
@ProviderFor(courseLanguages)
final courseLanguagesProvider = AutoDisposeProvider<List<String>>.internal(
  courseLanguages,
  name: r'courseLanguagesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$courseLanguagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CourseLanguagesRef = AutoDisposeProviderRef<List<String>>;
String _$currentUserIdHash() => r'4cd342540329b2d55a89201536bbcba0b57f436f';

/// Current user ID provider (mock)
///
/// Copied from [currentUserId].
@ProviderFor(currentUserId)
final currentUserIdProvider = AutoDisposeProvider<String>.internal(
  currentUserId,
  name: r'currentUserIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserIdRef = AutoDisposeProviderRef<String>;
String _$courseFilterNotifierHash() =>
    r'37f34bafa5937f8e63a13edee96aefb0b7736a0b';

/// Course filter provider
///
/// Copied from [CourseFilterNotifier].
@ProviderFor(CourseFilterNotifier)
final courseFilterNotifierProvider =
    AutoDisposeNotifierProvider<CourseFilterNotifier, CourseFilter>.internal(
  CourseFilterNotifier.new,
  name: r'courseFilterNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$courseFilterNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CourseFilterNotifier = AutoDisposeNotifier<CourseFilter>;
String _$enrollmentStateHash() => r'44de699688cbedad4cd4b5888a3703159d2031e2';

/// Enrollment state provider
///
/// Copied from [EnrollmentState].
@ProviderFor(EnrollmentState)
final enrollmentStateProvider =
    AutoDisposeNotifierProvider<EnrollmentState, Map<int, bool>>.internal(
  EnrollmentState.new,
  name: r'enrollmentStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$enrollmentStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EnrollmentState = AutoDisposeNotifier<Map<int, bool>>;
String _$courseProgressNotifierHash() =>
    r'aabd607209aae620962c10d404abac27d6e0695d';

/// Course progress update provider
///
/// Copied from [CourseProgressNotifier].
@ProviderFor(CourseProgressNotifier)
final courseProgressNotifierProvider = AutoDisposeNotifierProvider<
    CourseProgressNotifier, Map<String, StudentProgress>>.internal(
  CourseProgressNotifier.new,
  name: r'courseProgressNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$courseProgressNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CourseProgressNotifier
    = AutoDisposeNotifier<Map<String, StudentProgress>>;
String _$reviewSubmissionNotifierHash() =>
    r'3ec8cf447ea824f7274ceb9debba3e3349bd9fd9';

/// Review submission provider
///
/// Copied from [ReviewSubmissionNotifier].
@ProviderFor(ReviewSubmissionNotifier)
final reviewSubmissionNotifierProvider =
    AutoDisposeNotifierProvider<ReviewSubmissionNotifier, bool>.internal(
  ReviewSubmissionNotifier.new,
  name: r'reviewSubmissionNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reviewSubmissionNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReviewSubmissionNotifier = AutoDisposeNotifier<bool>;
String _$selectedCourseNotifierHash() =>
    r'f28436ec0da4138adefe659651c0a04d0d4aba46';

/// Selected course provider for navigation
///
/// Copied from [SelectedCourseNotifier].
@ProviderFor(SelectedCourseNotifier)
final selectedCourseNotifierProvider =
    AutoDisposeNotifierProvider<SelectedCourseNotifier, int?>.internal(
  SelectedCourseNotifier.new,
  name: r'selectedCourseNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedCourseNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedCourseNotifier = AutoDisposeNotifier<int?>;
String _$loadingStateHash() => r'1fe0661a85ca623c2922843c4d131da82e844e78';

/// Loading states
///
/// Copied from [LoadingState].
@ProviderFor(LoadingState)
final loadingStateProvider =
    AutoDisposeNotifierProvider<LoadingState, Map<String, bool>>.internal(
  LoadingState.new,
  name: r'loadingStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loadingStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LoadingState = AutoDisposeNotifier<Map<String, bool>>;
String _$errorStateHash() => r'5820a9afb62eec0d1c69080febbf652316fa421f';

/// Error states
///
/// Copied from [ErrorState].
@ProviderFor(ErrorState)
final errorStateProvider =
    AutoDisposeNotifierProvider<ErrorState, Map<String, String?>>.internal(
  ErrorState.new,
  name: r'errorStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$errorStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ErrorState = AutoDisposeNotifier<Map<String, String?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
