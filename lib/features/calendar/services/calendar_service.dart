import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/calendar_models.dart';

class CalendarService {
  final _uuid = const Uuid();
  
  // Mock data storage
  final List<Calendar> _calendars = [];
  final List<CalendarEvent> _events = [];
  
  CalendarService() {
    _initializeMockData();
  }

  void _initializeMockData() {
    // Create default calendars
    final personalCalendar = Calendar(
      id: _uuid.v4(),
      name: 'Personal',
      description: 'Personal events and reminders',
      color: Colors.blue,
      isDefault: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    final workCalendar = Calendar(
      id: _uuid.v4(),
      name: 'Work',
      description: 'Work meetings and deadlines',
      color: Colors.green,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    final familyCalendar = Calendar(
      id: _uuid.v4(),
      name: 'Family',
      description: 'Family events and birthdays',
      color: Colors.purple,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    _calendars.addAll([personalCalendar, workCalendar, familyCalendar]);
    
    // Create sample events
    final now = DateTime.now();
    
    _events.addAll([
      CalendarEvent(
        id: _uuid.v4(),
        title: 'Team Meeting',
        start: DateTime(now.year, now.month, now.day, 10, 0),
        end: DateTime(now.year, now.month, now.day, 11, 0),
        description: 'Weekly team sync meeting',
        location: 'Conference Room A',
        calendarId: workCalendar.id,
        category: EventCategory.meeting,
        priority: EventPriority.normal,
        attendees: ['john@example.com', 'jane@example.com'],
        reminders: [
          const EventReminder(
            type: ReminderType.notification,
            minutesBefore: 15,
          ),
        ],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CalendarEvent(
        id: _uuid.v4(),
        title: 'Project Deadline',
        start: DateTime(now.year, now.month, now.day + 3, 17, 0),
        end: DateTime(now.year, now.month, now.day + 3, 17, 0),
        description: 'Submit final project deliverables',
        calendarId: workCalendar.id,
        category: EventCategory.deadline,
        priority: EventPriority.high,
        reminders: [
          const EventReminder(
            type: ReminderType.notification,
            minutesBefore: 60,
          ),
          const EventReminder(
            type: ReminderType.notification,
            minutesBefore: 1440, // 1 day before
          ),
        ],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CalendarEvent(
        id: _uuid.v4(),
        title: 'Birthday Party',
        start: DateTime(now.year, now.month, now.day + 5, 18, 0),
        end: DateTime(now.year, now.month, now.day + 5, 22, 0),
        description: 'Sarah\'s birthday celebration',
        location: 'Home',
        calendarId: familyCalendar.id,
        category: EventCategory.birthday,
        priority: EventPriority.normal,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CalendarEvent(
        id: _uuid.v4(),
        title: 'Gym Session',
        start: DateTime(now.year, now.month, now.day + 1, 7, 0),
        end: DateTime(now.year, now.month, now.day + 1, 8, 0),
        description: 'Morning workout',
        location: 'Fitness Center',
        calendarId: personalCalendar.id,
        category: EventCategory.personal,
        priority: EventPriority.normal,
        recurrenceRule: const RecurrenceRule(
          frequency: RecurrenceFrequency.weekly,
          byWeekDay: [1, 3, 5], // Mon, Wed, Fri
        ),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CalendarEvent(
        id: _uuid.v4(),
        title: 'Annual Company Holiday',
        start: DateTime(now.year, now.month + 1, 15),
        end: DateTime(now.year, now.month + 1, 15),
        isAllDay: true,
        description: 'Company-wide holiday',
        calendarId: workCalendar.id,
        category: EventCategory.holiday,
        priority: EventPriority.low,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ]);
  }

  // Calendar CRUD operations
  Future<List<Calendar>> getCalendars() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_calendars);
  }

  Future<Calendar> createCalendar(Calendar calendar) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final newCalendar = calendar.copyWith(
      id: _uuid.v4(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _calendars.add(newCalendar);
    return newCalendar;
  }

  Future<Calendar> updateCalendar(Calendar calendar) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _calendars.indexWhere((c) => c.id == calendar.id);
    if (index != -1) {
      final updatedCalendar = calendar.copyWith(updatedAt: DateTime.now());
      _calendars[index] = updatedCalendar;
      return updatedCalendar;
    }
    throw Exception('Calendar not found');
  }

  Future<void> deleteCalendar(String calendarId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _calendars.removeWhere((c) => c.id == calendarId);
    _events.removeWhere((e) => e.calendarId == calendarId);
  }

  // Event CRUD operations
  Future<List<CalendarEvent>> getEvents({
    DateTime? startDate,
    DateTime? endDate,
    String? calendarId,
    EventCategory? category,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    var events = List.from(_events);
    
    if (calendarId != null) {
      events = events.where((e) => e.calendarId == calendarId).toList();
    }
    
    if (category != null) {
      events = events.where((e) => e.category == category).toList();
    }
    
    if (startDate != null && endDate != null) {
      events = events.where((e) => 
        e.start.isAfter(startDate.subtract(const Duration(days: 1))) &&
        e.start.isBefore(endDate.add(const Duration(days: 1)))
      ).toList();
    }
    
    // Sort by start date
    events.sort((a, b) => a.start.compareTo(b.start));
    
    return events.cast<CalendarEvent>();
  }

  Future<CalendarEvent> createEvent(CalendarEvent event) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final newEvent = event.copyWith(
      id: _uuid.v4(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _events.add(newEvent);
    
    // Handle recurring events
    if (event.recurrenceRule != null) {
      _generateRecurringEvents(newEvent);
    }
    
    return newEvent;
  }

  Future<CalendarEvent> updateEvent(CalendarEvent event) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _events.indexWhere((e) => e.id == event.id);
    if (index != -1) {
      final updatedEvent = event.copyWith(updatedAt: DateTime.now());
      _events[index] = updatedEvent;
      return updatedEvent;
    }
    throw Exception('Event not found');
  }

  Future<void> deleteEvent(String eventId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _events.removeWhere((e) => e.id == eventId);
  }

  Future<void> deleteRecurringEvent(String recurringEventId, {bool deleteAll = false}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (deleteAll) {
      _events.removeWhere((e) => e.recurringEventId == recurringEventId || e.id == recurringEventId);
    } else {
      _events.removeWhere((e) => e.id == recurringEventId);
    }
  }

  // Export/Import functionality
  Future<String> exportEvents({DateTime? startDate, DateTime? endDate}) async {
    final events = await getEvents(startDate: startDate, endDate: endDate);
    final data = events.map((e) => e.toJson()).toList();
    return jsonEncode(data);
  }

  Future<void> importEvents(String jsonData) async {
    try {
      final List<dynamic> data = jsonDecode(jsonData);
      final events = data.map((e) => CalendarEvent.fromJson(e)).toList();
      
      for (final event in events) {
        await createEvent(event);
      }
    } catch (e) {
      throw Exception('Failed to import events: $e');
    }
  }

  // Helper methods
  void _generateRecurringEvents(CalendarEvent baseEvent) {
    final rule = baseEvent.recurrenceRule!;
    final maxOccurrences = rule.count ?? 52; // Default to 1 year of weekly events
    final endDate = rule.until ?? DateTime.now().add(const Duration(days: 365));
    
    var currentDate = baseEvent.start;
    var occurrenceCount = 0;
    
    while (occurrenceCount < maxOccurrences && currentDate.isBefore(endDate)) {
      switch (rule.frequency) {
        case RecurrenceFrequency.daily:
          currentDate = currentDate.add(Duration(days: rule.interval));
          break;
        case RecurrenceFrequency.weekly:
          currentDate = currentDate.add(Duration(days: 7 * rule.interval));
          break;
        case RecurrenceFrequency.monthly:
          currentDate = DateTime(
            currentDate.year,
            currentDate.month + rule.interval,
            currentDate.day,
            currentDate.hour,
            currentDate.minute,
          );
          break;
        case RecurrenceFrequency.yearly:
          currentDate = DateTime(
            currentDate.year + rule.interval,
            currentDate.month,
            currentDate.day,
            currentDate.hour,
            currentDate.minute,
          );
          break;
      }
      
      if (currentDate.isAfter(baseEvent.start) && currentDate.isBefore(endDate)) {
        final duration = baseEvent.end.difference(baseEvent.start);
        final recurringEvent = baseEvent.copyWith(
          id: _uuid.v4(),
          start: currentDate,
          end: currentDate.add(duration),
          recurringEventId: baseEvent.id,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        _events.add(recurringEvent);
        occurrenceCount++;
      }
    }
  }

  // Get events for a specific date
  Future<List<CalendarEvent>> getEventsForDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    return getEvents(startDate: startOfDay, endDate: endOfDay);
  }

  // Get upcoming events
  Future<List<CalendarEvent>> getUpcomingEvents({int limit = 10}) async {
    final now = DateTime.now();
    final events = await getEvents(startDate: now);
    return events.take(limit).toList();
  }

  // Search events
  Future<List<CalendarEvent>> searchEvents(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final lowercaseQuery = query.toLowerCase();
    
    return _events.where((event) {
      return event.title.toLowerCase().contains(lowercaseQuery) ||
             (event.description?.toLowerCase().contains(lowercaseQuery) ?? false) ||
             (event.location?.toLowerCase().contains(lowercaseQuery) ?? false);
    }).toList();
  }
}