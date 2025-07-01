import 'package:flutter/material.dart';
import '../models/dialog_models.dart';
import 'base_dialog.dart';
import 'dialog_footer.dart';

/// Dialog wrapper with form validation support
class FormDialog extends StatefulWidget {
  const FormDialog({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.onSubmit,
    this.onCancel,
    this.submitText = 'Submit',
    this.cancelText = 'Cancel',
    this.size = DialogSize.medium,
    this.isLoading = false,
    this.canSubmit = true,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final VoidCallback? onSubmit;
  final VoidCallback? onCancel;
  final String submitText;
  final String cancelText;
  final DialogSize size;
  final bool isLoading;
  final bool canSubmit;

  @override
  State<FormDialog> createState() => _FormDialogState();
}

class _FormDialogState extends State<FormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ValidationState _validationState = const ValidationState();

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: widget.title,
      subtitle: widget.subtitle,
      size: widget.size,
      showCloseButton: true,
      onClose: widget.onCancel ?? () => Navigator.of(context).pop(),
      scrollable: false,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: widget.child,
              ),
            ),
            DialogFooter(
              isLoading: widget.isLoading,
              primaryAction: DialogActionButton.primary(
                text: widget.submitText,
                onPressed: widget.canSubmit && !widget.isLoading
                    ? () => _handleSubmit()
                    : null,
                isLoading: widget.isLoading,
              ),
              secondaryAction: DialogActionButton.outlined(
                text: widget.cancelText,
                onPressed: widget.isLoading
                    ? null
                    : widget.onCancel ?? () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit?.call();
    }
  }

  void updateValidationState(ValidationState state) {
    setState(() {
      _validationState = state;
    });
  }
}

/// Form field with consistent styling
class DialogFormField extends StatelessWidget {
  const DialogFormField({
    super.key,
    required this.label,
    this.hint,
    this.value,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.enabled = true,
    this.required = false,
    this.suffixIcon,
    this.prefixIcon,
  });

  final String label;
  final String? hint;
  final String? value;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final bool enabled;
  final bool required;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: value,
        onChanged: onChanged,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          hintText: hint,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

/// Dropdown form field with consistent styling
class DialogDropdownField<T> extends StatelessWidget {
  const DialogDropdownField({
    super.key,
    required this.label,
    this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.enabled = true,
    this.required = false,
  });

  final String label;
  final String? hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? Function(T?)? validator;
  final bool enabled;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<T>(
        value: value,
        items: items,
        onChanged: enabled ? onChanged : null,
        validator: validator,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}