import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/simple_calendar_models.dart';
import '../services/calendar_api_service.dart';

/// Current calendar date provider
final calendarDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

/// Current calendar view provider
final calendarViewProvider = StateProvider<CalendarView>((ref) => CalendarView.month);

/// Selected event provider
final selectedEventProvider = StateProvider<CalendarEvent?>((ref) => null);

/// Calendar events provider
final calendarEventsProvider = StateNotifierProvider<CalendarEventsNotifier, AsyncValue<List<CalendarEvent>>>((ref) {
  final apiService = ref.watch(calendarApiServiceProvider);
  return CalendarEventsNotifier(apiService);
});

/// Calendar events notifier
class CalendarEventsNotifier extends StateNotifier<AsyncValue<List<CalendarEvent>>> {
  CalendarEventsNotifier(this._apiService) : super(const AsyncValue.loading()) {
    loadEvents();
  }

  final CalendarApiService _apiService;
  DateTime? _lastLoadedMonth;

  /// Load events for the current date range
  Future<void> loadEvents({
    DateTime? startDate,
    DateTime? endDate,
    String? type,
    String? search,
  }) async {
    try {
      state = const AsyncValue.loading();
      final events = await _apiService.getEvents(
        startDate: startDate,
        endDate: endDate,
        type: type,
        search: search,
      );
      state = AsyncValue.data(events);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Load events for a specific month
  Future<void> loadMonthEvents(DateTime date) async {
    final monthStart = DateTime(date.year, date.month, 1);
    final monthEnd = DateTime(date.year, date.month + 1, 0);
    
    // Only reload if we haven't loaded this month yet
    if (_lastLoadedMonth == null || 
        _lastLoadedMonth!.year != date.year || 
        _lastLoadedMonth!.month != date.month) {
      
      await loadEvents(startDate: monthStart, endDate: monthEnd);
      _lastLoadedMonth = date;
    }
  }

  /// Create a new event
  Future<void> createEvent(CalendarEvent event) async {
    try {
      final newEvent = await _apiService.createEvent(event);
      state.whenData((events) {
        final updatedEvents = [...events, newEvent];
        state = AsyncValue.data(updatedEvents);
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Update an existing event
  Future<void> updateEvent(int eventId, CalendarEvent event) async {
    try {
      final updatedEvent = await _apiService.updateEvent(eventId, event);
      state.whenData((events) {
        final updatedEvents = events.map((e) => e.id == eventId ? updatedEvent : e).toList();
        state = AsyncValue.data(updatedEvents);
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Delete an event
  Future<void> deleteEvent(int eventId) async {
    try {
      await _apiService.deleteEvent(eventId);
      state.whenData((events) {
        final updatedEvents = events.where((e) => e.id != eventId).toList();
        state = AsyncValue.data(updatedEvents);
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Move an event (for drag and drop)
  Future<void> moveEvent(int eventId, DateTime newStartTime) async {
    state.whenData((events) {
      final eventIndex = events.indexWhere((e) => e.id == eventId);
      if (eventIndex != -1) {
        final event = events[eventIndex];
        final duration = event.endTime.difference(event.startTime);
        final newEndTime = newStartTime.add(duration);
        
        final updatedEvent = event.copyWith(
          startTime: newStartTime,
          endTime: newEndTime,
        );
        
        final updatedEvents = [...events];
        updatedEvents[eventIndex] = updatedEvent;
        state = AsyncValue.data(updatedEvents);
        
        // Update on server
        updateEvent(eventId, updatedEvent);
      }
    });
  }

  /// Search events
  Future<void> searchEvents(String query) async {
    try {
      state = const AsyncValue.loading();
      final events = await _apiService.searchEvents(query);
      state = AsyncValue.data(events);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Refresh events
  Future<void> refresh() async {
    _lastLoadedMonth = null;
    await loadEvents();
  }
}

/// Upcoming events provider
final upcomingEventsProvider = FutureProvider<List<CalendarEvent>>((ref) async {
  final apiService = ref.watch(calendarApiServiceProvider);
  return apiService.getUpcomingEvents(limit: 5);
});

/// Calendars provider
final calendarsProvider = StateNotifierProvider<CalendarsNotifier, AsyncValue<List<CalendarModel>>>((ref) {
  final apiService = ref.watch(calendarApiServiceProvider);
  return CalendarsNotifier(apiService);
});

/// Calendars notifier
class CalendarsNotifier extends StateNotifier<AsyncValue<List<CalendarModel>>> {
  CalendarsNotifier(this._apiService) : super(const AsyncValue.loading()) {
    loadCalendars();
  }

  final CalendarApiService _apiService;

  /// Load all calendars
  Future<void> loadCalendars() async {
    try {
      state = const AsyncValue.loading();
      final calendars = await _apiService.getCalendars();
      state = AsyncValue.data(calendars);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Create a new calendar
  Future<void> createCalendar(CalendarModel calendar) async {
    try {
      final newCalendar = await _apiService.createCalendar(calendar);
      state.whenData((calendars) {
        final updatedCalendars = [...calendars, newCalendar];
        state = AsyncValue.data(updatedCalendars);
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Update a calendar
  Future<void> updateCalendar(int calendarId, CalendarModel calendar) async {
    try {
      final updatedCalendar = await _apiService.updateCalendar(calendarId, calendar);
      state.whenData((calendars) {
        final updatedCalendars = calendars.map((c) => c.id == calendarId ? updatedCalendar : c).toList();
        state = AsyncValue.data(updatedCalendars);
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Delete a calendar
  Future<void> deleteCalendar(int calendarId) async {
    try {
      await _apiService.deleteCalendar(calendarId);
      state.whenData((calendars) {
        final updatedCalendars = calendars.where((c) => c.id != calendarId).toList();
        state = AsyncValue.data(updatedCalendars);
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Toggle calendar visibility
  Future<void> toggleCalendarVisibility(int calendarId) async {
    state.whenData((calendars) {
      final calendarIndex = calendars.indexWhere((c) => c.id == calendarId);
      if (calendarIndex != -1) {
        final calendar = calendars[calendarIndex];
        final updatedCalendar = calendar.copyWith(isVisible: !calendar.isVisible);
        
        final updatedCalendars = [...calendars];
        updatedCalendars[calendarIndex] = updatedCalendar;
        state = AsyncValue.data(updatedCalendars);
        
        // Update on server
        updateCalendar(calendarId, updatedCalendar);
      }
    });
  }
}

/// Calendar settings provider
final calendarSettingsProvider = StateNotifierProvider<CalendarSettingsNotifier, AsyncValue<CalendarSettings>>((ref) {
  final apiService = ref.watch(calendarApiServiceProvider);
  return CalendarSettingsNotifier(apiService);
});

/// Calendar settings notifier
class CalendarSettingsNotifier extends StateNotifier<AsyncValue<CalendarSettings>> {
  CalendarSettingsNotifier(this._apiService) : super(const AsyncValue.loading()) {
    loadSettings();
  }

  final CalendarApiService _apiService;

  /// Load calendar settings
  Future<void> loadSettings() async {
    try {
      state = const AsyncValue.loading();
      final settings = await _apiService.getSettings();
      state = AsyncValue.data(settings);
    } catch (e, stack) {
      // Use default settings if API fails
      state = const AsyncValue.data(CalendarSettings());
    }
  }

  /// Update calendar settings
  Future<void> updateSettings(CalendarSettings settings) async {
    try {
      final updatedSettings = await _apiService.updateSettings(settings);
      state = AsyncValue.data(updatedSettings);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Update specific setting
  Future<void> updateSetting({
    CalendarView? defaultView,
    int? firstDayOfWeek,
    String? timezone,
    TimeOfDay? workDayStart,
    TimeOfDay? workDayEnd,
    List<int>? workDays,
    bool? showWeekNumbers,
    bool? showDeclinedEvents,
    bool? enable24HourFormat,
    bool? enableNotifications,
  }) async {
    state.whenData((currentSettings) {
      final updatedSettings = currentSettings.copyWith(
        defaultView: defaultView,
        firstDayOfWeek: firstDayOfWeek,
        timezone: timezone,
        workDayStart: workDayStart,
        workDayEnd: workDayEnd,
        workDays: workDays,
        showWeekNumbers: showWeekNumbers,
        showDeclinedEvents: showDeclinedEvents,
        enable24HourFormat: enable24HourFormat,
        enableNotifications: enableNotifications,
      );
      
      updateSettings(updatedSettings);
    });
  }
}

/// Event categories provider
final eventCategoriesProvider = StateNotifierProvider<EventCategoriesNotifier, AsyncValue<List<EventCategory>>>((ref) {
  final apiService = ref.watch(calendarApiServiceProvider);
  return EventCategoriesNotifier(apiService);
});

/// Event categories notifier
class EventCategoriesNotifier extends StateNotifier<AsyncValue<List<EventCategory>>> {
  EventCategoriesNotifier(this._apiService) : super(const AsyncValue.loading()) {
    loadCategories();
  }

  final CalendarApiService _apiService;

  /// Load event categories
  Future<void> loadCategories() async {
    try {
      state = const AsyncValue.loading();
      final categories = await _apiService.getCategories();
      state = AsyncValue.data(categories);
    } catch (e, stack) {
      // Use default categories if API fails
      state = AsyncValue.data(_getDefaultCategories());
    }
  }

  /// Create a new category
  Future<void> createCategory(EventCategory category) async {
    try {
      final newCategory = await _apiService.createCategory(category);
      state.whenData((categories) {
        final updatedCategories = [...categories, newCategory];
        state = AsyncValue.data(updatedCategories);
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Update a category
  Future<void> updateCategory(int categoryId, EventCategory category) async {
    try {
      final updatedCategory = await _apiService.updateCategory(categoryId, category);
      state.whenData((categories) {
        final updatedCategories = categories.map((c) => c.id == categoryId ? updatedCategory : c).toList();
        state = AsyncValue.data(updatedCategories);
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Delete a category
  Future<void> deleteCategory(int categoryId) async {
    try {
      await _apiService.deleteCategory(categoryId);
      state.whenData((categories) {
        final updatedCategories = categories.where((c) => c.id != categoryId).toList();
        state = AsyncValue.data(updatedCategories);
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Get default categories
  List<EventCategory> _getDefaultCategories() {
    return [
      const EventCategory(id: 1, name: 'Meeting', color: '#2196F3', icon: 'group'),
      const EventCategory(id: 2, name: 'Appointment', color: '#4CAF50', icon: 'event'),
      const EventCategory(id: 3, name: 'Task', color: '#9C27B0', icon: 'task_alt'),
      const EventCategory(id: 4, name: 'Personal', color: '#E91E63', icon: 'person'),
      const EventCategory(id: 5, name: 'Work', color: '#607D8B', icon: 'work'),
      const EventCategory(id: 6, name: 'Holiday', color: '#F44336', icon: 'celebration'),
    ];
  }
}

/// Selected date events provider
final selectedDateEventsProvider = Provider<List<CalendarEvent>>((ref) {
  final events = ref.watch(calendarEventsProvider).asData?.value ?? [];
  final selectedDate = ref.watch(calendarDateProvider);
  
  return events.where((event) => event.occursOnDate(selectedDate)).toList()
    ..sort((a, b) => a.startTime.compareTo(b.startTime));
});

/// Filtered events provider
final filteredEventsProvider = StateProvider<List<CalendarEvent>?>((ref) => null);

/// Event filter provider
final eventFilterProvider = StateNotifierProvider<EventFilterNotifier, EventFilter>((ref) {
  return EventFilterNotifier();
});

/// Event filter model
class EventFilter {
  final List<EventType> types;
  final List<int> calendarIds;
  final String? searchQuery;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool showDeclined;

  const EventFilter({
    this.types = const [],
    this.calendarIds = const [],
    this.searchQuery,
    this.startDate,
    this.endDate,
    this.showDeclined = true,
  });

  EventFilter copyWith({
    List<EventType>? types,
    List<int>? calendarIds,
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
    bool? showDeclined,
  }) {
    return EventFilter(
      types: types ?? this.types,
      calendarIds: calendarIds ?? this.calendarIds,
      searchQuery: searchQuery ?? this.searchQuery,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      showDeclined: showDeclined ?? this.showDeclined,
    );
  }

  bool get hasActiveFilters {
    return types.isNotEmpty || 
           calendarIds.isNotEmpty || 
           (searchQuery?.isNotEmpty ?? false) ||
           startDate != null ||
           endDate != null ||
           !showDeclined;
  }
}

/// Event filter notifier
class EventFilterNotifier extends StateNotifier<EventFilter> {
  EventFilterNotifier() : super(const EventFilter());

  void updateFilter({
    List<EventType>? types,
    List<int>? calendarIds,
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
    bool? showDeclined,
  }) {
    state = state.copyWith(
      types: types,
      calendarIds: calendarIds,
      searchQuery: searchQuery,
      startDate: startDate,
      endDate: endDate,
      showDeclined: showDeclined,
    );
  }

  void clearFilter() {
    state = const EventFilter();
  }

  void toggleEventType(EventType type) {
    final currentTypes = List<EventType>.from(state.types);
    if (currentTypes.contains(type)) {
      currentTypes.remove(type);
    } else {
      currentTypes.add(type);
    }
    state = state.copyWith(types: currentTypes);
  }

  void toggleCalendar(int calendarId) {
    final currentCalendars = List<int>.from(state.calendarIds);
    if (currentCalendars.contains(calendarId)) {
      currentCalendars.remove(calendarId);
    } else {
      currentCalendars.add(calendarId);
    }
    state = state.copyWith(calendarIds: currentCalendars);
  }
}

/// Drag and drop state provider
final dragDropStateProvider = StateNotifierProvider<DragDropNotifier, DragDropState>((ref) {
  return DragDropNotifier();
});

/// Drag and drop state
class DragDropState {
  final CalendarEvent? draggedEvent;
  final bool isDragging;
  final DateTime? dropTargetDate;

  const DragDropState({
    this.draggedEvent,
    this.isDragging = false,
    this.dropTargetDate,
  });

  DragDropState copyWith({
    CalendarEvent? draggedEvent,
    bool? isDragging,
    DateTime? dropTargetDate,
  }) {
    return DragDropState(
      draggedEvent: draggedEvent ?? this.draggedEvent,
      isDragging: isDragging ?? this.isDragging,
      dropTargetDate: dropTargetDate ?? this.dropTargetDate,
    );
  }
}

/// Drag and drop notifier
class DragDropNotifier extends StateNotifier<DragDropState> {
  DragDropNotifier() : super(const DragDropState());

  void startDrag(CalendarEvent event) {
    state = state.copyWith(
      draggedEvent: event,
      isDragging: true,
    );
  }

  void updateDropTarget(DateTime? date) {
    state = state.copyWith(dropTargetDate: date);
  }

  void endDrag() {
    state = const DragDropState();
  }

  void cancelDrag() {
    state = const DragDropState();
  }
}

/// Event form state provider
final eventFormProvider = StateNotifierProvider.autoDispose<EventFormNotifier, EventFormState>((ref) {
  return EventFormNotifier();
});

/// Event form state
class EventFormState {
  final CalendarEvent? event;
  final bool isEditing;
  final bool isLoading;
  final String? error;

  const EventFormState({
    this.event,
    this.isEditing = false,
    this.isLoading = false,
    this.error,
  });

  EventFormState copyWith({
    CalendarEvent? event,
    bool? isEditing,
    bool? isLoading,
    String? error,
  }) {
    return EventFormState(
      event: event ?? this.event,
      isEditing: isEditing ?? this.isEditing,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

/// Event form notifier
class EventFormNotifier extends StateNotifier<EventFormState> {
  EventFormNotifier() : super(const EventFormState());

  void startCreating({DateTime? startTime, DateTime? endTime}) {
    final now = DateTime.now();
    final defaultStart = startTime ?? now.add(const Duration(hours: 1));
    final defaultEnd = endTime ?? defaultStart.add(const Duration(hours: 1));
    
    state = state.copyWith(
      event: CalendarEvent(
        id: 0,
        title: '',
        startTime: defaultStart,
        endTime: defaultEnd,
      ),
      isEditing: false,
    );
  }

  void startEditing(CalendarEvent event) {
    state = state.copyWith(
      event: event,
      isEditing: true,
    );
  }

  void updateEvent(CalendarEvent event) {
    state = state.copyWith(event: event);
  }

  void clearForm() {
    state = const EventFormState();
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }
}