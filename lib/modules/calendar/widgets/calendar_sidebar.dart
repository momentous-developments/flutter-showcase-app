import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/simple_calendar_models.dart';
import '../providers/calendar_providers.dart';
import 'mini_calendar.dart';

/// Calendar sidebar with mini calendar and calendar list
class CalendarSidebar extends ConsumerWidget {
  const CalendarSidebar({
    super.key,
    required this.onDateSelected,
    required this.onCreateEvent,
  });

  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback onCreateEvent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final upcomingEventsAsync = ref.watch(upcomingEventsProvider);
    final calendarsAsync = ref.watch(calendarsProvider);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Create event button
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onCreateEvent,
                icon: const Icon(Icons.add),
                label: const Text('Create Event'),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Mini calendar
            MiniCalendar(
              onDateSelected: onDateSelected,
            ),
            
            const SizedBox(height: 24),
            
            // Upcoming events section
            Text(
              'Upcoming Events',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 12),
            
            upcomingEventsAsync.when(
              data: (events) => events.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'No upcoming events',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : Column(
                      children: events.map((event) => _buildUpcomingEventItem(
                        context,
                        event,
                        onDateSelected,
                      )).toList(),
                    ),
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stack) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Failed to load upcoming events',
                  style: TextStyle(color: colorScheme.error),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Calendars section
            Row(
              children: [
                Expanded(
                  child: Text(
                    'My Calendars',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _showCalendarManagement(context, ref),
                  icon: const Icon(Icons.settings),
                  iconSize: 20,
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  tooltip: 'Manage calendars',
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            calendarsAsync.when(
              data: (calendars) => Column(
                children: calendars.map((calendar) => _buildCalendarItem(
                  context,
                  ref,
                  calendar,
                )).toList(),
              ),
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stack) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Failed to load calendars',
                  style: TextStyle(color: colorScheme.error),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Add calendar button
            TextButton.icon(
              onPressed: () => _showAddCalendarDialog(context, ref),
              icon: const Icon(Icons.add),
              label: const Text('Add Calendar'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build upcoming event item
  Widget _buildUpcomingEventItem(
    BuildContext context,
    CalendarEvent event,
    ValueChanged<DateTime> onDateSelected,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: () => onDateSelected(event.startTime),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Color indicator
            Container(
              width: 12,
              height: 12,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: event.colorValue,
                shape: BoxShape.circle,
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Event details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 2),
                  
                  Text(
                    _formatEventTime(event),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build calendar item
  Widget _buildCalendarItem(
    BuildContext context,
    WidgetRef ref,
    CalendarModel calendar,
  ) {
    final theme = Theme.of(context);

    return CheckboxListTile(
      value: calendar.isVisible,
      onChanged: (value) {
        ref.read(calendarsProvider.notifier).toggleCalendarVisibility(calendar.id);
      },
      title: Text(
        calendar.name,
        style: theme.textTheme.bodyMedium,
      ),
      secondary: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: Color(int.parse(calendar.color.replaceAll('#', '0xFF'))),
          shape: BoxShape.circle,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      dense: true,
    );
  }

  /// Format event time for upcoming events
  String _formatEventTime(CalendarEvent event) {
    final now = DateTime.now();
    final startDate = event.startTime;
    
    if (event.allDay) {
      if (_isSameDay(startDate, now)) {
        return 'Today • All day';
      } else if (_isTomorrow(startDate, now)) {
        return 'Tomorrow • All day';
      } else {
        return '${DateFormat('MMM d').format(startDate)} • All day';
      }
    } else {
      final timeFormat = DateFormat('h:mm a');
      
      if (_isSameDay(startDate, now)) {
        return 'Today • ${timeFormat.format(startDate)}';
      } else if (_isTomorrow(startDate, now)) {
        return 'Tomorrow • ${timeFormat.format(startDate)}';
      } else {
        return '${DateFormat('MMM d').format(startDate)} • ${timeFormat.format(startDate)}';
      }
    }
  }

  /// Check if two dates are the same day
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  /// Check if date is tomorrow
  bool _isTomorrow(DateTime date, DateTime now) {
    final tomorrow = now.add(const Duration(days: 1));
    return _isSameDay(date, tomorrow);
  }

  /// Show calendar management dialog
  void _showCalendarManagement(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Manage Calendars'),
        content: const Text('Calendar management features coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  /// Show add calendar dialog
  void _showAddCalendarDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    Color selectedColor = Colors.blue;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add Calendar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Calendar Name',
                  hintText: 'Enter calendar name',
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Color picker
              Text(
                'Color',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              
              const SizedBox(height: 8),
              
              Wrap(
                spacing: 8,
                children: [
                  Colors.blue,
                  Colors.red,
                  Colors.green,
                  Colors.orange,
                  Colors.purple,
                  Colors.teal,
                  Colors.pink,
                  Colors.indigo,
                ].map((color) {
                  return InkWell(
                    onTap: () => setState(() => selectedColor = color),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: selectedColor == color
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  final calendar = CalendarModel(
                    id: 0, // Will be assigned by server
                    name: nameController.text,
                    color: '#${selectedColor.value.toRadixString(16).substring(2)}',
                  );
                  
                  ref.read(calendarsProvider.notifier).createCalendar(calendar);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}