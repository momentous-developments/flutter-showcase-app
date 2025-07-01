import 'package:flutter/material.dart';

/// Base dialog wrapper with consistent styling and behavior
class BaseDialog extends StatelessWidget {
  const BaseDialog({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.showCloseButton = true,
    this.size = DialogSize.medium,
    this.padding,
    this.onClose,
    this.actions,
    this.scrollable = true,
  });

  final Widget child;
  final String? title;
  final String? subtitle;
  final bool showCloseButton;
  final DialogSize size;
  final EdgeInsets? padding;
  final VoidCallback? onClose;
  final List<Widget>? actions;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      elevation: 6,
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      child: Container(
        constraints: _getConstraints(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null || showCloseButton) _buildHeader(context),
            Flexible(
              child: scrollable
                  ? SingleChildScrollView(
                      padding: padding ??
                          const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                      child: child,
                    )
                  : Padding(
                      padding: padding ??
                          const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                      child: child,
                    ),
            ),
            if (actions != null) _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 8, 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (showCloseButton)
            IconButton(
              onPressed: onClose ?? () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.close,
                color: colorScheme.onSurfaceVariant,
              ),
              style: IconButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: actions!
            .map((action) => Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: action,
                ))
            .toList(),
      ),
    );
  }

  BoxConstraints _getConstraints() {
    switch (size) {
      case DialogSize.small:
        return const BoxConstraints(
          maxWidth: 400,
          maxHeight: 300,
        );
      case DialogSize.medium:
        return const BoxConstraints(
          maxWidth: 560,
          maxHeight: 600,
        );
      case DialogSize.large:
        return const BoxConstraints(
          maxWidth: 800,
          maxHeight: 800,
        );
      case DialogSize.fullscreen:
        return const BoxConstraints(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
        );
    }
  }
}

enum DialogSize {
  small,
  medium,
  large,
  fullscreen,
}