import 'package:flutter/material.dart';
import '../models/chart_models.dart';

/// Custom legend widget for charts
class ChartLegend extends StatelessWidget {
  final List<ChartSeries> series;
  final ChartLegendPosition position;
  final ChartLegendAlignment alignment;
  final bool showValues;
  final Function(int index, bool selected)? onItemToggle;
  final Map<int, bool> selectedItems;
  final EdgeInsetsGeometry? padding;
  final double itemSpacing;
  final double indicatorSize;
  final TextStyle? textStyle;

  const ChartLegend({
    super.key,
    required this.series,
    this.position = ChartLegendPosition.bottom,
    this.alignment = ChartLegendAlignment.center,
    this.showValues = false,
    this.onItemToggle,
    this.selectedItems = const {},
    this.padding,
    this.itemSpacing = 16,
    this.indicatorSize = 12,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final defaultColors = ChartTheme.fromColorScheme(colorScheme).colors;

    final items = <Widget>[];
    for (int i = 0; i < series.length; i++) {
      if (!series[i].showInLegend) continue;

      final isSelected = selectedItems[i] ?? true;
      final color = series[i].color ?? defaultColors[i % defaultColors.length];

      items.add(
        _LegendItem(
          label: series[i].name,
          color: color,
          value: showValues ? _getSeriesValue(series[i]) : null,
          isSelected: isSelected,
          onTap: onItemToggle != null ? () => onItemToggle!(i, !isSelected) : null,
          indicatorSize: indicatorSize,
          textStyle: textStyle,
        ),
      );
    }

    Widget legend;
    switch (position) {
      case ChartLegendPosition.top:
      case ChartLegendPosition.bottom:
        legend = Wrap(
          spacing: itemSpacing,
          runSpacing: itemSpacing / 2,
          alignment: _getWrapAlignment(),
          children: items,
        );
        break;
      case ChartLegendPosition.left:
      case ChartLegendPosition.right:
        legend = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: _getCrossAxisAlignment(),
          children: items
              .map((item) => Padding(
                    padding: EdgeInsets.only(bottom: itemSpacing / 2),
                    child: item,
                  ))
              .toList(),
        );
        break;
    }

    return Padding(
      padding: padding ?? const EdgeInsets.all(8),
      child: legend,
    );
  }

  WrapAlignment _getWrapAlignment() {
    switch (alignment) {
      case ChartLegendAlignment.start:
        return WrapAlignment.start;
      case ChartLegendAlignment.center:
        return WrapAlignment.center;
      case ChartLegendAlignment.end:
        return WrapAlignment.end;
    }
  }

  CrossAxisAlignment _getCrossAxisAlignment() {
    switch (alignment) {
      case ChartLegendAlignment.start:
        return CrossAxisAlignment.start;
      case ChartLegendAlignment.center:
        return CrossAxisAlignment.center;
      case ChartLegendAlignment.end:
        return CrossAxisAlignment.end;
    }
  }

  String _getSeriesValue(ChartSeries series) {
    if (series.data.isEmpty) return '';
    
    // Calculate appropriate value based on series type
    switch (series.type) {
      case ChartSeriesType.pie:
      case ChartSeriesType.donut:
        final total = series.data.fold(0.0, (sum, point) => sum + point.y);
        return total.toStringAsFixed(0);
      default:
        // Return last value for other chart types
        return series.data.last.y.toStringAsFixed(1);
    }
  }
}

/// Individual legend item
class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;
  final String? value;
  final bool isSelected;
  final VoidCallback? onTap;
  final double indicatorSize;
  final TextStyle? textStyle;

  const _LegendItem({
    required this.label,
    required this.color,
    this.value,
    this.isSelected = true,
    this.onTap,
    required this.indicatorSize,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveTextStyle = textStyle ?? theme.textTheme.bodySmall;

    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: AnimatedOpacity(
          opacity: isSelected ? 1.0 : 0.5,
          duration: const Duration(milliseconds: 200),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: indicatorSize,
                height: indicatorSize,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: effectiveTextStyle?.copyWith(
                  decoration: isSelected ? null : TextDecoration.lineThrough,
                ),
              ),
              if (value != null) ...[
                const SizedBox(width: 4),
                Text(
                  '($value)',
                  style: effectiveTextStyle?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Legend position options
enum ChartLegendPosition {
  top,
  bottom,
  left,
  right,
}

/// Legend alignment options
enum ChartLegendAlignment {
  start,
  center,
  end,
}

/// Chart legend configuration
class ChartLegendConfig {
  final bool show;
  final ChartLegendPosition position;
  final ChartLegendAlignment alignment;
  final bool showValues;
  final EdgeInsetsGeometry? padding;
  final double itemSpacing;
  final double indicatorSize;
  final TextStyle? textStyle;

  const ChartLegendConfig({
    this.show = true,
    this.position = ChartLegendPosition.bottom,
    this.alignment = ChartLegendAlignment.center,
    this.showValues = false,
    this.padding,
    this.itemSpacing = 16,
    this.indicatorSize = 12,
    this.textStyle,
  });

  ChartLegendConfig copyWith({
    bool? show,
    ChartLegendPosition? position,
    ChartLegendAlignment? alignment,
    bool? showValues,
    EdgeInsetsGeometry? padding,
    double? itemSpacing,
    double? indicatorSize,
    TextStyle? textStyle,
  }) {
    return ChartLegendConfig(
      show: show ?? this.show,
      position: position ?? this.position,
      alignment: alignment ?? this.alignment,
      showValues: showValues ?? this.showValues,
      padding: padding ?? this.padding,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}