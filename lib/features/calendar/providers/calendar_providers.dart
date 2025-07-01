import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../models/calendar_models.dart';
import '../services/calendar_service.dart';

// Calendar Service Provider
final calendarServiceProvider = Provider<CalendarService>((ref) {
  return CalendarService();
});

// Calendar List Provider
final calendarsProvider = FutureProvider<List<Calendar>>((ref) async {
  final service = ref.watch(calendarServiceProvider);
  return service.getCalendars();
});

// Selected Calendar Provider
final selectedCalendarProvider = StateProvider<String?>((ref) => null);

// Calendar View Type Provider
final calendarViewTypeProvider = StateProvider<CalendarViewType>((ref) {
  return CalendarViewType.month;
});

// Selected Date Provider
final selectedDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

// Focused Day Provider (for table_calendar)
final focusedDayProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

// Date Range Provider (for week/month views)
final dateRangeProvider = Provider<DateTimeRange>((ref) {
  final viewType = ref.watch(calendarViewTypeProvider);
  final selectedDate = ref.watch(selectedDateProvider);
  
  switch (viewType) {
    case CalendarViewType.day:
      return DateTimeRange(
        start: DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
        end: DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 23, 59, 59),
      );
    case CalendarViewType.week:
      final weekday = selectedDate.weekday;
      final startOfWeek = selectedDate.subtract(Duration(days: weekday - 1));
      final endOfWeek = startOfWeek.add(const Duration(days: 6));
      return DateTimeRange(
        start: DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
        end: DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59),
      );
    case CalendarViewType.month:
      final startOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
      final endOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0);
      return DateTimeRange(start: startOfMonth, end: endOfMonth);
    case CalendarViewType.agenda:
      return DateTimeRange(
        start: DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
        end: DateTime(selectedDate.year, selectedDate.month, selectedDate.day).add(const Duration(days: 30)),
      );
  }
});

// Events Provider
final eventsProvider = FutureProvider.family<List<CalendarEvent>, DateTimeRange?>((ref, dateRange) async {
  final service = ref.watch(calendarServiceProvider);
  final selectedCalendar = ref.watch(selectedCalendarProvider);
  
  return service.getEvents(
    startDate: dateRange?.start,
    endDate: dateRange?.end,
    calendarId: selectedCalendar,
  );
});

// Events for Selected Date Provider
final eventsForSelectedDateProvider = FutureProvider<List<CalendarEvent>>((ref) async {
  final service = ref.watch(calendarServiceProvider);
  final selectedDate = ref.watch(selectedDateProvider);
  final selectedCalendar = ref.watch(selectedCalendarProvider);
  
  return service.getEvents(
    startDate: DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
    endDate: DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 23, 59, 59),
    calendarId: selectedCalendar,
  );
});

// Upcoming Events Provider
final upcomingEventsProvider = FutureProvider<List<CalendarEvent>>((ref) async {
  final service = ref.watch(calendarServiceProvider);
  return service.getUpcomingEvents(limit: 5);
});

// Event Search Provider
final eventSearchQueryProvider = StateProvider<String>((ref) => '');

final eventSearchResultsProvider = FutureProvider<List<CalendarEvent>>((ref) async {
  final service = ref.watch(calendarServiceProvider);
  final query = ref.watch(eventSearchQueryProvider);
  
  if (query.isEmpty) {
    return [];
  }
  
  return service.searchEvents(query);
});

// Selected Event Provider (for editing)
final selectedEventProvider = StateProvider<CalendarEvent?>((ref) => null);

// Calendar Visibility Filter Provider
final calendarVisibilityProvider = StateNotifierProvider<CalendarVisibilityNotifier, Map<String, bool>>((ref) {
  return CalendarVisibilityNotifier();
});

class CalendarVisibilityNotifier extends StateNotifier<Map<String, bool>> {
  CalendarVisibilityNotifier() : super({});

  void toggleCalendarVisibility(String calendarId) {
    state = {
      ...state,
      calendarId: !(state[calendarId] ?? true),
    };
  }

  void setCalendarVisibility(String calendarId, bool isVisible) {
    state = {
      ...state,
      calendarId: isVisible,
    };
  }

  void showAllCalendars(List<String> calendarIds) {
    state = Map.fromEntries(
      calendarIds.map((id) => MapEntry(id, true)),
    );
  }

  void hideAllCalendars(List<String> calendarIds) {
    state = Map.fromEntries(
      calendarIds.map((id) => MapEntry(id, false)),
    );
  }
}

// Events Map Provider (for table_calendar)
final eventsMapProvider = Provider<Map<DateTime, List<CalendarEvent>>>((ref) {
  final dateRange = ref.watch(dateRangeProvider);
  final eventsAsync = ref.watch(eventsProvider(dateRange));
  final visibilityFilter = ref.watch(calendarVisibilityProvider);
  
  return eventsAsync.when(
    data: (events) {
      final Map<DateTime, List<CalendarEvent>> eventMap = {};
      
      for (final event in events) {
        // Check if calendar is visible
        if (visibilityFilter[event.calendarId] == false) continue;
        
        final date = DateTime(event.start.year, event.start.month, event.start.day);
        if (eventMap[date] != null) {
          eventMap[date]!.add(event);
        } else {
          eventMap[date] = [event];
        }
      }
      
      return eventMap;
    },
    loading: () => {},
    error: (_, __) => {},
  );
});

// Event Form State Provider
final eventFormStateProvider = StateNotifierProvider<EventFormStateNotifier, EventFormState>((ref) {
  return EventFormStateNotifier();
});

class EventFormState {
  final String title;
  final String description;
  final String location;
  final DateTime start;
  final DateTime end;
  final bool isAllDay;
  final EventCategory category;
  final EventPriority priority;
  final String calendarId;
  final List<EventReminder> reminders;
  final RecurrenceRule? recurrenceRule;
  final List<String> attendees;

  EventFormState({
    this.title = '',
    this.description = '',
    this.location = '',
    DateTime? start,
    DateTime? end,
    this.isAllDay = false,
    this.category = EventCategory.general,
    this.priority = EventPriority.normal,
    this.calendarId = '',
    this.reminders = const [],
    this.recurrenceRule,
    this.attendees = const [],
  })  : start = start ?? DateTime.now(),
        end = end ?? DateTime.now().add(const Duration(hours: 1));

  EventFormState copyWith({
    String? title,
    String? description,
    String? location,
    DateTime? start,
    DateTime? end,
    bool? isAllDay,
    EventCategory? category,
    EventPriority? priority,
    String? calendarId,
    List<EventReminder>? reminders,
    RecurrenceRule? recurrenceRule,
    List<String>? attendees,
  }) {
    return EventFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      start: start ?? this.start,
      end: end ?? this.end,
      isAllDay: isAllDay ?? this.isAllDay,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      calendarId: calendarId ?? this.calendarId,
      reminders: reminders ?? this.reminders,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      attendees: attendees ?? this.attendees,
    );
  }
}

class EventFormStateNotifier extends StateNotifier<EventFormState> {
  EventFormStateNotifier() : super(EventFormState());

  void reset() {
    state = EventFormState();
  }

  void loadEvent(CalendarEvent event) {
    state = EventFormState(
      title: event.title,
      description: event.description ?? '',
      location: event.location ?? '',
      start: event.start,
      end: event.end,
      isAllDay: event.isAllDay,
      category: event.category,
      priority: event.priority,
      calendarId: event.calendarId,
      reminders: event.reminders,
      recurrenceRule: event.recurrenceRule,
      attendees: event.attendees,
    );
  }

  void updateTitle(String title) {
    state = state.copyWith(title: title);
  }

  void updateDescription(String description) {
    state = state.copyWith(description: description);
  }

  void updateLocation(String location) {
    state = state.copyWith(location: location);
  }

  void updateStart(DateTime start) {
    state = state.copyWith(start: start);
    // Adjust end time if needed
    if (start.isAfter(state.end)) {
      state = state.copyWith(end: start.add(const Duration(hours: 1)));
    }
  }

  void updateEnd(DateTime end) {
    state = state.copyWith(end: end);
  }

  void toggleAllDay() {
    state = state.copyWith(isAllDay: !state.isAllDay);
  }

  void updateCategory(EventCategory category) {
    state = state.copyWith(category: category);
  }

  void updatePriority(EventPriority priority) {
    state = state.copyWith(priority: priority);
  }

  void updateCalendarId(String calendarId) {
    state = state.copyWith(calendarId: calendarId);
  }

  void addReminder(EventReminder reminder) {
    state = state.copyWith(reminders: [...state.reminders, reminder]);
  }

  void removeReminder(int index) {
    final reminders = List<EventReminder>.from(state.reminders);
    reminders.removeAt(index);
    state = state.copyWith(reminders: reminders);
  }

  void updateRecurrenceRule(RecurrenceRule? rule) {
    state = state.copyWith(recurrenceRule: rule);
  }

  void addAttendee(String email) {
    state = state.copyWith(attendees: [...state.attendees, email]);
  }

  void removeAttendee(String email) {
    state = state.copyWith(
      attendees: state.attendees.where((e) => e != email).toList(),
    );
  }
}