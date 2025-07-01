import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/calendar_providers.dart';
import '../models/calendar_models.dart';
import '../widgets/event_card.dart';
import '../widgets/event_detail_dialog.dart';

class WeekView extends ConsumerStatefulWidget {
  const WeekView({super.key});

  @override
  ConsumerState<WeekView> createState() => _WeekViewState();
}

class _WeekViewState extends ConsumerState<WeekView> {
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  static const double _hourHeight = 60.0;
  static const double _dayWidth = 150.0;

  @override
  void initState() {
    super.initState();
    // Scroll to current time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentTime();
    });
  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentTime() {
    final now = DateTime.now();
    final scrollPosition = (now.hour * _hourHeight) - 100;
    _verticalScrollController.animateTo(
      scrollPosition.clamp(0, _verticalScrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedDate = ref.watch(selectedDateProvider);
    final dateRange = ref.watch(dateRangeProvider);
    final eventsAsync = ref.watch(eventsProvider(dateRange));

    // Calculate week dates
    final weekStart = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final weekDates = List.generate(7, (index) => weekStart.add(Duration(days: index)));

    return eventsAsync.when(
      data: (events) {
        // Group events by date and time
        final eventsByDate = <DateTime, List<CalendarEvent>>{};
        for (final event in events) {
          final date = DateTime(event.start.year, event.start.month, event.start.day);
          eventsByDate[date] ??= [];
          eventsByDate[date]!.add(event);
        }

        return Column(
          children: [
            // Header with day names and dates
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(
                  bottom: BorderSide(
                    color: theme.colorScheme.outlineVariant,
                  ),
                ),
              ),
              child: Row(
                children: [
                  // Time column header
                  Container(
                    width: 60,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                    ),
                  ),
                  // Days header
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _horizontalScrollController,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: weekDates.map((date) {
                          final isToday = _isToday(date);
                          final isSelected = _isSameDay(date, selectedDate);
                          
                          return Container(
                            width: _dayWidth,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? theme.colorScheme.primaryContainer
                                  : null,
                              border: Border(
                                right: BorderSide(
                                  color: theme.colorScheme.outlineVariant,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('EEE').format(date),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: isToday
                                        ? theme.colorScheme.primary
                                        : null,
                                    fontWeight: isToday
                                        ? FontWeight.bold
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: isToday
                                        ? theme.colorScheme.primary
                                        : null,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    date.day.toString(),
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      color: isToday
                                          ? theme.colorScheme.onPrimary
                                          : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Calendar grid
            Expanded(
              child: Row(
                children: [
                  // Time column
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      border: Border(
                        right: BorderSide(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                    ),
                    child: SingleChildScrollView(
                      controller: _verticalScrollController,
                      child: Column(
                        children: List.generate(24, (hour) {
                          return Container(
                            height: _hourHeight,
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              DateFormat('ha').format(
                                DateTime(2024, 1, 1, hour),
                              ),
                              style: theme.textTheme.bodySmall,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  // Days grid
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _horizontalScrollController,
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: _dayWidth * 7,
                        child: Stack(
                          children: [
                            // Grid lines and day columns
                            Row(
                              children: weekDates.map((date) {
                                return Container(
                                  width: _dayWidth,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: theme.colorScheme.outlineVariant,
                                      ),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    controller: _verticalScrollController,
                                    child: Column(
                                      children: List.generate(24, (hour) {
                                        return GestureDetector(
                                          onTap: () => _createEvent(date, hour),
                                          child: Container(
                                            height: _hourHeight,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: theme.colorScheme.outlineVariant.withOpacity(0.3),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            // Events overlay
                            ...weekDates.asMap().entries.map((entry) {
                              final dayIndex = entry.key;
                              final date = entry.value;
                              final dayEvents = eventsByDate[DateTime(date.year, date.month, date.day)] ?? [];
                              
                              return Positioned(
                                left: dayIndex * _dayWidth,
                                top: 0,
                                width: _dayWidth,
                                bottom: 0,
                                child: SingleChildScrollView(
                                  controller: _verticalScrollController,
                                  child: Stack(
                                    children: dayEvents.map((event) {
                                      if (event.isAllDay) {
                                        return Container(); // Handle all-day events in header
                                      }
                                      
                                      final startMinutes = event.start.hour * 60 + event.start.minute;
                                      final endMinutes = event.end.hour * 60 + event.end.minute;
                                      final top = startMinutes * _hourHeight / 60;
                                      final height = (endMinutes - startMinutes) * _hourHeight / 60;
                                      
                                      return Positioned(
                                        top: top,
                                        left: 4,
                                        right: 4,
                                        height: height.clamp(20, double.infinity),
                                        child: _buildEventBlock(event),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            }).toList(),
                            // Current time indicator
                            if (_isCurrentWeek(weekStart)) _buildCurrentTimeIndicator(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildEventBlock(CalendarEvent event) {
    final theme = Theme.of(context);
    final duration = event.end.difference(event.start).inMinutes;
    final isShort = duration < 60;
    
    return GestureDetector(
      onTap: () => _showEventDetail(event),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: event.category.color.withOpacity(0.8),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: event.category.color,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: isShort ? 1 : 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (!isShort && event.location != null) ...[
              const SizedBox(height: 2),
              Text(
                event.location!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 10,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentTimeIndicator() {
    final now = DateTime.now();
    final dayIndex = now.weekday - 1;
    final minutes = now.hour * 60 + now.minute;
    final top = minutes * _hourHeight / 60;
    
    return Positioned(
      left: dayIndex * _dayWidth,
      top: top,
      right: (6 - dayIndex) * _dayWidth,
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Container(
              height: 2,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isCurrentWeek(DateTime weekStart) {
    final now = DateTime.now();
    final currentWeekStart = now.subtract(Duration(days: now.weekday - 1));
    return _isSameDay(weekStart, currentWeekStart);
  }

  void _createEvent(DateTime date, int hour) {
    final eventStart = DateTime(date.year, date.month, date.day, hour);
    ref.read(eventFormStateProvider.notifier).reset();
    ref.read(eventFormStateProvider.notifier).updateStart(eventStart);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const EventDetailDialog(),
    );
  }

  void _showEventDetail(CalendarEvent event) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => EventDetailDialog(event: event),
    );
  }
}