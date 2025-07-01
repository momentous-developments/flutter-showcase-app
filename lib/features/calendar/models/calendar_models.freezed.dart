// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Calendar _$CalendarFromJson(Map<String, dynamic> json) {
  return _Calendar.fromJson(json);
}

/// @nodoc
mixin _$Calendar {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @ColorConverter()
  Color get color => throw _privateConstructorUsedError;
  bool get isVisible => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;
  String? get ownerId => throw _privateConstructorUsedError;
  List<String> get sharedWith => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Calendar to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Calendar
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalendarCopyWith<Calendar> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarCopyWith<$Res> {
  factory $CalendarCopyWith(Calendar value, $Res Function(Calendar) then) =
      _$CalendarCopyWithImpl<$Res, Calendar>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      @ColorConverter() Color color,
      bool isVisible,
      bool isDefault,
      String? ownerId,
      List<String> sharedWith,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$CalendarCopyWithImpl<$Res, $Val extends Calendar>
    implements $CalendarCopyWith<$Res> {
  _$CalendarCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Calendar
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? color = null,
    Object? isVisible = null,
    Object? isDefault = null,
    Object? ownerId = freezed,
    Object? sharedWith = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      sharedWith: null == sharedWith
          ? _value.sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalendarImplCopyWith<$Res>
    implements $CalendarCopyWith<$Res> {
  factory _$$CalendarImplCopyWith(
          _$CalendarImpl value, $Res Function(_$CalendarImpl) then) =
      __$$CalendarImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      @ColorConverter() Color color,
      bool isVisible,
      bool isDefault,
      String? ownerId,
      List<String> sharedWith,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$CalendarImplCopyWithImpl<$Res>
    extends _$CalendarCopyWithImpl<$Res, _$CalendarImpl>
    implements _$$CalendarImplCopyWith<$Res> {
  __$$CalendarImplCopyWithImpl(
      _$CalendarImpl _value, $Res Function(_$CalendarImpl) _then)
      : super(_value, _then);

  /// Create a copy of Calendar
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? color = null,
    Object? isVisible = null,
    Object? isDefault = null,
    Object? ownerId = freezed,
    Object? sharedWith = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$CalendarImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      sharedWith: null == sharedWith
          ? _value._sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalendarImpl implements _Calendar {
  const _$CalendarImpl(
      {required this.id,
      required this.name,
      required this.description,
      @ColorConverter() required this.color,
      this.isVisible = true,
      this.isDefault = false,
      this.ownerId,
      final List<String> sharedWith = const [],
      this.createdAt,
      this.updatedAt})
      : _sharedWith = sharedWith;

  factory _$CalendarImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  @ColorConverter()
  final Color color;
  @override
  @JsonKey()
  final bool isVisible;
  @override
  @JsonKey()
  final bool isDefault;
  @override
  final String? ownerId;
  final List<String> _sharedWith;
  @override
  @JsonKey()
  List<String> get sharedWith {
    if (_sharedWith is EqualUnmodifiableListView) return _sharedWith;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sharedWith);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Calendar(id: $id, name: $name, description: $description, color: $color, isVisible: $isVisible, isDefault: $isDefault, ownerId: $ownerId, sharedWith: $sharedWith, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality()
                .equals(other._sharedWith, _sharedWith) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      color,
      isVisible,
      isDefault,
      ownerId,
      const DeepCollectionEquality().hash(_sharedWith),
      createdAt,
      updatedAt);

  /// Create a copy of Calendar
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarImplCopyWith<_$CalendarImpl> get copyWith =>
      __$$CalendarImplCopyWithImpl<_$CalendarImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalendarImplToJson(
      this,
    );
  }
}

abstract class _Calendar implements Calendar {
  const factory _Calendar(
      {required final String id,
      required final String name,
      required final String description,
      @ColorConverter() required final Color color,
      final bool isVisible,
      final bool isDefault,
      final String? ownerId,
      final List<String> sharedWith,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$CalendarImpl;

  factory _Calendar.fromJson(Map<String, dynamic> json) =
      _$CalendarImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  @ColorConverter()
  Color get color;
  @override
  bool get isVisible;
  @override
  bool get isDefault;
  @override
  String? get ownerId;
  @override
  List<String> get sharedWith;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Calendar
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalendarImplCopyWith<_$CalendarImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CalendarEvent _$CalendarEventFromJson(Map<String, dynamic> json) {
  return _CalendarEvent.fromJson(json);
}

/// @nodoc
mixin _$CalendarEvent {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get start => throw _privateConstructorUsedError;
  DateTime get end => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String get calendarId => throw _privateConstructorUsedError;
  bool get isAllDay => throw _privateConstructorUsedError;
  EventCategory get category => throw _privateConstructorUsedError;
  EventPriority get priority => throw _privateConstructorUsedError;
  List<String> get attendees => throw _privateConstructorUsedError;
  List<EventReminder> get reminders => throw _privateConstructorUsedError;
  RecurrenceRule? get recurrenceRule => throw _privateConstructorUsedError;
  String? get recurringEventId => throw _privateConstructorUsedError;
  EventStatus get status => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;

  /// Serializes this CalendarEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalendarEventCopyWith<CalendarEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarEventCopyWith<$Res> {
  factory $CalendarEventCopyWith(
          CalendarEvent value, $Res Function(CalendarEvent) then) =
      _$CalendarEventCopyWithImpl<$Res, CalendarEvent>;
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime start,
      DateTime end,
      String? description,
      String? location,
      String calendarId,
      bool isAllDay,
      EventCategory category,
      EventPriority priority,
      List<String> attendees,
      List<EventReminder> reminders,
      RecurrenceRule? recurrenceRule,
      String? recurringEventId,
      EventStatus status,
      Map<String, dynamic>? metadata,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? createdBy});

  $RecurrenceRuleCopyWith<$Res>? get recurrenceRule;
}

/// @nodoc
class _$CalendarEventCopyWithImpl<$Res, $Val extends CalendarEvent>
    implements $CalendarEventCopyWith<$Res> {
  _$CalendarEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? start = null,
    Object? end = null,
    Object? description = freezed,
    Object? location = freezed,
    Object? calendarId = null,
    Object? isAllDay = null,
    Object? category = null,
    Object? priority = null,
    Object? attendees = null,
    Object? reminders = null,
    Object? recurrenceRule = freezed,
    Object? recurringEventId = freezed,
    Object? status = null,
    Object? metadata = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? createdBy = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      calendarId: null == calendarId
          ? _value.calendarId
          : calendarId // ignore: cast_nullable_to_non_nullable
              as String,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as EventCategory,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as EventPriority,
      attendees: null == attendees
          ? _value.attendees
          : attendees // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reminders: null == reminders
          ? _value.reminders
          : reminders // ignore: cast_nullable_to_non_nullable
              as List<EventReminder>,
      recurrenceRule: freezed == recurrenceRule
          ? _value.recurrenceRule
          : recurrenceRule // ignore: cast_nullable_to_non_nullable
              as RecurrenceRule?,
      recurringEventId: freezed == recurringEventId
          ? _value.recurringEventId
          : recurringEventId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatus,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecurrenceRuleCopyWith<$Res>? get recurrenceRule {
    if (_value.recurrenceRule == null) {
      return null;
    }

    return $RecurrenceRuleCopyWith<$Res>(_value.recurrenceRule!, (value) {
      return _then(_value.copyWith(recurrenceRule: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CalendarEventImplCopyWith<$Res>
    implements $CalendarEventCopyWith<$Res> {
  factory _$$CalendarEventImplCopyWith(
          _$CalendarEventImpl value, $Res Function(_$CalendarEventImpl) then) =
      __$$CalendarEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime start,
      DateTime end,
      String? description,
      String? location,
      String calendarId,
      bool isAllDay,
      EventCategory category,
      EventPriority priority,
      List<String> attendees,
      List<EventReminder> reminders,
      RecurrenceRule? recurrenceRule,
      String? recurringEventId,
      EventStatus status,
      Map<String, dynamic>? metadata,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? createdBy});

  @override
  $RecurrenceRuleCopyWith<$Res>? get recurrenceRule;
}

/// @nodoc
class __$$CalendarEventImplCopyWithImpl<$Res>
    extends _$CalendarEventCopyWithImpl<$Res, _$CalendarEventImpl>
    implements _$$CalendarEventImplCopyWith<$Res> {
  __$$CalendarEventImplCopyWithImpl(
      _$CalendarEventImpl _value, $Res Function(_$CalendarEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? start = null,
    Object? end = null,
    Object? description = freezed,
    Object? location = freezed,
    Object? calendarId = null,
    Object? isAllDay = null,
    Object? category = null,
    Object? priority = null,
    Object? attendees = null,
    Object? reminders = null,
    Object? recurrenceRule = freezed,
    Object? recurringEventId = freezed,
    Object? status = null,
    Object? metadata = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? createdBy = freezed,
  }) {
    return _then(_$CalendarEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      calendarId: null == calendarId
          ? _value.calendarId
          : calendarId // ignore: cast_nullable_to_non_nullable
              as String,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as EventCategory,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as EventPriority,
      attendees: null == attendees
          ? _value._attendees
          : attendees // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reminders: null == reminders
          ? _value._reminders
          : reminders // ignore: cast_nullable_to_non_nullable
              as List<EventReminder>,
      recurrenceRule: freezed == recurrenceRule
          ? _value.recurrenceRule
          : recurrenceRule // ignore: cast_nullable_to_non_nullable
              as RecurrenceRule?,
      recurringEventId: freezed == recurringEventId
          ? _value.recurringEventId
          : recurringEventId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatus,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalendarEventImpl implements _CalendarEvent {
  const _$CalendarEventImpl(
      {required this.id,
      required this.title,
      required this.start,
      required this.end,
      this.description,
      this.location,
      required this.calendarId,
      this.isAllDay = false,
      this.category = EventCategory.general,
      this.priority = EventPriority.normal,
      final List<String> attendees = const [],
      final List<EventReminder> reminders = const [],
      this.recurrenceRule,
      this.recurringEventId,
      this.status = EventStatus.confirmed,
      final Map<String, dynamic>? metadata,
      this.createdAt,
      this.updatedAt,
      this.createdBy})
      : _attendees = attendees,
        _reminders = reminders,
        _metadata = metadata;

  factory _$CalendarEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarEventImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime start;
  @override
  final DateTime end;
  @override
  final String? description;
  @override
  final String? location;
  @override
  final String calendarId;
  @override
  @JsonKey()
  final bool isAllDay;
  @override
  @JsonKey()
  final EventCategory category;
  @override
  @JsonKey()
  final EventPriority priority;
  final List<String> _attendees;
  @override
  @JsonKey()
  List<String> get attendees {
    if (_attendees is EqualUnmodifiableListView) return _attendees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attendees);
  }

  final List<EventReminder> _reminders;
  @override
  @JsonKey()
  List<EventReminder> get reminders {
    if (_reminders is EqualUnmodifiableListView) return _reminders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reminders);
  }

  @override
  final RecurrenceRule? recurrenceRule;
  @override
  final String? recurringEventId;
  @override
  @JsonKey()
  final EventStatus status;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? createdBy;

  @override
  String toString() {
    return 'CalendarEvent(id: $id, title: $title, start: $start, end: $end, description: $description, location: $location, calendarId: $calendarId, isAllDay: $isAllDay, category: $category, priority: $priority, attendees: $attendees, reminders: $reminders, recurrenceRule: $recurrenceRule, recurringEventId: $recurringEventId, status: $status, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.calendarId, calendarId) ||
                other.calendarId == calendarId) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            const DeepCollectionEquality()
                .equals(other._attendees, _attendees) &&
            const DeepCollectionEquality()
                .equals(other._reminders, _reminders) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                other.recurrenceRule == recurrenceRule) &&
            (identical(other.recurringEventId, recurringEventId) ||
                other.recurringEventId == recurringEventId) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        start,
        end,
        description,
        location,
        calendarId,
        isAllDay,
        category,
        priority,
        const DeepCollectionEquality().hash(_attendees),
        const DeepCollectionEquality().hash(_reminders),
        recurrenceRule,
        recurringEventId,
        status,
        const DeepCollectionEquality().hash(_metadata),
        createdAt,
        updatedAt,
        createdBy
      ]);

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarEventImplCopyWith<_$CalendarEventImpl> get copyWith =>
      __$$CalendarEventImplCopyWithImpl<_$CalendarEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalendarEventImplToJson(
      this,
    );
  }
}

abstract class _CalendarEvent implements CalendarEvent {
  const factory _CalendarEvent(
      {required final String id,
      required final String title,
      required final DateTime start,
      required final DateTime end,
      final String? description,
      final String? location,
      required final String calendarId,
      final bool isAllDay,
      final EventCategory category,
      final EventPriority priority,
      final List<String> attendees,
      final List<EventReminder> reminders,
      final RecurrenceRule? recurrenceRule,
      final String? recurringEventId,
      final EventStatus status,
      final Map<String, dynamic>? metadata,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final String? createdBy}) = _$CalendarEventImpl;

  factory _CalendarEvent.fromJson(Map<String, dynamic> json) =
      _$CalendarEventImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  DateTime get start;
  @override
  DateTime get end;
  @override
  String? get description;
  @override
  String? get location;
  @override
  String get calendarId;
  @override
  bool get isAllDay;
  @override
  EventCategory get category;
  @override
  EventPriority get priority;
  @override
  List<String> get attendees;
  @override
  List<EventReminder> get reminders;
  @override
  RecurrenceRule? get recurrenceRule;
  @override
  String? get recurringEventId;
  @override
  EventStatus get status;
  @override
  Map<String, dynamic>? get metadata;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  String? get createdBy;

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalendarEventImplCopyWith<_$CalendarEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EventReminder _$EventReminderFromJson(Map<String, dynamic> json) {
  return _EventReminder.fromJson(json);
}

/// @nodoc
mixin _$EventReminder {
  ReminderType get type => throw _privateConstructorUsedError;
  int get minutesBefore => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;

  /// Serializes this EventReminder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventReminder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventReminderCopyWith<EventReminder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventReminderCopyWith<$Res> {
  factory $EventReminderCopyWith(
          EventReminder value, $Res Function(EventReminder) then) =
      _$EventReminderCopyWithImpl<$Res, EventReminder>;
  @useResult
  $Res call({ReminderType type, int minutesBefore, bool enabled});
}

/// @nodoc
class _$EventReminderCopyWithImpl<$Res, $Val extends EventReminder>
    implements $EventReminderCopyWith<$Res> {
  _$EventReminderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventReminder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? minutesBefore = null,
    Object? enabled = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ReminderType,
      minutesBefore: null == minutesBefore
          ? _value.minutesBefore
          : minutesBefore // ignore: cast_nullable_to_non_nullable
              as int,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventReminderImplCopyWith<$Res>
    implements $EventReminderCopyWith<$Res> {
  factory _$$EventReminderImplCopyWith(
          _$EventReminderImpl value, $Res Function(_$EventReminderImpl) then) =
      __$$EventReminderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ReminderType type, int minutesBefore, bool enabled});
}

/// @nodoc
class __$$EventReminderImplCopyWithImpl<$Res>
    extends _$EventReminderCopyWithImpl<$Res, _$EventReminderImpl>
    implements _$$EventReminderImplCopyWith<$Res> {
  __$$EventReminderImplCopyWithImpl(
      _$EventReminderImpl _value, $Res Function(_$EventReminderImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventReminder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? minutesBefore = null,
    Object? enabled = null,
  }) {
    return _then(_$EventReminderImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ReminderType,
      minutesBefore: null == minutesBefore
          ? _value.minutesBefore
          : minutesBefore // ignore: cast_nullable_to_non_nullable
              as int,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventReminderImpl implements _EventReminder {
  const _$EventReminderImpl(
      {required this.type, required this.minutesBefore, this.enabled = true});

  factory _$EventReminderImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventReminderImplFromJson(json);

  @override
  final ReminderType type;
  @override
  final int minutesBefore;
  @override
  @JsonKey()
  final bool enabled;

  @override
  String toString() {
    return 'EventReminder(type: $type, minutesBefore: $minutesBefore, enabled: $enabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventReminderImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.minutesBefore, minutesBefore) ||
                other.minutesBefore == minutesBefore) &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, minutesBefore, enabled);

  /// Create a copy of EventReminder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventReminderImplCopyWith<_$EventReminderImpl> get copyWith =>
      __$$EventReminderImplCopyWithImpl<_$EventReminderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventReminderImplToJson(
      this,
    );
  }
}

abstract class _EventReminder implements EventReminder {
  const factory _EventReminder(
      {required final ReminderType type,
      required final int minutesBefore,
      final bool enabled}) = _$EventReminderImpl;

  factory _EventReminder.fromJson(Map<String, dynamic> json) =
      _$EventReminderImpl.fromJson;

  @override
  ReminderType get type;
  @override
  int get minutesBefore;
  @override
  bool get enabled;

  /// Create a copy of EventReminder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventReminderImplCopyWith<_$EventReminderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecurrenceRule _$RecurrenceRuleFromJson(Map<String, dynamic> json) {
  return _RecurrenceRule.fromJson(json);
}

/// @nodoc
mixin _$RecurrenceRule {
  RecurrenceFrequency get frequency => throw _privateConstructorUsedError;
  int get interval => throw _privateConstructorUsedError;
  DateTime? get until => throw _privateConstructorUsedError;
  int? get count => throw _privateConstructorUsedError;
  List<int> get byWeekDay => throw _privateConstructorUsedError;
  List<int> get byMonthDay => throw _privateConstructorUsedError;
  List<int> get byMonth => throw _privateConstructorUsedError;
  List<int> get bySetPos => throw _privateConstructorUsedError;

  /// Serializes this RecurrenceRule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecurrenceRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecurrenceRuleCopyWith<RecurrenceRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecurrenceRuleCopyWith<$Res> {
  factory $RecurrenceRuleCopyWith(
          RecurrenceRule value, $Res Function(RecurrenceRule) then) =
      _$RecurrenceRuleCopyWithImpl<$Res, RecurrenceRule>;
  @useResult
  $Res call(
      {RecurrenceFrequency frequency,
      int interval,
      DateTime? until,
      int? count,
      List<int> byWeekDay,
      List<int> byMonthDay,
      List<int> byMonth,
      List<int> bySetPos});
}

/// @nodoc
class _$RecurrenceRuleCopyWithImpl<$Res, $Val extends RecurrenceRule>
    implements $RecurrenceRuleCopyWith<$Res> {
  _$RecurrenceRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecurrenceRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
    Object? interval = null,
    Object? until = freezed,
    Object? count = freezed,
    Object? byWeekDay = null,
    Object? byMonthDay = null,
    Object? byMonth = null,
    Object? bySetPos = null,
  }) {
    return _then(_value.copyWith(
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as RecurrenceFrequency,
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as int,
      until: freezed == until
          ? _value.until
          : until // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      byWeekDay: null == byWeekDay
          ? _value.byWeekDay
          : byWeekDay // ignore: cast_nullable_to_non_nullable
              as List<int>,
      byMonthDay: null == byMonthDay
          ? _value.byMonthDay
          : byMonthDay // ignore: cast_nullable_to_non_nullable
              as List<int>,
      byMonth: null == byMonth
          ? _value.byMonth
          : byMonth // ignore: cast_nullable_to_non_nullable
              as List<int>,
      bySetPos: null == bySetPos
          ? _value.bySetPos
          : bySetPos // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecurrenceRuleImplCopyWith<$Res>
    implements $RecurrenceRuleCopyWith<$Res> {
  factory _$$RecurrenceRuleImplCopyWith(_$RecurrenceRuleImpl value,
          $Res Function(_$RecurrenceRuleImpl) then) =
      __$$RecurrenceRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RecurrenceFrequency frequency,
      int interval,
      DateTime? until,
      int? count,
      List<int> byWeekDay,
      List<int> byMonthDay,
      List<int> byMonth,
      List<int> bySetPos});
}

/// @nodoc
class __$$RecurrenceRuleImplCopyWithImpl<$Res>
    extends _$RecurrenceRuleCopyWithImpl<$Res, _$RecurrenceRuleImpl>
    implements _$$RecurrenceRuleImplCopyWith<$Res> {
  __$$RecurrenceRuleImplCopyWithImpl(
      _$RecurrenceRuleImpl _value, $Res Function(_$RecurrenceRuleImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecurrenceRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
    Object? interval = null,
    Object? until = freezed,
    Object? count = freezed,
    Object? byWeekDay = null,
    Object? byMonthDay = null,
    Object? byMonth = null,
    Object? bySetPos = null,
  }) {
    return _then(_$RecurrenceRuleImpl(
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as RecurrenceFrequency,
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as int,
      until: freezed == until
          ? _value.until
          : until // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      byWeekDay: null == byWeekDay
          ? _value._byWeekDay
          : byWeekDay // ignore: cast_nullable_to_non_nullable
              as List<int>,
      byMonthDay: null == byMonthDay
          ? _value._byMonthDay
          : byMonthDay // ignore: cast_nullable_to_non_nullable
              as List<int>,
      byMonth: null == byMonth
          ? _value._byMonth
          : byMonth // ignore: cast_nullable_to_non_nullable
              as List<int>,
      bySetPos: null == bySetPos
          ? _value._bySetPos
          : bySetPos // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecurrenceRuleImpl implements _RecurrenceRule {
  const _$RecurrenceRuleImpl(
      {required this.frequency,
      this.interval = 1,
      this.until,
      this.count,
      final List<int> byWeekDay = const [],
      final List<int> byMonthDay = const [],
      final List<int> byMonth = const [],
      final List<int> bySetPos = const []})
      : _byWeekDay = byWeekDay,
        _byMonthDay = byMonthDay,
        _byMonth = byMonth,
        _bySetPos = bySetPos;

  factory _$RecurrenceRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecurrenceRuleImplFromJson(json);

  @override
  final RecurrenceFrequency frequency;
  @override
  @JsonKey()
  final int interval;
  @override
  final DateTime? until;
  @override
  final int? count;
  final List<int> _byWeekDay;
  @override
  @JsonKey()
  List<int> get byWeekDay {
    if (_byWeekDay is EqualUnmodifiableListView) return _byWeekDay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_byWeekDay);
  }

  final List<int> _byMonthDay;
  @override
  @JsonKey()
  List<int> get byMonthDay {
    if (_byMonthDay is EqualUnmodifiableListView) return _byMonthDay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_byMonthDay);
  }

  final List<int> _byMonth;
  @override
  @JsonKey()
  List<int> get byMonth {
    if (_byMonth is EqualUnmodifiableListView) return _byMonth;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_byMonth);
  }

  final List<int> _bySetPos;
  @override
  @JsonKey()
  List<int> get bySetPos {
    if (_bySetPos is EqualUnmodifiableListView) return _bySetPos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bySetPos);
  }

  @override
  String toString() {
    return 'RecurrenceRule(frequency: $frequency, interval: $interval, until: $until, count: $count, byWeekDay: $byWeekDay, byMonthDay: $byMonthDay, byMonth: $byMonth, bySetPos: $bySetPos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurrenceRuleImpl &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.interval, interval) ||
                other.interval == interval) &&
            (identical(other.until, until) || other.until == until) &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality()
                .equals(other._byWeekDay, _byWeekDay) &&
            const DeepCollectionEquality()
                .equals(other._byMonthDay, _byMonthDay) &&
            const DeepCollectionEquality().equals(other._byMonth, _byMonth) &&
            const DeepCollectionEquality().equals(other._bySetPos, _bySetPos));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      frequency,
      interval,
      until,
      count,
      const DeepCollectionEquality().hash(_byWeekDay),
      const DeepCollectionEquality().hash(_byMonthDay),
      const DeepCollectionEquality().hash(_byMonth),
      const DeepCollectionEquality().hash(_bySetPos));

  /// Create a copy of RecurrenceRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecurrenceRuleImplCopyWith<_$RecurrenceRuleImpl> get copyWith =>
      __$$RecurrenceRuleImplCopyWithImpl<_$RecurrenceRuleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecurrenceRuleImplToJson(
      this,
    );
  }
}

abstract class _RecurrenceRule implements RecurrenceRule {
  const factory _RecurrenceRule(
      {required final RecurrenceFrequency frequency,
      final int interval,
      final DateTime? until,
      final int? count,
      final List<int> byWeekDay,
      final List<int> byMonthDay,
      final List<int> byMonth,
      final List<int> bySetPos}) = _$RecurrenceRuleImpl;

  factory _RecurrenceRule.fromJson(Map<String, dynamic> json) =
      _$RecurrenceRuleImpl.fromJson;

  @override
  RecurrenceFrequency get frequency;
  @override
  int get interval;
  @override
  DateTime? get until;
  @override
  int? get count;
  @override
  List<int> get byWeekDay;
  @override
  List<int> get byMonthDay;
  @override
  List<int> get byMonth;
  @override
  List<int> get bySetPos;

  /// Create a copy of RecurrenceRule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecurrenceRuleImplCopyWith<_$RecurrenceRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
