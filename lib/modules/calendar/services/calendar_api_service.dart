import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/api_service.dart';
import '../models/simple_calendar_models.dart';

/// Provider for the calendar API service
final calendarApiServiceProvider = Provider<CalendarApiService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return CalendarApiService(apiService);
});

/// Service for calendar-related API operations
class CalendarApiService {
  CalendarApiService(this._apiService);

  final ApiService _apiService;

  /// Get all events with optional filtering
  Future<List<CalendarEvent>> getEvents({
    DateTime? startDate,
    DateTime? endDate,
    String? type,
    String? search,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'limit': limit,
        'offset': offset,
      };

      if (startDate != null) {
        queryParams['start_date'] = startDate.toIso8601String().split('T')[0];
      }
      if (endDate != null) {
        queryParams['end_date'] = endDate.toIso8601String().split('T')[0];
      }
      if (type != null) {
        queryParams['type'] = type;
      }
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final response = await _apiService.get('/calendar/events', queryParams: queryParams);
      
      if (response.data['success'] == true) {
        final List<dynamic> eventsData = response.data['data'] as List<dynamic>;
        return eventsData.map((json) => CalendarEvent.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to fetch events: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Failed to fetch events: $e');
    }
  }

  /// Get a specific event by ID
  Future<CalendarEvent> getEvent(int eventId) async {
    try {
      final response = await _apiService.get('/calendar/events/$eventId');
      return CalendarEvent.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to fetch event: $e');
    }
  }

  /// Create a new event
  Future<CalendarEvent> createEvent(CalendarEvent event) async {
    try {
      final eventData = event.toJson();
      eventData.remove('id'); // Remove ID for creation
      
      final response = await _apiService.post('/calendar/events', data: eventData);
      return CalendarEvent.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to create event: $e');
    }
  }

  /// Update an existing event
  Future<CalendarEvent> updateEvent(int eventId, CalendarEvent event) async {
    try {
      final response = await _apiService.put('/calendar/events/$eventId', data: event.toJson());
      return CalendarEvent.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to update event: $e');
    }
  }

  /// Delete an event
  Future<void> deleteEvent(int eventId) async {
    try {
      await _apiService.delete('/calendar/events/$eventId');
    } catch (e) {
      throw Exception('Failed to delete event: $e');
    }
  }

  /// Get events for a specific month
  Future<Map<String, dynamic>> getMonthEvents(int year, int month) async {
    try {
      final response = await _apiService.get('/calendar/events/month/$year/$month');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch month events: $e');
    }
  }

  /// Get events for a specific week
  Future<Map<String, dynamic>> getWeekEvents(int year, int week) async {
    try {
      final response = await _apiService.get('/calendar/events/week/$year/$week');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch week events: $e');
    }
  }

  /// Get upcoming events
  Future<List<CalendarEvent>> getUpcomingEvents({int limit = 10}) async {
    try {
      final response = await _apiService.get('/calendar/events/upcoming', queryParams: {'limit': limit});
      
      if (response.data['events'] != null) {
        final List<dynamic> eventsData = response.data['events'] as List<dynamic>;
        return eventsData.map((json) => CalendarEvent.fromJson(json as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch upcoming events: $e');
    }
  }

  /// Search events
  Future<List<CalendarEvent>> searchEvents(String query, {int limit = 20}) async {
    try {
      final response = await _apiService.get('/calendar/events/search', queryParams: {
        'q': query,
        'limit': limit,
      });
      
      if (response.data['results'] != null) {
        final List<dynamic> eventsData = response.data['results'] as List<dynamic>;
        return eventsData.map((json) => CalendarEvent.fromJson(json as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to search events: $e');
    }
  }

  /// RSVP to an event
  Future<void> rsvpToEvent(int eventId, String response) async {
    try {
      await _apiService.post('/calendar/events/$eventId/rsvp', queryParams: {'response': response});
    } catch (e) {
      throw Exception('Failed to RSVP to event: $e');
    }
  }

  /// Get calendars
  Future<List<CalendarModel>> getCalendars() async {
    try {
      final response = await _apiService.get('/calendar/calendars');
      
      if (response.data['data'] != null) {
        final List<dynamic> calendarsData = response.data['data'] as List<dynamic>;
        return calendarsData.map((json) => CalendarModel.fromJson(json as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch calendars: $e');
    }
  }

  /// Create a calendar
  Future<CalendarModel> createCalendar(CalendarModel calendar) async {
    try {
      final calendarData = calendar.toJson();
      calendarData.remove('id'); // Remove ID for creation
      
      final response = await _apiService.post('/calendar/calendars', data: calendarData);
      return CalendarModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to create calendar: $e');
    }
  }

  /// Update a calendar
  Future<CalendarModel> updateCalendar(int calendarId, CalendarModel calendar) async {
    try {
      final response = await _apiService.put('/calendar/calendars/$calendarId', data: calendar.toJson());
      return CalendarModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to update calendar: $e');
    }
  }

  /// Delete a calendar
  Future<void> deleteCalendar(int calendarId) async {
    try {
      await _apiService.delete('/calendar/calendars/$calendarId');
    } catch (e) {
      throw Exception('Failed to delete calendar: $e');
    }
  }

  /// Sync calendar with external provider
  Future<void> syncCalendar(int calendarId, String provider) async {
    try {
      await _apiService.post('/calendar/calendars/$calendarId/sync', data: {'provider': provider});
    } catch (e) {
      throw Exception('Failed to sync calendar: $e');
    }
  }

  /// Import events from external source
  Future<void> importEvents(String source, Map<String, dynamic> config) async {
    try {
      await _apiService.post('/calendar/import', data: {
        'source': source,
        'config': config,
      });
    } catch (e) {
      throw Exception('Failed to import events: $e');
    }
  }

  /// Export events to external format
  Future<String> exportEvents({
    String format = 'ical',
    DateTime? startDate,
    DateTime? endDate,
    List<int>? calendarIds,
  }) async {
    try {
      final data = <String, dynamic>{'format': format};
      
      if (startDate != null) {
        data['start_date'] = startDate.toIso8601String();
      }
      if (endDate != null) {
        data['end_date'] = endDate.toIso8601String();
      }
      if (calendarIds != null && calendarIds.isNotEmpty) {
        data['calendar_ids'] = calendarIds;
      }

      final response = await _apiService.post('/calendar/export', data: data);
      return response.data['export_url'] as String;
    } catch (e) {
      throw Exception('Failed to export events: $e');
    }
  }

  /// Get available time slots for scheduling
  Future<List<TimeSlot>> getAvailableSlots({
    required DateTime startDate,
    required DateTime endDate,
    required Duration duration,
    List<int>? calendarIds,
  }) async {
    try {
      final response = await _apiService.get('/calendar/availability', queryParams: {
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
        'duration': duration.inMinutes,
        if (calendarIds != null) 'calendar_ids': calendarIds.join(','),
      });
      
      if (response.data['slots'] != null) {
        final List<dynamic> slotsData = response.data['slots'] as List<dynamic>;
        return slotsData.map((json) => TimeSlot.fromJson(json as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch available slots: $e');
    }
  }

  /// Check for event conflicts
  Future<List<EventConflict>> checkConflicts(CalendarEvent event) async {
    try {
      final response = await _apiService.post('/calendar/conflicts', data: event.toJson());
      
      if (response.data['conflicts'] != null) {
        final List<dynamic> conflictsData = response.data['conflicts'] as List<dynamic>;
        return conflictsData.map((json) => EventConflict.fromJson(json as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to check conflicts: $e');
    }
  }

  /// Get calendar settings
  Future<CalendarSettings> getSettings() async {
    try {
      final response = await _apiService.get('/calendar/settings');
      return CalendarSettings.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to fetch settings: $e');
    }
  }

  /// Update calendar settings
  Future<CalendarSettings> updateSettings(CalendarSettings settings) async {
    try {
      final response = await _apiService.put('/calendar/settings', data: settings.toJson());
      return CalendarSettings.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to update settings: $e');
    }
  }

  /// Get event categories
  Future<List<EventCategory>> getCategories() async {
    try {
      final response = await _apiService.get('/calendar/categories');
      
      if (response.data['data'] != null) {
        final List<dynamic> categoriesData = response.data['data'] as List<dynamic>;
        return categoriesData.map((json) => EventCategory.fromJson(json as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  /// Create event category
  Future<EventCategory> createCategory(EventCategory category) async {
    try {
      final categoryData = category.toJson();
      categoryData.remove('id'); // Remove ID for creation
      
      final response = await _apiService.post('/calendar/categories', data: categoryData);
      return EventCategory.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to create category: $e');
    }
  }

  /// Update event category
  Future<EventCategory> updateCategory(int categoryId, EventCategory category) async {
    try {
      final response = await _apiService.put('/calendar/categories/$categoryId', data: category.toJson());
      return EventCategory.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to update category: $e');
    }
  }

  /// Delete event category
  Future<void> deleteCategory(int categoryId) async {
    try {
      await _apiService.delete('/calendar/categories/$categoryId');
    } catch (e) {
      throw Exception('Failed to delete category: $e');
    }
  }
}