import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../models/chart_models.dart';

/// Custom tooltip widget for charts
class ChartTooltip extends StatelessWidget {
  final ChartTooltipData data;
  final ChartTooltipConfig? config;
  final VoidCallback? onClose;

  const ChartTooltip({
    super.key,
    required this.data,
    this.config,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final effectiveConfig = config ?? ChartTooltipConfig();

    return Container(
      constraints: BoxConstraints(
        maxWidth: effectiveConfig.maxWidth,
      ),
      child: Card(
        elevation: effectiveConfig.elevation,
        color: effectiveConfig.backgroundColor ?? colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(effectiveConfig.borderRadius),
          side: BorderSide(
            color: effectiveConfig.borderColor ?? colorScheme.outlineVariant,
            width: effectiveConfig.borderWidth,
          ),
        ),
        child: Padding(
          padding: effectiveConfig.padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (effectiveConfig.showHeader) _buildHeader(theme, colorScheme),
              _buildContent(theme, colorScheme, effectiveConfig),
              if (effectiveConfig.showFooter && data.point.customData != null)
                _buildFooter(theme, colorScheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: data.series.color ?? theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                data.series.name,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (onClose != null)
            IconButton(
              icon: const Icon(Icons.close),
              iconSize: 16,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              onPressed: onClose,
            ),
        ],
      ),
    );
  }

  Widget _buildContent(ThemeData theme, ColorScheme colorScheme, ChartTooltipConfig config) {
    final items = <Widget>[];

    // Add label if available
    if (data.point.label != null) {
      items.add(
        Text(
          data.point.label!,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      );
      items.add(const SizedBox(height: 4));
    }

    // Add main value
    items.add(
      Row(
        children: [
          if (config.showValueLabel)
            Text(
              '${config.valueLabel}: ',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          Text(
            _formatValue(data.point.y, config),
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );

    // Add X value if different from label
    if (config.showXValue && data.point.label == null) {
      items.add(const SizedBox(height: 4));
      items.add(
        Text(
          '${config.xLabel}: ${_formatValue(data.point.x, config)}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    // Add financial data if available
    if (data.point is FinancialPoint) {
      final financial = data.point as FinancialPoint;
      items.add(const SizedBox(height: 8));
      items.addAll(_buildFinancialData(financial, theme, colorScheme, config));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }

  List<Widget> _buildFinancialData(
    FinancialPoint point,
    ThemeData theme,
    ColorScheme colorScheme,
    ChartTooltipConfig config,
  ) {
    return [
      _buildValueRow('Open', point.open, theme, colorScheme, config),
      _buildValueRow('High', point.high, theme, colorScheme, config),
      _buildValueRow('Low', point.low, theme, colorScheme, config),
      _buildValueRow('Close', point.close, theme, colorScheme, config),
      if (point.volume != null)
        _buildValueRow('Volume', point.volume!, theme, colorScheme, config),
    ];
  }

  Widget _buildValueRow(
    String label,
    double value,
    ThemeData theme,
    ColorScheme colorScheme,
    ChartTooltipConfig config,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            _formatValue(value, config),
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(ThemeData theme, ColorScheme colorScheme) {
    final customData = data.point.customData as Map<String, dynamic>;
    return Container(
      padding: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant,
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: customData.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatKey(entry.key),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  _formatCustomValue(entry.value),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  String _formatValue(double value, ChartTooltipConfig config) {
    if (config.valueFormatter != null) {
      return config.valueFormatter!(value);
    }
    return value.toStringAsFixed(config.decimalPlaces);
  }

  String _formatKey(String key) {
    // Convert camelCase to Title Case
    return key.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(0)}',
    ).trim().split(' ').map((word) {
      return word.isNotEmpty
          ? '${word[0].toUpperCase()}${word.substring(1)}'
          : '';
    }).join(' ');
  }

  String _formatCustomValue(dynamic value) {
    if (value is double) {
      return value.toStringAsFixed(2);
    } else if (value is DateTime) {
      return '${value.day}/${value.month}/${value.year}';
    }
    return value.toString();
  }
}

/// Tooltip configuration
class ChartTooltipConfig {
  final bool showHeader;
  final bool showFooter;
  final bool showXValue;
  final bool showValueLabel;
  final String xLabel;
  final String valueLabel;
  final int decimalPlaces;
  final String Function(double value)? valueFormatter;
  final double maxWidth;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final double elevation;

  const ChartTooltipConfig({
    this.showHeader = true,
    this.showFooter = false,
    this.showXValue = false,
    this.showValueLabel = true,
    this.xLabel = 'X',
    this.valueLabel = 'Value',
    this.decimalPlaces = 2,
    this.valueFormatter,
    this.maxWidth = 200,
    this.padding = const EdgeInsets.all(12),
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1,
    this.borderRadius = 8,
    this.elevation = 4,
  });
}

/// Overlay tooltip that can be positioned
class ChartTooltipOverlay extends StatefulWidget {
  final Widget child;
  final List<ChartTooltipEntry> tooltips;
  final ChartTooltipConfig? config;

  const ChartTooltipOverlay({
    super.key,
    required this.child,
    required this.tooltips,
    this.config,
  });

  @override
  State<ChartTooltipOverlay> createState() => _ChartTooltipOverlayState();
}

class _ChartTooltipOverlayState extends State<ChartTooltipOverlay> {
  final _overlayKey = GlobalKey<OverlayState>();
  final Map<String, OverlayEntry> _overlayEntries = {};

  @override
  void didUpdateWidget(ChartTooltipOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateTooltips();
  }

  void _updateTooltips() {
    // Remove tooltips that are no longer in the list
    final currentIds = widget.tooltips.map((t) => t.id).toSet();
    _overlayEntries.keys.toList().forEach((id) {
      if (!currentIds.contains(id)) {
        _overlayEntries[id]?.remove();
        _overlayEntries.remove(id);
      }
    });

    // Add or update tooltips
    for (final tooltip in widget.tooltips) {
      if (!_overlayEntries.containsKey(tooltip.id)) {
        final entry = OverlayEntry(
          builder: (context) => _TooltipPositioned(
            position: tooltip.position,
            child: ChartTooltip(
              data: tooltip.data,
              config: widget.config,
              onClose: () => _removeTooltip(tooltip.id),
            ),
          ),
        );
        _overlayEntries[tooltip.id] = entry;
        Overlay.of(context).insert(entry);
      }
    }
  }

  void _removeTooltip(String id) {
    _overlayEntries[id]?.remove();
    _overlayEntries.remove(id);
  }

  @override
  void dispose() {
    _overlayEntries.values.forEach((entry) => entry.remove());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// Tooltip entry for overlay
class ChartTooltipEntry {
  final String id;
  final ChartTooltipData data;
  final Offset position;

  const ChartTooltipEntry({
    required this.id,
    required this.data,
    required this.position,
  });
}

/// Positioned tooltip widget
class _TooltipPositioned extends StatelessWidget {
  final Offset position;
  final Widget child;

  const _TooltipPositioned({
    required this.position,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: IgnorePointer(
        child: child,
      ),
    );
  }
}