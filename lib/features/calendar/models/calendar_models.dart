import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'color_converter.dart';

part 'calendar_models.freezed.dart';
part 'calendar_models.g.dart';

// Calendar Model
@freezed
class Calendar with _$Calendar {
  const factory Calendar({
    required String id,
    required String name,
    required String description,
    @ColorConverter() required Color color,
    @Default(true) bool isVisible,
    @Default(false) bool isDefault,
    String? ownerId,
    @Default([]) List<String> sharedWith,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Calendar;

  factory Calendar.fromJson(Map<String, dynamic> json) => _$CalendarFromJson(json);
}

// Event Model
@freezed
class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent({
    required String id,
    required String title,
    required DateTime start,
    required DateTime end,
    String? description,
    String? location,
    required String calendarId,
    @Default(false) bool isAllDay,
    @Default(EventCategory.general) EventCategory category,
    @Default(EventPriority.normal) EventPriority priority,
    @Default([]) List<String> attendees,
    @Default([]) List<EventReminder> reminders,
    RecurrenceRule? recurrenceRule,
    String? recurringEventId,
    @Default(EventStatus.confirmed) EventStatus status,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
  }) = _CalendarEvent;

  factory CalendarEvent.fromJson(Map<String, dynamic> json) => _$CalendarEventFromJson(json);
}

// Event Category
enum EventCategory {
  @JsonValue('general')
  general,
  @JsonValue('meeting')
  meeting,
  @JsonValue('personal')
  personal,
  @JsonValue('work')
  work,
  @JsonValue('holiday')
  holiday,
  @JsonValue('birthday')
  birthday,
  @JsonValue('deadline')
  deadline,
  @JsonValue('reminder')
  reminder,
}

// Event Priority
enum EventPriority {
  @JsonValue('low')
  low,
  @JsonValue('normal')
  normal,
  @JsonValue('high')
  high,
  @JsonValue('urgent')
  urgent,
}

// Event Status
enum EventStatus {
  @JsonValue('tentative')
  tentative,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('cancelled')
  cancelled,
}

// Event Reminder
@freezed
class EventReminder with _$EventReminder {
  const factory EventReminder({
    required ReminderType type,
    required int minutesBefore,
    @Default(true) bool enabled,
  }) = _EventReminder;

  factory EventReminder.fromJson(Map<String, dynamic> json) => _$EventReminderFromJson(json);
}

// Reminder Type
enum ReminderType {
  @JsonValue('notification')
  notification,
  @JsonValue('email')
  email,
  @JsonValue('popup')
  popup,
}

// Recurrence Rule
@freezed
class RecurrenceRule with _$RecurrenceRule {
  const factory RecurrenceRule({
    required RecurrenceFrequency frequency,
    @Default(1) int interval,
    DateTime? until,
    int? count,
    @Default([]) List<int> byWeekDay,
    @Default([]) List<int> byMonthDay,
    @Default([]) List<int> byMonth,
    @Default([]) List<int> bySetPos,
  }) = _RecurrenceRule;

  factory RecurrenceRule.fromJson(Map<String, dynamic> json) => _$RecurrenceRuleFromJson(json);
}

// Recurrence Frequency
enum RecurrenceFrequency {
  @JsonValue('daily')
  daily,
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly,
  @JsonValue('yearly')
  yearly,
}

// Calendar View Type
enum CalendarViewType {
  month,
  week,
  day,
  agenda,
}

// Extension methods for EventCategory
extension EventCategoryExtension on EventCategory {
  String get displayName {
    switch (this) {
      case EventCategory.general:
        return 'General';
      case EventCategory.meeting:
        return 'Meeting';
      case EventCategory.personal:
        return 'Personal';
      case EventCategory.work:
        return 'Work';
      case EventCategory.holiday:
        return 'Holiday';
      case EventCategory.birthday:
        return 'Birthday';
      case EventCategory.deadline:
        return 'Deadline';
      case EventCategory.reminder:
        return 'Reminder';
    }
  }

  Color get color {
    switch (this) {
      case EventCategory.general:
        return Colors.blue;
      case EventCategory.meeting:
        return Colors.orange;
      case EventCategory.personal:
        return Colors.purple;
      case EventCategory.work:
        return Colors.green;
      case EventCategory.holiday:
        return Colors.red;
      case EventCategory.birthday:
        return Colors.pink;
      case EventCategory.deadline:
        return Colors.amber;
      case EventCategory.reminder:
        return Colors.teal;
    }
  }

  IconData get icon {
    switch (this) {
      case EventCategory.general:
        return Icons.event;
      case EventCategory.meeting:
        return Icons.groups;
      case EventCategory.personal:
        return Icons.person;
      case EventCategory.work:
        return Icons.work;
      case EventCategory.holiday:
        return Icons.beach_access;
      case EventCategory.birthday:
        return Icons.cake;
      case EventCategory.deadline:
        return Icons.alarm;
      case EventCategory.reminder:
        return Icons.notifications;
    }
  }
}

// Extension methods for EventPriority
extension EventPriorityExtension on EventPriority {
  String get displayName {
    switch (this) {
      case EventPriority.low:
        return 'Low';
      case EventPriority.normal:
        return 'Normal';
      case EventPriority.high:
        return 'High';
      case EventPriority.urgent:
        return 'Urgent';
    }
  }

  Color get color {
    switch (this) {
      case EventPriority.low:
        return Colors.grey;
      case EventPriority.normal:
        return Colors.blue;
      case EventPriority.high:
        return Colors.orange;
      case EventPriority.urgent:
        return Colors.red;
    }
  }
}