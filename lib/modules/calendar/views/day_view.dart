import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/simple_calendar_models.dart';
import '../providers/calendar_providers.dart';
import '../widgets/event_card.dart';

/// Day view of the calendar with detailed timeline
class DayView extends ConsumerStatefulWidget {
  const DayView({
    super.key,
    required this.currentDate,
    required this.onEventTapped,
    required this.onEventCreate,
    required this.onEventMoved,
  });

  final DateTime currentDate;
  final ValueChanged<CalendarEvent> onEventTapped;
  final Function(DateTime startTime, DateTime endTime) onEventCreate;
  final Function(CalendarEvent event, DateTime newStartTime) onEventMoved;

  @override
  ConsumerState<DayView> createState() => _DayViewState();
}

class _DayViewState extends ConsumerState<DayView> {
  final ScrollController _scrollController = ScrollController();
  static const double _hourHeight = 80.0;
  static const double _timeColumnWidth = 80.0;
  
  @override
  void initState() {
    super.initState();
    
    // Scroll to work day start (8 AM)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        8 * _hourHeight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final eventsAsync = ref.watch(calendarEventsProvider);

    return Container(
      color: colorScheme.surface,
      child: Column(
        children: [
          // Day header
          _buildDayHeader(theme, colorScheme),
          
          // Timeline
          Expanded(
            child: eventsAsync.when(
              data: (events) => _buildTimeline(context, events),
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

  /// Build day header
  Widget _buildDayHeader(ThemeData theme, ColorScheme colorScheme) {
    final isToday = _isToday(widget.currentDate);

    return Container(
      height: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('EEEE').format(widget.currentDate),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: isToday ? colorScheme.primary : colorScheme.onSurface,
            ),
          ),
          
          const SizedBox(height: 4),
          
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isToday ? colorScheme.primary : colorScheme.outline.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  DateFormat('MMMM d, y').format(widget.currentDate),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isToday ? colorScheme.onPrimary : colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              
              const Spacer(),
              
              // Weather info (placeholder)
              if (isToday)
                Row(
                  children: [
                    Icon(
                      Icons.wb_sunny,
                      size: 20,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '22°C',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build timeline with events
  Widget _buildTimeline(BuildContext context, List<CalendarEvent> events) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Filter events for this day
    final dayEvents = events.where((event) => event.occursOnDate(widget.currentDate)).toList();
    dayEvents.sort((a, b) => a.startTime.compareTo(b.startTime));

    return Row(
      children: [
        // Time column
        SizedBox(
          width: _timeColumnWidth,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: List.generate(24, (hour) {
                final now = DateTime.now();
                final isCurrentHour = _isToday(widget.currentDate) && 
                                    hour == now.hour;
                
                return Container(
                  height: _hourHeight,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                    color: isCurrentHour 
                        ? colorScheme.primaryContainer.withOpacity(0.1)
                        : null,
                  ),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('HH:mm').format(DateTime(2023, 1, 1, hour)),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isCurrentHour 
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                          fontWeight: isCurrentHour ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                      
                      if (hour < 23)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          height: 1,
                          width: 40,
                          color: colorScheme.outline.withOpacity(0.3),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
        
        // Events column
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Stack(
              children: [
                // Background grid
                Column(
                  children: List.generate(24, (hour) {
                    final now = DateTime.now();
                    final isCurrentHour = _isToday(widget.currentDate) && 
                                        hour == now.hour;
                    
                    return GestureDetector(
                      onTap: () => _createEventAtTime(hour),
                      child: Container(
                        height: _hourHeight,
                        decoration: BoxDecoration(
                          color: isCurrentHour 
                              ? colorScheme.primaryContainer.withOpacity(0.05)
                              : null,
                          border: Border(
                            top: BorderSide(
                              color: colorScheme.outline.withOpacity(0.1),
                              width: 1,
                            ),
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
                              widget.currentDate.year,
                              widget.currentDate.month,
                              widget.currentDate.day,
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
                              child: candidateData.isEmpty
                                  ? Center(
                                      child: Icon(
                                        Icons.add,
                                        color: colorScheme.onSurfaceVariant.withOpacity(0.3),
                                        size: 16,
                                      ),
                                    )
                                  : null,
                            );
                          },
                        ),
                      ),
                    );
                  }),
                ),
                
                // Current time indicator
                if (_isToday(widget.currentDate))
                  _buildCurrentTimeIndicator(colorScheme),
                
                // All-day events
                if (dayEvents.any((event) => event.allDay))
                  _buildAllDayEvents(context, dayEvents.where((e) => e.allDay).toList()),
                
                // Timed events
                ...dayEvents.where((event) => !event.allDay).map((event) => 
                  _buildEventBlock(context, event)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Build current time indicator
  Widget _buildCurrentTimeIndicator(ColorScheme colorScheme) {
    final now = DateTime.now();
    final hourProgress = now.hour + now.minute / 60.0;
    final top = hourProgress * _hourHeight;
    
    return Positioned(
      left: 0,
      top: top,
      right: 0,
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: colorScheme.error,
              shape: BoxShape.circle,
            ),
          ),
          
          Expanded(
            child: Container(
              height: 2,
              color: colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }

  /// Build all-day events section
  Widget _buildAllDayEvents(BuildContext context, List<CalendarEvent> allDayEvents) {
    if (allDayEvents.isEmpty) return const SizedBox.shrink();
    
    final theme = Theme.of(context);
    
    return Positioned(
      top: 0,
      left: 8,
      right: 8,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All Day',
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            
            const SizedBox(height: 4),
            
            ...allDayEvents.map((event) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: EventCard(
                event: event,
                onTap: () => widget.onEventTapped(event),
                compact: true,
                showTime: false,
              ),
            )),
          ],
        ),
      ),
    );
  }

  /// Build event block positioned in the timeline
  Widget _buildEventBlock(BuildContext context, CalendarEvent event) {
    final startHour = event.startTime.hour + event.startTime.minute / 60.0;
    final duration = event.duration;
    final heightInHours = duration.inMinutes / 60.0;
    
    final top = startHour * _hourHeight;
    final height = (heightInHours * _hourHeight).clamp(30.0, double.infinity);
    
    return Positioned(
      left: 8,
      top: top,
      right: 8,
      height: height,
      child: DraggableEventCard(
        event: event,
        onDragStarted: () {},
        onDragEnd: () {},
        onTap: () => widget.onEventTapped(event),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: event.colorValue,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 4),
                
                Text(
                  event.timeRange,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                
                if (event.location != null && 
                    event.location!.isNotEmpty && 
                    height > 60) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.location!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                
                if (event.attendees.isNotEmpty && height > 80) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.people,
                        color: Colors.white,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${event.attendees.length} attendees',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Create event at specific time
  void _createEventAtTime(int hour) {
    final startTime = DateTime(
      widget.currentDate.year,
      widget.currentDate.month,
      widget.currentDate.day,
      hour,
      0,
    );
    final endTime = startTime.add(const Duration(hours: 1));
    widget.onEventCreate(startTime, endTime);
  }

  /// Check if date is today
  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
           date.month == now.month &&
           date.day == now.day;
  }
}