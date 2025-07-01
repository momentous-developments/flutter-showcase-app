import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/calendar_providers.dart';
import '../models/calendar_models.dart';
import '../widgets/event_detail_dialog.dart';

class DayView extends ConsumerStatefulWidget {
  const DayView({super.key});

  @override
  ConsumerState<DayView> createState() => _DayViewState();
}

class _DayViewState extends ConsumerState<DayView> {
  final ScrollController _scrollController = ScrollController();
  static const double _hourHeight = 80.0;

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
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentTime() {
    final now = DateTime.now();
    final scrollPosition = (now.hour * _hourHeight) - 200;
    _scrollController.animateTo(
      scrollPosition.clamp(0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedDate = ref.watch(selectedDateProvider);
    final eventsAsync = ref.watch(eventsForSelectedDateProvider);
    final isToday = _isToday(selectedDate);

    return Column(
      children: [
        // Date header
        Container(
          padding: const EdgeInsets.all(16),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('EEEE').format(selectedDate),
                    style: theme.textTheme.headlineSmall,
                  ),
                  Text(
                    DateFormat('MMMM d, yyyy').format(selectedDate),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (isToday)
                Chip(
                  label: const Text('Today'),
                  backgroundColor: theme.colorScheme.primaryContainer,
                ),
            ],
          ),
        ),
        // Time grid
        Expanded(
          child: eventsAsync.when(
            data: (events) {
              // Separate all-day and timed events
              final allDayEvents = events.where((e) => e.isAllDay).toList();
              final timedEvents = events.where((e) => !e.isAllDay).toList();

              return Column(
                children: [
                  // All-day events
                  if (allDayEvents.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                        border: Border(
                          bottom: BorderSide(
                            color: theme.colorScheme.outlineVariant,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'All Day Events',
                            style: theme.textTheme.titleSmall,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: allDayEvents.map((event) {
                              return _buildAllDayEventChip(event);
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                  // Timed events grid
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Stack(
                        children: [
                          // Hour grid
                          Column(
                            children: List.generate(24, (hour) {
                              return _buildHourRow(hour, selectedDate);
                            }),
                          ),
                          // Events overlay
                          ...timedEvents.map((event) {
                            return _buildEventBlock(event);
                          }).toList(),
                          // Current time indicator
                          if (isToday) _buildCurrentTimeIndicator(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('Error: $error')),
          ),
        ),
      ],
    );
  }

  Widget _buildHourRow(int hour, DateTime date) {
    final theme = Theme.of(context);
    
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
        child: Row(
          children: [
            // Time label
            Container(
              width: 80,
              padding: const EdgeInsets.only(right: 16, top: 4),
              alignment: Alignment.topRight,
              child: Text(
                DateFormat('h a').format(DateTime(2024, 1, 1, hour)),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            // Grid line
            Container(
              width: 1,
              color: theme.colorScheme.outlineVariant,
            ),
            // Event area
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllDayEventChip(CalendarEvent event) {
    return ActionChip(
      avatar: Icon(
        event.category.icon,
        size: 16,
        color: event.category.color,
      ),
      label: Text(event.title),
      backgroundColor: event.category.color.withOpacity(0.1),
      onPressed: () => _showEventDetail(event),
    );
  }

  Widget _buildEventBlock(CalendarEvent event) {
    final theme = Theme.of(context);
    final startMinutes = event.start.hour * 60 + event.start.minute;
    final endMinutes = event.end.hour * 60 + event.end.minute;
    final top = startMinutes * _hourHeight / 60;
    final height = (endMinutes - startMinutes) * _hourHeight / 60;
    final duration = event.end.difference(event.start).inMinutes;
    final isShort = duration < 45;
    
    return Positioned(
      top: top,
      left: 96,
      right: 16,
      height: height.clamp(30, double.infinity),
      child: GestureDetector(
        onTap: () => _showEventDetail(event),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: event.category.color.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    event.category.icon,
                    size: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      event.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: isShort ? 1 : 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (event.priority == EventPriority.high || 
                      event.priority == EventPriority.urgent)
                    Icon(
                      Icons.priority_high,
                      size: 16,
                      color: Colors.white,
                    ),
                ],
              ),
              if (!isShort) ...[
                const SizedBox(height: 4),
                Text(
                  '${DateFormat('h:mm').format(event.start)} - ${DateFormat('h:mm a').format(event.end)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                if (event.location != null && duration >= 60) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 12,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          event.location!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 11,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                if (event.attendees.isNotEmpty && duration >= 90) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        size: 12,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${event.attendees.length} attendee${event.attendees.length > 1 ? 's' : ''}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentTimeIndicator() {
    final now = DateTime.now();
    final minutes = now.hour * 60 + now.minute;
    final top = minutes * _hourHeight / 60;
    
    return Positioned(
      top: top,
      left: 80,
      right: 0,
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