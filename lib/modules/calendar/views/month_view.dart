import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/simple_calendar_models.dart';
import '../providers/calendar_providers.dart';
import '../widgets/event_card.dart';

/// Month view of the calendar with drag and drop support
class MonthView extends ConsumerStatefulWidget {
  const MonthView({
    super.key,
    required this.currentDate,
    required this.onDateSelected,
    required this.onEventTapped,
    required this.onEventCreate,
  });

  final DateTime currentDate;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<CalendarEvent> onEventTapped;
  final Function(DateTime startTime, DateTime endTime) onEventCreate;

  @override
  ConsumerState<MonthView> createState() => _MonthViewState();
}

class _MonthViewState extends ConsumerState<MonthView> {
  @override
  void initState() {
    super.initState();
    // Load events for the current month
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(calendarEventsProvider.notifier).loadMonthEvents(widget.currentDate);
    });
  }

  @override
  void didUpdateWidget(MonthView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentDate.month != widget.currentDate.month ||
        oldWidget.currentDate.year != widget.currentDate.year) {
      ref.read(calendarEventsProvider.notifier).loadMonthEvents(widget.currentDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final eventsAsync = ref.watch(calendarEventsProvider);
    final selectedDate = ref.watch(calendarDateProvider);
    final dragDropState = ref.watch(dragDropStateProvider);

    return Container(
      color: colorScheme.surface,
      child: Column(
        children: [
          // Week day headers
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              border: Border(
                bottom: BorderSide(
                  color: colorScheme.outline.withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: _getWeekDays().map((day) {
                return Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Calendar grid
          Expanded(
            child: eventsAsync.when(
              data: (events) => _buildCalendarGrid(
                context,
                events,
                selectedDate,
                dragDropState,
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load events',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.error,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => ref.refresh(calendarEventsProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Get week day headers
  List<String> _getWeekDays() {
    return ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  }

  /// Build the calendar grid
  Widget _buildCalendarGrid(
    BuildContext context,
    List<CalendarEvent> events,
    DateTime selectedDate,
    DragDropState dragDropState,
  ) {
    final firstDayOfMonth = DateTime(widget.currentDate.year, widget.currentDate.month, 1);
    final lastDayOfMonth = DateTime(widget.currentDate.year, widget.currentDate.month + 1, 0);
    
    // Calculate first day of the calendar grid (start of week containing first day of month)
    final firstDayOfCalendar = firstDayOfMonth.subtract(
      Duration(days: firstDayOfMonth.weekday - 1),
    );
    
    // Calculate last day of the calendar grid
    final lastDayOfCalendar = lastDayOfMonth.add(
      Duration(days: 7 - lastDayOfMonth.weekday),
    );
    
    final totalDays = lastDayOfCalendar.difference(firstDayOfCalendar).inDays + 1;
    final weeks = (totalDays / 7).ceil();
    
    return Column(
      children: List.generate(weeks, (weekIndex) {
        return Expanded(
          child: Row(
            children: List.generate(7, (dayIndex) {
              final dayOffset = weekIndex * 7 + dayIndex;
              final date = firstDayOfCalendar.add(Duration(days: dayOffset));
              final dayEvents = events.where((event) => event.occursOnDate(date)).toList();
              
              return Expanded(
                child: _buildDayCell(
                  context,
                  date,
                  dayEvents,
                  selectedDate,
                  dragDropState,
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  /// Build individual day cell
  Widget _buildDayCell(
    BuildContext context,
    DateTime date,
    List<CalendarEvent> events,
    DateTime selectedDate,
    DragDropState dragDropState,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final isToday = _isToday(date);
    final isSelected = _isSameDay(date, selectedDate);
    final isCurrentMonth = date.month == widget.currentDate.month;
    final isDropTarget = dragDropState.isDragging && 
                         dragDropState.dropTargetDate != null &&
                         _isSameDay(date, dragDropState.dropTargetDate!);
    
    return DragTarget<CalendarEvent>(
      onWillAcceptWithDetails: (details) {
        ref.read(dragDropStateProvider.notifier).updateDropTarget(date);
        return true;
      },
      onLeave: (data) {
        ref.read(dragDropStateProvider.notifier).updateDropTarget(null);
      },
      onAcceptWithDetails: (details) {
        final event = details.data;
        final newStartTime = DateTime(
          date.year,
          date.month,
          date.day,
          event.startTime.hour,
          event.startTime.minute,
        );
        
        ref.read(calendarEventsProvider.notifier).moveEvent(event.id, newStartTime);
        ref.read(dragDropStateProvider.notifier).endDrag();
      },
      builder: (context, candidateData, rejectedData) {
        return GestureDetector(
          onTap: () => widget.onDateSelected(date),
          onDoubleTap: () => _createEventForDate(date),
          child: Container(
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: isDropTarget
                  ? colorScheme.primaryContainer.withOpacity(0.3)
                  : null,
              border: Border.all(
                color: colorScheme.outline.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Day number header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? colorScheme.primary
                              : isToday
                                  ? colorScheme.primaryContainer
                                  : null,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${date.day}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isSelected
                                ? colorScheme.onPrimary
                                : isToday
                                    ? colorScheme.onPrimaryContainer
                                    : isCurrentMonth
                                        ? colorScheme.onSurface
                                        : colorScheme.onSurfaceVariant.withOpacity(0.5),
                            fontWeight: isToday || isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ),
                      
                      const Spacer(),
                      
                      // Add event button (on hover)
                      if (isCurrentMonth)
                        MouseRegion(
                          child: GestureDetector(
                            onTap: () => _createEventForDate(date),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              child: Icon(
                                Icons.add,
                                size: 16,
                                color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                
                // Events list
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      children: [
                        ...events.take(3).map((event) => Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: _buildEventChip(context, event),
                        )),
                        
                        // More events indicator
                        if (events.length > 3)
                          GestureDetector(
                            onTap: () => _showMoreEvents(context, date, events),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                              child: Text(
                                '+${events.length - 3} more',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Build event chip for month view
  Widget _buildEventChip(BuildContext context, CalendarEvent event) {
    final theme = Theme.of(context);
    
    return Draggable<CalendarEvent>(
      data: event,
      feedback: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: 120,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: event.colorValue,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            event.title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      childWhenDragging: Container(
        height: 20,
        decoration: BoxDecoration(
          color: event.colorValue.withOpacity(0.3),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onDragStarted: () {
        ref.read(dragDropStateProvider.notifier).startDrag(event);
      },
      onDragEnd: (details) {
        ref.read(dragDropStateProvider.notifier).endDrag();
      },
      child: GestureDetector(
        onTap: () => widget.onEventTapped(event),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: event.colorValue,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            event.allDay ? event.title : '${DateFormat('HH:mm').format(event.startTime)} ${event.title}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  /// Create event for specific date
  void _createEventForDate(DateTime date) {
    final startTime = DateTime(date.year, date.month, date.day, 9, 0);
    final endTime = startTime.add(const Duration(hours: 1));
    widget.onEventCreate(startTime, endTime);
  }

  /// Show more events dialog
  void _showMoreEvents(BuildContext context, DateTime date, List<CalendarEvent> events) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(DateFormat('EEEE, MMMM d').format(date)),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return ListTile(
                dense: true,
                leading: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: event.colorValue,
                    shape: BoxShape.circle,
                  ),
                ),
                title: Text(event.title),
                subtitle: Text(event.timeRange),
                onTap: () {
                  Navigator.of(context).pop();
                  widget.onEventTapped(event);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  /// Check if date is today
  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return _isSameDay(date, now);
  }

  /// Check if two dates are the same day
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }
}