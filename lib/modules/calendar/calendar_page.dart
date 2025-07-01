import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'models/simple_calendar_models.dart';
import 'providers/calendar_providers.dart';
import 'views/month_view.dart';
import 'views/week_view.dart';
import 'views/day_view.dart';
import 'views/agenda_view.dart';
import 'widgets/calendar_header.dart';
import 'widgets/calendar_sidebar.dart';
import 'widgets/event_form_dialog.dart';
import '../../core/utils/responsive.dart';

/// Main calendar page with view switching and responsive layout
class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentView = ref.watch(calendarViewProvider);
    final currentDate = ref.watch(calendarDateProvider);
    final isLargeScreen = Responsive.isLargeScreen(context);
    final isMediumScreen = Responsive.isMediumScreen(context);

    return Scaffold(
      body: Column(
        children: [
          // Calendar header with view controls and date navigation
          CalendarHeader(
            currentDate: currentDate,
            currentView: currentView,
            onDateChanged: (date) => ref.read(calendarDateProvider.notifier).state = date,
            onViewChanged: (view) => ref.read(calendarViewProvider.notifier).state = view,
            onTodayPressed: () => ref.read(calendarDateProvider.notifier).state = DateTime.now(),
            onCreateEvent: () => _showEventForm(context, ref),
          ),
          
          // Main calendar content
          Expanded(
            child: isLargeScreen || isMediumScreen
                ? Row(
                    children: [
                      // Sidebar with mini calendar and calendar list
                      if (isLargeScreen)
                        SizedBox(
                          width: 280,
                          child: CalendarSidebar(
                            onDateSelected: (date) => ref.read(calendarDateProvider.notifier).state = date,
                            onCreateEvent: () => _showEventForm(context, ref),
                          ),
                        ),
                      
                      // Divider
                      if (isLargeScreen)
                        const VerticalDivider(width: 1),
                      
                      // Main calendar view
                      Expanded(
                        child: _buildCalendarView(context, ref, currentView, currentDate),
                      ),
                    ],
                  )
                : _buildCalendarView(context, ref, currentView, currentDate),
          ),
        ],
      ),
      
      // Floating action button for creating events
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEventForm(context, ref),
        tooltip: 'Create Event',
        child: const Icon(Icons.add),
      ),
      
      // Bottom navigation for small screens
      bottomNavigationBar: !isLargeScreen && !isMediumScreen
          ? _buildBottomNavigation(context, ref, currentView)
          : null,
    );
  }

  /// Build the calendar view based on current view mode
  Widget _buildCalendarView(BuildContext context, WidgetRef ref, CalendarView view, DateTime date) {
    switch (view) {
      case CalendarView.month:
        return MonthView(
          currentDate: date,
          onDateSelected: (selectedDate) => ref.read(calendarDateProvider.notifier).state = selectedDate,
          onEventTapped: (event) => _showEventDetails(context, ref, event),
          onEventCreate: (startTime, endTime) => _showEventForm(context, ref, startTime: startTime, endTime: endTime),
        );
      
      case CalendarView.week:
        return WeekView(
          currentDate: date,
          onDateSelected: (selectedDate) => ref.read(calendarDateProvider.notifier).state = selectedDate,
          onEventTapped: (event) => _showEventDetails(context, ref, event),
          onEventCreate: (startTime, endTime) => _showEventForm(context, ref, startTime: startTime, endTime: endTime),
          onEventMoved: (event, newStartTime) => _moveEvent(ref, event, newStartTime),
        );
      
      case CalendarView.day:
        return DayView(
          currentDate: date,
          onEventTapped: (event) => _showEventDetails(context, ref, event),
          onEventCreate: (startTime, endTime) => _showEventForm(context, ref, startTime: startTime, endTime: endTime),
          onEventMoved: (event, newStartTime) => _moveEvent(ref, event, newStartTime),
        );
      
      case CalendarView.agenda:
        return AgendaView(
          currentDate: date,
          onEventTapped: (event) => _showEventDetails(context, ref, event),
          onDateSelected: (selectedDate) => ref.read(calendarDateProvider.notifier).state = selectedDate,
        );
      
      case CalendarView.year:
        // Year view could be implemented as a grid of mini months
        return const Center(
          child: Text('Year view coming soon!'),
        );
    }
  }

  /// Build bottom navigation for small screens
  Widget _buildBottomNavigation(BuildContext context, WidgetRef ref, CalendarView currentView) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _getViewIndex(currentView),
      onTap: (index) {
        final view = _getViewFromIndex(index);
        ref.read(calendarViewProvider.notifier).state = view;
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Month',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.view_week),
          label: 'Week',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.today),
          label: 'Day',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Agenda',
        ),
      ],
    );
  }

  /// Get index for bottom navigation
  int _getViewIndex(CalendarView view) {
    switch (view) {
      case CalendarView.month:
        return 0;
      case CalendarView.week:
        return 1;
      case CalendarView.day:
        return 2;
      case CalendarView.agenda:
        return 3;
      case CalendarView.year:
        return 0; // Default to month
    }
  }

  /// Get view from bottom navigation index
  CalendarView _getViewFromIndex(int index) {
    switch (index) {
      case 0:
        return CalendarView.month;
      case 1:
        return CalendarView.week;
      case 2:
        return CalendarView.day;
      case 3:
        return CalendarView.agenda;
      default:
        return CalendarView.month;
    }
  }

  /// Show event creation/editing form
  void _showEventForm(
    BuildContext context, 
    WidgetRef ref, {
    DateTime? startTime,
    DateTime? endTime,
    CalendarEvent? editEvent,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => EventFormDialog(
        initialStartTime: startTime,
        initialEndTime: endTime,
        editEvent: editEvent,
        onSave: (event) async {
          if (editEvent != null) {
            await ref.read(calendarEventsProvider.notifier).updateEvent(editEvent.id, event);
          } else {
            await ref.read(calendarEventsProvider.notifier).createEvent(event);
          }
          Navigator.of(context).pop();
        },
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }

  /// Show event details
  void _showEventDetails(BuildContext context, WidgetRef ref, CalendarEvent event) {
    showDialog(
      context: context,
      builder: (context) => EventDetailsDialog(
        event: event,
        onEdit: () {
          Navigator.of(context).pop();
          _showEventForm(context, ref, editEvent: event);
        },
        onDelete: () async {
          Navigator.of(context).pop();
          await ref.read(calendarEventsProvider.notifier).deleteEvent(event.id);
        },
      ),
    );
  }

  /// Move an event to a new time
  void _moveEvent(WidgetRef ref, CalendarEvent event, DateTime newStartTime) {
    ref.read(calendarEventsProvider.notifier).moveEvent(event.id, newStartTime);
  }
}

/// Event details dialog
class EventDetailsDialog extends StatelessWidget {
  const EventDetailsDialog({
    super.key,
    required this.event,
    required this.onEdit,
    required this.onDelete,
  });

  final CalendarEvent event;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: event.colorValue,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              event.title,
              style: theme.textTheme.titleLarge,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Date and time
            _buildDetailRow(
              icon: Icons.schedule,
              label: 'Time',
              value: event.allDay
                  ? 'All day • ${DateFormat('EEEE, MMMM d, y').format(event.startTime)}'
                  : '${DateFormat('EEEE, MMMM d, y').format(event.startTime)}\n${event.timeRange}',
            ),
            
            // Location
            if (event.location != null && event.location!.isNotEmpty)
              _buildDetailRow(
                icon: Icons.location_on,
                label: 'Location',
                value: event.location!,
              ),
            
            // Description
            if (event.description != null && event.description!.isNotEmpty)
              _buildDetailRow(
                icon: Icons.description,
                label: 'Description',
                value: event.description!,
              ),
            
            // Type
            _buildDetailRow(
              icon: event.type.icon,
              label: 'Type',
              value: event.type.displayName,
            ),
            
            // Priority
            _buildDetailRow(
              icon: event.priority.icon,
              label: 'Priority',
              value: event.priority.displayName,
              valueColor: event.priority.color,
            ),
            
            // Attendees
            if (event.attendees.isNotEmpty)
              _buildDetailRow(
                icon: Icons.people,
                label: 'Attendees',
                value: event.attendees.join(', '),
              ),
            
            // Meeting URL
            if (event.meetingUrl != null && event.meetingUrl!.isNotEmpty)
              _buildDetailRow(
                icon: Icons.videocam,
                label: 'Meeting URL',
                value: event.meetingUrl!,
                isLink: true,
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: onEdit,
          child: const Text('Edit'),
        ),
        TextButton(
          onPressed: () {
            // Show confirmation dialog
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete Event'),
                content: Text('Are you sure you want to delete "${event.title}"?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onDelete();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.error,
                    ),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
          },
          style: TextButton.styleFrom(
            foregroundColor: colorScheme.error,
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
    bool isLink = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: valueColor,
                    decoration: isLink ? TextDecoration.underline : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}