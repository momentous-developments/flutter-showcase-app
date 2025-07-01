import 'package:flutter/material.dart';
import '../../models/form_models.dart';

class ToggleFormField extends StatelessWidget {
  final FormFieldModel field;
  final bool value;
  final String? error;
  final Function(bool) onChanged;
  
  const ToggleFormField({
    super.key,
    required this.field,
    required this.value,
    this.error,
    required this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
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
                  ],
                  if (field.helperText != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      field.helperText!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: field.disabled ? null : onChanged,
            ),
          ],
        ),
        if (error != null) ...[
          const SizedBox(height: 8),
          Text(
            error!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
}

class ToggleButtonsFormField extends StatelessWidget {
  final FormFieldModel field;
  final List<bool> value;
  final String? error;
  final Function(List<bool>) onChanged;
  
  const ToggleButtonsFormField({
    super.key,
    required this.field,
    required this.value,
    this.error,
    required this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    final options = field.options?.options ?? [];
    
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
          const SizedBox(height: 12),
        ],
        
        LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ToggleButtons(
                isSelected: value,
                onPressed: field.disabled
                    ? null
                    : (index) {
                        final newValue = List<bool>.from(value);
                        newValue[index] = !newValue[index];
                        onChanged(newValue);
                      },
                borderRadius: BorderRadius.circular(8),
                children: options.map((option) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (option.icon != null) ...[
                          Icon(option.icon, size: 20),
                          const SizedBox(width: 8),
                        ],
                        Text(option.label),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
        
        if (field.helperText != null) ...[
          const SizedBox(height: 8),
          Text(
            field.helperText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        
        if (error != null) ...[
          const SizedBox(height: 8),
          Text(
            error!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
}

class SegmentedButtonFormField extends StatelessWidget {
  final FormFieldModel field;
  final dynamic value;
  final String? error;
  final Function(dynamic) onChanged;
  
  const SegmentedButtonFormField({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    final options = field.options?.options ?? [];
    
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
          const SizedBox(height: 12),
        ],
        
        SegmentedButton<dynamic>(
          segments: options.map((option) {
            return ButtonSegment<dynamic>(
              value: option.value,
              label: Text(option.label),
              icon: option.icon != null ? Icon(option.icon, size: 20) : null,
              enabled: !option.disabled,
            );
          }).toList(),
          selected: value != null ? {value} : {},
          onSelectionChanged: field.disabled
              ? null
              : (selection) {
                  if (selection.isNotEmpty) {
                    onChanged(selection.first);
                  }
                },
        ),
        
        if (field.helperText != null) ...[
          const SizedBox(height: 8),
          Text(
            field.helperText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        
        if (error != null) ...[
          const SizedBox(height: 8),
          Text(
            error!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
}