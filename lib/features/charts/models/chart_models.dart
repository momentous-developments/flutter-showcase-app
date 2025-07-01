import 'package:flutter/material.dart';

/// Base class for chart data points
class ChartPoint {
  final double x;
  final double y;
  final String? label;
  final Color? color;
  final dynamic customData;

  const ChartPoint({
    required this.x,
    required this.y,
    this.label,
    this.color,
    this.customData,
  });

  ChartPoint copyWith({
    double? x,
    double? y,
    String? label,
    Color? color,
    dynamic customData,
  }) {
    return ChartPoint(
      x: x ?? this.x,
      y: y ?? this.y,
      label: label ?? this.label,
      color: color ?? this.color,
      customData: customData ?? this.customData,
    );
  }
}

/// Extended chart point for financial data
class FinancialPoint extends ChartPoint {
  final double open;
  final double high;
  final double low;
  final double close;
  final double? volume;
  final DateTime timestamp;

  FinancialPoint({
    required super.x,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.timestamp,
    this.volume,
    super.label,
    super.color,
  }) : super(y: close);
}

/// Chart series data
class ChartSeries {
  final String name;
  final List<ChartPoint> data;
  final Color? color;
  final bool showInLegend;
  final ChartSeriesType type;
  final Map<String, dynamic> style;

  const ChartSeries({
    required this.name,
    required this.data,
    this.color,
    this.showInLegend = true,
    this.type = ChartSeriesType.line,
    this.style = const {},
  });

  ChartSeries copyWith({
    String? name,
    List<ChartPoint>? data,
    Color? color,
    bool? showInLegend,
    ChartSeriesType? type,
    Map<String, dynamic>? style,
  }) {
    return ChartSeries(
      name: name ?? this.name,
      data: data ?? this.data,
      color: color ?? this.color,
      showInLegend: showInLegend ?? this.showInLegend,
      type: type ?? this.type,
      style: style ?? this.style,
    );
  }
}

/// Chart series types
enum ChartSeriesType {
  line,
  area,
  bar,
  column,
  scatter,
  pie,
  donut,
  radar,
  candlestick,
  heatmap,
  radialBar,
}

/// Chart configuration
class ChartConfig {
  final String title;
  final String subtitle;
  final ChartType type;
  final bool showLegend;
  final bool showTooltip;
  final bool showGrid;
  final bool enableZoom;
  final bool enablePan;
  final bool animate;
  final Duration animationDuration;
  final ChartTheme? theme;
  final Map<String, dynamic> customSettings;

  const ChartConfig({
    this.title = '',
    this.subtitle = '',
    required this.type,
    this.showLegend = true,
    this.showTooltip = true,
    this.showGrid = true,
    this.enableZoom = false,
    this.enablePan = false,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 500),
    this.theme,
    this.customSettings = const {},
  });

  ChartConfig copyWith({
    String? title,
    String? subtitle,
    ChartType? type,
    bool? showLegend,
    bool? showTooltip,
    bool? showGrid,
    bool? enableZoom,
    bool? enablePan,
    bool? animate,
    Duration? animationDuration,
    ChartTheme? theme,
    Map<String, dynamic>? customSettings,
  }) {
    return ChartConfig(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      type: type ?? this.type,
      showLegend: showLegend ?? this.showLegend,
      showTooltip: showTooltip ?? this.showTooltip,
      showGrid: showGrid ?? this.showGrid,
      enableZoom: enableZoom ?? this.enableZoom,
      enablePan: enablePan ?? this.enablePan,
      animate: animate ?? this.animate,
      animationDuration: animationDuration ?? this.animationDuration,
      theme: theme ?? this.theme,
      customSettings: customSettings ?? this.customSettings,
    );
  }
}

/// Chart types
enum ChartType {
  area,
  bar,
  candlestick,
  column,
  donut,
  heatmap,
  line,
  pie,
  radar,
  radialBar,
  scatter,
  // Dashboard specific
  analytics,
  revenue,
  userGrowth,
  conversion,
  traffic,
  performance,
}

/// Chart theme configuration
class ChartTheme {
  final List<Color> colors;
  final Color backgroundColor;
  final Color gridColor;
  final Color axisColor;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final TextStyle? labelStyle;
  final TextStyle? tooltipStyle;

  const ChartTheme({
    required this.colors,
    required this.backgroundColor,
    required this.gridColor,
    required this.axisColor,
    this.titleStyle,
    this.subtitleStyle,
    this.labelStyle,
    this.tooltipStyle,
  });

  factory ChartTheme.fromColorScheme(ColorScheme colorScheme) {
    return ChartTheme(
      colors: [
        colorScheme.primary,
        colorScheme.secondary,
        colorScheme.tertiary,
        colorScheme.error,
        colorScheme.primaryContainer,
        colorScheme.secondaryContainer,
        colorScheme.tertiaryContainer,
        colorScheme.errorContainer,
      ],
      backgroundColor: colorScheme.surface,
      gridColor: colorScheme.outlineVariant.withOpacity(0.2),
      axisColor: colorScheme.outline,
    );
  }
}

/// Chart data source
class ChartDataSource {
  final String id;
  final String name;
  final List<ChartSeries> series;
  final DateTime? lastUpdated;
  final Map<String, dynamic> metadata;

  const ChartDataSource({
    required this.id,
    required this.name,
    required this.series,
    this.lastUpdated,
    this.metadata = const {},
  });
}

/// Chart filter
class ChartFilter {
  final String name;
  final ChartFilterType type;
  final dynamic value;
  final List<dynamic>? options;

  const ChartFilter({
    required this.name,
    required this.type,
    this.value,
    this.options,
  });
}

/// Chart filter types
enum ChartFilterType {
  dateRange,
  category,
  numeric,
  boolean,
  multiSelect,
}

/// Chart export configuration
class ChartExportConfig {
  final ChartExportFormat format;
  final double? width;
  final double? height;
  final double pixelRatio;
  final Color? backgroundColor;

  const ChartExportConfig({
    required this.format,
    this.width,
    this.height,
    this.pixelRatio = 2.0,
    this.backgroundColor,
  });
}

/// Chart export formats
enum ChartExportFormat {
  png,
  jpg,
  pdf,
  svg,
  csv,
}

/// Chart tooltip data
class ChartTooltipData {
  final ChartPoint point;
  final ChartSeries series;
  final int seriesIndex;
  final int pointIndex;

  const ChartTooltipData({
    required this.point,
    required this.series,
    required this.seriesIndex,
    required this.pointIndex,
  });
}

/// Chart interaction event
class ChartInteractionEvent {
  final ChartInteractionType type;
  final ChartTooltipData? data;
  final Offset? position;

  const ChartInteractionEvent({
    required this.type,
    this.data,
    this.position,
  });
}

/// Chart interaction types
enum ChartInteractionType {
  tap,
  doubleTap,
  longPress,
  hover,
  pan,
  zoom,
}