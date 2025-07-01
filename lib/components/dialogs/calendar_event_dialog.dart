import 'package:flutter/material.dart';
import 'widgets/form_dialog.dart';

/// Dialog for creating or editing calendar events
class CalendarEventDialog extends StatefulWidget {
  const CalendarEventDialog({
    super.key,
    this.eventData,
    this.onSave,
    this.onCancel,
  });

  final EventData? eventData;
  final Function(EventData)? onSave;
  final VoidCallback? onCancel;

  @override
  State<CalendarEventDialog> createState() => _CalendarEventDialogState();
}

class _CalendarEventDialogState extends State<CalendarEventDialog> {
  late EventData _eventData;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _eventData = widget.eventData ?? EventData(
      title: '',
      description: '',
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      isAllDay: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.eventData != null;

    return FormDialog(
      title: isEditing ? 'Edit Event' : 'New Event',
      subtitle: isEditing ? 'Update event details' : 'Create a new calendar event',
      submitText: isEditing ? 'Update' : 'Create',
      cancelText: 'Cancel',
      isLoading: _isLoading,
      canSubmit: _eventData.title.isNotEmpty,
      onSubmit: _handleSave,
      onCancel: widget.onCancel,
      child: Column(
        children: [
          DialogFormField(
            label: 'Event Title',
            hint: 'Team Meeting',
            value: _eventData.title,
            required: true,
            onChanged: (value) => setState(() => _eventData = _eventData.copyWith(title: value)),
            validator: (value) => value?.isEmpty == true ? 'Title is required' : null,
          ),
          DialogFormField(
            label: 'Description',
            hint: 'Meeting agenda and details...',
            value: _eventData.description,
            maxLines: 3,
            onChanged: (value) => setState(() => _eventData = _eventData.copyWith(description: value)),
          ),
          SwitchListTile(
            title: const Text('All Day'),
            value: _eventData.isAllDay,
            onChanged: (value) => setState(() => _eventData = _eventData.copyWith(isAllDay: value)),
          ),
          if (!_eventData.isAllDay) ...[
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Start Time'),
                    subtitle: Text(_formatDateTime(_eventData.startTime)),
                    onTap: () => _selectDateTime(true),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('End Time'),
                    subtitle: Text(_formatDateTime(_eventData.endTime)),
                    onTap: () => _selectDateTime(false),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _selectDateTime(bool isStartTime) async {
    final date = await showDatePicker(
      context: context,
      initialDate: isStartTime ? _eventData.startTime : _eventData.endTime,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          isStartTime ? _eventData.startTime : _eventData.endTime,
        ),
      );

      if (time != null) {
        final dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
        setState(() {
          if (isStartTime) {
            _eventData = _eventData.copyWith(startTime: dateTime);
          } else {
            _eventData = _eventData.copyWith(endTime: dateTime);
          }
        });
      }
    }
  }

  void _handleSave() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

    widget.onSave?.call(_eventData);
    if (mounted) Navigator.of(context).pop();
  }
}

class EventData {
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final bool isAllDay;

  const EventData({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.isAllDay,
  });

  EventData copyWith({
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    bool? isAllDay,
  }) {
    return EventData(
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isAllDay: isAllDay ?? this.isAllDay,
    );
  }
}