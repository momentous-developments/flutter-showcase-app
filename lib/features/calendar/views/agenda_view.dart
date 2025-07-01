import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/calendar_providers.dart';
import '../models/calendar_models.dart';
import '../widgets/event_card.dart';
import '../widgets/event_detail_dialog.dart';

class AgendaView extends ConsumerStatefulWidget {
  const AgendaView({super.key});

  @override
  ConsumerState<AgendaView> createState() => _AgendaViewState();
}

class _AgendaViewState extends ConsumerState<AgendaView> {
  final ScrollController _scrollController = ScrollController();
  int _daysToShow = 30;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedDate = ref.watch(selectedDateProvider);
    final service = ref.watch(calendarServiceProvider);

    // Get events for the next X days
    final startDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    final endDate = startDate.add(Duration(days: _daysToShow));
    final dateRange = DateTimeRange(start: startDate, end: endDate);
    final eventsAsync = ref.watch(eventsProvider(dateRange));

    return Column(
      children: [
        // Header
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
              Text(
                'Agenda',
                style: theme.textTheme.headlineSmall,
              ),
              const Spacer(),
              // Days selector
              SegmentedButton<int>(
                segments: const [
                  ButtonSegment(value: 7, label: Text('Week')),
                  ButtonSegment(value: 30, label: Text('Month')),
                  ButtonSegment(value: 90, label: Text('3 Months')),
                ],
                selected: {_daysToShow},
                onSelectionChanged: (Set<int> selected) {
                  setState(() {
                    _daysToShow = selected.first;
                  });
                },
              ),
            ],
          ),
        ),
        // Events list
        Expanded(
          child: eventsAsync.when(
            data: (events) {
              if (events.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event_available,
                        size: 64,
                        color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No upcoming events',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your schedule is clear for the next $_daysToShow days',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 16),
                      FilledButton.tonal(
                        onPressed: () => _createEvent(selectedDate),
                        child: const Text('Create Event'),
                      ),
                    ],
                  ),
                );
              }

              // Group events by date
              final eventsByDate = <DateTime, List<CalendarEvent>>{};
              for (final event in events) {
                final date = DateTime(event.start.year, event.start.month, event.start.day);
                eventsByDate[date] ??= [];
                eventsByDate[date]!.add(event);
              }

              // Sort dates
              final sortedDates = eventsByDate.keys.toList()..sort();

              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: sortedDates.length,
                itemBuilder: (context, index) {
                  final date = sortedDates[index];
                  final dayEvents = eventsByDate[date]!;
                  final isToday = _isToday(date);
                  final isTomorrow = _isTomorrow(date);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date header
                      Padding(
                        padding: EdgeInsets.only(bottom: 8, top: index == 0 ? 0 : 16),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: isToday
                                    ? theme.colorScheme.primaryContainer
                                    : theme.colorScheme.surfaceVariant,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _formatDateHeader(date, isToday, isTomorrow),
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: isToday
                                      ? theme.colorScheme.onPrimaryContainer
                                      : null,
                                  fontWeight: isToday ? FontWeight.bold : null,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Divider(
                                color: theme.colorScheme.outlineVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Events for this date
                      ...dayEvents.map((event) {
                        return EventCard(
                          event: event,
                          onTap: () => _showEventDetail(event),
                        );
                      }).toList(),
                    ],
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('Error: $error')),
          ),
        ),
      ],
    );
  }

  String _formatDateHeader(DateTime date, bool isToday, bool isTomorrow) {
    if (isToday) {
      return 'Today • ${DateFormat('EEEE, MMMM d').format(date)}';
    } else if (isTomorrow) {
      return 'Tomorrow • ${DateFormat('EEEE, MMMM d').format(date)}';
    } else {
      final now = DateTime.now();
      if (date.year == now.year) {
        return DateFormat('EEEE, MMMM d').format(date);
      } else {
        return DateFormat('EEEE, MMMM d, yyyy').format(date);
      }
    }
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  bool _isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year && date.month == tomorrow.month && date.day == tomorrow.day;
  }

  void _createEvent(DateTime date) {
    ref.read(eventFormStateProvider.notifier).reset();
    ref.read(eventFormStateProvider.notifier).updateStart(date);
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