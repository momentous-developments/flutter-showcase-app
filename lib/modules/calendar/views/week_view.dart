import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/simple_calendar_models.dart';
import '../providers/calendar_providers.dart';
import '../widgets/event_card.dart';

/// Week view of the calendar with time slots and event scheduling
class WeekView extends ConsumerStatefulWidget {
  const WeekView({
    super.key,
    required this.currentDate,
    required this.onDateSelected,
    required this.onEventTapped,
    required this.onEventCreate,
    required this.onEventMoved,
  });

  final DateTime currentDate;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<CalendarEvent> onEventTapped;
  final Function(DateTime startTime, DateTime endTime) onEventCreate;
  final Function(CalendarEvent event, DateTime newStartTime) onEventMoved;

  @override
  ConsumerState<WeekView> createState() => _WeekViewState();
}

class _WeekViewState extends ConsumerState<WeekView> {
  final ScrollController _scrollController = ScrollController();
  static const double _hourHeight = 60.0;
  static const double _dayColumnWidth = 120.0;
  
  late DateTime _weekStart;
  late DateTime _weekEnd;

  @override
  void initState() {
    super.initState();
    _calculateWeekRange();
    
    // Scroll to work day start (9 AM)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        9 * _hourHeight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void didUpdateWidget(WeekView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentDate != widget.currentDate) {
      _calculateWeekRange();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _calculateWeekRange() {
    final weekday = widget.currentDate.weekday;
    _weekStart = widget.currentDate.subtract(Duration(days: weekday - 1));
    _weekEnd = _weekStart.add(const Duration(days: 6));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final eventsAsync = ref.watch(calendarEventsProvider);
    final selectedDate = ref.watch(calendarDateProvider);

    return Container(
      color: colorScheme.surface,
      child: Column(
        children: [
          // Week header with dates
          _buildWeekHeader(theme, colorScheme, selectedDate),
          
          // Time slots and events
          Expanded(
            child: eventsAsync.when(
              data: (events) => _buildWeekGrid(context, events),
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

  /// Build week header with day columns
  Widget _buildWeekHeader(ThemeData theme, ColorScheme colorScheme, DateTime selectedDate) {
    return Container(
      height: 80,
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
        children: [
          // Time column placeholder
          SizedBox(
            width: 60,
            child: Center(
              child: Text(
                'GMT',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          
          // Day columns
          ...List.generate(7, (index) {
            final date = _weekStart.add(Duration(days: index));
            final isToday = _isToday(date);
            final isSelected = _isSameDay(date, selectedDate);
            
            return Expanded(
              child: GestureDetector(
                onTap: () => widget.onDateSelected(date),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colorScheme.primaryContainer.withOpacity(0.3)
                        : null,
                    border: Border(
                      left: BorderSide(
                        color: colorScheme.outline.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('E').format(date),
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      const SizedBox(height: 4),
                      
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? colorScheme.primary
                              : isToday
                                  ? colorScheme.primaryContainer
                                  : null,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${date.day}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isSelected
                                  ? colorScheme.onPrimary
                                  : isToday
                                      ? colorScheme.onPrimaryContainer
                                      : colorScheme.onSurface,
                              fontWeight: isToday || isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  /// Build week grid with time slots
  Widget _buildWeekGrid(BuildContext context, List<CalendarEvent> events) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Filter events for this week
    final weekEvents = events.where((event) {
      return event.startTime.isAfter(_weekStart.subtract(const Duration(days: 1))) &&
             event.startTime.isBefore(_weekEnd.add(const Duration(days: 1)));
    }).toList();

    return Row(
      children: [
        // Time column
        SizedBox(
          width: 60,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: List.generate(24, (hour) {
                return Container(
                  height: _hourHeight,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    DateFormat('HH:mm').format(DateTime(2023, 1, 1, hour)),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        
        // Day columns with events
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Stack(
              children: [
                // Background grid
                Column(
                  children: List.generate(24, (hour) {
                    return Container(
                      height: _hourHeight,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: colorScheme.outline.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: List.generate(7, (dayIndex) {
                          final date = _weekStart.add(Duration(days: dayIndex));
                          
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => _createEventAtTime(date, hour),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: colorScheme.outline.withOpacity(0.1),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: DragTarget<CalendarEvent>(
                                  onWillAcceptWithDetails: (details) => true,
                                  onAcceptWithDetails: (details) {
                                    final event = details.data;
                                    final newStartTime = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      hour,
                                      0,
                                    );
                                    widget.onEventMoved(event, newStartTime);
                                  },
                                  builder: (context, candidateData, rejectedData) {
                                    return Container(
                                      height: _hourHeight,
                                      color: candidateData.isNotEmpty
                                          ? colorScheme.primaryContainer.withOpacity(0.2)
                                          : Colors.transparent,
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  }),
                ),
                
                // Events overlay
                ...weekEvents.map((event) => _buildEventBlock(context, event)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Build event block positioned in the grid
  Widget _buildEventBlock(BuildContext context, CalendarEvent event) {
    final dayIndex = event.startTime.difference(_weekStart).inDays;
    
    if (dayIndex < 0 || dayIndex >= 7) {
      return const SizedBox.shrink();
    }
    
    final startHour = event.startTime.hour + event.startTime.minute / 60.0;
    final duration = event.duration;
    final heightInHours = duration.inMinutes / 60.0;
    
    final left = 60.0 + (dayIndex * (_dayColumnWidth + 1));
    final top = startHour * _hourHeight;
    final height = heightInHours * _hourHeight;
    final width = _dayColumnWidth - 4;
    
    return Positioned(
      left: left + 2,
      top: top,
      width: width,
      height: height.clamp(20.0, double.infinity),
      child: DraggableEventCard(
        event: event,
        onDragStarted: () {},
        onDragEnd: () {},
        onTap: () => widget.onEventTapped(event),
        child: EventChip(
          event: event,
          onTap: () => widget.onEventTapped(event),
          height: height.clamp(20.0, double.infinity),
          width: width,
        ),
      ),
    );
  }

  /// Create event at specific time
  void _createEventAtTime(DateTime date, int hour) {
    final startTime = DateTime(date.year, date.month, date.day, hour, 0);
    final endTime = startTime.add(const Duration(hours: 1));
    widget.onEventCreate(startTime, endTime);
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