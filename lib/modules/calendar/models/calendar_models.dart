import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'calendar_models.freezed.dart';
part 'calendar_models.g.dart';

/// Event types for categorizing calendar events
enum EventType {
  @JsonValue('meeting')
  meeting,
  @JsonValue('appointment')
  appointment,
  @JsonValue('reminder')
  reminder,
  @JsonValue('task')
  task,
  @JsonValue('personal')
  personal,
  @JsonValue('work')
  work,
  @JsonValue('holiday')
  holiday,
  @JsonValue('birthday')
  birthday,
  @JsonValue('call')
  call,
  @JsonValue('travel')
  travel,
}

/// Event priority levels
enum EventPriority {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('urgent')
  urgent,
}

/// Calendar view modes
enum CalendarView {
  month,
  week,
  day,
  agenda,
  year,
}

/// Recurrence pattern types
enum RecurrenceType {
  @JsonValue('none')
  none,
  @JsonValue('daily')
  daily,
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly,
  @JsonValue('yearly')
  yearly,
  @JsonValue('custom')
  custom,
}

/// RSVP response status
enum RsvpStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('accepted')
  accepted,
  @JsonValue('declined')
  declined,
  @JsonValue('maybe')
  maybe,
}

/// Event visibility levels
enum EventVisibility {
  @JsonValue('public')
  public,
  @JsonValue('private')
  private,
  @JsonValue('confidential')
  confidential,
}

/// Main calendar event model
@freezed
class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent({
    required int id,
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
    @Default(false) bool allDay,
    String? location,
    @Default([]) List<String> attendees,
    @Default(EventType.meeting) EventType type,
    @Default('#2196F3') String color,
    int? reminder, // minutes before
    @Default(EventPriority.medium) EventPriority priority,
    @Default(EventVisibility.public) EventVisibility visibility,
    RecurrenceRule? recurrence,
    @Default([]) List<String> tags,
    @Default([]) List<EventAttachment> attachments,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default({}) Map<String, RsvpStatus> rsvpResponses,
    String? meetingUrl,
    String? timezone,
    @Default(false) bool isOrganizer,
    @Default([]) List<EventReminder> reminders,
    int? calendarId,
    String? externalId,
    @Default({}) Map<String, dynamic> customFields,
  }) = _CalendarEvent;

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);
}

/// Recurrence rule for repeating events
@freezed
class RecurrenceRule with _$RecurrenceRule {
  const factory RecurrenceRule({
    required RecurrenceType type,
    @Default(1) int interval,
    DateTime? endDate,
    int? occurrences,
    @Default([]) List<int> daysOfWeek, // 1=Monday, 7=Sunday
    @Default([]) List<int> daysOfMonth, // 1-31
    @Default([]) List<int> monthsOfYear, // 1-12
    @Default([]) List<int> weeksOfYear, // 1-53
    @Default([]) List<DateTime> exceptions, // dates to skip
    String? rruleString, // iCal RRULE format
  }) = _RecurrenceRule;

  factory RecurrenceRule.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceRuleFromJson(json);
}

/// Event reminder settings
@freezed
class EventReminder with _$EventReminder {
  const factory EventReminder({
    required int id,
    required int minutesBefore,
    @Default('notification') String type, // notification, email, sms
    @Default(true) bool enabled,
    String? message,
    DateTime? scheduledTime,
  }) = _EventReminder;

  factory EventReminder.fromJson(Map<String, dynamic> json) =>
      _$EventReminderFromJson(json);
}

/// Event attachment model
@freezed
class EventAttachment with _$EventAttachment {
  const factory EventAttachment({
    required String id,
    required String name,
    required String url,
    required String type, // image, document, video, etc.
    required int size,
    DateTime? uploadedAt,
    String? description,
  }) = _EventAttachment;

  factory EventAttachment.fromJson(Map<String, dynamic> json) =>
      _$EventAttachmentFromJson(json);
}

/// Calendar model for managing multiple calendars
@freezed
class CalendarModel with _$CalendarModel {
  const factory CalendarModel({
    required int id,
    required String name,
    required String color,
    @Default('') String description,
    @Default(true) bool isVisible,
    @Default(false) bool isReadOnly,
    @Default(false) bool isDefault,
    @Default('local') String type, // local, google, outlook, icloud
    String? ownerId,
    @Default([]) List<String> sharedWith,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncToken,
    Map<String, dynamic>? syncSettings,
  }) = _CalendarModel;

  factory CalendarModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarModelFromJson(json);
}

/// Event invitation model
@freezed
class EventInvitation with _$EventInvitation {
  const factory EventInvitation({
    required String id,
    required int eventId,
    required String email,
    required String name,
    @Default(RsvpStatus.pending) RsvpStatus status,
    String? message,
    DateTime? sentAt,
    DateTime? respondedAt,
    @Default(false) bool isOptional,
    @Default('attendee') String role, // organizer, attendee, optional
  }) = _EventInvitation;

  factory EventInvitation.fromJson(Map<String, dynamic> json) =>
      _$EventInvitationFromJson(json);
}

/// Event conflict detection result
@freezed
class EventConflict with _$EventConflict {
  const factory EventConflict({
    required CalendarEvent event1,
    required CalendarEvent event2,
    required DateTime conflictStart,
    required DateTime conflictEnd,
    @Default('overlap') String type, // overlap, adjacent, etc.
    String? suggestion,
  }) = _EventConflict;

  factory EventConflict.fromJson(Map<String, dynamic> json) =>
      _$EventConflictFromJson(json);
}

/// Time slot for scheduling
@freezed
class TimeSlot with _$TimeSlot {
  const factory TimeSlot({
    required DateTime startTime,
    required DateTime endTime,
    @Default(true) bool isAvailable,
    @Default([]) List<CalendarEvent> events,
    String? label,
  }) = _TimeSlot;

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);
}

/// Calendar settings and preferences
@freezed
class CalendarSettings with _$CalendarSettings {
  const factory CalendarSettings({
    @Default(CalendarView.month) CalendarView defaultView,
    @Default(1) int firstDayOfWeek, // 0=Sunday, 1=Monday
    @Default('local') String timezone,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(TimeOfDay(hour: 9, minute: 0)) TimeOfDay workDayStart,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(TimeOfDay(hour: 17, minute: 0)) TimeOfDay workDayEnd,
    @Default([1, 2, 3, 4, 5]) List<int> workDays, // 1=Monday, 7=Sunday
    @Default([15, 30, 60]) List<int> defaultReminders,
    @Default(true) bool showWeekNumbers,
    @Default(true) bool showDeclinedEvents,
    @Default(false) bool enable24HourFormat,
    @Default('yyyy-MM-dd') String dateFormat,
    @Default('HH:mm') String timeFormat,
    @Default({}) Map<EventType, String> eventTypeColors,
    @Default(true) bool enableNotifications,
    @Default(true) bool enableEmailReminders,
    @Default(false) bool enableSmsReminders,
    @Default(30) int defaultEventDuration, // minutes
    @Default(5) int eventSnapInterval, // minutes
    @Default([]) List<String> quickAddTags,
  }) = _CalendarSettings;

  factory CalendarSettings.fromJson(Map<String, dynamic> json) =>
      _$CalendarSettingsFromJson(json);
}

/// Event category for grouping and filtering
@freezed
class EventCategory with _$EventCategory {
  const factory EventCategory({
    required int id,
    required String name,
    required String color,
    String? icon,
    String? description,
    @Default(true) bool isVisible,
    @Default(0) int sortOrder,
  }) = _EventCategory;

  factory EventCategory.fromJson(Map<String, dynamic> json) =>
      _$EventCategoryFromJson(json);
}

/// Calendar sync status and information
@freezed
class CalendarSync with _$CalendarSync {
  const factory CalendarSync({
    required int calendarId,
    required String provider, // google, outlook, icloud
    DateTime? lastSyncTime,
    @Default('idle') String status, // syncing, idle, error, success
    String? error,
    int? syncedEvents,
    String? syncToken,
    Map<String, dynamic>? syncData,
  }) = _CalendarSync;

  factory CalendarSync.fromJson(Map<String, dynamic> json) =>
      _$CalendarSyncFromJson(json);
}

/// Quick event suggestion
@freezed
class QuickEventSuggestion with _$QuickEventSuggestion {
  const factory QuickEventSuggestion({
    required String title,
    required EventType type,
    required Duration duration,
    String? location,
    @Default([]) List<String> tags,
    @Default([15]) List<int> reminders,
  }) = _QuickEventSuggestion;

  factory QuickEventSuggestion.fromJson(Map<String, dynamic> json) =>
      _$QuickEventSuggestionFromJson(json);
}

/// Extension methods for CalendarEvent
extension CalendarEventExtension on CalendarEvent {
  /// Check if event occurs on a specific date
  bool occursOnDate(DateTime date) {
    final eventDate = DateTime(startTime.year, startTime.month, startTime.day);
    final checkDate = DateTime(date.year, date.month, date.day);
    return eventDate.isAtSameMomentAs(checkDate) || 
           (startTime.isBefore(checkDate.add(const Duration(days: 1))) &&
            endTime.isAfter(checkDate));
  }

  /// Get event duration
  Duration get duration => endTime.difference(startTime);

  /// Check if event is happening now
  bool get isCurrentlyHappening {
    final now = DateTime.now();
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  /// Check if event is upcoming (starts within next 24 hours)
  bool get isUpcoming {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    return startTime.isAfter(now) && startTime.isBefore(tomorrow);
  }

  /// Check if event is overdue (for tasks)
  bool get isOverdue {
    if (type != EventType.task) return false;
    return DateTime.now().isAfter(endTime);
  }

  /// Get formatted time range
  String get timeRange {
    final formatter = DateFormat('HH:mm');
    if (allDay) return 'All day';
    return '${formatter.format(startTime)} - ${formatter.format(endTime)}';
  }

  /// Get formatted date range
  String get dateRange {
    final dateFormatter = DateFormat('MMM dd');
    final startDate = dateFormatter.format(startTime);
    
    if (allDay && duration.inDays == 1) {
      return startDate;
    }
    
    final endDate = dateFormatter.format(endTime);
    if (startDate == endDate) {
      return startDate;
    }
    
    return '$startDate - $endDate';
  }

  /// Check if user can edit this event
  bool canEdit(String userId) {
    return isOrganizer || createdBy == userId;
  }

  /// Get event color as Color object
  Color get colorValue {
    try {
      return Color(int.parse(color.replaceAll('#', '0xFF')));
    } catch (e) {
      return Colors.blue;
    }
  }

  /// Create a copy for recurring event instance
  CalendarEvent copyForDate(DateTime newDate) {
    final timeDiff = newDate.difference(
      DateTime(startTime.year, startTime.month, startTime.day),
    );
    
    return copyWith(
      id: 0, // New instance gets new ID
      startTime: startTime.add(timeDiff),
      endTime: endTime.add(timeDiff),
    );
  }
}

/// Extension methods for RecurrenceRule
extension RecurrenceRuleExtension on RecurrenceRule {
  /// Generate next occurrence date
  DateTime? getNextOccurrence(DateTime after) {
    switch (type) {
      case RecurrenceType.daily:
        return after.add(Duration(days: interval));
      case RecurrenceType.weekly:
        return after.add(Duration(days: 7 * interval));
      case RecurrenceType.monthly:
        return DateTime(after.year, after.month + interval, after.day);
      case RecurrenceType.yearly:
        return DateTime(after.year + interval, after.month, after.day);
      default:
        return null;
    }
  }

  /// Check if recurrence should end
  bool shouldEnd(DateTime date, int occurrenceCount) {
    if (endDate != null && date.isAfter(endDate!)) return true;
    if (occurrences != null && occurrenceCount >= occurrences!) return true;
    return false;
  }

  /// Generate list of occurrences
  List<DateTime> generateOccurrences(
    DateTime startDate,
    DateTime endDate, {
    int maxOccurrences = 100,
  }) {
    final occurrences = <DateTime>[];
    var currentDate = startDate;
    var count = 0;

    while (currentDate.isBefore(endDate) && 
           count < maxOccurrences &&
           !shouldEnd(currentDate, count)) {
      
      if (!exceptions.contains(currentDate)) {
        occurrences.add(currentDate);
      }
      
      final nextDate = getNextOccurrence(currentDate);
      if (nextDate == null) break;
      
      currentDate = nextDate;
      count++;
    }

    return occurrences;
  }
}

/// Extension methods for EventType
extension EventTypeExtension on EventType {
  /// Get display name for event type
  String get displayName {
    switch (this) {
      case EventType.meeting:
        return 'Meeting';
      case EventType.appointment:
        return 'Appointment';
      case EventType.reminder:
        return 'Reminder';
      case EventType.task:
        return 'Task';
      case EventType.personal:
        return 'Personal';
      case EventType.work:
        return 'Work';
      case EventType.holiday:
        return 'Holiday';
      case EventType.birthday:
        return 'Birthday';
      case EventType.call:
        return 'Call';
      case EventType.travel:
        return 'Travel';
    }
  }

  /// Get icon for event type
  IconData get icon {
    switch (this) {
      case EventType.meeting:
        return Icons.group;
      case EventType.appointment:
        return Icons.event;
      case EventType.reminder:
        return Icons.notifications;
      case EventType.task:
        return Icons.task_alt;
      case EventType.personal:
        return Icons.person;
      case EventType.work:
        return Icons.work;
      case EventType.holiday:
        return Icons.celebration;
      case EventType.birthday:
        return Icons.cake;
      case EventType.call:
        return Icons.phone;
      case EventType.travel:
        return Icons.flight;
    }
  }

  /// Get default color for event type
  String get defaultColor {
    switch (this) {
      case EventType.meeting:
        return '#2196F3';
      case EventType.appointment:
        return '#4CAF50';
      case EventType.reminder:
        return '#FF9800';
      case EventType.task:
        return '#9C27B0';
      case EventType.personal:
        return '#E91E63';
      case EventType.work:
        return '#607D8B';
      case EventType.holiday:
        return '#F44336';
      case EventType.birthday:
        return '#FFEB3B';
      case EventType.call:
        return '#00BCD4';
      case EventType.travel:
        return '#795548';
    }
  }
}

/// Extension methods for CalendarView
extension CalendarViewExtension on CalendarView {
  /// Get display name for calendar view
  String get displayName {
    switch (this) {
      case CalendarView.month:
        return 'Month';
      case CalendarView.week:
        return 'Week';
      case CalendarView.day:
        return 'Day';
      case CalendarView.agenda:
        return 'Agenda';
      case CalendarView.year:
        return 'Year';
    }
  }

  /// Get icon for calendar view
  IconData get icon {
    switch (this) {
      case CalendarView.month:
        return Icons.calendar_month;
      case CalendarView.week:
        return Icons.view_week;
      case CalendarView.day:
        return Icons.today;
      case CalendarView.agenda:
        return Icons.list;
      case CalendarView.year:
        return Icons.calendar_view_month;
    }
  }
}

/// Extension methods for EventPriority
extension EventPriorityExtension on EventPriority {
  /// Get display name for priority
  String get displayName {
    switch (this) {
      case EventPriority.low:
        return 'Low';
      case EventPriority.medium:
        return 'Medium';
      case EventPriority.high:
        return 'High';
      case EventPriority.urgent:
        return 'Urgent';
    }
  }

  /// Get color for priority
  Color get color {
    switch (this) {
      case EventPriority.low:
        return Colors.grey;
      case EventPriority.medium:
        return Colors.blue;
      case EventPriority.high:
        return Colors.orange;
      case EventPriority.urgent:
        return Colors.red;
    }
  }

  /// Get icon for priority
  IconData get icon {
    switch (this) {
      case EventPriority.low:
        return Icons.keyboard_arrow_down;
      case EventPriority.medium:
        return Icons.remove;
      case EventPriority.high:
        return Icons.keyboard_arrow_up;
      case EventPriority.urgent:
        return Icons.priority_high;
    }
  }
}