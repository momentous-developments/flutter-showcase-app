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

CalendarEvent _$CalendarEventFromJson(Map<String, dynamic> json) {
  return _CalendarEvent.fromJson(json);
}

/// @nodoc
mixin _$CalendarEvent {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  bool get allDay => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  List<String> get attendees => throw _privateConstructorUsedError;
  EventType get type => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  int? get reminder => throw _privateConstructorUsedError; // minutes before
  EventPriority get priority => throw _privateConstructorUsedError;
  EventVisibility get visibility => throw _privateConstructorUsedError;
  RecurrenceRule? get recurrence => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  List<EventAttachment> get attachments => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  Map<String, RsvpStatus> get rsvpResponses =>
      throw _privateConstructorUsedError;
  String? get meetingUrl => throw _privateConstructorUsedError;
  String? get timezone => throw _privateConstructorUsedError;
  bool get isOrganizer => throw _privateConstructorUsedError;
  List<EventReminder> get reminders => throw _privateConstructorUsedError;
  int? get calendarId => throw _privateConstructorUsedError;
  String? get externalId => throw _privateConstructorUsedError;
  Map<String, dynamic> get customFields => throw _privateConstructorUsedError;

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
      {int id,
      String title,
      String? description,
      DateTime startTime,
      DateTime endTime,
      bool allDay,
      String? location,
      List<String> attendees,
      EventType type,
      String color,
      int? reminder,
      EventPriority priority,
      EventVisibility visibility,
      RecurrenceRule? recurrence,
      List<String> tags,
      List<EventAttachment> attachments,
      String? createdBy,
      DateTime? createdAt,
      DateTime? updatedAt,
      Map<String, RsvpStatus> rsvpResponses,
      String? meetingUrl,
      String? timezone,
      bool isOrganizer,
      List<EventReminder> reminders,
      int? calendarId,
      String? externalId,
      Map<String, dynamic> customFields});

  $RecurrenceRuleCopyWith<$Res>? get recurrence;
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
    Object? description = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? allDay = null,
    Object? location = freezed,
    Object? attendees = null,
    Object? type = null,
    Object? color = null,
    Object? reminder = freezed,
    Object? priority = null,
    Object? visibility = null,
    Object? recurrence = freezed,
    Object? tags = null,
    Object? attachments = null,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? rsvpResponses = null,
    Object? meetingUrl = freezed,
    Object? timezone = freezed,
    Object? isOrganizer = null,
    Object? reminders = null,
    Object? calendarId = freezed,
    Object? externalId = freezed,
    Object? customFields = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      allDay: null == allDay
          ? _value.allDay
          : allDay // ignore: cast_nullable_to_non_nullable
              as bool,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      attendees: null == attendees
          ? _value.attendees
          : attendees // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as EventType,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      reminder: freezed == reminder
          ? _value.reminder
          : reminder // ignore: cast_nullable_to_non_nullable
              as int?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as EventPriority,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as EventVisibility,
      recurrence: freezed == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as RecurrenceRule?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      attachments: null == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<EventAttachment>,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rsvpResponses: null == rsvpResponses
          ? _value.rsvpResponses
          : rsvpResponses // ignore: cast_nullable_to_non_nullable
              as Map<String, RsvpStatus>,
      meetingUrl: freezed == meetingUrl
          ? _value.meetingUrl
          : meetingUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      timezone: freezed == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String?,
      isOrganizer: null == isOrganizer
          ? _value.isOrganizer
          : isOrganizer // ignore: cast_nullable_to_non_nullable
              as bool,
      reminders: null == reminders
          ? _value.reminders
          : reminders // ignore: cast_nullable_to_non_nullable
              as List<EventReminder>,
      calendarId: freezed == calendarId
          ? _value.calendarId
          : calendarId // ignore: cast_nullable_to_non_nullable
              as int?,
      externalId: freezed == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String?,
      customFields: null == customFields
          ? _value.customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecurrenceRuleCopyWith<$Res>? get recurrence {
    if (_value.recurrence == null) {
      return null;
    }

    return $RecurrenceRuleCopyWith<$Res>(_value.recurrence!, (value) {
      return _then(_value.copyWith(recurrence: value) as $Val);
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
      {int id,
      String title,
      String? description,
      DateTime startTime,
      DateTime endTime,
      bool allDay,
      String? location,
      List<String> attendees,
      EventType type,
      String color,
      int? reminder,
      EventPriority priority,
      EventVisibility visibility,
      RecurrenceRule? recurrence,
      List<String> tags,
      List<EventAttachment> attachments,
      String? createdBy,
      DateTime? createdAt,
      DateTime? updatedAt,
      Map<String, RsvpStatus> rsvpResponses,
      String? meetingUrl,
      String? timezone,
      bool isOrganizer,
      List<EventReminder> reminders,
      int? calendarId,
      String? externalId,
      Map<String, dynamic> customFields});

  @override
  $RecurrenceRuleCopyWith<$Res>? get recurrence;
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
    Object? description = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? allDay = null,
    Object? location = freezed,
    Object? attendees = null,
    Object? type = null,
    Object? color = null,
    Object? reminder = freezed,
    Object? priority = null,
    Object? visibility = null,
    Object? recurrence = freezed,
    Object? tags = null,
    Object? attachments = null,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? rsvpResponses = null,
    Object? meetingUrl = freezed,
    Object? timezone = freezed,
    Object? isOrganizer = null,
    Object? reminders = null,
    Object? calendarId = freezed,
    Object? externalId = freezed,
    Object? customFields = null,
  }) {
    return _then(_$CalendarEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      allDay: null == allDay
          ? _value.allDay
          : allDay // ignore: cast_nullable_to_non_nullable
              as bool,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      attendees: null == attendees
          ? _value._attendees
          : attendees // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as EventType,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      reminder: freezed == reminder
          ? _value.reminder
          : reminder // ignore: cast_nullable_to_non_nullable
              as int?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as EventPriority,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as EventVisibility,
      recurrence: freezed == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as RecurrenceRule?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      attachments: null == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<EventAttachment>,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rsvpResponses: null == rsvpResponses
          ? _value._rsvpResponses
          : rsvpResponses // ignore: cast_nullable_to_non_nullable
              as Map<String, RsvpStatus>,
      meetingUrl: freezed == meetingUrl
          ? _value.meetingUrl
          : meetingUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      timezone: freezed == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String?,
      isOrganizer: null == isOrganizer
          ? _value.isOrganizer
          : isOrganizer // ignore: cast_nullable_to_non_nullable
              as bool,
      reminders: null == reminders
          ? _value._reminders
          : reminders // ignore: cast_nullable_to_non_nullable
              as List<EventReminder>,
      calendarId: freezed == calendarId
          ? _value.calendarId
          : calendarId // ignore: cast_nullable_to_non_nullable
              as int?,
      externalId: freezed == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String?,
      customFields: null == customFields
          ? _value._customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalendarEventImpl implements _CalendarEvent {
  const _$CalendarEventImpl(
      {required this.id,
      required this.title,
      this.description,
      required this.startTime,
      required this.endTime,
      this.allDay = false,
      this.location,
      final List<String> attendees = const [],
      this.type = EventType.meeting,
      this.color = '#2196F3',
      this.reminder,
      this.priority = EventPriority.medium,
      this.visibility = EventVisibility.public,
      this.recurrence,
      final List<String> tags = const [],
      final List<EventAttachment> attachments = const [],
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      final Map<String, RsvpStatus> rsvpResponses = const {},
      this.meetingUrl,
      this.timezone,
      this.isOrganizer = false,
      final List<EventReminder> reminders = const [],
      this.calendarId,
      this.externalId,
      final Map<String, dynamic> customFields = const {}})
      : _attendees = attendees,
        _tags = tags,
        _attachments = attachments,
        _rsvpResponses = rsvpResponses,
        _reminders = reminders,
        _customFields = customFields;

  factory _$CalendarEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarEventImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  @JsonKey()
  final bool allDay;
  @override
  final String? location;
  final List<String> _attendees;
  @override
  @JsonKey()
  List<String> get attendees {
    if (_attendees is EqualUnmodifiableListView) return _attendees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attendees);
  }

  @override
  @JsonKey()
  final EventType type;
  @override
  @JsonKey()
  final String color;
  @override
  final int? reminder;
// minutes before
  @override
  @JsonKey()
  final EventPriority priority;
  @override
  @JsonKey()
  final EventVisibility visibility;
  @override
  final RecurrenceRule? recurrence;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<EventAttachment> _attachments;
  @override
  @JsonKey()
  List<EventAttachment> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  final String? createdBy;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  final Map<String, RsvpStatus> _rsvpResponses;
  @override
  @JsonKey()
  Map<String, RsvpStatus> get rsvpResponses {
    if (_rsvpResponses is EqualUnmodifiableMapView) return _rsvpResponses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_rsvpResponses);
  }

  @override
  final String? meetingUrl;
  @override
  final String? timezone;
  @override
  @JsonKey()
  final bool isOrganizer;
  final List<EventReminder> _reminders;
  @override
  @JsonKey()
  List<EventReminder> get reminders {
    if (_reminders is EqualUnmodifiableListView) return _reminders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reminders);
  }

  @override
  final int? calendarId;
  @override
  final String? externalId;
  final Map<String, dynamic> _customFields;
  @override
  @JsonKey()
  Map<String, dynamic> get customFields {
    if (_customFields is EqualUnmodifiableMapView) return _customFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customFields);
  }

  @override
  String toString() {
    return 'CalendarEvent(id: $id, title: $title, description: $description, startTime: $startTime, endTime: $endTime, allDay: $allDay, location: $location, attendees: $attendees, type: $type, color: $color, reminder: $reminder, priority: $priority, visibility: $visibility, recurrence: $recurrence, tags: $tags, attachments: $attachments, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, rsvpResponses: $rsvpResponses, meetingUrl: $meetingUrl, timezone: $timezone, isOrganizer: $isOrganizer, reminders: $reminders, calendarId: $calendarId, externalId: $externalId, customFields: $customFields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.allDay, allDay) || other.allDay == allDay) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality()
                .equals(other._attendees, _attendees) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.reminder, reminder) ||
                other.reminder == reminder) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.recurrence, recurrence) ||
                other.recurrence == recurrence) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other._rsvpResponses, _rsvpResponses) &&
            (identical(other.meetingUrl, meetingUrl) ||
                other.meetingUrl == meetingUrl) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.isOrganizer, isOrganizer) ||
                other.isOrganizer == isOrganizer) &&
            const DeepCollectionEquality()
                .equals(other._reminders, _reminders) &&
            (identical(other.calendarId, calendarId) ||
                other.calendarId == calendarId) &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            const DeepCollectionEquality()
                .equals(other._customFields, _customFields));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        description,
        startTime,
        endTime,
        allDay,
        location,
        const DeepCollectionEquality().hash(_attendees),
        type,
        color,
        reminder,
        priority,
        visibility,
        recurrence,
        const DeepCollectionEquality().hash(_tags),
        const DeepCollectionEquality().hash(_attachments),
        createdBy,
        createdAt,
        updatedAt,
        const DeepCollectionEquality().hash(_rsvpResponses),
        meetingUrl,
        timezone,
        isOrganizer,
        const DeepCollectionEquality().hash(_reminders),
        calendarId,
        externalId,
        const DeepCollectionEquality().hash(_customFields)
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
      {required final int id,
      required final String title,
      final String? description,
      required final DateTime startTime,
      required final DateTime endTime,
      final bool allDay,
      final String? location,
      final List<String> attendees,
      final EventType type,
      final String color,
      final int? reminder,
      final EventPriority priority,
      final EventVisibility visibility,
      final RecurrenceRule? recurrence,
      final List<String> tags,
      final List<EventAttachment> attachments,
      final String? createdBy,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final Map<String, RsvpStatus> rsvpResponses,
      final String? meetingUrl,
      final String? timezone,
      final bool isOrganizer,
      final List<EventReminder> reminders,
      final int? calendarId,
      final String? externalId,
      final Map<String, dynamic> customFields}) = _$CalendarEventImpl;

  factory _CalendarEvent.fromJson(Map<String, dynamic> json) =
      _$CalendarEventImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  bool get allDay;
  @override
  String? get location;
  @override
  List<String> get attendees;
  @override
  EventType get type;
  @override
  String get color;
  @override
  int? get reminder; // minutes before
  @override
  EventPriority get priority;
  @override
  EventVisibility get visibility;
  @override
  RecurrenceRule? get recurrence;
  @override
  List<String> get tags;
  @override
  List<EventAttachment> get attachments;
  @override
  String? get createdBy;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  Map<String, RsvpStatus> get rsvpResponses;
  @override
  String? get meetingUrl;
  @override
  String? get timezone;
  @override
  bool get isOrganizer;
  @override
  List<EventReminder> get reminders;
  @override
  int? get calendarId;
  @override
  String? get externalId;
  @override
  Map<String, dynamic> get customFields;

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalendarEventImplCopyWith<_$CalendarEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecurrenceRule _$RecurrenceRuleFromJson(Map<String, dynamic> json) {
  return _RecurrenceRule.fromJson(json);
}

/// @nodoc
mixin _$RecurrenceRule {
  RecurrenceType get type => throw _privateConstructorUsedError;
  int get interval => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  int? get occurrences => throw _privateConstructorUsedError;
  List<int> get daysOfWeek =>
      throw _privateConstructorUsedError; // 1=Monday, 7=Sunday
  List<int> get daysOfMonth => throw _privateConstructorUsedError; // 1-31
  List<int> get monthsOfYear => throw _privateConstructorUsedError; // 1-12
  List<int> get weeksOfYear => throw _privateConstructorUsedError; // 1-53
  List<DateTime> get exceptions =>
      throw _privateConstructorUsedError; // dates to skip
  String? get rruleString => throw _privateConstructorUsedError;

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
      {RecurrenceType type,
      int interval,
      DateTime? endDate,
      int? occurrences,
      List<int> daysOfWeek,
      List<int> daysOfMonth,
      List<int> monthsOfYear,
      List<int> weeksOfYear,
      List<DateTime> exceptions,
      String? rruleString});
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
    Object? type = null,
    Object? interval = null,
    Object? endDate = freezed,
    Object? occurrences = freezed,
    Object? daysOfWeek = null,
    Object? daysOfMonth = null,
    Object? monthsOfYear = null,
    Object? weeksOfYear = null,
    Object? exceptions = null,
    Object? rruleString = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RecurrenceType,
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as int,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      occurrences: freezed == occurrences
          ? _value.occurrences
          : occurrences // ignore: cast_nullable_to_non_nullable
              as int?,
      daysOfWeek: null == daysOfWeek
          ? _value.daysOfWeek
          : daysOfWeek // ignore: cast_nullable_to_non_nullable
              as List<int>,
      daysOfMonth: null == daysOfMonth
          ? _value.daysOfMonth
          : daysOfMonth // ignore: cast_nullable_to_non_nullable
              as List<int>,
      monthsOfYear: null == monthsOfYear
          ? _value.monthsOfYear
          : monthsOfYear // ignore: cast_nullable_to_non_nullable
              as List<int>,
      weeksOfYear: null == weeksOfYear
          ? _value.weeksOfYear
          : weeksOfYear // ignore: cast_nullable_to_non_nullable
              as List<int>,
      exceptions: null == exceptions
          ? _value.exceptions
          : exceptions // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      rruleString: freezed == rruleString
          ? _value.rruleString
          : rruleString // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {RecurrenceType type,
      int interval,
      DateTime? endDate,
      int? occurrences,
      List<int> daysOfWeek,
      List<int> daysOfMonth,
      List<int> monthsOfYear,
      List<int> weeksOfYear,
      List<DateTime> exceptions,
      String? rruleString});
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
    Object? type = null,
    Object? interval = null,
    Object? endDate = freezed,
    Object? occurrences = freezed,
    Object? daysOfWeek = null,
    Object? daysOfMonth = null,
    Object? monthsOfYear = null,
    Object? weeksOfYear = null,
    Object? exceptions = null,
    Object? rruleString = freezed,
  }) {
    return _then(_$RecurrenceRuleImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RecurrenceType,
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as int,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      occurrences: freezed == occurrences
          ? _value.occurrences
          : occurrences // ignore: cast_nullable_to_non_nullable
              as int?,
      daysOfWeek: null == daysOfWeek
          ? _value._daysOfWeek
          : daysOfWeek // ignore: cast_nullable_to_non_nullable
              as List<int>,
      daysOfMonth: null == daysOfMonth
          ? _value._daysOfMonth
          : daysOfMonth // ignore: cast_nullable_to_non_nullable
              as List<int>,
      monthsOfYear: null == monthsOfYear
          ? _value._monthsOfYear
          : monthsOfYear // ignore: cast_nullable_to_non_nullable
              as List<int>,
      weeksOfYear: null == weeksOfYear
          ? _value._weeksOfYear
          : weeksOfYear // ignore: cast_nullable_to_non_nullable
              as List<int>,
      exceptions: null == exceptions
          ? _value._exceptions
          : exceptions // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      rruleString: freezed == rruleString
          ? _value.rruleString
          : rruleString // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecurrenceRuleImpl implements _RecurrenceRule {
  const _$RecurrenceRuleImpl(
      {required this.type,
      this.interval = 1,
      this.endDate,
      this.occurrences,
      final List<int> daysOfWeek = const [],
      final List<int> daysOfMonth = const [],
      final List<int> monthsOfYear = const [],
      final List<int> weeksOfYear = const [],
      final List<DateTime> exceptions = const [],
      this.rruleString})
      : _daysOfWeek = daysOfWeek,
        _daysOfMonth = daysOfMonth,
        _monthsOfYear = monthsOfYear,
        _weeksOfYear = weeksOfYear,
        _exceptions = exceptions;

  factory _$RecurrenceRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecurrenceRuleImplFromJson(json);

  @override
  final RecurrenceType type;
  @override
  @JsonKey()
  final int interval;
  @override
  final DateTime? endDate;
  @override
  final int? occurrences;
  final List<int> _daysOfWeek;
  @override
  @JsonKey()
  List<int> get daysOfWeek {
    if (_daysOfWeek is EqualUnmodifiableListView) return _daysOfWeek;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_daysOfWeek);
  }

// 1=Monday, 7=Sunday
  final List<int> _daysOfMonth;
// 1=Monday, 7=Sunday
  @override
  @JsonKey()
  List<int> get daysOfMonth {
    if (_daysOfMonth is EqualUnmodifiableListView) return _daysOfMonth;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_daysOfMonth);
  }

// 1-31
  final List<int> _monthsOfYear;
// 1-31
  @override
  @JsonKey()
  List<int> get monthsOfYear {
    if (_monthsOfYear is EqualUnmodifiableListView) return _monthsOfYear;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monthsOfYear);
  }

// 1-12
  final List<int> _weeksOfYear;
// 1-12
  @override
  @JsonKey()
  List<int> get weeksOfYear {
    if (_weeksOfYear is EqualUnmodifiableListView) return _weeksOfYear;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weeksOfYear);
  }

// 1-53
  final List<DateTime> _exceptions;
// 1-53
  @override
  @JsonKey()
  List<DateTime> get exceptions {
    if (_exceptions is EqualUnmodifiableListView) return _exceptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exceptions);
  }

// dates to skip
  @override
  final String? rruleString;

  @override
  String toString() {
    return 'RecurrenceRule(type: $type, interval: $interval, endDate: $endDate, occurrences: $occurrences, daysOfWeek: $daysOfWeek, daysOfMonth: $daysOfMonth, monthsOfYear: $monthsOfYear, weeksOfYear: $weeksOfYear, exceptions: $exceptions, rruleString: $rruleString)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurrenceRuleImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.interval, interval) ||
                other.interval == interval) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.occurrences, occurrences) ||
                other.occurrences == occurrences) &&
            const DeepCollectionEquality()
                .equals(other._daysOfWeek, _daysOfWeek) &&
            const DeepCollectionEquality()
                .equals(other._daysOfMonth, _daysOfMonth) &&
            const DeepCollectionEquality()
                .equals(other._monthsOfYear, _monthsOfYear) &&
            const DeepCollectionEquality()
                .equals(other._weeksOfYear, _weeksOfYear) &&
            const DeepCollectionEquality()
                .equals(other._exceptions, _exceptions) &&
            (identical(other.rruleString, rruleString) ||
                other.rruleString == rruleString));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      interval,
      endDate,
      occurrences,
      const DeepCollectionEquality().hash(_daysOfWeek),
      const DeepCollectionEquality().hash(_daysOfMonth),
      const DeepCollectionEquality().hash(_monthsOfYear),
      const DeepCollectionEquality().hash(_weeksOfYear),
      const DeepCollectionEquality().hash(_exceptions),
      rruleString);

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
      {required final RecurrenceType type,
      final int interval,
      final DateTime? endDate,
      final int? occurrences,
      final List<int> daysOfWeek,
      final List<int> daysOfMonth,
      final List<int> monthsOfYear,
      final List<int> weeksOfYear,
      final List<DateTime> exceptions,
      final String? rruleString}) = _$RecurrenceRuleImpl;

  factory _RecurrenceRule.fromJson(Map<String, dynamic> json) =
      _$RecurrenceRuleImpl.fromJson;

  @override
  RecurrenceType get type;
  @override
  int get interval;
  @override
  DateTime? get endDate;
  @override
  int? get occurrences;
  @override
  List<int> get daysOfWeek; // 1=Monday, 7=Sunday
  @override
  List<int> get daysOfMonth; // 1-31
  @override
  List<int> get monthsOfYear; // 1-12
  @override
  List<int> get weeksOfYear; // 1-53
  @override
  List<DateTime> get exceptions; // dates to skip
  @override
  String? get rruleString;

  /// Create a copy of RecurrenceRule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecurrenceRuleImplCopyWith<_$RecurrenceRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EventReminder _$EventReminderFromJson(Map<String, dynamic> json) {
  return _EventReminder.fromJson(json);
}

/// @nodoc
mixin _$EventReminder {
  int get id => throw _privateConstructorUsedError;
  int get minutesBefore => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // notification, email, sms
  bool get enabled => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  DateTime? get scheduledTime => throw _privateConstructorUsedError;

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
  $Res call(
      {int id,
      int minutesBefore,
      String type,
      bool enabled,
      String? message,
      DateTime? scheduledTime});
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
    Object? id = null,
    Object? minutesBefore = null,
    Object? type = null,
    Object? enabled = null,
    Object? message = freezed,
    Object? scheduledTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      minutesBefore: null == minutesBefore
          ? _value.minutesBefore
          : minutesBefore // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduledTime: freezed == scheduledTime
          ? _value.scheduledTime
          : scheduledTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
  $Res call(
      {int id,
      int minutesBefore,
      String type,
      bool enabled,
      String? message,
      DateTime? scheduledTime});
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
    Object? id = null,
    Object? minutesBefore = null,
    Object? type = null,
    Object? enabled = null,
    Object? message = freezed,
    Object? scheduledTime = freezed,
  }) {
    return _then(_$EventReminderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      minutesBefore: null == minutesBefore
          ? _value.minutesBefore
          : minutesBefore // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduledTime: freezed == scheduledTime
          ? _value.scheduledTime
          : scheduledTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventReminderImpl implements _EventReminder {
  const _$EventReminderImpl(
      {required this.id,
      required this.minutesBefore,
      this.type = 'notification',
      this.enabled = true,
      this.message,
      this.scheduledTime});

  factory _$EventReminderImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventReminderImplFromJson(json);

  @override
  final int id;
  @override
  final int minutesBefore;
  @override
  @JsonKey()
  final String type;
// notification, email, sms
  @override
  @JsonKey()
  final bool enabled;
  @override
  final String? message;
  @override
  final DateTime? scheduledTime;

  @override
  String toString() {
    return 'EventReminder(id: $id, minutesBefore: $minutesBefore, type: $type, enabled: $enabled, message: $message, scheduledTime: $scheduledTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventReminderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.minutesBefore, minutesBefore) ||
                other.minutesBefore == minutesBefore) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.scheduledTime, scheduledTime) ||
                other.scheduledTime == scheduledTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, minutesBefore, type, enabled, message, scheduledTime);

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
      {required final int id,
      required final int minutesBefore,
      final String type,
      final bool enabled,
      final String? message,
      final DateTime? scheduledTime}) = _$EventReminderImpl;

  factory _EventReminder.fromJson(Map<String, dynamic> json) =
      _$EventReminderImpl.fromJson;

  @override
  int get id;
  @override
  int get minutesBefore;
  @override
  String get type; // notification, email, sms
  @override
  bool get enabled;
  @override
  String? get message;
  @override
  DateTime? get scheduledTime;

  /// Create a copy of EventReminder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventReminderImplCopyWith<_$EventReminderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EventAttachment _$EventAttachmentFromJson(Map<String, dynamic> json) {
  return _EventAttachment.fromJson(json);
}

/// @nodoc
mixin _$EventAttachment {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // image, document, video, etc.
  int get size => throw _privateConstructorUsedError;
  DateTime? get uploadedAt => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this EventAttachment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventAttachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventAttachmentCopyWith<EventAttachment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventAttachmentCopyWith<$Res> {
  factory $EventAttachmentCopyWith(
          EventAttachment value, $Res Function(EventAttachment) then) =
      _$EventAttachmentCopyWithImpl<$Res, EventAttachment>;
  @useResult
  $Res call(
      {String id,
      String name,
      String url,
      String type,
      int size,
      DateTime? uploadedAt,
      String? description});
}

/// @nodoc
class _$EventAttachmentCopyWithImpl<$Res, $Val extends EventAttachment>
    implements $EventAttachmentCopyWith<$Res> {
  _$EventAttachmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventAttachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? url = null,
    Object? type = null,
    Object? size = null,
    Object? uploadedAt = freezed,
    Object? description = freezed,
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
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      uploadedAt: freezed == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventAttachmentImplCopyWith<$Res>
    implements $EventAttachmentCopyWith<$Res> {
  factory _$$EventAttachmentImplCopyWith(_$EventAttachmentImpl value,
          $Res Function(_$EventAttachmentImpl) then) =
      __$$EventAttachmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String url,
      String type,
      int size,
      DateTime? uploadedAt,
      String? description});
}

/// @nodoc
class __$$EventAttachmentImplCopyWithImpl<$Res>
    extends _$EventAttachmentCopyWithImpl<$Res, _$EventAttachmentImpl>
    implements _$$EventAttachmentImplCopyWith<$Res> {
  __$$EventAttachmentImplCopyWithImpl(
      _$EventAttachmentImpl _value, $Res Function(_$EventAttachmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventAttachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? url = null,
    Object? type = null,
    Object? size = null,
    Object? uploadedAt = freezed,
    Object? description = freezed,
  }) {
    return _then(_$EventAttachmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      uploadedAt: freezed == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventAttachmentImpl implements _EventAttachment {
  const _$EventAttachmentImpl(
      {required this.id,
      required this.name,
      required this.url,
      required this.type,
      required this.size,
      this.uploadedAt,
      this.description});

  factory _$EventAttachmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventAttachmentImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String url;
  @override
  final String type;
// image, document, video, etc.
  @override
  final int size;
  @override
  final DateTime? uploadedAt;
  @override
  final String? description;

  @override
  String toString() {
    return 'EventAttachment(id: $id, name: $name, url: $url, type: $type, size: $size, uploadedAt: $uploadedAt, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventAttachmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.uploadedAt, uploadedAt) ||
                other.uploadedAt == uploadedAt) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, url, type, size, uploadedAt, description);

  /// Create a copy of EventAttachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventAttachmentImplCopyWith<_$EventAttachmentImpl> get copyWith =>
      __$$EventAttachmentImplCopyWithImpl<_$EventAttachmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventAttachmentImplToJson(
      this,
    );
  }
}

abstract class _EventAttachment implements EventAttachment {
  const factory _EventAttachment(
      {required final String id,
      required final String name,
      required final String url,
      required final String type,
      required final int size,
      final DateTime? uploadedAt,
      final String? description}) = _$EventAttachmentImpl;

  factory _EventAttachment.fromJson(Map<String, dynamic> json) =
      _$EventAttachmentImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get url;
  @override
  String get type; // image, document, video, etc.
  @override
  int get size;
  @override
  DateTime? get uploadedAt;
  @override
  String? get description;

  /// Create a copy of EventAttachment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventAttachmentImplCopyWith<_$EventAttachmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CalendarModel _$CalendarModelFromJson(Map<String, dynamic> json) {
  return _CalendarModel.fromJson(json);
}

/// @nodoc
mixin _$CalendarModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get isVisible => throw _privateConstructorUsedError;
  bool get isReadOnly => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // local, google, outlook, icloud
  String? get ownerId => throw _privateConstructorUsedError;
  List<String> get sharedWith => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get syncToken => throw _privateConstructorUsedError;
  Map<String, dynamic>? get syncSettings => throw _privateConstructorUsedError;

  /// Serializes this CalendarModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CalendarModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalendarModelCopyWith<CalendarModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarModelCopyWith<$Res> {
  factory $CalendarModelCopyWith(
          CalendarModel value, $Res Function(CalendarModel) then) =
      _$CalendarModelCopyWithImpl<$Res, CalendarModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      String color,
      String description,
      bool isVisible,
      bool isReadOnly,
      bool isDefault,
      String type,
      String? ownerId,
      List<String> sharedWith,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? syncToken,
      Map<String, dynamic>? syncSettings});
}

/// @nodoc
class _$CalendarModelCopyWithImpl<$Res, $Val extends CalendarModel>
    implements $CalendarModelCopyWith<$Res> {
  _$CalendarModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalendarModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = null,
    Object? description = null,
    Object? isVisible = null,
    Object? isReadOnly = null,
    Object? isDefault = null,
    Object? type = null,
    Object? ownerId = freezed,
    Object? sharedWith = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? syncToken = freezed,
    Object? syncSettings = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      isReadOnly: null == isReadOnly
          ? _value.isReadOnly
          : isReadOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
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
      syncToken: freezed == syncToken
          ? _value.syncToken
          : syncToken // ignore: cast_nullable_to_non_nullable
              as String?,
      syncSettings: freezed == syncSettings
          ? _value.syncSettings
          : syncSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalendarModelImplCopyWith<$Res>
    implements $CalendarModelCopyWith<$Res> {
  factory _$$CalendarModelImplCopyWith(
          _$CalendarModelImpl value, $Res Function(_$CalendarModelImpl) then) =
      __$$CalendarModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String color,
      String description,
      bool isVisible,
      bool isReadOnly,
      bool isDefault,
      String type,
      String? ownerId,
      List<String> sharedWith,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? syncToken,
      Map<String, dynamic>? syncSettings});
}

/// @nodoc
class __$$CalendarModelImplCopyWithImpl<$Res>
    extends _$CalendarModelCopyWithImpl<$Res, _$CalendarModelImpl>
    implements _$$CalendarModelImplCopyWith<$Res> {
  __$$CalendarModelImplCopyWithImpl(
      _$CalendarModelImpl _value, $Res Function(_$CalendarModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = null,
    Object? description = null,
    Object? isVisible = null,
    Object? isReadOnly = null,
    Object? isDefault = null,
    Object? type = null,
    Object? ownerId = freezed,
    Object? sharedWith = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? syncToken = freezed,
    Object? syncSettings = freezed,
  }) {
    return _then(_$CalendarModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      isReadOnly: null == isReadOnly
          ? _value.isReadOnly
          : isReadOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
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
      syncToken: freezed == syncToken
          ? _value.syncToken
          : syncToken // ignore: cast_nullable_to_non_nullable
              as String?,
      syncSettings: freezed == syncSettings
          ? _value._syncSettings
          : syncSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalendarModelImpl implements _CalendarModel {
  const _$CalendarModelImpl(
      {required this.id,
      required this.name,
      required this.color,
      this.description = '',
      this.isVisible = true,
      this.isReadOnly = false,
      this.isDefault = false,
      this.type = 'local',
      this.ownerId,
      final List<String> sharedWith = const [],
      this.createdAt,
      this.updatedAt,
      this.syncToken,
      final Map<String, dynamic>? syncSettings})
      : _sharedWith = sharedWith,
        _syncSettings = syncSettings;

  factory _$CalendarModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String color;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final bool isVisible;
  @override
  @JsonKey()
  final bool isReadOnly;
  @override
  @JsonKey()
  final bool isDefault;
  @override
  @JsonKey()
  final String type;
// local, google, outlook, icloud
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
  final String? syncToken;
  final Map<String, dynamic>? _syncSettings;
  @override
  Map<String, dynamic>? get syncSettings {
    final value = _syncSettings;
    if (value == null) return null;
    if (_syncSettings is EqualUnmodifiableMapView) return _syncSettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'CalendarModel(id: $id, name: $name, color: $color, description: $description, isVisible: $isVisible, isReadOnly: $isReadOnly, isDefault: $isDefault, type: $type, ownerId: $ownerId, sharedWith: $sharedWith, createdAt: $createdAt, updatedAt: $updatedAt, syncToken: $syncToken, syncSettings: $syncSettings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible) &&
            (identical(other.isReadOnly, isReadOnly) ||
                other.isReadOnly == isReadOnly) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality()
                .equals(other._sharedWith, _sharedWith) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncToken, syncToken) ||
                other.syncToken == syncToken) &&
            const DeepCollectionEquality()
                .equals(other._syncSettings, _syncSettings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      color,
      description,
      isVisible,
      isReadOnly,
      isDefault,
      type,
      ownerId,
      const DeepCollectionEquality().hash(_sharedWith),
      createdAt,
      updatedAt,
      syncToken,
      const DeepCollectionEquality().hash(_syncSettings));

  /// Create a copy of CalendarModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarModelImplCopyWith<_$CalendarModelImpl> get copyWith =>
      __$$CalendarModelImplCopyWithImpl<_$CalendarModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalendarModelImplToJson(
      this,
    );
  }
}

abstract class _CalendarModel implements CalendarModel {
  const factory _CalendarModel(
      {required final int id,
      required final String name,
      required final String color,
      final String description,
      final bool isVisible,
      final bool isReadOnly,
      final bool isDefault,
      final String type,
      final String? ownerId,
      final List<String> sharedWith,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final String? syncToken,
      final Map<String, dynamic>? syncSettings}) = _$CalendarModelImpl;

  factory _CalendarModel.fromJson(Map<String, dynamic> json) =
      _$CalendarModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get color;
  @override
  String get description;
  @override
  bool get isVisible;
  @override
  bool get isReadOnly;
  @override
  bool get isDefault;
  @override
  String get type; // local, google, outlook, icloud
  @override
  String? get ownerId;
  @override
  List<String> get sharedWith;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  String? get syncToken;
  @override
  Map<String, dynamic>? get syncSettings;

  /// Create a copy of CalendarModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalendarModelImplCopyWith<_$CalendarModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EventInvitation _$EventInvitationFromJson(Map<String, dynamic> json) {
  return _EventInvitation.fromJson(json);
}

/// @nodoc
mixin _$EventInvitation {
  String get id => throw _privateConstructorUsedError;
  int get eventId => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  RsvpStatus get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  DateTime? get sentAt => throw _privateConstructorUsedError;
  DateTime? get respondedAt => throw _privateConstructorUsedError;
  bool get isOptional => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;

  /// Serializes this EventInvitation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventInvitation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventInvitationCopyWith<EventInvitation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventInvitationCopyWith<$Res> {
  factory $EventInvitationCopyWith(
          EventInvitation value, $Res Function(EventInvitation) then) =
      _$EventInvitationCopyWithImpl<$Res, EventInvitation>;
  @useResult
  $Res call(
      {String id,
      int eventId,
      String email,
      String name,
      RsvpStatus status,
      String? message,
      DateTime? sentAt,
      DateTime? respondedAt,
      bool isOptional,
      String role});
}

/// @nodoc
class _$EventInvitationCopyWithImpl<$Res, $Val extends EventInvitation>
    implements $EventInvitationCopyWith<$Res> {
  _$EventInvitationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventInvitation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? email = null,
    Object? name = null,
    Object? status = null,
    Object? message = freezed,
    Object? sentAt = freezed,
    Object? respondedAt = freezed,
    Object? isOptional = null,
    Object? role = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RsvpStatus,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      respondedAt: freezed == respondedAt
          ? _value.respondedAt
          : respondedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isOptional: null == isOptional
          ? _value.isOptional
          : isOptional // ignore: cast_nullable_to_non_nullable
              as bool,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventInvitationImplCopyWith<$Res>
    implements $EventInvitationCopyWith<$Res> {
  factory _$$EventInvitationImplCopyWith(_$EventInvitationImpl value,
          $Res Function(_$EventInvitationImpl) then) =
      __$$EventInvitationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int eventId,
      String email,
      String name,
      RsvpStatus status,
      String? message,
      DateTime? sentAt,
      DateTime? respondedAt,
      bool isOptional,
      String role});
}

/// @nodoc
class __$$EventInvitationImplCopyWithImpl<$Res>
    extends _$EventInvitationCopyWithImpl<$Res, _$EventInvitationImpl>
    implements _$$EventInvitationImplCopyWith<$Res> {
  __$$EventInvitationImplCopyWithImpl(
      _$EventInvitationImpl _value, $Res Function(_$EventInvitationImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventInvitation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? email = null,
    Object? name = null,
    Object? status = null,
    Object? message = freezed,
    Object? sentAt = freezed,
    Object? respondedAt = freezed,
    Object? isOptional = null,
    Object? role = null,
  }) {
    return _then(_$EventInvitationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RsvpStatus,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      respondedAt: freezed == respondedAt
          ? _value.respondedAt
          : respondedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isOptional: null == isOptional
          ? _value.isOptional
          : isOptional // ignore: cast_nullable_to_non_nullable
              as bool,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventInvitationImpl implements _EventInvitation {
  const _$EventInvitationImpl(
      {required this.id,
      required this.eventId,
      required this.email,
      required this.name,
      this.status = RsvpStatus.pending,
      this.message,
      this.sentAt,
      this.respondedAt,
      this.isOptional = false,
      this.role = 'attendee'});

  factory _$EventInvitationImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventInvitationImplFromJson(json);

  @override
  final String id;
  @override
  final int eventId;
  @override
  final String email;
  @override
  final String name;
  @override
  @JsonKey()
  final RsvpStatus status;
  @override
  final String? message;
  @override
  final DateTime? sentAt;
  @override
  final DateTime? respondedAt;
  @override
  @JsonKey()
  final bool isOptional;
  @override
  @JsonKey()
  final String role;

  @override
  String toString() {
    return 'EventInvitation(id: $id, eventId: $eventId, email: $email, name: $name, status: $status, message: $message, sentAt: $sentAt, respondedAt: $respondedAt, isOptional: $isOptional, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventInvitationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.respondedAt, respondedAt) ||
                other.respondedAt == respondedAt) &&
            (identical(other.isOptional, isOptional) ||
                other.isOptional == isOptional) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, eventId, email, name, status,
      message, sentAt, respondedAt, isOptional, role);

  /// Create a copy of EventInvitation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventInvitationImplCopyWith<_$EventInvitationImpl> get copyWith =>
      __$$EventInvitationImplCopyWithImpl<_$EventInvitationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventInvitationImplToJson(
      this,
    );
  }
}

abstract class _EventInvitation implements EventInvitation {
  const factory _EventInvitation(
      {required final String id,
      required final int eventId,
      required final String email,
      required final String name,
      final RsvpStatus status,
      final String? message,
      final DateTime? sentAt,
      final DateTime? respondedAt,
      final bool isOptional,
      final String role}) = _$EventInvitationImpl;

  factory _EventInvitation.fromJson(Map<String, dynamic> json) =
      _$EventInvitationImpl.fromJson;

  @override
  String get id;
  @override
  int get eventId;
  @override
  String get email;
  @override
  String get name;
  @override
  RsvpStatus get status;
  @override
  String? get message;
  @override
  DateTime? get sentAt;
  @override
  DateTime? get respondedAt;
  @override
  bool get isOptional;
  @override
  String get role;

  /// Create a copy of EventInvitation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventInvitationImplCopyWith<_$EventInvitationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EventConflict _$EventConflictFromJson(Map<String, dynamic> json) {
  return _EventConflict.fromJson(json);
}

/// @nodoc
mixin _$EventConflict {
  CalendarEvent get event1 => throw _privateConstructorUsedError;
  CalendarEvent get event2 => throw _privateConstructorUsedError;
  DateTime get conflictStart => throw _privateConstructorUsedError;
  DateTime get conflictEnd => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // overlap, adjacent, etc.
  String? get suggestion => throw _privateConstructorUsedError;

  /// Serializes this EventConflict to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventConflict
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventConflictCopyWith<EventConflict> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventConflictCopyWith<$Res> {
  factory $EventConflictCopyWith(
          EventConflict value, $Res Function(EventConflict) then) =
      _$EventConflictCopyWithImpl<$Res, EventConflict>;
  @useResult
  $Res call(
      {CalendarEvent event1,
      CalendarEvent event2,
      DateTime conflictStart,
      DateTime conflictEnd,
      String type,
      String? suggestion});

  $CalendarEventCopyWith<$Res> get event1;
  $CalendarEventCopyWith<$Res> get event2;
}

/// @nodoc
class _$EventConflictCopyWithImpl<$Res, $Val extends EventConflict>
    implements $EventConflictCopyWith<$Res> {
  _$EventConflictCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventConflict
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event1 = null,
    Object? event2 = null,
    Object? conflictStart = null,
    Object? conflictEnd = null,
    Object? type = null,
    Object? suggestion = freezed,
  }) {
    return _then(_value.copyWith(
      event1: null == event1
          ? _value.event1
          : event1 // ignore: cast_nullable_to_non_nullable
              as CalendarEvent,
      event2: null == event2
          ? _value.event2
          : event2 // ignore: cast_nullable_to_non_nullable
              as CalendarEvent,
      conflictStart: null == conflictStart
          ? _value.conflictStart
          : conflictStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      conflictEnd: null == conflictEnd
          ? _value.conflictEnd
          : conflictEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      suggestion: freezed == suggestion
          ? _value.suggestion
          : suggestion // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of EventConflict
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CalendarEventCopyWith<$Res> get event1 {
    return $CalendarEventCopyWith<$Res>(_value.event1, (value) {
      return _then(_value.copyWith(event1: value) as $Val);
    });
  }

  /// Create a copy of EventConflict
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CalendarEventCopyWith<$Res> get event2 {
    return $CalendarEventCopyWith<$Res>(_value.event2, (value) {
      return _then(_value.copyWith(event2: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EventConflictImplCopyWith<$Res>
    implements $EventConflictCopyWith<$Res> {
  factory _$$EventConflictImplCopyWith(
          _$EventConflictImpl value, $Res Function(_$EventConflictImpl) then) =
      __$$EventConflictImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CalendarEvent event1,
      CalendarEvent event2,
      DateTime conflictStart,
      DateTime conflictEnd,
      String type,
      String? suggestion});

  @override
  $CalendarEventCopyWith<$Res> get event1;
  @override
  $CalendarEventCopyWith<$Res> get event2;
}

/// @nodoc
class __$$EventConflictImplCopyWithImpl<$Res>
    extends _$EventConflictCopyWithImpl<$Res, _$EventConflictImpl>
    implements _$$EventConflictImplCopyWith<$Res> {
  __$$EventConflictImplCopyWithImpl(
      _$EventConflictImpl _value, $Res Function(_$EventConflictImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventConflict
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event1 = null,
    Object? event2 = null,
    Object? conflictStart = null,
    Object? conflictEnd = null,
    Object? type = null,
    Object? suggestion = freezed,
  }) {
    return _then(_$EventConflictImpl(
      event1: null == event1
          ? _value.event1
          : event1 // ignore: cast_nullable_to_non_nullable
              as CalendarEvent,
      event2: null == event2
          ? _value.event2
          : event2 // ignore: cast_nullable_to_non_nullable
              as CalendarEvent,
      conflictStart: null == conflictStart
          ? _value.conflictStart
          : conflictStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      conflictEnd: null == conflictEnd
          ? _value.conflictEnd
          : conflictEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      suggestion: freezed == suggestion
          ? _value.suggestion
          : suggestion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventConflictImpl implements _EventConflict {
  const _$EventConflictImpl(
      {required this.event1,
      required this.event2,
      required this.conflictStart,
      required this.conflictEnd,
      this.type = 'overlap',
      this.suggestion});

  factory _$EventConflictImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventConflictImplFromJson(json);

  @override
  final CalendarEvent event1;
  @override
  final CalendarEvent event2;
  @override
  final DateTime conflictStart;
  @override
  final DateTime conflictEnd;
  @override
  @JsonKey()
  final String type;
// overlap, adjacent, etc.
  @override
  final String? suggestion;

  @override
  String toString() {
    return 'EventConflict(event1: $event1, event2: $event2, conflictStart: $conflictStart, conflictEnd: $conflictEnd, type: $type, suggestion: $suggestion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventConflictImpl &&
            (identical(other.event1, event1) || other.event1 == event1) &&
            (identical(other.event2, event2) || other.event2 == event2) &&
            (identical(other.conflictStart, conflictStart) ||
                other.conflictStart == conflictStart) &&
            (identical(other.conflictEnd, conflictEnd) ||
                other.conflictEnd == conflictEnd) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.suggestion, suggestion) ||
                other.suggestion == suggestion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, event1, event2, conflictStart,
      conflictEnd, type, suggestion);

  /// Create a copy of EventConflict
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventConflictImplCopyWith<_$EventConflictImpl> get copyWith =>
      __$$EventConflictImplCopyWithImpl<_$EventConflictImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventConflictImplToJson(
      this,
    );
  }
}

abstract class _EventConflict implements EventConflict {
  const factory _EventConflict(
      {required final CalendarEvent event1,
      required final CalendarEvent event2,
      required final DateTime conflictStart,
      required final DateTime conflictEnd,
      final String type,
      final String? suggestion}) = _$EventConflictImpl;

  factory _EventConflict.fromJson(Map<String, dynamic> json) =
      _$EventConflictImpl.fromJson;

  @override
  CalendarEvent get event1;
  @override
  CalendarEvent get event2;
  @override
  DateTime get conflictStart;
  @override
  DateTime get conflictEnd;
  @override
  String get type; // overlap, adjacent, etc.
  @override
  String? get suggestion;

  /// Create a copy of EventConflict
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventConflictImplCopyWith<_$EventConflictImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) {
  return _TimeSlot.fromJson(json);
}

/// @nodoc
mixin _$TimeSlot {
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  List<CalendarEvent> get events => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;

  /// Serializes this TimeSlot to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeSlotCopyWith<TimeSlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeSlotCopyWith<$Res> {
  factory $TimeSlotCopyWith(TimeSlot value, $Res Function(TimeSlot) then) =
      _$TimeSlotCopyWithImpl<$Res, TimeSlot>;
  @useResult
  $Res call(
      {DateTime startTime,
      DateTime endTime,
      bool isAvailable,
      List<CalendarEvent> events,
      String? label});
}

/// @nodoc
class _$TimeSlotCopyWithImpl<$Res, $Val extends TimeSlot>
    implements $TimeSlotCopyWith<$Res> {
  _$TimeSlotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? endTime = null,
    Object? isAvailable = null,
    Object? events = null,
    Object? label = freezed,
  }) {
    return _then(_value.copyWith(
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<CalendarEvent>,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeSlotImplCopyWith<$Res>
    implements $TimeSlotCopyWith<$Res> {
  factory _$$TimeSlotImplCopyWith(
          _$TimeSlotImpl value, $Res Function(_$TimeSlotImpl) then) =
      __$$TimeSlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime startTime,
      DateTime endTime,
      bool isAvailable,
      List<CalendarEvent> events,
      String? label});
}

/// @nodoc
class __$$TimeSlotImplCopyWithImpl<$Res>
    extends _$TimeSlotCopyWithImpl<$Res, _$TimeSlotImpl>
    implements _$$TimeSlotImplCopyWith<$Res> {
  __$$TimeSlotImplCopyWithImpl(
      _$TimeSlotImpl _value, $Res Function(_$TimeSlotImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? endTime = null,
    Object? isAvailable = null,
    Object? events = null,
    Object? label = freezed,
  }) {
    return _then(_$TimeSlotImpl(
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      events: null == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<CalendarEvent>,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeSlotImpl implements _TimeSlot {
  const _$TimeSlotImpl(
      {required this.startTime,
      required this.endTime,
      this.isAvailable = true,
      final List<CalendarEvent> events = const [],
      this.label})
      : _events = events;

  factory _$TimeSlotImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeSlotImplFromJson(json);

  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  @JsonKey()
  final bool isAvailable;
  final List<CalendarEvent> _events;
  @override
  @JsonKey()
  List<CalendarEvent> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  @override
  final String? label;

  @override
  String toString() {
    return 'TimeSlot(startTime: $startTime, endTime: $endTime, isAvailable: $isAvailable, events: $events, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeSlotImpl &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            const DeepCollectionEquality().equals(other._events, _events) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, startTime, endTime, isAvailable,
      const DeepCollectionEquality().hash(_events), label);

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeSlotImplCopyWith<_$TimeSlotImpl> get copyWith =>
      __$$TimeSlotImplCopyWithImpl<_$TimeSlotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeSlotImplToJson(
      this,
    );
  }
}

abstract class _TimeSlot implements TimeSlot {
  const factory _TimeSlot(
      {required final DateTime startTime,
      required final DateTime endTime,
      final bool isAvailable,
      final List<CalendarEvent> events,
      final String? label}) = _$TimeSlotImpl;

  factory _TimeSlot.fromJson(Map<String, dynamic> json) =
      _$TimeSlotImpl.fromJson;

  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  bool get isAvailable;
  @override
  List<CalendarEvent> get events;
  @override
  String? get label;

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeSlotImplCopyWith<_$TimeSlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CalendarSettings _$CalendarSettingsFromJson(Map<String, dynamic> json) {
  return _CalendarSettings.fromJson(json);
}

/// @nodoc
mixin _$CalendarSettings {
  CalendarView get defaultView => throw _privateConstructorUsedError;
  int get firstDayOfWeek =>
      throw _privateConstructorUsedError; // 0=Sunday, 1=Monday
  String get timezone => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  TimeOfDay get workDayStart => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  TimeOfDay get workDayEnd => throw _privateConstructorUsedError;
  List<int> get workDays =>
      throw _privateConstructorUsedError; // 1=Monday, 7=Sunday
  List<int> get defaultReminders => throw _privateConstructorUsedError;
  bool get showWeekNumbers => throw _privateConstructorUsedError;
  bool get showDeclinedEvents => throw _privateConstructorUsedError;
  bool get enable24HourFormat => throw _privateConstructorUsedError;
  String get dateFormat => throw _privateConstructorUsedError;
  String get timeFormat => throw _privateConstructorUsedError;
  Map<EventType, String> get eventTypeColors =>
      throw _privateConstructorUsedError;
  bool get enableNotifications => throw _privateConstructorUsedError;
  bool get enableEmailReminders => throw _privateConstructorUsedError;
  bool get enableSmsReminders => throw _privateConstructorUsedError;
  int get defaultEventDuration => throw _privateConstructorUsedError; // minutes
  int get eventSnapInterval => throw _privateConstructorUsedError; // minutes
  List<String> get quickAddTags => throw _privateConstructorUsedError;

  /// Serializes this CalendarSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CalendarSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalendarSettingsCopyWith<CalendarSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarSettingsCopyWith<$Res> {
  factory $CalendarSettingsCopyWith(
          CalendarSettings value, $Res Function(CalendarSettings) then) =
      _$CalendarSettingsCopyWithImpl<$Res, CalendarSettings>;
  @useResult
  $Res call(
      {CalendarView defaultView,
      int firstDayOfWeek,
      String timezone,
      @JsonKey(includeFromJson: false, includeToJson: false)
      TimeOfDay workDayStart,
      @JsonKey(includeFromJson: false, includeToJson: false)
      TimeOfDay workDayEnd,
      List<int> workDays,
      List<int> defaultReminders,
      bool showWeekNumbers,
      bool showDeclinedEvents,
      bool enable24HourFormat,
      String dateFormat,
      String timeFormat,
      Map<EventType, String> eventTypeColors,
      bool enableNotifications,
      bool enableEmailReminders,
      bool enableSmsReminders,
      int defaultEventDuration,
      int eventSnapInterval,
      List<String> quickAddTags});
}

/// @nodoc
class _$CalendarSettingsCopyWithImpl<$Res, $Val extends CalendarSettings>
    implements $CalendarSettingsCopyWith<$Res> {
  _$CalendarSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalendarSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultView = null,
    Object? firstDayOfWeek = null,
    Object? timezone = null,
    Object? workDayStart = null,
    Object? workDayEnd = null,
    Object? workDays = null,
    Object? defaultReminders = null,
    Object? showWeekNumbers = null,
    Object? showDeclinedEvents = null,
    Object? enable24HourFormat = null,
    Object? dateFormat = null,
    Object? timeFormat = null,
    Object? eventTypeColors = null,
    Object? enableNotifications = null,
    Object? enableEmailReminders = null,
    Object? enableSmsReminders = null,
    Object? defaultEventDuration = null,
    Object? eventSnapInterval = null,
    Object? quickAddTags = null,
  }) {
    return _then(_value.copyWith(
      defaultView: null == defaultView
          ? _value.defaultView
          : defaultView // ignore: cast_nullable_to_non_nullable
              as CalendarView,
      firstDayOfWeek: null == firstDayOfWeek
          ? _value.firstDayOfWeek
          : firstDayOfWeek // ignore: cast_nullable_to_non_nullable
              as int,
      timezone: null == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
      workDayStart: null == workDayStart
          ? _value.workDayStart
          : workDayStart // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      workDayEnd: null == workDayEnd
          ? _value.workDayEnd
          : workDayEnd // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      workDays: null == workDays
          ? _value.workDays
          : workDays // ignore: cast_nullable_to_non_nullable
              as List<int>,
      defaultReminders: null == defaultReminders
          ? _value.defaultReminders
          : defaultReminders // ignore: cast_nullable_to_non_nullable
              as List<int>,
      showWeekNumbers: null == showWeekNumbers
          ? _value.showWeekNumbers
          : showWeekNumbers // ignore: cast_nullable_to_non_nullable
              as bool,
      showDeclinedEvents: null == showDeclinedEvents
          ? _value.showDeclinedEvents
          : showDeclinedEvents // ignore: cast_nullable_to_non_nullable
              as bool,
      enable24HourFormat: null == enable24HourFormat
          ? _value.enable24HourFormat
          : enable24HourFormat // ignore: cast_nullable_to_non_nullable
              as bool,
      dateFormat: null == dateFormat
          ? _value.dateFormat
          : dateFormat // ignore: cast_nullable_to_non_nullable
              as String,
      timeFormat: null == timeFormat
          ? _value.timeFormat
          : timeFormat // ignore: cast_nullable_to_non_nullable
              as String,
      eventTypeColors: null == eventTypeColors
          ? _value.eventTypeColors
          : eventTypeColors // ignore: cast_nullable_to_non_nullable
              as Map<EventType, String>,
      enableNotifications: null == enableNotifications
          ? _value.enableNotifications
          : enableNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      enableEmailReminders: null == enableEmailReminders
          ? _value.enableEmailReminders
          : enableEmailReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSmsReminders: null == enableSmsReminders
          ? _value.enableSmsReminders
          : enableSmsReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultEventDuration: null == defaultEventDuration
          ? _value.defaultEventDuration
          : defaultEventDuration // ignore: cast_nullable_to_non_nullable
              as int,
      eventSnapInterval: null == eventSnapInterval
          ? _value.eventSnapInterval
          : eventSnapInterval // ignore: cast_nullable_to_non_nullable
              as int,
      quickAddTags: null == quickAddTags
          ? _value.quickAddTags
          : quickAddTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalendarSettingsImplCopyWith<$Res>
    implements $CalendarSettingsCopyWith<$Res> {
  factory _$$CalendarSettingsImplCopyWith(_$CalendarSettingsImpl value,
          $Res Function(_$CalendarSettingsImpl) then) =
      __$$CalendarSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CalendarView defaultView,
      int firstDayOfWeek,
      String timezone,
      @JsonKey(includeFromJson: false, includeToJson: false)
      TimeOfDay workDayStart,
      @JsonKey(includeFromJson: false, includeToJson: false)
      TimeOfDay workDayEnd,
      List<int> workDays,
      List<int> defaultReminders,
      bool showWeekNumbers,
      bool showDeclinedEvents,
      bool enable24HourFormat,
      String dateFormat,
      String timeFormat,
      Map<EventType, String> eventTypeColors,
      bool enableNotifications,
      bool enableEmailReminders,
      bool enableSmsReminders,
      int defaultEventDuration,
      int eventSnapInterval,
      List<String> quickAddTags});
}

/// @nodoc
class __$$CalendarSettingsImplCopyWithImpl<$Res>
    extends _$CalendarSettingsCopyWithImpl<$Res, _$CalendarSettingsImpl>
    implements _$$CalendarSettingsImplCopyWith<$Res> {
  __$$CalendarSettingsImplCopyWithImpl(_$CalendarSettingsImpl _value,
      $Res Function(_$CalendarSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultView = null,
    Object? firstDayOfWeek = null,
    Object? timezone = null,
    Object? workDayStart = null,
    Object? workDayEnd = null,
    Object? workDays = null,
    Object? defaultReminders = null,
    Object? showWeekNumbers = null,
    Object? showDeclinedEvents = null,
    Object? enable24HourFormat = null,
    Object? dateFormat = null,
    Object? timeFormat = null,
    Object? eventTypeColors = null,
    Object? enableNotifications = null,
    Object? enableEmailReminders = null,
    Object? enableSmsReminders = null,
    Object? defaultEventDuration = null,
    Object? eventSnapInterval = null,
    Object? quickAddTags = null,
  }) {
    return _then(_$CalendarSettingsImpl(
      defaultView: null == defaultView
          ? _value.defaultView
          : defaultView // ignore: cast_nullable_to_non_nullable
              as CalendarView,
      firstDayOfWeek: null == firstDayOfWeek
          ? _value.firstDayOfWeek
          : firstDayOfWeek // ignore: cast_nullable_to_non_nullable
              as int,
      timezone: null == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
      workDayStart: null == workDayStart
          ? _value.workDayStart
          : workDayStart // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      workDayEnd: null == workDayEnd
          ? _value.workDayEnd
          : workDayEnd // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      workDays: null == workDays
          ? _value._workDays
          : workDays // ignore: cast_nullable_to_non_nullable
              as List<int>,
      defaultReminders: null == defaultReminders
          ? _value._defaultReminders
          : defaultReminders // ignore: cast_nullable_to_non_nullable
              as List<int>,
      showWeekNumbers: null == showWeekNumbers
          ? _value.showWeekNumbers
          : showWeekNumbers // ignore: cast_nullable_to_non_nullable
              as bool,
      showDeclinedEvents: null == showDeclinedEvents
          ? _value.showDeclinedEvents
          : showDeclinedEvents // ignore: cast_nullable_to_non_nullable
              as bool,
      enable24HourFormat: null == enable24HourFormat
          ? _value.enable24HourFormat
          : enable24HourFormat // ignore: cast_nullable_to_non_nullable
              as bool,
      dateFormat: null == dateFormat
          ? _value.dateFormat
          : dateFormat // ignore: cast_nullable_to_non_nullable
              as String,
      timeFormat: null == timeFormat
          ? _value.timeFormat
          : timeFormat // ignore: cast_nullable_to_non_nullable
              as String,
      eventTypeColors: null == eventTypeColors
          ? _value._eventTypeColors
          : eventTypeColors // ignore: cast_nullable_to_non_nullable
              as Map<EventType, String>,
      enableNotifications: null == enableNotifications
          ? _value.enableNotifications
          : enableNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      enableEmailReminders: null == enableEmailReminders
          ? _value.enableEmailReminders
          : enableEmailReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSmsReminders: null == enableSmsReminders
          ? _value.enableSmsReminders
          : enableSmsReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultEventDuration: null == defaultEventDuration
          ? _value.defaultEventDuration
          : defaultEventDuration // ignore: cast_nullable_to_non_nullable
              as int,
      eventSnapInterval: null == eventSnapInterval
          ? _value.eventSnapInterval
          : eventSnapInterval // ignore: cast_nullable_to_non_nullable
              as int,
      quickAddTags: null == quickAddTags
          ? _value._quickAddTags
          : quickAddTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalendarSettingsImpl implements _CalendarSettings {
  const _$CalendarSettingsImpl(
      {this.defaultView = CalendarView.month,
      this.firstDayOfWeek = 1,
      this.timezone = 'local',
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.workDayStart = const TimeOfDay(hour: 9, minute: 0),
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.workDayEnd = const TimeOfDay(hour: 17, minute: 0),
      final List<int> workDays = const [1, 2, 3, 4, 5],
      final List<int> defaultReminders = const [15, 30, 60],
      this.showWeekNumbers = true,
      this.showDeclinedEvents = true,
      this.enable24HourFormat = false,
      this.dateFormat = 'yyyy-MM-dd',
      this.timeFormat = 'HH:mm',
      final Map<EventType, String> eventTypeColors = const {},
      this.enableNotifications = true,
      this.enableEmailReminders = true,
      this.enableSmsReminders = false,
      this.defaultEventDuration = 30,
      this.eventSnapInterval = 5,
      final List<String> quickAddTags = const []})
      : _workDays = workDays,
        _defaultReminders = defaultReminders,
        _eventTypeColors = eventTypeColors,
        _quickAddTags = quickAddTags;

  factory _$CalendarSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarSettingsImplFromJson(json);

  @override
  @JsonKey()
  final CalendarView defaultView;
  @override
  @JsonKey()
  final int firstDayOfWeek;
// 0=Sunday, 1=Monday
  @override
  @JsonKey()
  final String timezone;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final TimeOfDay workDayStart;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final TimeOfDay workDayEnd;
  final List<int> _workDays;
  @override
  @JsonKey()
  List<int> get workDays {
    if (_workDays is EqualUnmodifiableListView) return _workDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workDays);
  }

// 1=Monday, 7=Sunday
  final List<int> _defaultReminders;
// 1=Monday, 7=Sunday
  @override
  @JsonKey()
  List<int> get defaultReminders {
    if (_defaultReminders is EqualUnmodifiableListView)
      return _defaultReminders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_defaultReminders);
  }

  @override
  @JsonKey()
  final bool showWeekNumbers;
  @override
  @JsonKey()
  final bool showDeclinedEvents;
  @override
  @JsonKey()
  final bool enable24HourFormat;
  @override
  @JsonKey()
  final String dateFormat;
  @override
  @JsonKey()
  final String timeFormat;
  final Map<EventType, String> _eventTypeColors;
  @override
  @JsonKey()
  Map<EventType, String> get eventTypeColors {
    if (_eventTypeColors is EqualUnmodifiableMapView) return _eventTypeColors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_eventTypeColors);
  }

  @override
  @JsonKey()
  final bool enableNotifications;
  @override
  @JsonKey()
  final bool enableEmailReminders;
  @override
  @JsonKey()
  final bool enableSmsReminders;
  @override
  @JsonKey()
  final int defaultEventDuration;
// minutes
  @override
  @JsonKey()
  final int eventSnapInterval;
// minutes
  final List<String> _quickAddTags;
// minutes
  @override
  @JsonKey()
  List<String> get quickAddTags {
    if (_quickAddTags is EqualUnmodifiableListView) return _quickAddTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quickAddTags);
  }

  @override
  String toString() {
    return 'CalendarSettings(defaultView: $defaultView, firstDayOfWeek: $firstDayOfWeek, timezone: $timezone, workDayStart: $workDayStart, workDayEnd: $workDayEnd, workDays: $workDays, defaultReminders: $defaultReminders, showWeekNumbers: $showWeekNumbers, showDeclinedEvents: $showDeclinedEvents, enable24HourFormat: $enable24HourFormat, dateFormat: $dateFormat, timeFormat: $timeFormat, eventTypeColors: $eventTypeColors, enableNotifications: $enableNotifications, enableEmailReminders: $enableEmailReminders, enableSmsReminders: $enableSmsReminders, defaultEventDuration: $defaultEventDuration, eventSnapInterval: $eventSnapInterval, quickAddTags: $quickAddTags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarSettingsImpl &&
            (identical(other.defaultView, defaultView) ||
                other.defaultView == defaultView) &&
            (identical(other.firstDayOfWeek, firstDayOfWeek) ||
                other.firstDayOfWeek == firstDayOfWeek) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.workDayStart, workDayStart) ||
                other.workDayStart == workDayStart) &&
            (identical(other.workDayEnd, workDayEnd) ||
                other.workDayEnd == workDayEnd) &&
            const DeepCollectionEquality().equals(other._workDays, _workDays) &&
            const DeepCollectionEquality()
                .equals(other._defaultReminders, _defaultReminders) &&
            (identical(other.showWeekNumbers, showWeekNumbers) ||
                other.showWeekNumbers == showWeekNumbers) &&
            (identical(other.showDeclinedEvents, showDeclinedEvents) ||
                other.showDeclinedEvents == showDeclinedEvents) &&
            (identical(other.enable24HourFormat, enable24HourFormat) ||
                other.enable24HourFormat == enable24HourFormat) &&
            (identical(other.dateFormat, dateFormat) ||
                other.dateFormat == dateFormat) &&
            (identical(other.timeFormat, timeFormat) ||
                other.timeFormat == timeFormat) &&
            const DeepCollectionEquality()
                .equals(other._eventTypeColors, _eventTypeColors) &&
            (identical(other.enableNotifications, enableNotifications) ||
                other.enableNotifications == enableNotifications) &&
            (identical(other.enableEmailReminders, enableEmailReminders) ||
                other.enableEmailReminders == enableEmailReminders) &&
            (identical(other.enableSmsReminders, enableSmsReminders) ||
                other.enableSmsReminders == enableSmsReminders) &&
            (identical(other.defaultEventDuration, defaultEventDuration) ||
                other.defaultEventDuration == defaultEventDuration) &&
            (identical(other.eventSnapInterval, eventSnapInterval) ||
                other.eventSnapInterval == eventSnapInterval) &&
            const DeepCollectionEquality()
                .equals(other._quickAddTags, _quickAddTags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        defaultView,
        firstDayOfWeek,
        timezone,
        workDayStart,
        workDayEnd,
        const DeepCollectionEquality().hash(_workDays),
        const DeepCollectionEquality().hash(_defaultReminders),
        showWeekNumbers,
        showDeclinedEvents,
        enable24HourFormat,
        dateFormat,
        timeFormat,
        const DeepCollectionEquality().hash(_eventTypeColors),
        enableNotifications,
        enableEmailReminders,
        enableSmsReminders,
        defaultEventDuration,
        eventSnapInterval,
        const DeepCollectionEquality().hash(_quickAddTags)
      ]);

  /// Create a copy of CalendarSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarSettingsImplCopyWith<_$CalendarSettingsImpl> get copyWith =>
      __$$CalendarSettingsImplCopyWithImpl<_$CalendarSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalendarSettingsImplToJson(
      this,
    );
  }
}

abstract class _CalendarSettings implements CalendarSettings {
  const factory _CalendarSettings(
      {final CalendarView defaultView,
      final int firstDayOfWeek,
      final String timezone,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final TimeOfDay workDayStart,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final TimeOfDay workDayEnd,
      final List<int> workDays,
      final List<int> defaultReminders,
      final bool showWeekNumbers,
      final bool showDeclinedEvents,
      final bool enable24HourFormat,
      final String dateFormat,
      final String timeFormat,
      final Map<EventType, String> eventTypeColors,
      final bool enableNotifications,
      final bool enableEmailReminders,
      final bool enableSmsReminders,
      final int defaultEventDuration,
      final int eventSnapInterval,
      final List<String> quickAddTags}) = _$CalendarSettingsImpl;

  factory _CalendarSettings.fromJson(Map<String, dynamic> json) =
      _$CalendarSettingsImpl.fromJson;

  @override
  CalendarView get defaultView;
  @override
  int get firstDayOfWeek; // 0=Sunday, 1=Monday
  @override
  String get timezone;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  TimeOfDay get workDayStart;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  TimeOfDay get workDayEnd;
  @override
  List<int> get workDays; // 1=Monday, 7=Sunday
  @override
  List<int> get defaultReminders;
  @override
  bool get showWeekNumbers;
  @override
  bool get showDeclinedEvents;
  @override
  bool get enable24HourFormat;
  @override
  String get dateFormat;
  @override
  String get timeFormat;
  @override
  Map<EventType, String> get eventTypeColors;
  @override
  bool get enableNotifications;
  @override
  bool get enableEmailReminders;
  @override
  bool get enableSmsReminders;
  @override
  int get defaultEventDuration; // minutes
  @override
  int get eventSnapInterval; // minutes
  @override
  List<String> get quickAddTags;

  /// Create a copy of CalendarSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalendarSettingsImplCopyWith<_$CalendarSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EventCategory _$EventCategoryFromJson(Map<String, dynamic> json) {
  return _EventCategory.fromJson(json);
}

/// @nodoc
mixin _$EventCategory {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isVisible => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this EventCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventCategoryCopyWith<EventCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCategoryCopyWith<$Res> {
  factory $EventCategoryCopyWith(
          EventCategory value, $Res Function(EventCategory) then) =
      _$EventCategoryCopyWithImpl<$Res, EventCategory>;
  @useResult
  $Res call(
      {int id,
      String name,
      String color,
      String? icon,
      String? description,
      bool isVisible,
      int sortOrder});
}

/// @nodoc
class _$EventCategoryCopyWithImpl<$Res, $Val extends EventCategory>
    implements $EventCategoryCopyWith<$Res> {
  _$EventCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = null,
    Object? icon = freezed,
    Object? description = freezed,
    Object? isVisible = null,
    Object? sortOrder = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventCategoryImplCopyWith<$Res>
    implements $EventCategoryCopyWith<$Res> {
  factory _$$EventCategoryImplCopyWith(
          _$EventCategoryImpl value, $Res Function(_$EventCategoryImpl) then) =
      __$$EventCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String color,
      String? icon,
      String? description,
      bool isVisible,
      int sortOrder});
}

/// @nodoc
class __$$EventCategoryImplCopyWithImpl<$Res>
    extends _$EventCategoryCopyWithImpl<$Res, _$EventCategoryImpl>
    implements _$$EventCategoryImplCopyWith<$Res> {
  __$$EventCategoryImplCopyWithImpl(
      _$EventCategoryImpl _value, $Res Function(_$EventCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = null,
    Object? icon = freezed,
    Object? description = freezed,
    Object? isVisible = null,
    Object? sortOrder = null,
  }) {
    return _then(_$EventCategoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventCategoryImpl implements _EventCategory {
  const _$EventCategoryImpl(
      {required this.id,
      required this.name,
      required this.color,
      this.icon,
      this.description,
      this.isVisible = true,
      this.sortOrder = 0});

  factory _$EventCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventCategoryImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String color;
  @override
  final String? icon;
  @override
  final String? description;
  @override
  @JsonKey()
  final bool isVisible;
  @override
  @JsonKey()
  final int sortOrder;

  @override
  String toString() {
    return 'EventCategory(id: $id, name: $name, color: $color, icon: $icon, description: $description, isVisible: $isVisible, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, color, icon, description, isVisible, sortOrder);

  /// Create a copy of EventCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventCategoryImplCopyWith<_$EventCategoryImpl> get copyWith =>
      __$$EventCategoryImplCopyWithImpl<_$EventCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventCategoryImplToJson(
      this,
    );
  }
}

abstract class _EventCategory implements EventCategory {
  const factory _EventCategory(
      {required final int id,
      required final String name,
      required final String color,
      final String? icon,
      final String? description,
      final bool isVisible,
      final int sortOrder}) = _$EventCategoryImpl;

  factory _EventCategory.fromJson(Map<String, dynamic> json) =
      _$EventCategoryImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get color;
  @override
  String? get icon;
  @override
  String? get description;
  @override
  bool get isVisible;
  @override
  int get sortOrder;

  /// Create a copy of EventCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventCategoryImplCopyWith<_$EventCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CalendarSync _$CalendarSyncFromJson(Map<String, dynamic> json) {
  return _CalendarSync.fromJson(json);
}

/// @nodoc
mixin _$CalendarSync {
  int get calendarId => throw _privateConstructorUsedError;
  String get provider =>
      throw _privateConstructorUsedError; // google, outlook, icloud
  DateTime? get lastSyncTime => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // syncing, idle, error, success
  String? get error => throw _privateConstructorUsedError;
  int? get syncedEvents => throw _privateConstructorUsedError;
  String? get syncToken => throw _privateConstructorUsedError;
  Map<String, dynamic>? get syncData => throw _privateConstructorUsedError;

  /// Serializes this CalendarSync to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CalendarSync
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalendarSyncCopyWith<CalendarSync> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarSyncCopyWith<$Res> {
  factory $CalendarSyncCopyWith(
          CalendarSync value, $Res Function(CalendarSync) then) =
      _$CalendarSyncCopyWithImpl<$Res, CalendarSync>;
  @useResult
  $Res call(
      {int calendarId,
      String provider,
      DateTime? lastSyncTime,
      String status,
      String? error,
      int? syncedEvents,
      String? syncToken,
      Map<String, dynamic>? syncData});
}

/// @nodoc
class _$CalendarSyncCopyWithImpl<$Res, $Val extends CalendarSync>
    implements $CalendarSyncCopyWith<$Res> {
  _$CalendarSyncCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalendarSync
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calendarId = null,
    Object? provider = null,
    Object? lastSyncTime = freezed,
    Object? status = null,
    Object? error = freezed,
    Object? syncedEvents = freezed,
    Object? syncToken = freezed,
    Object? syncData = freezed,
  }) {
    return _then(_value.copyWith(
      calendarId: null == calendarId
          ? _value.calendarId
          : calendarId // ignore: cast_nullable_to_non_nullable
              as int,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      lastSyncTime: freezed == lastSyncTime
          ? _value.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      syncedEvents: freezed == syncedEvents
          ? _value.syncedEvents
          : syncedEvents // ignore: cast_nullable_to_non_nullable
              as int?,
      syncToken: freezed == syncToken
          ? _value.syncToken
          : syncToken // ignore: cast_nullable_to_non_nullable
              as String?,
      syncData: freezed == syncData
          ? _value.syncData
          : syncData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalendarSyncImplCopyWith<$Res>
    implements $CalendarSyncCopyWith<$Res> {
  factory _$$CalendarSyncImplCopyWith(
          _$CalendarSyncImpl value, $Res Function(_$CalendarSyncImpl) then) =
      __$$CalendarSyncImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int calendarId,
      String provider,
      DateTime? lastSyncTime,
      String status,
      String? error,
      int? syncedEvents,
      String? syncToken,
      Map<String, dynamic>? syncData});
}

/// @nodoc
class __$$CalendarSyncImplCopyWithImpl<$Res>
    extends _$CalendarSyncCopyWithImpl<$Res, _$CalendarSyncImpl>
    implements _$$CalendarSyncImplCopyWith<$Res> {
  __$$CalendarSyncImplCopyWithImpl(
      _$CalendarSyncImpl _value, $Res Function(_$CalendarSyncImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarSync
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calendarId = null,
    Object? provider = null,
    Object? lastSyncTime = freezed,
    Object? status = null,
    Object? error = freezed,
    Object? syncedEvents = freezed,
    Object? syncToken = freezed,
    Object? syncData = freezed,
  }) {
    return _then(_$CalendarSyncImpl(
      calendarId: null == calendarId
          ? _value.calendarId
          : calendarId // ignore: cast_nullable_to_non_nullable
              as int,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      lastSyncTime: freezed == lastSyncTime
          ? _value.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      syncedEvents: freezed == syncedEvents
          ? _value.syncedEvents
          : syncedEvents // ignore: cast_nullable_to_non_nullable
              as int?,
      syncToken: freezed == syncToken
          ? _value.syncToken
          : syncToken // ignore: cast_nullable_to_non_nullable
              as String?,
      syncData: freezed == syncData
          ? _value._syncData
          : syncData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalendarSyncImpl implements _CalendarSync {
  const _$CalendarSyncImpl(
      {required this.calendarId,
      required this.provider,
      this.lastSyncTime,
      this.status = 'idle',
      this.error,
      this.syncedEvents,
      this.syncToken,
      final Map<String, dynamic>? syncData})
      : _syncData = syncData;

  factory _$CalendarSyncImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarSyncImplFromJson(json);

  @override
  final int calendarId;
  @override
  final String provider;
// google, outlook, icloud
  @override
  final DateTime? lastSyncTime;
  @override
  @JsonKey()
  final String status;
// syncing, idle, error, success
  @override
  final String? error;
  @override
  final int? syncedEvents;
  @override
  final String? syncToken;
  final Map<String, dynamic>? _syncData;
  @override
  Map<String, dynamic>? get syncData {
    final value = _syncData;
    if (value == null) return null;
    if (_syncData is EqualUnmodifiableMapView) return _syncData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'CalendarSync(calendarId: $calendarId, provider: $provider, lastSyncTime: $lastSyncTime, status: $status, error: $error, syncedEvents: $syncedEvents, syncToken: $syncToken, syncData: $syncData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarSyncImpl &&
            (identical(other.calendarId, calendarId) ||
                other.calendarId == calendarId) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.lastSyncTime, lastSyncTime) ||
                other.lastSyncTime == lastSyncTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.syncedEvents, syncedEvents) ||
                other.syncedEvents == syncedEvents) &&
            (identical(other.syncToken, syncToken) ||
                other.syncToken == syncToken) &&
            const DeepCollectionEquality().equals(other._syncData, _syncData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      calendarId,
      provider,
      lastSyncTime,
      status,
      error,
      syncedEvents,
      syncToken,
      const DeepCollectionEquality().hash(_syncData));

  /// Create a copy of CalendarSync
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarSyncImplCopyWith<_$CalendarSyncImpl> get copyWith =>
      __$$CalendarSyncImplCopyWithImpl<_$CalendarSyncImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalendarSyncImplToJson(
      this,
    );
  }
}

abstract class _CalendarSync implements CalendarSync {
  const factory _CalendarSync(
      {required final int calendarId,
      required final String provider,
      final DateTime? lastSyncTime,
      final String status,
      final String? error,
      final int? syncedEvents,
      final String? syncToken,
      final Map<String, dynamic>? syncData}) = _$CalendarSyncImpl;

  factory _CalendarSync.fromJson(Map<String, dynamic> json) =
      _$CalendarSyncImpl.fromJson;

  @override
  int get calendarId;
  @override
  String get provider; // google, outlook, icloud
  @override
  DateTime? get lastSyncTime;
  @override
  String get status; // syncing, idle, error, success
  @override
  String? get error;
  @override
  int? get syncedEvents;
  @override
  String? get syncToken;
  @override
  Map<String, dynamic>? get syncData;

  /// Create a copy of CalendarSync
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalendarSyncImplCopyWith<_$CalendarSyncImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuickEventSuggestion _$QuickEventSuggestionFromJson(Map<String, dynamic> json) {
  return _QuickEventSuggestion.fromJson(json);
}

/// @nodoc
mixin _$QuickEventSuggestion {
  String get title => throw _privateConstructorUsedError;
  EventType get type => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  List<int> get reminders => throw _privateConstructorUsedError;

  /// Serializes this QuickEventSuggestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuickEventSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuickEventSuggestionCopyWith<QuickEventSuggestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickEventSuggestionCopyWith<$Res> {
  factory $QuickEventSuggestionCopyWith(QuickEventSuggestion value,
          $Res Function(QuickEventSuggestion) then) =
      _$QuickEventSuggestionCopyWithImpl<$Res, QuickEventSuggestion>;
  @useResult
  $Res call(
      {String title,
      EventType type,
      Duration duration,
      String? location,
      List<String> tags,
      List<int> reminders});
}

/// @nodoc
class _$QuickEventSuggestionCopyWithImpl<$Res,
        $Val extends QuickEventSuggestion>
    implements $QuickEventSuggestionCopyWith<$Res> {
  _$QuickEventSuggestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuickEventSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? type = null,
    Object? duration = null,
    Object? location = freezed,
    Object? tags = null,
    Object? reminders = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as EventType,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reminders: null == reminders
          ? _value.reminders
          : reminders // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuickEventSuggestionImplCopyWith<$Res>
    implements $QuickEventSuggestionCopyWith<$Res> {
  factory _$$QuickEventSuggestionImplCopyWith(_$QuickEventSuggestionImpl value,
          $Res Function(_$QuickEventSuggestionImpl) then) =
      __$$QuickEventSuggestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      EventType type,
      Duration duration,
      String? location,
      List<String> tags,
      List<int> reminders});
}

/// @nodoc
class __$$QuickEventSuggestionImplCopyWithImpl<$Res>
    extends _$QuickEventSuggestionCopyWithImpl<$Res, _$QuickEventSuggestionImpl>
    implements _$$QuickEventSuggestionImplCopyWith<$Res> {
  __$$QuickEventSuggestionImplCopyWithImpl(_$QuickEventSuggestionImpl _value,
      $Res Function(_$QuickEventSuggestionImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuickEventSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? type = null,
    Object? duration = null,
    Object? location = freezed,
    Object? tags = null,
    Object? reminders = null,
  }) {
    return _then(_$QuickEventSuggestionImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as EventType,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reminders: null == reminders
          ? _value._reminders
          : reminders // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuickEventSuggestionImpl implements _QuickEventSuggestion {
  const _$QuickEventSuggestionImpl(
      {required this.title,
      required this.type,
      required this.duration,
      this.location,
      final List<String> tags = const [],
      final List<int> reminders = const [15]})
      : _tags = tags,
        _reminders = reminders;

  factory _$QuickEventSuggestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuickEventSuggestionImplFromJson(json);

  @override
  final String title;
  @override
  final EventType type;
  @override
  final Duration duration;
  @override
  final String? location;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<int> _reminders;
  @override
  @JsonKey()
  List<int> get reminders {
    if (_reminders is EqualUnmodifiableListView) return _reminders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reminders);
  }

  @override
  String toString() {
    return 'QuickEventSuggestion(title: $title, type: $type, duration: $duration, location: $location, tags: $tags, reminders: $reminders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickEventSuggestionImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._reminders, _reminders));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      type,
      duration,
      location,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_reminders));

  /// Create a copy of QuickEventSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickEventSuggestionImplCopyWith<_$QuickEventSuggestionImpl>
      get copyWith =>
          __$$QuickEventSuggestionImplCopyWithImpl<_$QuickEventSuggestionImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuickEventSuggestionImplToJson(
      this,
    );
  }
}

abstract class _QuickEventSuggestion implements QuickEventSuggestion {
  const factory _QuickEventSuggestion(
      {required final String title,
      required final EventType type,
      required final Duration duration,
      final String? location,
      final List<String> tags,
      final List<int> reminders}) = _$QuickEventSuggestionImpl;

  factory _QuickEventSuggestion.fromJson(Map<String, dynamic> json) =
      _$QuickEventSuggestionImpl.fromJson;

  @override
  String get title;
  @override
  EventType get type;
  @override
  Duration get duration;
  @override
  String? get location;
  @override
  List<String> get tags;
  @override
  List<int> get reminders;

  /// Create a copy of QuickEventSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuickEventSuggestionImplCopyWith<_$QuickEventSuggestionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
