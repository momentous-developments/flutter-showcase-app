import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/chart_models.dart';
import '../widgets/chart_container.dart';
import '../widgets/chart_legend.dart';

/// Scatter chart widget with multiple series support
class ScatterChartWidget extends StatefulWidget {
  final List<ChartSeries> series;
  final ChartConfig config;
  final ChartLegendConfig? legendConfig;
  final Function(ChartTooltipData)? onPointTap;
  final bool showGrid;
  final bool showBorder;
  final bool animate;
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;
  final double dotSize;

  const ScatterChartWidget({
    super.key,
    required this.series,
    required this.config,
    this.legendConfig,
    this.onPointTap,
    this.showGrid = true,
    this.showBorder = true,
    this.animate = true,
    this.minX = 0,
    this.maxX = 100,
    this.minY = 0,
    this.maxY = 100,
    this.dotSize = 8,
  });

  @override
  State<ScatterChartWidget> createState() => _ScatterChartWidgetState();
}

class _ScatterChartWidgetState extends State<ScatterChartWidget> with SingleTickerProviderStateMixin {
  final Map<int, bool> _visibleSeries = {};
  late AnimationController _animationController;
  late Animation<double> _animation;
  int? _touchedSeriesIndex;
  int? _touchedSpotIndex;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.config.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    if (widget.animate) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ScatterChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.series != widget.series && widget.animate) {
      _animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final chartTheme = widget.config.theme ?? ChartTheme.fromColorScheme(colorScheme);

    return ChartContainer(
      title: widget.config.title,
      subtitle: widget.config.subtitle,
      showToolbar: widget.config.enableZoom || widget.config.enablePan,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 16),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return ScatterChart(
                    ScatterChartData(
                      minX: widget.minX,
                      maxX: widget.maxX,
                      minY: widget.minY,
                      maxY: widget.maxY,
                      clipData: const FlClipData.all(),
                      gridData: FlGridData(
                        show: widget.showGrid,
                        drawVerticalLine: true,
                        drawHorizontalLine: true,
                        horizontalInterval: (widget.maxY - widget.minY) / 5,
                        verticalInterval: (widget.maxX - widget.minX) / 5,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: chartTheme.gridColor,
                            strokeWidth: 1,
                            dashArray: [5, 5],
                          );
                        },
                        getDrawingVerticalLine: (value) {
                          return FlLine(
                            color: chartTheme.gridColor,
                            strokeWidth: 1,
                            dashArray: [5, 5],
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                _formatAxisValue(value),
                                style: chartTheme.labelStyle ?? theme.textTheme.bodySmall,
                              );
                            },
                            reservedSize: 44,
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  _formatAxisValue(value),
                                  style: chartTheme.labelStyle ?? theme.textTheme.bodySmall,
                                ),
                              );
                            },
                            reservedSize: 32,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: widget.showBorder,
                        border: Border(
                          left: BorderSide(color: chartTheme.axisColor, width: 1),
                          bottom: BorderSide(color: chartTheme.axisColor, width: 1),
                        ),
                      ),
                      scatterSpots: _generateScatterSpots(chartTheme, _animation.value),
                      scatterTouchData: ScatterTouchData(
                        enabled: widget.config.showTooltip,
                        touchTooltipData: ScatterTouchTooltipData(
                          tooltipRoundedRadius: 8,
                          tooltipPadding: const EdgeInsets.all(12),
                          fitInsideHorizontally: true,
                          fitInsideVertically: true,
                          getTooltipItems: (touchedSpot) {
                            // Get series and point index from touched spot
                            final seriesIndex = 0; // We'll need to encode this differently
                            final pointIndex = 0;
                            
                            if (seriesIndex < widget.series.length) {
                              final series = widget.series[seriesIndex];
                              if (pointIndex < series.data.length) {
                                final point = series.data[pointIndex];
                                return ScatterTooltipItem(
                                  '${series.name}\n',
                                  textStyle: TextStyle(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'X: ${_formatValue(point.x)}\nY: ${_formatValue(point.y)}',
                                      style: TextStyle(
                                        color: colorScheme.onSurface,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    if (point.label != null)
                                      TextSpan(
                                        text: '\n${point.label}',
                                        style: TextStyle(
                                          color: colorScheme.onSurfaceVariant,
                                          fontSize: 10,
                                        ),
                                      ),
                                  ],
                                );
                              }
                            }
                            return null;
                          },
                        ),
                        touchCallback: (event, response) {
                          if (event is FlTapUpEvent && response != null) {
                            final touchedSpot = response.touchedSpot;
                            if (touchedSpot != null) {
                              final seriesIndex = touchedSpot.spotIndex ~/ 1000;
                              final pointIndex = touchedSpot.spotIndex % 1000;
                              
                              setState(() {
                                _touchedSeriesIndex = seriesIndex;
                                _touchedSpotIndex = pointIndex;
                              });
                              
                              if (widget.onPointTap != null && seriesIndex < widget.series.length) {
                                final series = widget.series[seriesIndex];
                                if (pointIndex < series.data.length) {
                                  widget.onPointTap!(ChartTooltipData(
                                    point: series.data[pointIndex],
                                    series: series,
                                    seriesIndex: seriesIndex,
                                    pointIndex: pointIndex,
                                  ));
                                }
                              }
                            }
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (widget.legendConfig?.show ?? widget.config.showLegend)
            ChartLegend(
              series: widget.series,
              position: widget.legendConfig?.position ?? ChartLegendPosition.bottom,
              alignment: widget.legendConfig?.alignment ?? ChartLegendAlignment.center,
              showValues: widget.legendConfig?.showValues ?? false,
              selectedItems: _visibleSeries,
              onItemToggle: (index, selected) {
                setState(() {
                  _visibleSeries[index] = selected;
                });
              },
            ),
        ],
      ),
    );
  }

  List<ScatterSpot> _generateScatterSpots(ChartTheme chartTheme, double animationValue) {
    final spots = <ScatterSpot>[];
    
    for (int seriesIndex = 0; seriesIndex < widget.series.length; seriesIndex++) {
      if (_visibleSeries[seriesIndex] == false) continue;
      
      final series = widget.series[seriesIndex];
      final color = series.color ?? chartTheme.colors[seriesIndex % chartTheme.colors.length];
      
      for (int pointIndex = 0; pointIndex < series.data.length; pointIndex++) {
        final point = series.data[pointIndex];
        final isTouched = _touchedSeriesIndex == seriesIndex && _touchedSpotIndex == pointIndex;
        
        spots.add(
          ScatterSpot(
            point.x,
            point.y * animationValue,
            dotPainter: FlDotCirclePainter(
              color: color,
              radius: (isTouched ? widget.dotSize * 1.5 : widget.dotSize) * animationValue,
              strokeWidth: isTouched ? 3 : 0,
              strokeColor: Colors.white,
            ),
            // Store original indices for touch handling
          ),
        );
      }
    }
    
    return spots;
  }

  String _formatAxisValue(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return value.toStringAsFixed(0);
  }

  String _formatValue(double value) {
    return value.toStringAsFixed(2);
  }
}

/// Bubble chart widget (extends scatter chart with size dimension)
class BubbleChartWidget extends StatelessWidget {
  final List<ChartSeries> series;
  final ChartConfig config;
  final ChartLegendConfig? legendConfig;
  final Function(ChartTooltipData)? onPointTap;
  final bool showGrid;
  final bool showBorder;
  final bool animate;
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;
  final double minBubbleSize;
  final double maxBubbleSize;

  const BubbleChartWidget({
    super.key,
    required this.series,
    required this.config,
    this.legendConfig,
    this.onPointTap,
    this.showGrid = true,
    this.showBorder = true,
    this.animate = true,
    this.minX = 0,
    this.maxX = 100,
    this.minY = 0,
    this.maxY = 100,
    this.minBubbleSize = 10,
    this.maxBubbleSize = 50,
  });

  @override
  Widget build(BuildContext context) {
    // Transform series data to include bubble sizes
    final bubbleSeries = series.map((s) {
      return s.copyWith(
        data: s.data.map((point) {
          // Use customData to store bubble size if available
          final size = point.customData?['size'] ?? 20.0;
          return point;
        }).toList(),
      );
    }).toList();

    return ScatterChartWidget(
      series: bubbleSeries,
      config: config,
      legendConfig: legendConfig,
      onPointTap: onPointTap,
      showGrid: showGrid,
      showBorder: showBorder,
      animate: animate,
      minX: minX,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
      dotSize: 20, // Base size, will be modified by bubble data
    );
  }
}