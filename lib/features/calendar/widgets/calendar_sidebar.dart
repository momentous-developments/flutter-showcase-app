import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/calendar_providers.dart';
import '../models/calendar_models.dart';
import 'mini_calendar.dart';

class CalendarSidebar extends ConsumerWidget {
  const CalendarSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final calendars = ref.watch(calendarsProvider);
    final upcomingEvents = ref.watch(upcomingEventsProvider);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: theme.colorScheme.outlineVariant,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mini Calendar
            const Padding(
              padding: EdgeInsets.all(16),
              child: MiniCalendar(),
            ),
            const Divider(),
            // Calendars Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Calendars',
                        style: theme.textTheme.titleMedium,
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _showAddCalendarDialog(context, ref),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  calendars.when(
                    data: (calendarList) => Column(
                      children: calendarList.map((calendar) {
                        return CalendarListItem(calendar: calendar);
                      }).toList(),
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, _) => Text('Error: $error'),
                  ),
                ],
              ),
            ),
            const Divider(),
            // Upcoming Events Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upcoming Events',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  upcomingEvents.when(
                    data: (events) {
                      if (events.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('No upcoming events'),
                          ),
                        );
                      }
                      return Column(
                        children: events.map((event) {
                          return UpcomingEventItem(event: event);
                        }).toList(),
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, _) => Text('Error: $error'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddCalendarDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AddCalendarDialog(),
    );
  }
}

class CalendarListItem extends ConsumerWidget {
  final Calendar calendar;

  const CalendarListItem({
    super.key,
    required this.calendar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final visibilityFilter = ref.watch(calendarVisibilityProvider);
    final isVisible = visibilityFilter[calendar.id] ?? true;

    return ListTile(
      leading: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: calendar.color,
          shape: BoxShape.circle,
        ),
      ),
      title: Text(calendar.name),
      subtitle: calendar.description.isNotEmpty
          ? Text(
              calendar.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
              size: 20,
            ),
            onPressed: () {
              ref
                  .read(calendarVisibilityProvider.notifier)
                  .toggleCalendarVisibility(calendar.id);
            },
          ),
          PopupMenuButton<String>(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'share',
                child: ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Share'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'export',
                child: ListTile(
                  leading: Icon(Icons.download),
                  title: Text('Export'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: ListTile(
                  leading: Icon(Icons.delete, color: Colors.red),
                  title: Text('Delete', style: TextStyle(color: Colors.red)),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  _showEditCalendarDialog(context, ref, calendar);
                  break;
                case 'share':
                  _showShareCalendarDialog(context, calendar);
                  break;
                case 'export':
                  _exportCalendar(context, ref, calendar);
                  break;
                case 'delete':
                  _deleteCalendar(context, ref, calendar);
                  break;
              }
            },
          ),
        ],
      ),
      onTap: () {
        ref.read(selectedCalendarProvider.notifier).state = calendar.id;
      },
    );
  }

  void _showEditCalendarDialog(BuildContext context, WidgetRef ref, Calendar calendar) {
    showDialog(
      context: context,
      builder: (context) => AddCalendarDialog(calendar: calendar),
    );
  }

  void _showShareCalendarDialog(BuildContext context, Calendar calendar) {
    showDialog(
      context: context,
      builder: (context) => ShareCalendarDialog(calendar: calendar),
    );
  }

  void _exportCalendar(BuildContext context, WidgetRef ref, Calendar calendar) async {
    final service = ref.read(calendarServiceProvider);
    try {
      final events = await service.getEvents(calendarId: calendar.id);
      final jsonData = await service.exportEvents();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Calendar "${calendar.name}" exported successfully'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to export calendar: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _deleteCalendar(BuildContext context, WidgetRef ref, Calendar calendar) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Calendar'),
        content: Text('Are you sure you want to delete "${calendar.name}"? All events in this calendar will be permanently deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final service = ref.read(calendarServiceProvider);
              try {
                await service.deleteCalendar(calendar.id);
                ref.invalidate(calendarsProvider);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Calendar "${calendar.name}" deleted'),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to delete calendar: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class UpcomingEventItem extends ConsumerWidget {
  final CalendarEvent event;

  const UpcomingEventItem({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final isToday = event.start.year == now.year &&
        event.start.month == now.month &&
        event.start.day == now.day;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: event.category.color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            event.category.icon,
            color: event.category.color,
            size: 20,
          ),
        ),
        title: Text(
          event.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.isAllDay
                  ? DateFormat('MMM d').format(event.start)
                  : isToday
                      ? DateFormat('h:mm a').format(event.start)
                      : DateFormat('MMM d, h:mm a').format(event.start),
              style: TextStyle(
                color: isToday ? theme.colorScheme.primary : null,
                fontWeight: isToday ? FontWeight.bold : null,
              ),
            ),
            if (event.location != null && event.location!.isNotEmpty)
              Text(
                event.location!,
                style: theme.textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
        onTap: () {
          ref.read(selectedDateProvider.notifier).state = event.start;
          ref.read(selectedEventProvider.notifier).state = event;
        },
      ),
    );
  }
}

class AddCalendarDialog extends ConsumerStatefulWidget {
  final Calendar? calendar;

  const AddCalendarDialog({
    super.key,
    this.calendar,
  });

  @override
  ConsumerState<AddCalendarDialog> createState() => _AddCalendarDialogState();
}

class _AddCalendarDialogState extends ConsumerState<AddCalendarDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.calendar?.name ?? '');
    _descriptionController = TextEditingController(text: widget.calendar?.description ?? '');
    _selectedColor = widget.calendar?.color ?? Colors.blue;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.calendar != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Calendar' : 'Add Calendar'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Calendar Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a calendar name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            // Color picker
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Calendar Color'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    Colors.blue,
                    Colors.green,
                    Colors.orange,
                    Colors.purple,
                    Colors.red,
                    Colors.teal,
                    Colors.pink,
                    Colors.amber,
                  ].map((color) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedColor = color;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _selectedColor == color
                                ? Colors.black
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: _selectedColor == color
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              )
                            : null,
                      ),
                    );
                  }).toList(),
                ),
              ],
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
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final service = ref.read(calendarServiceProvider);
              try {
                if (isEditing) {
                  await service.updateCalendar(
                    widget.calendar!.copyWith(
                      name: _nameController.text,
                      description: _descriptionController.text,
                      color: _selectedColor,
                    ),
                  );
                } else {
                  await service.createCalendar(
                    Calendar(
                      id: '',
                      name: _nameController.text,
                      description: _descriptionController.text,
                      color: _selectedColor,
                    ),
                  );
                }
                ref.invalidate(calendarsProvider);
                Navigator.of(context).pop();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to ${isEditing ? 'update' : 'create'} calendar: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
          child: Text(isEditing ? 'Update' : 'Create'),
        ),
      ],
    );
  }
}

class ShareCalendarDialog extends StatelessWidget {
  final Calendar calendar;

  const ShareCalendarDialog({
    super.key,
    required this.calendar,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Share "${calendar.name}"'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: 'Email address',
              hintText: 'Enter email to share with',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Permissions'),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(
                value: 'view',
                label: Text('View Only'),
              ),
              ButtonSegment(
                value: 'edit',
                label: Text('Can Edit'),
              ),
            ],
            selected: const {'view'},
            onSelectionChanged: (Set<String> selected) {
              // Handle permission change
            },
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
            // Handle share
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Calendar shared successfully'),
              ),
            );
          },
          child: const Text('Share'),
        ),
      ],
    );
  }
}