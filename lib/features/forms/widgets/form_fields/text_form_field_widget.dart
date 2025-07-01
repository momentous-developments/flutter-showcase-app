import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/form_models.dart';

class TextFormFieldWidget extends StatelessWidget {
  final FormFieldModel field;
  final dynamic value;
  final String? error;
  final Function(dynamic) onChanged;
  final VoidCallback? onTap;
  
  const TextFormFieldWidget({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
    this.onTap,
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
        
        TextFormField(
          initialValue: value?.toString(),
          enabled: !field.disabled,
          readOnly: field.readonly,
          obscureText: field.type == FormFieldType.password,
          keyboardType: _getKeyboardType(),
          textCapitalization: field.options?.textCapitalization ?? TextCapitalization.none,
          textInputAction: field.options?.textInputAction,
          maxLines: field.type == FormFieldType.multiline 
              ? (field.options?.maxLines ?? 5)
              : 1,
          minLines: field.type == FormFieldType.multiline
              ? (field.options?.minLines ?? 3)
              : 1,
          maxLength: field.options?.maxLength,
          inputFormatters: _getInputFormatters(),
          decoration: InputDecoration(
            hintText: field.placeholder,
            helperText: field.helperText,
            errorText: error,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            prefixIcon: field.options?.prefixIcon != null
                ? Icon(field.options!.prefixIcon)
                : null,
            suffixIcon: field.options?.suffixIcon != null
                ? Icon(field.options!.suffixIcon)
                : null,
            prefix: field.options?.prefix,
            suffix: field.options?.suffix,
            filled: field.disabled,
            fillColor: field.disabled
                ? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5)
                : null,
          ),
          onChanged: (value) => onChanged(value),
          onTap: onTap,
        ),
        
        if (field.state == FieldState.loading) ...[
          const SizedBox(height: 4),
          const LinearProgressIndicator(),
        ],
      ],
    );
  }
  
  TextInputType? _getKeyboardType() {
    switch (field.type) {
      case FormFieldType.email:
        return TextInputType.emailAddress;
      case FormFieldType.number:
        return TextInputType.numberWithOptions(
          decimal: (field.options?.step ?? 1) % 1 != 0,
        );
      case FormFieldType.phone:
        return TextInputType.phone;
      case FormFieldType.url:
        return TextInputType.url;
      case FormFieldType.multiline:
        return TextInputType.multiline;
      default:
        return field.options?.keyboardType ?? TextInputType.text;
    }
  }
  
  List<TextInputFormatter> _getInputFormatters() {
    final formatters = <TextInputFormatter>[];
    
    switch (field.type) {
      case FormFieldType.number:
        formatters.add(FilteringTextInputFormatter.allow(
          RegExp(r'[0-9.-]'),
        ));
        break;
      case FormFieldType.phone:
        formatters.add(_PhoneNumberFormatter());
        break;
      default:
        break;
    }
    
    if (field.options?.maxLength != null) {
      formatters.add(LengthLimitingTextInputFormatter(field.options!.maxLength));
    }
    
    return formatters;
  }
}

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    
    if (text.isEmpty) {
      return newValue;
    }
    
    // Remove all non-digits
    final digits = text.replaceAll(RegExp(r'\D'), '');
    
    // Format as US phone number
    String formatted = '';
    for (int i = 0; i < digits.length && i < 10; i++) {
      if (i == 0) {
        formatted = '(';
      } else if (i == 3) {
        formatted += ') ';
      } else if (i == 6) {
        formatted += '-';
      }
      formatted += digits[i];
    }
    
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}