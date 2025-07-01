import 'package:flutter/material.dart';
import '../models/calendar_models.dart';

class RecurrencePicker extends StatefulWidget {
  final RecurrenceRule? recurrenceRule;
  final Function(RecurrenceRule?) onChanged;

  const RecurrencePicker({
    super.key,
    required this.recurrenceRule,
    required this.onChanged,
  });

  @override
  State<RecurrencePicker> createState() => _RecurrencePickerState();
}

class _RecurrencePickerState extends State<RecurrencePicker> {
  bool _isRecurring = false;
  RecurrenceFrequency _frequency = RecurrenceFrequency.daily;
  int _interval = 1;
  DateTime? _until;
  int? _count;
  List<int> _selectedWeekDays = [];

  @override
  void initState() {
    super.initState();
    if (widget.recurrenceRule != null) {
      _isRecurring = true;
      _frequency = widget.recurrenceRule!.frequency;
      _interval = widget.recurrenceRule!.interval;
      _until = widget.recurrenceRule!.until;
      _count = widget.recurrenceRule!.count;
      _selectedWeekDays = List.from(widget.recurrenceRule!.byWeekDay);
    }
  }

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
              'Repeat',
              style: theme.textTheme.titleMedium,
            ),
            Switch(
              value: _isRecurring,
              onChanged: (value) {
                setState(() {
                  _isRecurring = value;
                  if (!value) {
                    widget.onChanged(null);
                  } else {
                    _updateRecurrenceRule();
                  }
                });
              },
            ),
          ],
        ),
        if (_isRecurring) ...[
          const SizedBox(height: 16),
          // Frequency
          DropdownButtonFormField<RecurrenceFrequency>(
            value: _frequency,
            decoration: const InputDecoration(
              labelText: 'Repeat',
              border: OutlineInputBorder(),
            ),
            items: RecurrenceFrequency.values.map((frequency) {
              return DropdownMenuItem(
                value: frequency,
                child: Text(_getFrequencyName(frequency)),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _frequency = value;
                  _updateRecurrenceRule();
                });
              }
            },
          ),
          const SizedBox(height: 16),
          // Interval
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: _interval.toString(),
                  decoration: InputDecoration(
                    labelText: 'Every',
                    border: const OutlineInputBorder(),
                    suffixText: _getIntervalSuffix(_frequency, _interval),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    final interval = int.tryParse(value);
                    if (interval != null && interval > 0) {
                      setState(() {
                        _interval = interval;
                        _updateRecurrenceRule();
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          if (_frequency == RecurrenceFrequency.weekly) ...[
            const SizedBox(height: 16),
            // Week days
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('On days'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: List.generate(7, (index) {
                    final weekday = index + 1;
                    final isSelected = _selectedWeekDays.contains(weekday);
                    return FilterChip(
                      label: Text(_getWeekdayName(weekday)),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedWeekDays.add(weekday);
                          } else {
                            _selectedWeekDays.remove(weekday);
                          }
                          _selectedWeekDays.sort();
                          _updateRecurrenceRule();
                        });
                      },
                    );
                  }),
                ),
              ],
            ),
          ],
          const SizedBox(height: 16),
          // End condition
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ends'),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'never', label: Text('Never')),
                  ButtonSegment(value: 'until', label: Text('On date')),
                  ButtonSegment(value: 'count', label: Text('After')),
                ],
                selected: {
                  _until == null && _count == null
                      ? 'never'
                      : _until != null
                          ? 'until'
                          : 'count',
                },
                onSelectionChanged: (Set<String> selected) {
                  setState(() {
                    switch (selected.first) {
                      case 'never':
                        _until = null;
                        _count = null;
                        break;
                      case 'until':
                        _until = DateTime.now().add(const Duration(days: 30));
                        _count = null;
                        break;
                      case 'count':
                        _until = null;
                        _count = 10;
                        break;
                    }
                    _updateRecurrenceRule();
                  });
                },
              ),
              const SizedBox(height: 8),
              if (_until != null) ...[
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _until!,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                    );
                    if (picked != null) {
                      setState(() {
                        _until = picked;
                        _updateRecurrenceRule();
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          '${_until!.month}/${_until!.day}/${_until!.year}',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (_count != null) ...[
                TextFormField(
                  initialValue: _count.toString(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    suffixText: 'occurrences',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    final count = int.tryParse(value);
                    if (count != null && count > 0) {
                      setState(() {
                        _count = count;
                        _updateRecurrenceRule();
                      });
                    }
                  },
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }

  String _getFrequencyName(RecurrenceFrequency frequency) {
    switch (frequency) {
      case RecurrenceFrequency.daily:
        return 'Daily';
      case RecurrenceFrequency.weekly:
        return 'Weekly';
      case RecurrenceFrequency.monthly:
        return 'Monthly';
      case RecurrenceFrequency.yearly:
        return 'Yearly';
    }
  }

  String _getIntervalSuffix(RecurrenceFrequency frequency, int interval) {
    switch (frequency) {
      case RecurrenceFrequency.daily:
        return interval == 1 ? 'day' : 'days';
      case RecurrenceFrequency.weekly:
        return interval == 1 ? 'week' : 'weeks';
      case RecurrenceFrequency.monthly:
        return interval == 1 ? 'month' : 'months';
      case RecurrenceFrequency.yearly:
        return interval == 1 ? 'year' : 'years';
    }
  }

  String _getWeekdayName(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }

  void _updateRecurrenceRule() {
    if (_isRecurring) {
      widget.onChanged(
        RecurrenceRule(
          frequency: _frequency,
          interval: _interval,
          until: _until,
          count: _count,
          byWeekDay: _selectedWeekDays,
        ),
      );
    } else {
      widget.onChanged(null);
    }
  }
}