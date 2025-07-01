import 'package:flutter/material.dart';
import '../models/calendar_models.dart';

class ReminderPicker extends StatelessWidget {
  final List<EventReminder> reminders;
  final Function(List<EventReminder>) onChanged;
  final Function(EventReminder) onAdd;
  final Function(int) onRemove;

  const ReminderPicker({
    super.key,
    required this.reminders,
    required this.onChanged,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Reminders',
              style: theme.textTheme.titleMedium,
            ),
            TextButton.icon(
              onPressed: () => _showAddReminderDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (reminders.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text('No reminders set'),
            ),
          )
        else
          ...reminders.asMap().entries.map((entry) {
            final index = entry.key;
            final reminder = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Icon(
                  _getReminderIcon(reminder.type),
                  color: theme.colorScheme.primary,
                ),
                title: Text(_getReminderDescription(reminder)),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => onRemove(index),
                ),
              ),
            );
          }).toList(),
      ],
    );
  }

  IconData _getReminderIcon(ReminderType type) {
    switch (type) {
      case ReminderType.notification:
        return Icons.notifications;
      case ReminderType.email:
        return Icons.email;
      case ReminderType.popup:
        return Icons.window;
    }
  }

  String _getReminderDescription(EventReminder reminder) {
    final timeText = _getTimeText(reminder.minutesBefore);
    switch (reminder.type) {
      case ReminderType.notification:
        return 'Notification $timeText';
      case ReminderType.email:
        return 'Email $timeText';
      case ReminderType.popup:
        return 'Pop-up $timeText';
    }
  }

  String _getTimeText(int minutes) {
    if (minutes == 0) {
      return 'at time of event';
    } else if (minutes < 60) {
      return '$minutes minute${minutes > 1 ? 's' : ''} before';
    } else if (minutes < 1440) {
      final hours = minutes ~/ 60;
      return '$hours hour${hours > 1 ? 's' : ''} before';
    } else {
      final days = minutes ~/ 1440;
      return '$days day${days > 1 ? 's' : ''} before';
    }
  }

  void _showAddReminderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddReminderDialog(
        onAdd: onAdd,
      ),
    );
  }
}

class AddReminderDialog extends StatefulWidget {
  final Function(EventReminder) onAdd;

  const AddReminderDialog({
    super.key,
    required this.onAdd,
  });

  @override
  State<AddReminderDialog> createState() => _AddReminderDialogState();
}

class _AddReminderDialogState extends State<AddReminderDialog> {
  ReminderType _type = ReminderType.notification;
  int _minutes = 15;
  String _timeUnit = 'minutes';

  final List<int> _minuteOptions = [0, 5, 10, 15, 30];
  final List<int> _hourOptions = [1, 2, 3, 4, 5, 6, 12, 24];
  final List<int> _dayOptions = [1, 2, 3, 7];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Reminder'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Reminder type
          DropdownButtonFormField<ReminderType>(
            value: _type,
            decoration: const InputDecoration(
              labelText: 'Type',
              border: OutlineInputBorder(),
            ),
            items: ReminderType.values.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Row(
                  children: [
                    Icon(_getIcon(type), size: 20),
                    const SizedBox(width: 8),
                    Text(_getTypeName(type)),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _type = value;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          // Time unit
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'minutes', label: Text('Minutes')),
              ButtonSegment(value: 'hours', label: Text('Hours')),
              ButtonSegment(value: 'days', label: Text('Days')),
            ],
            selected: {_timeUnit},
            onSelectionChanged: (Set<String> selected) {
              setState(() {
                _timeUnit = selected.first;
                // Reset to default value for new unit
                switch (_timeUnit) {
                  case 'minutes':
                    _minutes = 15;
                    break;
                  case 'hours':
                    _minutes = 60;
                    break;
                  case 'days':
                    _minutes = 1440;
                    break;
                }
              });
            },
          ),
          const SizedBox(height: 16),
          // Time value
          DropdownButtonFormField<int>(
            value: _getTimeValue(),
            decoration: InputDecoration(
              labelText: 'Time before event',
              border: const OutlineInputBorder(),
              suffixText: _timeUnit,
            ),
            items: _getTimeOptions().map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  switch (_timeUnit) {
                    case 'minutes':
                      _minutes = value;
                      break;
                    case 'hours':
                      _minutes = value * 60;
                      break;
                    case 'days':
                      _minutes = value * 1440;
                      break;
                  }
                });
              }
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
            widget.onAdd(
              EventReminder(
                type: _type,
                minutesBefore: _minutes,
              ),
            );
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  IconData _getIcon(ReminderType type) {
    switch (type) {
      case ReminderType.notification:
        return Icons.notifications;
      case ReminderType.email:
        return Icons.email;
      case ReminderType.popup:
        return Icons.window;
    }
  }

  String _getTypeName(ReminderType type) {
    switch (type) {
      case ReminderType.notification:
        return 'Notification';
      case ReminderType.email:
        return 'Email';
      case ReminderType.popup:
        return 'Pop-up';
    }
  }

  int _getTimeValue() {
    switch (_timeUnit) {
      case 'minutes':
        return _minutes;
      case 'hours':
        return _minutes ~/ 60;
      case 'days':
        return _minutes ~/ 1440;
      default:
        return _minutes;
    }
  }

  List<int> _getTimeOptions() {
    switch (_timeUnit) {
      case 'minutes':
        return _minuteOptions;
      case 'hours':
        return _hourOptions;
      case 'days':
        return _dayOptions;
      default:
        return _minuteOptions;
    }
  }
}