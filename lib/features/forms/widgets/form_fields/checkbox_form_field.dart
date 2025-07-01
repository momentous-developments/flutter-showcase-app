import 'package:flutter/material.dart';
import '../../models/form_models.dart';

class CheckboxFormField extends StatelessWidget {
  final FormFieldModel field;
  final bool value;
  final String? error;
  final Function(bool) onChanged;
  
  const CheckboxFormField({
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
        InkWell(
          onTap: field.disabled ? null : () => onChanged(!value),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Checkbox(
                  value: value,
                  onChanged: field.disabled ? null : (val) => onChanged(val ?? false),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              field.label ?? '',
                              style: Theme.of(context).textTheme.bodyMedium,
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
              ],
            ),
          ),
        ),
        if (error != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              error!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class CheckboxGroupFormField extends StatelessWidget {
  final FormFieldModel field;
  final List<dynamic> value;
  final String? error;
  final Function(List<dynamic>) onChanged;
  
  const CheckboxGroupFormField({
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
        
        ...options.map((option) {
          final isSelected = value.contains(option.value);
          
          return InkWell(
            onTap: field.disabled || option.disabled
                ? null
                : () {
                    final newValue = List<dynamic>.from(value);
                    if (isSelected) {
                      newValue.remove(option.value);
                    } else {
                      newValue.add(option.value);
                    }
                    onChanged(newValue);
                  },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Checkbox(
                    value: isSelected,
                    onChanged: field.disabled || option.disabled
                        ? null
                        : (val) {
                            final newValue = List<dynamic>.from(value);
                            if (val == true) {
                              newValue.add(option.value);
                            } else {
                              newValue.remove(option.value);
                            }
                            onChanged(newValue);
                          },
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