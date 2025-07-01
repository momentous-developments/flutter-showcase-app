import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/form_models.dart';

class DateFormField extends StatelessWidget {
  final FormFieldModel field;
  final DateTime? value;
  final String? error;
  final Function(DateTime?) onChanged;
  
  const DateFormField({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    final dateFormat = field.options?.dateFormat ?? 'MMM dd, yyyy';
    final formatter = DateFormat(dateFormat);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (field.label != null) ...[
          Row(
            children: [
              Text(
                field.label!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (field.required) ...[
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
        ],
        
        InkWell(
          onTap: field.disabled ? null : () => _selectDate(context),
          borderRadius: BorderRadius.circular(4),
          child: InputDecorator(
            decoration: InputDecoration(
              hintText: field.placeholder ?? 'Select date',
              helperText: field.helperText,
              errorText: error,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (value != null && !field.disabled)
                    IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () => onChanged(null),
                      splashRadius: 20,
                    ),
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 8),
                ],
              ),
              filled: field.disabled,
              fillColor: field.disabled
                  ? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5)
                  : null,
            ),
            child: Text(
              value != null ? formatter.format(value!) : '',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }
  
  Future<void> _selectDate(BuildContext context) async {
    final initialDate = value ?? DateTime.now();
    final firstDate = field.options?.minDate ?? DateTime(1900);
    final lastDate = field.options?.maxDate ?? DateTime(2100);
    
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    
    if (selectedDate != null) {
      onChanged(selectedDate);
    }
  }
}

class TimeFormField extends StatelessWidget {
  final FormFieldModel field;
  final TimeOfDay? value;
  final String? error;
  final Function(TimeOfDay?) onChanged;
  
  const TimeFormField({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (field.label != null) ...[
          Row(
            children: [
              Text(
                field.label!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (field.required) ...[
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
        ],
        
        InkWell(
          onTap: field.disabled ? null : () => _selectTime(context),
          borderRadius: BorderRadius.circular(4),
          child: InputDecorator(
            decoration: InputDecoration(
              hintText: field.placeholder ?? 'Select time',
              helperText: field.helperText,
              errorText: error,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (value != null && !field.disabled)
                    IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () => onChanged(null),
                      splashRadius: 20,
                    ),
                  const Icon(Icons.access_time),
                  const SizedBox(width: 8),
                ],
              ),
              filled: field.disabled,
              fillColor: field.disabled
                  ? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5)
                  : null,
            ),
            child: Text(
              value != null ? value!.format(context) : '',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }
  
  Future<void> _selectTime(BuildContext context) async {
    final initialTime = value ?? TimeOfDay.now();
    
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    
    if (selectedTime != null) {
      onChanged(selectedTime);
    }
  }
}

class DateTimeFormField extends StatelessWidget {
  final FormFieldModel field;
  final DateTime? value;
  final String? error;
  final Function(DateTime?) onChanged;
  
  const DateTimeFormField({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    final dateFormat = field.options?.dateFormat ?? 'MMM dd, yyyy HH:mm';
    final formatter = DateFormat(dateFormat);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (field.label != null) ...[
          Row(
            children: [
              Text(
                field.label!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (field.required) ...[
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
        ],
        
        InkWell(
          onTap: field.disabled ? null : () => _selectDateTime(context),
          borderRadius: BorderRadius.circular(4),
          child: InputDecorator(
            decoration: InputDecoration(
              hintText: field.placeholder ?? 'Select date and time',
              helperText: field.helperText,
              errorText: error,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (value != null && !field.disabled)
                    IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () => onChanged(null),
                      splashRadius: 20,
                    ),
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 8),
                ],
              ),
              filled: field.disabled,
              fillColor: field.disabled
                  ? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5)
                  : null,
            ),
            child: Text(
              value != null ? formatter.format(value!) : '',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }
  
  Future<void> _selectDateTime(BuildContext context) async {
    final initialDate = value ?? DateTime.now();
    final firstDate = field.options?.minDate ?? DateTime(1900);
    final lastDate = field.options?.maxDate ?? DateTime(2100);
    
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    
    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(value ?? DateTime.now()),
      );
      
      if (selectedTime != null) {
        final dateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        onChanged(dateTime);
      }
    }
  }
}

class DateRangeFormField extends StatelessWidget {
  final FormFieldModel field;
  final DateTimeRange? value;
  final String? error;
  final Function(DateTimeRange?) onChanged;
  
  const DateRangeFormField({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    final dateFormat = field.options?.dateFormat ?? 'MMM dd, yyyy';
    final formatter = DateFormat(dateFormat);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (field.label != null) ...[
          Row(
            children: [
              Text(
                field.label!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (field.required) ...[
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
        ],
        
        InkWell(
          onTap: field.disabled ? null : () => _selectDateRange(context),
          borderRadius: BorderRadius.circular(4),
          child: InputDecorator(
            decoration: InputDecoration(
              hintText: field.placeholder ?? 'Select date range',
              helperText: field.helperText,
              errorText: error,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (value != null && !field.disabled)
                    IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () => onChanged(null),
                      splashRadius: 20,
                    ),
                  const Icon(Icons.date_range),
                  const SizedBox(width: 8),
                ],
              ),
              filled: field.disabled,
              fillColor: field.disabled
                  ? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5)
                  : null,
            ),
            child: Text(
              value != null
                  ? '${formatter.format(value!.start)} - ${formatter.format(value!.end)}'
                  : '',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }
  
  Future<void> _selectDateRange(BuildContext context) async {
    final initialDateRange = value ??
        DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now().add(const Duration(days: 7)),
        );
    final firstDate = field.options?.minDate ?? DateTime(1900);
    final lastDate = field.options?.maxDate ?? DateTime(2100);
    
    final selectedRange = await showDateRangePicker(
      context: context,
      initialDateRange: initialDateRange,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    
    if (selectedRange != null) {
      onChanged(selectedRange);
    }
  }
}