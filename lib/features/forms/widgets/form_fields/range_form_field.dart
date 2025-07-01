import 'package:flutter/material.dart';
import '../../models/form_models.dart';

class RangeFormField extends StatelessWidget {
  final FormFieldModel field;
  final double? value;
  final String? error;
  final Function(double) onChanged;
  
  const RangeFormField({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    final min = field.options?.min ?? 0.0;
    final max = field.options?.max ?? 100.0;
    final divisions = ((max - min) / (field.options?.step ?? 1)).round();
    final currentValue = value ?? min;
    
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
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _formatValue(currentValue),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        
        SliderTheme(
          data: SliderThemeData(
            showValueIndicator: ShowValueIndicator.always,
            valueIndicatorTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          child: Slider(
            value: currentValue,
            min: min,
            max: max,
            divisions: divisions > 0 ? divisions : null,
            label: _formatValue(currentValue),
            onChanged: field.disabled ? null : onChanged,
          ),
        ),
        
        // Min and Max labels
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatValue(min),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                _formatValue(max),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
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
  
  String _formatValue(double value) {
    final prefix = field.options?.prefix ?? '';
    final suffix = field.options?.suffix ?? '';
    final decimalPlaces = (field.options?.step ?? 1) < 1 ? 2 : 0;
    
    return '$prefix${value.toStringAsFixed(decimalPlaces)}$suffix';
  }
}

class RangeSliderFormField extends StatelessWidget {
  final FormFieldModel field;
  final RangeValues? value;
  final String? error;
  final Function(RangeValues) onChanged;
  
  const RangeSliderFormField({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    final min = field.options?.min ?? 0.0;
    final max = field.options?.max ?? 100.0;
    final divisions = ((max - min) / (field.options?.step ?? 1)).round();
    final currentValue = value ?? RangeValues(min, max);
    
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
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${_formatValue(currentValue.start)} - ${_formatValue(currentValue.end)}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        
        RangeSlider(
          values: currentValue,
          min: min,
          max: max,
          divisions: divisions > 0 ? divisions : null,
          labels: RangeLabels(
            _formatValue(currentValue.start),
            _formatValue(currentValue.end),
          ),
          onChanged: field.disabled ? null : onChanged,
        ),
        
        // Min and Max labels
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatValue(min),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                _formatValue(max),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
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
  
  String _formatValue(double value) {
    final prefix = field.options?.prefix ?? '';
    final suffix = field.options?.suffix ?? '';
    final decimalPlaces = (field.options?.step ?? 1) < 1 ? 2 : 0;
    
    return '$prefix${value.toStringAsFixed(decimalPlaces)}$suffix';
  }
}