import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Event types for categorizing calendar events
enum EventType {
  meeting,
  appointment,
  reminder,
  task,
  personal,
  work,
  holiday,
  birthday,
  call,
  travel,
}

/// Event priority levels
enum EventPriority {
  low,
  medium,
  high,
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
  none,
  daily,
  weekly,
  monthly,
  yearly,
}

/// RSVP response status
enum RsvpStatus {
  pending,
  accepted,
  declined,
  maybe,
}

/// Event visibility levels
enum EventVisibility {
  public,
  private,
  confidential,
}

/// Main calendar event model
class CalendarEvent {
  final int id;
  final String title;
  final String? description;
  final DateTime startTime;
  final DateTime endTime;
  final bool allDay;
  final String? location;
  final List<String> attendees;
  final EventType type;
  final String color;
  final int? reminder; // minutes before
  final EventPriority priority;
  final EventVisibility visibility;
  final RecurrenceRule? recurrence;
  final List<String> tags;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Map<String, RsvpStatus> rsvpResponses;
  final String? meetingUrl;
  final String? timezone;
  final bool isOrganizer;
  final int? calendarId;

  const CalendarEvent({
    required this.id,
    required this.title,
    this.description,
    required this.startTime,
    required this.endTime,
    this.allDay = false,
    this.location,
    this.attendees = const [],
    this.type = EventType.meeting,
    this.color = '#2196F3',
    this.reminder,
    this.priority = EventPriority.medium,
    this.visibility = EventVisibility.public,
    this.recurrence,
    this.tags = const [],
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.rsvpResponses = const {},
    this.meetingUrl,
    this.timezone,
    this.isOrganizer = false,
    this.calendarId,
  });

  CalendarEvent copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    bool? allDay,
    String? location,
    List<String>? attendees,
    EventType? type,
    String? color,
    int? reminder,
    EventPriority? priority,
    EventVisibility? visibility,
    RecurrenceRule? recurrence,
    List<String>? tags,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, RsvpStatus>? rsvpResponses,
    String? meetingUrl,
    String? timezone,
    bool? isOrganizer,
    int? calendarId,
  }) {
    return CalendarEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      allDay: allDay ?? this.allDay,
      location: location ?? this.location,
      attendees: attendees ?? this.attendees,
      type: type ?? this.type,
      color: color ?? this.color,
      reminder: reminder ?? this.reminder,
      priority: priority ?? this.priority,
      visibility: visibility ?? this.visibility,
      recurrence: recurrence ?? this.recurrence,
      tags: tags ?? this.tags,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rsvpResponses: rsvpResponses ?? this.rsvpResponses,
      meetingUrl: meetingUrl ?? this.meetingUrl,
      timezone: timezone ?? this.timezone,
      isOrganizer: isOrganizer ?? this.isOrganizer,
      calendarId: calendarId ?? this.calendarId,
    );
  }

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      allDay: json['all_day'] as bool? ?? false,
      location: json['location'] as String?,
      attendees: (json['attendees'] as List<dynamic>?)?.cast<String>() ?? [],
      type: _eventTypeFromString(json['type'] as String?),
      color: json['color'] as String? ?? '#2196F3',
      reminder: json['reminder'] as int?,
      priority: _priorityFromString(json['priority'] as String?),
      visibility: _visibilityFromString(json['visibility'] as String?),
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at'] as String) : null,
      rsvpResponses: (json['rsvp_responses'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, _rsvpStatusFromString(value as String)),
      ) ?? {},
      meetingUrl: json['meeting_url'] as String?,
      timezone: json['timezone'] as String?,
      isOrganizer: json['is_organizer'] as bool? ?? false,
      calendarId: json['calendar_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      if (description != null) 'description': description,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'all_day': allDay,
      if (location != null) 'location': location,
      'attendees': attendees,
      'type': type.name,
      'color': color,
      if (reminder != null) 'reminder': reminder,
      'priority': priority.name,
      'visibility': visibility.name,
      'tags': tags,
      if (createdBy != null) 'created_by': createdBy,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
      'rsvp_responses': rsvpResponses.map((key, value) => MapEntry(key, value.name)),
      if (meetingUrl != null) 'meeting_url': meetingUrl,
      if (timezone != null) 'timezone': timezone,
      'is_organizer': isOrganizer,
      if (calendarId != null) 'calendar_id': calendarId,
    };
  }

  static EventType _eventTypeFromString(String? type) {
    switch (type?.toLowerCase()) {
      case 'meeting': return EventType.meeting;
      case 'appointment': return EventType.appointment;
      case 'reminder': return EventType.reminder;
      case 'task': return EventType.task;
      case 'personal': return EventType.personal;
      case 'work': return EventType.work;
      case 'holiday': return EventType.holiday;
      case 'birthday': return EventType.birthday;
      case 'call': return EventType.call;
      case 'travel': return EventType.travel;
      default: return EventType.meeting;
    }
  }

  static EventPriority _priorityFromString(String? priority) {
    switch (priority?.toLowerCase()) {
      case 'low': return EventPriority.low;
      case 'medium': return EventPriority.medium;
      case 'high': return EventPriority.high;
      case 'urgent': return EventPriority.urgent;
      default: return EventPriority.medium;
    }
  }

  static EventVisibility _visibilityFromString(String? visibility) {
    switch (visibility?.toLowerCase()) {
      case 'public': return EventVisibility.public;
      case 'private': return EventVisibility.private;
      case 'confidential': return EventVisibility.confidential;
      default: return EventVisibility.public;
    }
  }

  static RsvpStatus _rsvpStatusFromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending': return RsvpStatus.pending;
      case 'accepted': return RsvpStatus.accepted;
      case 'declined': return RsvpStatus.declined;
      case 'maybe': return RsvpStatus.maybe;
      default: return RsvpStatus.pending;
    }
  }
}

/// Recurrence rule for repeating events
class RecurrenceRule {
  final RecurrenceType type;
  final int interval;
  final DateTime? endDate;
  final int? occurrences;
  final List<int> daysOfWeek; // 1=Monday, 7=Sunday
  final List<DateTime> exceptions; // dates to skip

  const RecurrenceRule({
    required this.type,
    this.interval = 1,
    this.endDate,
    this.occurrences,
    this.daysOfWeek = const [],
    this.exceptions = const [],
  });

  factory RecurrenceRule.fromJson(Map<String, dynamic> json) {
    return RecurrenceRule(
      type: _recurrenceTypeFromString(json['type'] as String),
      interval: json['interval'] as int? ?? 1,
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date'] as String) : null,
      occurrences: json['occurrences'] as int?,
      daysOfWeek: (json['days_of_week'] as List<dynamic>?)?.cast<int>() ?? [],
      exceptions: (json['exceptions'] as List<dynamic>?)?.map((e) => DateTime.parse(e as String)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'interval': interval,
      if (endDate != null) 'end_date': endDate!.toIso8601String(),
      if (occurrences != null) 'occurrences': occurrences,
      'days_of_week': daysOfWeek,
      'exceptions': exceptions.map((e) => e.toIso8601String()).toList(),
    };
  }

  static RecurrenceType _recurrenceTypeFromString(String type) {
    switch (type.toLowerCase()) {
      case 'none': return RecurrenceType.none;
      case 'daily': return RecurrenceType.daily;
      case 'weekly': return RecurrenceType.weekly;
      case 'monthly': return RecurrenceType.monthly;
      case 'yearly': return RecurrenceType.yearly;
      default: return RecurrenceType.none;
    }
  }
}

/// Calendar model for managing multiple calendars
class CalendarModel {
  final int id;
  final String name;
  final String color;
  final String description;
  final bool isVisible;
  final bool isReadOnly;
  final bool isDefault;
  final String type; // local, google, outlook, icloud
  final String? ownerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CalendarModel({
    required this.id,
    required this.name,
    required this.color,
    this.description = '',
    this.isVisible = true,
    this.isReadOnly = false,
    this.isDefault = false,
    this.type = 'local',
    this.ownerId,
    this.createdAt,
    this.updatedAt,
  });

  CalendarModel copyWith({
    int? id,
    String? name,
    String? color,
    String? description,
    bool? isVisible,
    bool? isReadOnly,
    bool? isDefault,
    String? type,
    String? ownerId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CalendarModel(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      description: description ?? this.description,
      isVisible: isVisible ?? this.isVisible,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      isDefault: isDefault ?? this.isDefault,
      type: type ?? this.type,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    return CalendarModel(
      id: json['id'] as int,
      name: json['name'] as String,
      color: json['color'] as String,
      description: json['description'] as String? ?? '',
      isVisible: json['is_visible'] as bool? ?? true,
      isReadOnly: json['is_read_only'] as bool? ?? false,
      isDefault: json['is_default'] as bool? ?? false,
      type: json['type'] as String? ?? 'local',
      ownerId: json['owner_id'] as String?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'description': description,
      'is_visible': isVisible,
      'is_read_only': isReadOnly,
      'is_default': isDefault,
      'type': type,
      if (ownerId != null) 'owner_id': ownerId,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }
}

/// Time slot for scheduling
class TimeSlot {
  final DateTime startTime;
  final DateTime endTime;
  final bool isAvailable;
  final List<CalendarEvent> events;
  final String? label;

  const TimeSlot({
    required this.startTime,
    required this.endTime,
    this.isAvailable = true,
    this.events = const [],
    this.label,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      isAvailable: json['is_available'] as bool? ?? true,
      events: (json['events'] as List<dynamic>?)?.map((e) => CalendarEvent.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      label: json['label'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'is_available': isAvailable,
      'events': events.map((e) => e.toJson()).toList(),
      if (label != null) 'label': label,
    };
  }
}

/// Event conflict detection result
class EventConflict {
  final CalendarEvent event1;
  final CalendarEvent event2;
  final DateTime conflictStart;
  final DateTime conflictEnd;
  final String type; // overlap, adjacent, etc.
  final String? suggestion;

  const EventConflict({
    required this.event1,
    required this.event2,
    required this.conflictStart,
    required this.conflictEnd,
    this.type = 'overlap',
    this.suggestion,
  });

  factory EventConflict.fromJson(Map<String, dynamic> json) {
    return EventConflict(
      event1: CalendarEvent.fromJson(json['event1'] as Map<String, dynamic>),
      event2: CalendarEvent.fromJson(json['event2'] as Map<String, dynamic>),
      conflictStart: DateTime.parse(json['conflict_start'] as String),
      conflictEnd: DateTime.parse(json['conflict_end'] as String),
      type: json['type'] as String? ?? 'overlap',
      suggestion: json['suggestion'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event1': event1.toJson(),
      'event2': event2.toJson(),
      'conflict_start': conflictStart.toIso8601String(),
      'conflict_end': conflictEnd.toIso8601String(),
      'type': type,
      if (suggestion != null) 'suggestion': suggestion,
    };
  }
}

/// Calendar settings and preferences
class CalendarSettings {
  final CalendarView defaultView;
  final int firstDayOfWeek; // 0=Sunday, 1=Monday
  final String timezone;
  final TimeOfDay workDayStart;
  final TimeOfDay workDayEnd;
  final List<int> workDays; // 1=Monday, 7=Sunday
  final List<int> defaultReminders;
  final bool showWeekNumbers;
  final bool showDeclinedEvents;
  final bool enable24HourFormat;
  final bool enableNotifications;
  final int defaultEventDuration; // minutes

  const CalendarSettings({
    this.defaultView = CalendarView.month,
    this.firstDayOfWeek = 1,
    this.timezone = 'local',
    this.workDayStart = const TimeOfDay(hour: 9, minute: 0),
    this.workDayEnd = const TimeOfDay(hour: 17, minute: 0),
    this.workDays = const [1, 2, 3, 4, 5],
    this.defaultReminders = const [15, 30, 60],
    this.showWeekNumbers = true,
    this.showDeclinedEvents = true,
    this.enable24HourFormat = false,
    this.enableNotifications = true,
    this.defaultEventDuration = 30,
  });

  CalendarSettings copyWith({
    CalendarView? defaultView,
    int? firstDayOfWeek,
    String? timezone,
    TimeOfDay? workDayStart,
    TimeOfDay? workDayEnd,
    List<int>? workDays,
    List<int>? defaultReminders,
    bool? showWeekNumbers,
    bool? showDeclinedEvents,
    bool? enable24HourFormat,
    bool? enableNotifications,
    int? defaultEventDuration,
  }) {
    return CalendarSettings(
      defaultView: defaultView ?? this.defaultView,
      firstDayOfWeek: firstDayOfWeek ?? this.firstDayOfWeek,
      timezone: timezone ?? this.timezone,
      workDayStart: workDayStart ?? this.workDayStart,
      workDayEnd: workDayEnd ?? this.workDayEnd,
      workDays: workDays ?? this.workDays,
      defaultReminders: defaultReminders ?? this.defaultReminders,
      showWeekNumbers: showWeekNumbers ?? this.showWeekNumbers,
      showDeclinedEvents: showDeclinedEvents ?? this.showDeclinedEvents,
      enable24HourFormat: enable24HourFormat ?? this.enable24HourFormat,
      enableNotifications: enableNotifications ?? this.enableNotifications,
      defaultEventDuration: defaultEventDuration ?? this.defaultEventDuration,
    );
  }

  factory CalendarSettings.fromJson(Map<String, dynamic> json) {
    return CalendarSettings(
      defaultView: _calendarViewFromString(json['default_view'] as String?),
      firstDayOfWeek: json['first_day_of_week'] as int? ?? 1,
      timezone: json['timezone'] as String? ?? 'local',
      workDayStart: _timeOfDayFromString(json['work_day_start'] as String?) ?? const TimeOfDay(hour: 9, minute: 0),
      workDayEnd: _timeOfDayFromString(json['work_day_end'] as String?) ?? const TimeOfDay(hour: 17, minute: 0),
      workDays: (json['work_days'] as List<dynamic>?)?.cast<int>() ?? [1, 2, 3, 4, 5],
      defaultReminders: (json['default_reminders'] as List<dynamic>?)?.cast<int>() ?? [15, 30, 60],
      showWeekNumbers: json['show_week_numbers'] as bool? ?? true,
      showDeclinedEvents: json['show_declined_events'] as bool? ?? true,
      enable24HourFormat: json['enable_24_hour_format'] as bool? ?? false,
      enableNotifications: json['enable_notifications'] as bool? ?? true,
      defaultEventDuration: json['default_event_duration'] as int? ?? 30,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'default_view': defaultView.name,
      'first_day_of_week': firstDayOfWeek,
      'timezone': timezone,
      'work_day_start': '${workDayStart.hour.toString().padLeft(2, '0')}:${workDayStart.minute.toString().padLeft(2, '0')}',
      'work_day_end': '${workDayEnd.hour.toString().padLeft(2, '0')}:${workDayEnd.minute.toString().padLeft(2, '0')}',
      'work_days': workDays,
      'default_reminders': defaultReminders,
      'show_week_numbers': showWeekNumbers,
      'show_declined_events': showDeclinedEvents,
      'enable_24_hour_format': enable24HourFormat,
      'enable_notifications': enableNotifications,
      'default_event_duration': defaultEventDuration,
    };
  }

  static CalendarView _calendarViewFromString(String? view) {
    switch (view?.toLowerCase()) {
      case 'month': return CalendarView.month;
      case 'week': return CalendarView.week;  
      case 'day': return CalendarView.day;
      case 'agenda': return CalendarView.agenda;
      case 'year': return CalendarView.year;
      default: return CalendarView.month;
    }
  }

  static TimeOfDay? _timeOfDayFromString(String? timeString) {
    if (timeString == null) return null;
    final parts = timeString.split(':');
    if (parts.length != 2) return null;
    return TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 0,
      minute: int.tryParse(parts[1]) ?? 0,
    );
  }
}

/// Event category for grouping and filtering
class EventCategory {
  final int id;
  final String name;
  final String color;
  final String? icon;
  final String? description;
  final bool isVisible;
  final int sortOrder;

  const EventCategory({
    required this.id,
    required this.name,
    required this.color,
    this.icon,
    this.description,
    this.isVisible = true,
    this.sortOrder = 0,
  });

  factory EventCategory.fromJson(Map<String, dynamic> json) {
    return EventCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      color: json['color'] as String,
      icon: json['icon'] as String?,
      description: json['description'] as String?,
      isVisible: json['is_visible'] as bool? ?? true,
      sortOrder: json['sort_order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      if (icon != null) 'icon': icon,
      if (description != null) 'description': description,
      'is_visible': isVisible,
      'sort_order': sortOrder,
    };
  }
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

  /// Get event color as Color object
  Color get colorValue {
    try {
      return Color(int.parse(color.replaceAll('#', '0xFF')));
    } catch (e) {
      return Colors.blue;
    }
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