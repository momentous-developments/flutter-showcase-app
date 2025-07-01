// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalendarImpl _$$CalendarImplFromJson(Map<String, dynamic> json) =>
    _$CalendarImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      color: const ColorConverter().fromJson((json['color'] as num).toInt()),
      isVisible: json['isVisible'] as bool? ?? true,
      isDefault: json['isDefault'] as bool? ?? false,
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
    );

Map<String, dynamic> _$$CalendarImplToJson(_$CalendarImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'color': const ColorConverter().toJson(instance.color),
      'isVisible': instance.isVisible,
      'isDefault': instance.isDefault,
      'ownerId': instance.ownerId,
      'sharedWith': instance.sharedWith,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$CalendarEventImpl _$$CalendarEventImplFromJson(Map<String, dynamic> json) =>
    _$CalendarEventImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      description: json['description'] as String?,
      location: json['location'] as String?,
      calendarId: json['calendarId'] as String,
      isAllDay: json['isAllDay'] as bool? ?? false,
      category: $enumDecodeNullable(_$EventCategoryEnumMap, json['category']) ??
          EventCategory.general,
      priority: $enumDecodeNullable(_$EventPriorityEnumMap, json['priority']) ??
          EventPriority.normal,
      attendees: (json['attendees'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      reminders: (json['reminders'] as List<dynamic>?)
              ?.map((e) => EventReminder.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      recurrenceRule: json['recurrenceRule'] == null
          ? null
          : RecurrenceRule.fromJson(
              json['recurrenceRule'] as Map<String, dynamic>),
      recurringEventId: json['recurringEventId'] as String?,
      status: $enumDecodeNullable(_$EventStatusEnumMap, json['status']) ??
          EventStatus.confirmed,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      createdBy: json['createdBy'] as String?,
    );

Map<String, dynamic> _$$CalendarEventImplToJson(_$CalendarEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'description': instance.description,
      'location': instance.location,
      'calendarId': instance.calendarId,
      'isAllDay': instance.isAllDay,
      'category': _$EventCategoryEnumMap[instance.category]!,
      'priority': _$EventPriorityEnumMap[instance.priority]!,
      'attendees': instance.attendees,
      'reminders': instance.reminders,
      'recurrenceRule': instance.recurrenceRule,
      'recurringEventId': instance.recurringEventId,
      'status': _$EventStatusEnumMap[instance.status]!,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdBy': instance.createdBy,
    };

const _$EventCategoryEnumMap = {
  EventCategory.general: 'general',
  EventCategory.meeting: 'meeting',
  EventCategory.personal: 'personal',
  EventCategory.work: 'work',
  EventCategory.holiday: 'holiday',
  EventCategory.birthday: 'birthday',
  EventCategory.deadline: 'deadline',
  EventCategory.reminder: 'reminder',
};

const _$EventPriorityEnumMap = {
  EventPriority.low: 'low',
  EventPriority.normal: 'normal',
  EventPriority.high: 'high',
  EventPriority.urgent: 'urgent',
};

const _$EventStatusEnumMap = {
  EventStatus.tentative: 'tentative',
  EventStatus.confirmed: 'confirmed',
  EventStatus.cancelled: 'cancelled',
};

_$EventReminderImpl _$$EventReminderImplFromJson(Map<String, dynamic> json) =>
    _$EventReminderImpl(
      type: $enumDecode(_$ReminderTypeEnumMap, json['type']),
      minutesBefore: (json['minutesBefore'] as num).toInt(),
      enabled: json['enabled'] as bool? ?? true,
    );

Map<String, dynamic> _$$EventReminderImplToJson(_$EventReminderImpl instance) =>
    <String, dynamic>{
      'type': _$ReminderTypeEnumMap[instance.type]!,
      'minutesBefore': instance.minutesBefore,
      'enabled': instance.enabled,
    };

const _$ReminderTypeEnumMap = {
  ReminderType.notification: 'notification',
  ReminderType.email: 'email',
  ReminderType.popup: 'popup',
};

_$RecurrenceRuleImpl _$$RecurrenceRuleImplFromJson(Map<String, dynamic> json) =>
    _$RecurrenceRuleImpl(
      frequency: $enumDecode(_$RecurrenceFrequencyEnumMap, json['frequency']),
      interval: (json['interval'] as num?)?.toInt() ?? 1,
      until: json['until'] == null
          ? null
          : DateTime.parse(json['until'] as String),
      count: (json['count'] as num?)?.toInt(),
      byWeekDay: (json['byWeekDay'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      byMonthDay: (json['byMonthDay'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      byMonth: (json['byMonth'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      bySetPos: (json['bySetPos'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$RecurrenceRuleImplToJson(
        _$RecurrenceRuleImpl instance) =>
    <String, dynamic>{
      'frequency': _$RecurrenceFrequencyEnumMap[instance.frequency]!,
      'interval': instance.interval,
      'until': instance.until?.toIso8601String(),
      'count': instance.count,
      'byWeekDay': instance.byWeekDay,
      'byMonthDay': instance.byMonthDay,
      'byMonth': instance.byMonth,
      'bySetPos': instance.bySetPos,
    };

const _$RecurrenceFrequencyEnumMap = {
  RecurrenceFrequency.daily: 'daily',
  RecurrenceFrequency.weekly: 'weekly',
  RecurrenceFrequency.monthly: 'monthly',
  RecurrenceFrequency.yearly: 'yearly',
};
