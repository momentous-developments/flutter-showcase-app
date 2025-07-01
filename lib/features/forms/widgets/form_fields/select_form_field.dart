import 'package:flutter/material.dart';
import '../../models/form_models.dart';

class SelectFormField extends StatelessWidget {
  final FormFieldModel field;
  final dynamic value;
  final String? error;
  final Function(dynamic) onChanged;
  
  const SelectFormField({
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
          const SizedBox(height: 8),
        ],
        
        if (field.type == FormFieldType.multiSelect)
          _buildMultiSelect(context, options)
        else
          _buildSingleSelect(context, options),
        
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
  
  Widget _buildSingleSelect(BuildContext context, List<SelectOption> options) {
    return DropdownButtonFormField<dynamic>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        hintText: field.placeholder ?? 'Select an option',
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        errorText: error,
        filled: field.disabled,
        fillColor: field.disabled
            ? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5)
            : null,
      ),
      items: options.map((option) {
        return DropdownMenuItem(
          value: option.value,
          enabled: !option.disabled,
          child: Row(
            children: [
              if (option.icon != null) ...[
                Icon(option.icon, size: 20),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(option.label),
                    if (option.description != null)
                      Text(
                        option.description!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: field.disabled ? null : onChanged,
    );
  }
  
  Widget _buildMultiSelect(BuildContext context, List<SelectOption> options) {
    final selectedValues = value is List ? List.from(value) : [];
    
    return InkWell(
      onTap: field.disabled
          ? null
          : () => _showMultiSelectDialog(context, options, selectedValues),
      borderRadius: BorderRadius.circular(4),
      child: InputDecorator(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          errorText: error,
          filled: field.disabled,
          fillColor: field.disabled
              ? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5)
              : null,
          suffixIcon: const Icon(Icons.arrow_drop_down),
        ),
        child: selectedValues.isEmpty
            ? Text(
                field.placeholder ?? 'Select options',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              )
            : Wrap(
                spacing: 8,
                runSpacing: 4,
                children: selectedValues.map((val) {
                  final option = options.firstWhere(
                    (opt) => opt.value == val,
                    orElse: () => SelectOption(value: val, label: val.toString()),
                  );
                  return Chip(
                    label: Text(option.label),
                    onDeleted: field.disabled
                        ? null
                        : () {
                            final newValues = List.from(selectedValues)..remove(val);
                            onChanged(newValues);
                          },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                }).toList(),
              ),
      ),
    );
  }
  
  void _showMultiSelectDialog(
    BuildContext context,
    List<SelectOption> options,
    List<dynamic> selectedValues,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return _MultiSelectDialog(
          title: field.label ?? 'Select Options',
          options: options,
          selectedValues: selectedValues,
          onConfirm: onChanged,
        );
      },
    );
  }
}

class _MultiSelectDialog extends StatefulWidget {
  final String title;
  final List<SelectOption> options;
  final List<dynamic> selectedValues;
  final Function(List<dynamic>) onConfirm;
  
  const _MultiSelectDialog({
    required this.title,
    required this.options,
    required this.selectedValues,
    required this.onConfirm,
  });
  
  @override
  State<_MultiSelectDialog> createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<_MultiSelectDialog> {
  late List<dynamic> _selectedValues;
  
  @override
  void initState() {
    super.initState();
    _selectedValues = List.from(widget.selectedValues);
  }
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.options.map((option) {
            final isSelected = _selectedValues.contains(option.value);
            return CheckboxListTile(
              value: isSelected,
              enabled: !option.disabled,
              title: Text(option.label),
              subtitle: option.description != null
                  ? Text(option.description!)
                  : null,
              secondary: option.icon != null
                  ? Icon(option.icon)
                  : null,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _selectedValues.add(option.value);
                  } else {
                    _selectedValues.remove(option.value);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            widget.onConfirm(_selectedValues);
            Navigator.of(context).pop();
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}