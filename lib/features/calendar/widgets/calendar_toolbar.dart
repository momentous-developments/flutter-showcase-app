import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/calendar_providers.dart';
import '../models/calendar_models.dart';

class CalendarToolbar extends ConsumerWidget {
  final VoidCallback? onMenuPressed;

  const CalendarToolbar({
    super.key,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selectedDate = ref.watch(selectedDateProvider);
    final viewType = ref.watch(calendarViewTypeProvider);

    return Container(
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
          // Menu button for mobile
          if (onMenuPressed != null) ...[
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: onMenuPressed,
            ),
            const SizedBox(width: 8),
          ],
          // Today button
          FilledButton.tonal(
            onPressed: () {
              ref.read(selectedDateProvider.notifier).state = DateTime.now();
              ref.read(focusedDayProvider.notifier).state = DateTime.now();
            },
            child: const Text('Today'),
          ),
          const SizedBox(width: 16),
          // Navigation buttons
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => _navigateDate(ref, viewType, -1),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => _navigateDate(ref, viewType, 1),
          ),
          const SizedBox(width: 16),
          // Date display
          Text(
            _formatDateDisplay(selectedDate, viewType),
            style: theme.textTheme.titleLarge,
          ),
          const Spacer(),
          // Search button
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context, ref),
          ),
          // Settings button
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettingsDialog(context),
          ),
        ],
      ),
    );
  }

  void _navigateDate(WidgetRef ref, CalendarViewType viewType, int direction) {
    final currentDate = ref.read(selectedDateProvider);
    DateTime newDate;

    switch (viewType) {
      case CalendarViewType.day:
        newDate = currentDate.add(Duration(days: direction));
        break;
      case CalendarViewType.week:
        newDate = currentDate.add(Duration(days: 7 * direction));
        break;
      case CalendarViewType.month:
        newDate = DateTime(
          currentDate.year,
          currentDate.month + direction,
          currentDate.day,
        );
        break;
      case CalendarViewType.agenda:
        newDate = currentDate.add(Duration(days: direction));
        break;
    }

    ref.read(selectedDateProvider.notifier).state = newDate;
    ref.read(focusedDayProvider.notifier).state = newDate;
  }

  String _formatDateDisplay(DateTime date, CalendarViewType viewType) {
    switch (viewType) {
      case CalendarViewType.day:
        return DateFormat('EEEE, MMMM d, yyyy').format(date);
      case CalendarViewType.week:
        final weekStart = date.subtract(Duration(days: date.weekday - 1));
        final weekEnd = weekStart.add(const Duration(days: 6));
        if (weekStart.month == weekEnd.month) {
          return '${DateFormat('MMMM d').format(weekStart)} - ${DateFormat('d, yyyy').format(weekEnd)}';
        } else if (weekStart.year == weekEnd.year) {
          return '${DateFormat('MMM d').format(weekStart)} - ${DateFormat('MMM d, yyyy').format(weekEnd)}';
        } else {
          return '${DateFormat('MMM d, yyyy').format(weekStart)} - ${DateFormat('MMM d, yyyy').format(weekEnd)}';
        }
      case CalendarViewType.month:
        return DateFormat('MMMM yyyy').format(date);
      case CalendarViewType.agenda:
        return DateFormat('MMMM yyyy').format(date);
    }
  }

  void _showSearchDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => const EventSearchDialog(),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CalendarSettingsDialog(),
    );
  }
}

class EventSearchDialog extends ConsumerStatefulWidget {
  const EventSearchDialog({super.key});

  @override
  ConsumerState<EventSearchDialog> createState() => _EventSearchDialogState();
}

class _EventSearchDialogState extends ConsumerState<EventSearchDialog> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final searchResults = ref.watch(eventSearchResultsProvider);

    return AlertDialog(
      title: const Text('Search Events'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for events...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    ref.read(eventSearchQueryProvider.notifier).state = '';
                  },
                ),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                ref.read(eventSearchQueryProvider.notifier).state = value;
              },
            ),
            const SizedBox(height: 16),
            Flexible(
              child: searchResults.when(
                data: (events) {
                  if (events.isEmpty && _searchController.text.isNotEmpty) {
                    return const Center(
                      child: Text('No events found'),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: event.category.color,
                          child: Icon(
                            event.category.icon,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        title: Text(event.title),
                        subtitle: Text(
                          DateFormat('MMM d, yyyy - h:mm a').format(event.start),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          ref.read(selectedDateProvider.notifier).state = event.start;
                          ref.read(selectedEventProvider.notifier).state = event;
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, _) => Center(
                  child: Text('Error: $error'),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class CalendarSettingsDialog extends StatelessWidget {
  const CalendarSettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Calendar Settings'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Week Start'),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Sun')),
                ButtonSegment(value: 1, label: Text('Mon')),
                ButtonSegment(value: 6, label: Text('Sat')),
              ],
              selected: const {1},
              onSelectionChanged: (Set<int> selected) {
                // Handle week start change
              },
            ),
            const SizedBox(height: 24),
            const Text('Time Format'),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: '12h', label: Text('12 Hour')),
                ButtonSegment(value: '24h', label: Text('24 Hour')),
              ],
              selected: const {'12h'},
              onSelectionChanged: (Set<String> selected) {
                // Handle time format change
              },
            ),
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('Show Week Numbers'),
              value: false,
              onChanged: (value) {
                // Handle show week numbers
              },
            ),
            SwitchListTile(
              title: const Text('Show Declined Events'),
              value: false,
              onChanged: (value) {
                // Handle show declined events
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            // Save settings
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}