import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/chart_models.dart';

/// Container widget for charts with toolbar and controls
class ChartContainer extends StatefulWidget {
  final Widget child;
  final String? title;
  final String? subtitle;
  final List<Widget>? actions;
  final bool showToolbar;
  final VoidCallback? onRefresh;
  final VoidCallback? onExport;
  final VoidCallback? onFullscreen;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final Color? backgroundColor;

  const ChartContainer({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.actions,
    this.showToolbar = true,
    this.onRefresh,
    this.onExport,
    this.onFullscreen,
    this.padding,
    this.height,
    this.backgroundColor,
  });

  @override
  State<ChartContainer> createState() => _ChartContainerState();
}

class _ChartContainerState extends State<ChartContainer> {
  bool _isFullscreen = false;

  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
    });
    
    if (_isFullscreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
    
    widget.onFullscreen?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final content = Card(
      elevation: 0,
      color: widget.backgroundColor ?? colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showToolbar || widget.title != null)
            _buildHeader(theme, colorScheme),
          Flexible(
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.all(16),
              child: widget.child,
            ),
          ),
        ],
      ),
    );

    if (_isFullscreen) {
      return Scaffold(
        backgroundColor: colorScheme.surface,
        body: SafeArea(
          child: content,
        ),
      );
    }

    return SizedBox(
      height: widget.height,
      child: content,
    );
  }

  Widget _buildHeader(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          if (widget.title != null) ...[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title!,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (widget.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
          if (widget.actions != null) ...widget.actions!,
          if (widget.showToolbar) ...[
            if (widget.onRefresh != null)
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: widget.onRefresh,
                tooltip: 'Refresh',
                iconSize: 20,
              ),
            if (widget.onExport != null)
              IconButton(
                icon: const Icon(Icons.download),
                onPressed: widget.onExport,
                tooltip: 'Export',
                iconSize: 20,
              ),
            IconButton(
              icon: Icon(_isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen),
              onPressed: _toggleFullscreen,
              tooltip: _isFullscreen ? 'Exit fullscreen' : 'Fullscreen',
              iconSize: 20,
            ),
          ],
        ],
      ),
    );
  }
}

/// Chart toolbar widget
class ChartToolbar extends StatelessWidget {
  final List<ChartToolbarItem> items;
  final EdgeInsetsGeometry? padding;

  const ChartToolbar({
    super.key,
    required this.items,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: items.map((item) {
          if (item.isDivider) {
            return Container(
              width: 1,
              height: 24,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: colorScheme.outlineVariant,
            );
          }

          final Widget button = item.isToggle
              ? _buildToggleButton(item, colorScheme)
              : _buildActionButton(item, colorScheme);

          if (item.tooltip != null) {
            return Tooltip(
              message: item.tooltip!,
              child: button,
            );
          }

          return button;
        }).toList(),
      ),
    );
  }

  Widget _buildActionButton(ChartToolbarItem item, ColorScheme colorScheme) {
    return TextButton.icon(
      onPressed: item.onPressed,
      icon: Icon(item.icon, size: 18),
      label: Text(item.label),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        minimumSize: const Size(0, 32),
      ),
    );
  }

  Widget _buildToggleButton(ChartToolbarItem item, ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        color: item.isSelected ? colorScheme.primaryContainer : null,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextButton.icon(
        onPressed: item.onPressed,
        icon: Icon(
          item.icon,
          size: 18,
          color: item.isSelected ? colorScheme.onPrimaryContainer : null,
        ),
        label: Text(
          item.label,
          style: TextStyle(
            color: item.isSelected ? colorScheme.onPrimaryContainer : null,
          ),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          minimumSize: const Size(0, 32),
        ),
      ),
    );
  }
}

/// Chart toolbar item
class ChartToolbarItem {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final bool isToggle;
  final bool isSelected;
  final bool isDivider;

  const ChartToolbarItem({
    required this.label,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.isToggle = false,
    this.isSelected = false,
    this.isDivider = false,
  });

  const ChartToolbarItem.divider()
      : label = '',
        icon = Icons.remove,
        onPressed = null,
        tooltip = null,
        isToggle = false,
        isSelected = false,
        isDivider = true;
}