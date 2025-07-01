import 'package:flutter/material.dart';

/// Reusable dialog footer with action buttons
class DialogFooter extends StatelessWidget {
  const DialogFooter({
    super.key,
    this.primaryAction,
    this.secondaryAction,
    this.tertiaryAction,
    this.alignment = MainAxisAlignment.end,
    this.backgroundColor,
    this.isLoading = false,
  });

  final Widget? primaryAction;
  final Widget? secondaryAction;
  final Widget? tertiaryAction;
  final MainAxisAlignment alignment;
  final Color? backgroundColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final actions = <Widget>[];
    if (tertiaryAction != null) actions.add(tertiaryAction!);
    if (secondaryAction != null) actions.add(secondaryAction!);
    if (primaryAction != null) actions.add(primaryAction!);

    if (actions.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          if (isLoading) ...[
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
          ],
          ...actions
              .map((action) => Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: action,
                  ))
              .toList(),
        ],
      ),
    );
  }
}

/// Builder for common dialog action buttons
class DialogActionButton {
  static Widget primary({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Icon? icon,
  }) {
    if (icon != null || isLoading) {
      return FilledButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : icon!,
        label: Text(text),
      );
    } else {
      return FilledButton(
        onPressed: onPressed,
        child: Text(text),
      );
    }
  }

  static Widget secondary({
    required String text,
    required VoidCallback? onPressed,
    Icon? icon,
  }) {
    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(text),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      );
    }
  }

  static Widget text({
    required String text,
    required VoidCallback? onPressed,
    Icon? icon,
  }) {
    if (icon != null) {
      return TextButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(text),
      );
    } else {
      return TextButton(
        onPressed: onPressed,
        child: Text(text),
      );
    }
  }

  static Widget outlined({
    required String text,
    required VoidCallback? onPressed,
    Icon? icon,
  }) {
    if (icon != null) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(text),
      );
    } else {
      return OutlinedButton(
        onPressed: onPressed,
        child: Text(text),
      );
    }
  }
}