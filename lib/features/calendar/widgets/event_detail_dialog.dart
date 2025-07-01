import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/calendar_models.dart';
import '../providers/calendar_providers.dart';
import 'recurrence_picker.dart';
import 'reminder_picker.dart';

class EventDetailDialog extends ConsumerStatefulWidget {
  final CalendarEvent? event;

  const EventDetailDialog({
    super.key,
    this.event,
  });

  @override
  ConsumerState<EventDetailDialog> createState() => _EventDetailDialogState();
}

class _EventDetailDialogState extends ConsumerState<EventDetailDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _attendeeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      // Load existing event
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(eventFormStateProvider.notifier).loadEvent(widget.event!);
      });
      _titleController.text = widget.event!.title;
      _descriptionController.text = widget.event!.description ?? '';
      _locationController.text = widget.event!.location ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _attendeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formState = ref.watch(eventFormStateProvider);
    final calendars = ref.watch(calendarsProvider);
    final isEditing = widget.event != null;

    return Dialog(
      child: Container(
        width: 600,
        constraints: const BoxConstraints(maxHeight: 800),
        child: Scaffold(
          appBar: AppBar(
            title: Text(isEditing ? 'Edit Event' : 'New Event'),
            actions: [
              if (isEditing) ...[
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteEvent(context),
                ),
              ],
            ],
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Event Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an event title';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      ref.read(eventFormStateProvider.notifier).updateTitle(value);
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Calendar selection
                  calendars.when(
                    data: (calendarList) {
                      if (calendarList.isEmpty) return const SizedBox();
                      
                      // Set default calendar if not set
                      if (formState.calendarId.isEmpty && calendarList.isNotEmpty) {
                        final defaultCalendar = calendarList.firstWhere(
                          (c) => c.isDefault,
                          orElse: () => calendarList.first,
                        );
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ref.read(eventFormStateProvider.notifier).updateCalendarId(defaultCalendar.id);
                        });
                      }
                      
                      return DropdownButtonFormField<String>(
                        value: formState.calendarId.isEmpty ? null : formState.calendarId,
                        decoration: const InputDecoration(
                          labelText: 'Calendar',
                          border: OutlineInputBorder(),
                        ),
                        items: calendarList.map((calendar) {
                          return DropdownMenuItem(
                            value: calendar.id,
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: calendar.color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(calendar.name),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            ref.read(eventFormStateProvider.notifier).updateCalendarId(value);
                          }
                        },
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (_, __) => const SizedBox(),
                  ),
                  const SizedBox(height: 16),
                  
                  // Date and time
                  Row(
                    children: [
                      Expanded(
                        child: _buildDateTimePicker(
                          context: context,
                          label: 'Start',
                          date: formState.start,
                          isAllDay: formState.isAllDay,
                          onChanged: (date) {
                            ref.read(eventFormStateProvider.notifier).updateStart(date);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDateTimePicker(
                          context: context,
                          label: 'End',
                          date: formState.end,
                          isAllDay: formState.isAllDay,
                          onChanged: (date) {
                            ref.read(eventFormStateProvider.notifier).updateEnd(date);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // All day toggle
                  CheckboxListTile(
                    title: const Text('All day'),
                    value: formState.isAllDay,
                    onChanged: (value) {
                      ref.read(eventFormStateProvider.notifier).toggleAllDay();
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(height: 16),
                  
                  // Category and Priority
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<EventCategory>(
                          value: formState.category,
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(),
                          ),
                          items: EventCategory.values.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Row(
                                children: [
                                  Icon(category.icon, size: 20, color: category.color),
                                  const SizedBox(width: 8),
                                  Text(category.displayName),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              ref.read(eventFormStateProvider.notifier).updateCategory(value);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<EventPriority>(
                          value: formState.priority,
                          decoration: const InputDecoration(
                            labelText: 'Priority',
                            border: OutlineInputBorder(),
                          ),
                          items: EventPriority.values.map((priority) {
                            return DropdownMenuItem(
                              value: priority,
                              child: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: priority.color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(priority.displayName),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              ref.read(eventFormStateProvider.notifier).updatePriority(value);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Location
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    onChanged: (value) {
                      ref.read(eventFormStateProvider.notifier).updateLocation(value);
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Description
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 3,
                    onChanged: (value) {
                      ref.read(eventFormStateProvider.notifier).updateDescription(value);
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  // Recurrence
                  RecurrencePicker(
                    recurrenceRule: formState.recurrenceRule,
                    onChanged: (rule) {
                      ref.read(eventFormStateProvider.notifier).updateRecurrenceRule(rule);
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  // Reminders
                  ReminderPicker(
                    reminders: formState.reminders,
                    onChanged: (reminders) {
                      // Update reminders in state
                    },
                    onAdd: (reminder) {
                      ref.read(eventFormStateProvider.notifier).addReminder(reminder);
                    },
                    onRemove: (index) {
                      ref.read(eventFormStateProvider.notifier).removeReminder(index);
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  // Attendees
                  _buildAttendeesSection(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: theme.colorScheme.outlineVariant,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () => _saveEvent(context),
                  child: Text(isEditing ? 'Update' : 'Create'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker({
    required BuildContext context,
    required String label,
    required DateTime date,
    required bool isAllDay,
    required Function(DateTime) onChanged,
  }) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
        );
        
        if (pickedDate != null) {
          if (!isAllDay) {
            final pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(date),
            );
            
            if (pickedTime != null) {
              onChanged(DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              ));
            }
          } else {
            onChanged(DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
            ));
          }
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 20,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Text(
              isAllDay
                  ? DateFormat('MMM d, yyyy').format(date)
                  : DateFormat('MMM d, yyyy h:mm a').format(date),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendeesSection() {
    final formState = ref.watch(eventFormStateProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Attendees',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton.icon(
              onPressed: () => _showAddAttendeeDialog(),
              icon: const Icon(Icons.person_add),
              label: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (formState.attendees.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text('No attendees'),
            ),
          )
        else
          ...formState.attendees.map((email) {
            return ListTile(
              leading: CircleAvatar(
                child: Text(email[0].toUpperCase()),
              ),
              title: Text(email),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () {
                  ref.read(eventFormStateProvider.notifier).removeAttendee(email);
                },
              ),
            );
          }).toList(),
      ],
    );
  }

  void _showAddAttendeeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Attendee'),
          content: TextField(
            controller: _attendeeController,
            decoration: const InputDecoration(
              labelText: 'Email address',
              hintText: 'Enter attendee email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          actions: [
            TextButton(
              onPressed: () {
                _attendeeController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (_attendeeController.text.isNotEmpty) {
                  ref.read(eventFormStateProvider.notifier).addAttendee(_attendeeController.text);
                  _attendeeController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveEvent(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final formState = ref.read(eventFormStateProvider);
      final service = ref.read(calendarServiceProvider);
      
      try {
        final event = CalendarEvent(
          id: widget.event?.id ?? '',
          title: formState.title,
          description: formState.description.isEmpty ? null : formState.description,
          location: formState.location.isEmpty ? null : formState.location,
          start: formState.start,
          end: formState.end,
          isAllDay: formState.isAllDay,
          category: formState.category,
          priority: formState.priority,
          calendarId: formState.calendarId,
          reminders: formState.reminders,
          recurrenceRule: formState.recurrenceRule,
          attendees: formState.attendees,
          status: widget.event?.status ?? EventStatus.confirmed,
        );
        
        if (widget.event != null) {
          await service.updateEvent(event);
        } else {
          await service.createEvent(event);
        }
        
        // Refresh events
        ref.invalidate(eventsProvider);
        ref.invalidate(upcomingEventsProvider);
        
        Navigator.of(context).pop();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Event ${widget.event != null ? 'updated' : 'created'} successfully'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to ${widget.event != null ? 'update' : 'create'} event: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteEvent(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Event'),
        content: const Text('Are you sure you want to delete this event?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      final service = ref.read(calendarServiceProvider);
      
      try {
        await service.deleteEvent(widget.event!.id);
        
        // Refresh events
        ref.invalidate(eventsProvider);
        ref.invalidate(upcomingEventsProvider);
        
        Navigator.of(context).pop();
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Event deleted successfully'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete event: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}