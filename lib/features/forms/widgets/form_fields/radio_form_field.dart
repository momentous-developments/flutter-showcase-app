import 'package:flutter/material.dart';
import '../../models/form_models.dart';

class RadioFormField extends StatelessWidget {
  final FormFieldModel field;
  final dynamic value;
  final String? error;
  final Function(dynamic) onChanged;
  
  const RadioFormField({
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
        
        ...options.map((option) {
          return InkWell(
            onTap: field.disabled || option.disabled
                ? null
                : () => onChanged(option.value),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Radio<dynamic>(
                    value: option.value,
                    groupValue: value,
                    onChanged: field.disabled || option.disabled
                        ? null
                        : onChanged,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  const SizedBox(width: 8),
                  if (option.icon != null) ...[
                    Icon(option.icon, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option.label,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: option.disabled
                                ? Theme.of(context).colorScheme.onSurface.withOpacity(0.5)
                                : null,
                          ),
                        ),
                        if (option.description != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            option.description!,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        
        if (error != null) ...[
          const SizedBox(height: 8),
          Text(
            error!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
        
        if (field.helperText != null) ...[
          const SizedBox(height: 8),
          Text(
            field.helperText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

class RadioButtonFormField extends StatelessWidget {
  final FormFieldModel field;
  final dynamic value;
  final String? error;
  final Function(dynamic) onChanged;
  
  const RadioButtonFormField({
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
        
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = value == option.value;
            
            return ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (option.icon != null) ...[
                    Icon(option.icon, size: 18),
                    const SizedBox(width: 4),
                  ],
                  Text(option.label),
                ],
              ),
              selected: isSelected,
              onSelected: field.disabled || option.disabled
                  ? null
                  : (selected) {
                      if (selected) {
                        onChanged(option.value);
                      }
                    },
            );
          }).toList(),
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
        
        if (field.helperText != null) ...[
          const SizedBox(height: 8),
          Text(
            field.helperText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}