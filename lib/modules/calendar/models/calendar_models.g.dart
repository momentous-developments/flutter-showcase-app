// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalendarEventImpl _$$CalendarEventImplFromJson(Map<String, dynamic> json) =>
    _$CalendarEventImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      allDay: json['allDay'] as bool? ?? false,
      location: json['location'] as String?,
      attendees: (json['attendees'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      type: $enumDecodeNullable(_$EventTypeEnumMap, json['type']) ??
          EventType.meeting,
      color: json['color'] as String? ?? '#2196F3',
      reminder: (json['reminder'] as num?)?.toInt(),
      priority: $enumDecodeNullable(_$EventPriorityEnumMap, json['priority']) ??
          EventPriority.medium,
      visibility:
          $enumDecodeNullable(_$EventVisibilityEnumMap, json['visibility']) ??
              EventVisibility.public,
      recurrence: json['recurrence'] == null
          ? null
          : RecurrenceRule.fromJson(json['recurrence'] as Map<String, dynamic>),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => EventAttachment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      rsvpResponses: (json['rsvpResponses'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, $enumDecode(_$RsvpStatusEnumMap, e)),
          ) ??
          const {},
      meetingUrl: json['meetingUrl'] as String?,
      timezone: json['timezone'] as String?,
      isOrganizer: json['isOrganizer'] as bool? ?? false,
      reminders: (json['reminders'] as List<dynamic>?)
              ?.map((e) => EventReminder.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      calendarId: (json['calendarId'] as num?)?.toInt(),
      externalId: json['externalId'] as String?,
      customFields: json['customFields'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$CalendarEventImplToJson(_$CalendarEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'allDay': instance.allDay,
      'location': instance.location,
      'attendees': instance.attendees,
      'type': _$EventTypeEnumMap[instance.type]!,
      'color': instance.color,
      'reminder': instance.reminder,
      'priority': _$EventPriorityEnumMap[instance.priority]!,
      'visibility': _$EventVisibilityEnumMap[instance.visibility]!,
      'recurrence': instance.recurrence,
      'tags': instance.tags,
      'attachments': instance.attachments,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'rsvpResponses': instance.rsvpResponses
          .map((k, e) => MapEntry(k, _$RsvpStatusEnumMap[e]!)),
      'meetingUrl': instance.meetingUrl,
      'timezone': instance.timezone,
      'isOrganizer': instance.isOrganizer,
      'reminders': instance.reminders,
      'calendarId': instance.calendarId,
      'externalId': instance.externalId,
      'customFields': instance.customFields,
    };

const _$EventTypeEnumMap = {
  EventType.meeting: 'meeting',
  EventType.appointment: 'appointment',
  EventType.reminder: 'reminder',
  EventType.task: 'task',
  EventType.personal: 'personal',
  EventType.work: 'work',
  EventType.holiday: 'holiday',
  EventType.birthday: 'birthday',
  EventType.call: 'call',
  EventType.travel: 'travel',
};

const _$EventPriorityEnumMap = {
  EventPriority.low: 'low',
  EventPriority.medium: 'medium',
  EventPriority.high: 'high',
  EventPriority.urgent: 'urgent',
};

const _$EventVisibilityEnumMap = {
  EventVisibility.public: 'public',
  EventVisibility.private: 'private',
  EventVisibility.confidential: 'confidential',
};

const _$RsvpStatusEnumMap = {
  RsvpStatus.pending: 'pending',
  RsvpStatus.accepted: 'accepted',
  RsvpStatus.declined: 'declined',
  RsvpStatus.maybe: 'maybe',
};

_$RecurrenceRuleImpl _$$RecurrenceRuleImplFromJson(Map<String, dynamic> json) =>
    _$RecurrenceRuleImpl(
      type: $enumDecode(_$RecurrenceTypeEnumMap, json['type']),
      interval: (json['interval'] as num?)?.toInt() ?? 1,
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      occurrences: (json['occurrences'] as num?)?.toInt(),
      daysOfWeek: (json['daysOfWeek'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      daysOfMonth: (json['daysOfMonth'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      monthsOfYear: (json['monthsOfYear'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      weeksOfYear: (json['weeksOfYear'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      exceptions: (json['exceptions'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          const [],
      rruleString: json['rruleString'] as String?,
    );

Map<String, dynamic> _$$RecurrenceRuleImplToJson(
        _$RecurrenceRuleImpl instance) =>
    <String, dynamic>{
      'type': _$RecurrenceTypeEnumMap[instance.type]!,
      'interval': instance.interval,
      'endDate': instance.endDate?.toIso8601String(),
      'occurrences': instance.occurrences,
      'daysOfWeek': instance.daysOfWeek,
      'daysOfMonth': instance.daysOfMonth,
      'monthsOfYear': instance.monthsOfYear,
      'weeksOfYear': instance.weeksOfYear,
      'exceptions':
          instance.exceptions.map((e) => e.toIso8601String()).toList(),
      'rruleString': instance.rruleString,
    };

const _$RecurrenceTypeEnumMap = {
  RecurrenceType.none: 'none',
  RecurrenceType.daily: 'daily',
  RecurrenceType.weekly: 'weekly',
  RecurrenceType.monthly: 'monthly',
  RecurrenceType.yearly: 'yearly',
  RecurrenceType.custom: 'custom',
};

_$EventReminderImpl _$$EventReminderImplFromJson(Map<String, dynamic> json) =>
    _$EventReminderImpl(
      id: (json['id'] as num).toInt(),
      minutesBefore: (json['minutesBefore'] as num).toInt(),
      type: json['type'] as String? ?? 'notification',
      enabled: json['enabled'] as bool? ?? true,
      message: json['message'] as String?,
      scheduledTime: json['scheduledTime'] == null
          ? null
          : DateTime.parse(json['scheduledTime'] as String),
    );

Map<String, dynamic> _$$EventReminderImplToJson(_$EventReminderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'minutesBefore': instance.minutesBefore,
      'type': instance.type,
      'enabled': instance.enabled,
      'message': instance.message,
      'scheduledTime': instance.scheduledTime?.toIso8601String(),
    };

_$EventAttachmentImpl _$$EventAttachmentImplFromJson(
        Map<String, dynamic> json) =>
    _$EventAttachmentImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      type: json['type'] as String,
      size: (json['size'] as num).toInt(),
      uploadedAt: json['uploadedAt'] == null
          ? null
          : DateTime.parse(json['uploadedAt'] as String),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$EventAttachmentImplToJson(
        _$EventAttachmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'type': instance.type,
      'size': instance.size,
      'uploadedAt': instance.uploadedAt?.toIso8601String(),
      'description': instance.description,
    };

_$CalendarModelImpl _$$CalendarModelImplFromJson(Map<String, dynamic> json) =>
    _$CalendarModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      color: json['color'] as String,
      description: json['description'] as String? ?? '',
      isVisible: json['isVisible'] as bool? ?? true,
      isReadOnly: json['isReadOnly'] as bool? ?? false,
      isDefault: json['isDefault'] as bool? ?? false,
      type: json['type'] as String? ?? 'local',
      ownerId: json['ownerId'] as String?,
      sharedWith: (json['sharedWith'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      syncToken: json['syncToken'] as String?,
      syncSettings: json['syncSettings'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$CalendarModelImplToJson(_$CalendarModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'description': instance.description,
      'isVisible': instance.isVisible,
      'isReadOnly': instance.isReadOnly,
      'isDefault': instance.isDefault,
      'type': instance.type,
      'ownerId': instance.ownerId,
      'sharedWith': instance.sharedWith,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'syncToken': instance.syncToken,
      'syncSettings': instance.syncSettings,
    };

_$EventInvitationImpl _$$EventInvitationImplFromJson(
        Map<String, dynamic> json) =>
    _$EventInvitationImpl(
      id: json['id'] as String,
      eventId: (json['eventId'] as num).toInt(),
      email: json['email'] as String,
      name: json['name'] as String,
      status: $enumDecodeNullable(_$RsvpStatusEnumMap, json['status']) ??
          RsvpStatus.pending,
      message: json['message'] as String?,
      sentAt: json['sentAt'] == null
          ? null
          : DateTime.parse(json['sentAt'] as String),
      respondedAt: json['respondedAt'] == null
          ? null
          : DateTime.parse(json['respondedAt'] as String),
      isOptional: json['isOptional'] as bool? ?? false,
      role: json['role'] as String? ?? 'attendee',
    );

Map<String, dynamic> _$$EventInvitationImplToJson(
        _$EventInvitationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'email': instance.email,
      'name': instance.name,
      'status': _$RsvpStatusEnumMap[instance.status]!,
      'message': instance.message,
      'sentAt': instance.sentAt?.toIso8601String(),
      'respondedAt': instance.respondedAt?.toIso8601String(),
      'isOptional': instance.isOptional,
      'role': instance.role,
    };

_$EventConflictImpl _$$EventConflictImplFromJson(Map<String, dynamic> json) =>
    _$EventConflictImpl(
      event1: CalendarEvent.fromJson(json['event1'] as Map<String, dynamic>),
      event2: CalendarEvent.fromJson(json['event2'] as Map<String, dynamic>),
      conflictStart: DateTime.parse(json['conflictStart'] as String),
      conflictEnd: DateTime.parse(json['conflictEnd'] as String),
      type: json['type'] as String? ?? 'overlap',
      suggestion: json['suggestion'] as String?,
    );

Map<String, dynamic> _$$EventConflictImplToJson(_$EventConflictImpl instance) =>
    <String, dynamic>{
      'event1': instance.event1,
      'event2': instance.event2,
      'conflictStart': instance.conflictStart.toIso8601String(),
      'conflictEnd': instance.conflictEnd.toIso8601String(),
      'type': instance.type,
      'suggestion': instance.suggestion,
    };

_$TimeSlotImpl _$$TimeSlotImplFromJson(Map<String, dynamic> json) =>
    _$TimeSlotImpl(
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      isAvailable: json['isAvailable'] as bool? ?? true,
      events: (json['events'] as List<dynamic>?)
              ?.map((e) => CalendarEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      label: json['label'] as String?,
    );

Map<String, dynamic> _$$TimeSlotImplToJson(_$TimeSlotImpl instance) =>
    <String, dynamic>{
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'isAvailable': instance.isAvailable,
      'events': instance.events,
      'label': instance.label,
    };

_$CalendarSettingsImpl _$$CalendarSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$CalendarSettingsImpl(
      defaultView:
          $enumDecodeNullable(_$CalendarViewEnumMap, json['defaultView']) ??
              CalendarView.month,
      firstDayOfWeek: (json['firstDayOfWeek'] as num?)?.toInt() ?? 1,
      timezone: json['timezone'] as String? ?? 'local',
      workDays: (json['workDays'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [1, 2, 3, 4, 5],
      defaultReminders: (json['defaultReminders'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [15, 30, 60],
      showWeekNumbers: json['showWeekNumbers'] as bool? ?? true,
      showDeclinedEvents: json['showDeclinedEvents'] as bool? ?? true,
      enable24HourFormat: json['enable24HourFormat'] as bool? ?? false,
      dateFormat: json['dateFormat'] as String? ?? 'yyyy-MM-dd',
      timeFormat: json['timeFormat'] as String? ?? 'HH:mm',
      eventTypeColors: (json['eventTypeColors'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry($enumDecode(_$EventTypeEnumMap, k), e as String),
          ) ??
          const {},
      enableNotifications: json['enableNotifications'] as bool? ?? true,
      enableEmailReminders: json['enableEmailReminders'] as bool? ?? true,
      enableSmsReminders: json['enableSmsReminders'] as bool? ?? false,
      defaultEventDuration:
          (json['defaultEventDuration'] as num?)?.toInt() ?? 30,
      eventSnapInterval: (json['eventSnapInterval'] as num?)?.toInt() ?? 5,
      quickAddTags: (json['quickAddTags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CalendarSettingsImplToJson(
        _$CalendarSettingsImpl instance) =>
    <String, dynamic>{
      'defaultView': _$CalendarViewEnumMap[instance.defaultView]!,
      'firstDayOfWeek': instance.firstDayOfWeek,
      'timezone': instance.timezone,
      'workDays': instance.workDays,
      'defaultReminders': instance.defaultReminders,
      'showWeekNumbers': instance.showWeekNumbers,
      'showDeclinedEvents': instance.showDeclinedEvents,
      'enable24HourFormat': instance.enable24HourFormat,
      'dateFormat': instance.dateFormat,
      'timeFormat': instance.timeFormat,
      'eventTypeColors': instance.eventTypeColors
          .map((k, e) => MapEntry(_$EventTypeEnumMap[k]!, e)),
      'enableNotifications': instance.enableNotifications,
      'enableEmailReminders': instance.enableEmailReminders,
      'enableSmsReminders': instance.enableSmsReminders,
      'defaultEventDuration': instance.defaultEventDuration,
      'eventSnapInterval': instance.eventSnapInterval,
      'quickAddTags': instance.quickAddTags,
    };

const _$CalendarViewEnumMap = {
  CalendarView.month: 'month',
  CalendarView.week: 'week',
  CalendarView.day: 'day',
  CalendarView.agenda: 'agenda',
  CalendarView.year: 'year',
};

_$EventCategoryImpl _$$EventCategoryImplFromJson(Map<String, dynamic> json) =>
    _$EventCategoryImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      color: json['color'] as String,
      icon: json['icon'] as String?,
      description: json['description'] as String?,
      isVisible: json['isVisible'] as bool? ?? true,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$EventCategoryImplToJson(_$EventCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'icon': instance.icon,
      'description': instance.description,
      'isVisible': instance.isVisible,
      'sortOrder': instance.sortOrder,
    };

_$CalendarSyncImpl _$$CalendarSyncImplFromJson(Map<String, dynamic> json) =>
    _$CalendarSyncImpl(
      calendarId: (json['calendarId'] as num).toInt(),
      provider: json['provider'] as String,
      lastSyncTime: json['lastSyncTime'] == null
          ? null
          : DateTime.parse(json['lastSyncTime'] as String),
      status: json['status'] as String? ?? 'idle',
      error: json['error'] as String?,
      syncedEvents: (json['syncedEvents'] as num?)?.toInt(),
      syncToken: json['syncToken'] as String?,
      syncData: json['syncData'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$CalendarSyncImplToJson(_$CalendarSyncImpl instance) =>
    <String, dynamic>{
      'calendarId': instance.calendarId,
      'provider': instance.provider,
      'lastSyncTime': instance.lastSyncTime?.toIso8601String(),
      'status': instance.status,
      'error': instance.error,
      'syncedEvents': instance.syncedEvents,
      'syncToken': instance.syncToken,
      'syncData': instance.syncData,
    };

_$QuickEventSuggestionImpl _$$QuickEventSuggestionImplFromJson(
        Map<String, dynamic> json) =>
    _$QuickEventSuggestionImpl(
      title: json['title'] as String,
      type: $enumDecode(_$EventTypeEnumMap, json['type']),
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
      location: json['location'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      reminders: (json['reminders'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [15],
    );

Map<String, dynamic> _$$QuickEventSuggestionImplToJson(
        _$QuickEventSuggestionImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'type': _$EventTypeEnumMap[instance.type]!,
      'duration': instance.duration.inMicroseconds,
      'location': instance.location,
      'tags': instance.tags,
      'reminders': instance.reminders,
    };
