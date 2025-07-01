import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/chart_models.dart';
import '../widgets/chart_container.dart';
import '../widgets/chart_legend.dart';

/// Line chart widget with multiple series support
class LineChartWidget extends StatefulWidget {
  final List<ChartSeries> series;
  final ChartConfig config;
  final ChartLegendConfig? legendConfig;
  final Function(ChartTooltipData)? onPointTap;
  final bool showGrid;
  final bool showBorder;
  final bool animate;
  final bool showDots;
  final bool isCurved;
  final double strokeWidth;

  const LineChartWidget({
    super.key,
    required this.series,
    required this.config,
    this.legendConfig,
    this.onPointTap,
    this.showGrid = true,
    this.showBorder = true,
    this.animate = true,
    this.showDots = true,
    this.isCurved = true,
    this.strokeWidth = 2.5,
  });

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> with SingleTickerProviderStateMixin {
  final Map<int, bool> _visibleSeries = {};
  List<LineChartBarData> _chartLines = [];
  late AnimationController _animationController;
  late Animation<double> _animation;

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
    
    _updateChartData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(LineChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.series != widget.series) {
      _updateChartData();
      if (widget.animate) {
        _animationController.forward(from: 0);
      }
    }
  }

  void _updateChartData() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final chartTheme = widget.config.theme ?? ChartTheme.fromColorScheme(colorScheme);

    _chartLines = [];
    for (int i = 0; i < widget.series.length; i++) {
      if (_visibleSeries[i] == false) continue;

      final series = widget.series[i];
      final color = series.color ?? chartTheme.colors[i % chartTheme.colors.length];
      final spots = series.data.map((point) => FlSpot(point.x, point.y)).toList();

      // Apply custom styles from series
      final dashArray = series.style['dashArray'] as List<int>?;
      final showArea = series.style['showArea'] as bool? ?? false;

      _chartLines.add(
        LineChartBarData(
          spots: spots,
          isCurved: widget.isCurved,
          color: color,
          barWidth: widget.strokeWidth,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: widget.showDots && series.data.length < 50,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 4,
                color: color,
                strokeWidth: 2,
                strokeColor: Colors.white,
              );
            },
          ),
          dashArray: dashArray,
          belowBarData: showArea ? BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                color.withOpacity(0.2),
                color.withOpacity(0.0),
              ],
            ),
          ) : BarAreaData(show: false),
          preventCurveOverShooting: true,
        ),
      );
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
      actions: [
        if (widget.config.enableZoom)
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              // Implement zoom functionality
            },
            iconSize: 20,
            tooltip: 'Zoom In',
          ),
        if (widget.config.enablePan)
          IconButton(
            icon: const Icon(Icons.pan_tool),
            onPressed: () {
              // Implement pan functionality
            },
            iconSize: 20,
            tooltip: 'Pan',
          ),
      ],
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 16),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: widget.showGrid,
                        drawVerticalLine: true,
                        drawHorizontalLine: true,
                        horizontalInterval: _calculateInterval(series: widget.series, isHorizontal: true),
                        verticalInterval: _calculateInterval(series: widget.series, isHorizontal: false),
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
                              final series = widget.series.first;
                              final index = value.toInt();
                              if (index >= 0 && index < series.data.length) {
                                final label = series.data[index].label;
                                if (label != null) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: RotatedBox(
                                      quarterTurns: series.data.length > 10 ? 1 : 0,
                                      child: Text(
                                        label,
                                        style: chartTheme.labelStyle ?? theme.textTheme.bodySmall,
                                      ),
                                    ),
                                  );
                                }
                              }
                              return Text(
                                value.toStringAsFixed(0),
                                style: chartTheme.labelStyle ?? theme.textTheme.bodySmall,
                              );
                            },
                            reservedSize: widget.series.isNotEmpty && widget.series.first.data.length > 10 ? 48 : 32,
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
                      lineBarsData: _animateLines(_chartLines, _animation.value),
                      lineTouchData: LineTouchData(
                        enabled: widget.config.showTooltip,
                        touchTooltipData: LineTouchTooltipData(
                          // Background color is set through tooltipBgColor in newer versions
                          tooltipRoundedRadius: 8,
                          tooltipPadding: const EdgeInsets.all(12),
                          tooltipMargin: 8,
                          fitInsideHorizontally: true,
                          fitInsideVertically: true,
                          showOnTopOfTheChartBoxArea: true,
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((spot) {
                              final series = widget.series[spot.barIndex];
                              final point = series.data[spot.spotIndex];
                              final color = spot.bar.color ?? colorScheme.primary;
                              
                              return LineTooltipItem(
                                '${series.name}\n',
                                TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text: _formatValue(point.y),
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
                            }).toList();
                          },
                        ),
                        getTouchedSpotIndicator: (barData, spotIndexes) {
                          return spotIndexes.map((spotIndex) {
                            return TouchedSpotIndicatorData(
                              FlLine(
                                color: colorScheme.primary.withOpacity(0.3),
                                strokeWidth: 2,
                                dashArray: [5, 5],
                              ),
                              FlDotData(
                                getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(
                                    radius: 6,
                                    color: barData.color ?? colorScheme.primary,
                                    strokeWidth: 2,
                                    strokeColor: Colors.white,
                                  );
                                },
                              ),
                            );
                          }).toList();
                        },
                        touchCallback: (event, response) {
                          if (event is FlLongPressEnd || event is FlTapUpEvent) {
                            if (response?.lineBarSpots != null && response!.lineBarSpots!.isNotEmpty) {
                              final spot = response.lineBarSpots!.first;
                              final series = widget.series[spot.barIndex];
                              final point = series.data[spot.spotIndex];
                              
                              widget.onPointTap?.call(ChartTooltipData(
                                point: point,
                                series: series,
                                seriesIndex: spot.barIndex,
                                pointIndex: spot.spotIndex,
                              ));
                            }
                          }
                        },
                      ),
                      clipData: const FlClipData.all(),
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
                  _updateChartData();
                });
              },
            ),
        ],
      ),
    );
  }

  List<LineChartBarData> _animateLines(List<LineChartBarData> lines, double animationValue) {
    if (!widget.animate) return lines;
    
    return lines.map((line) {
      final animatedSpots = <FlSpot>[];
      for (int i = 0; i < line.spots.length; i++) {
        final progress = (animationValue * line.spots.length - i).clamp(0, 1).toDouble();
        animatedSpots.add(FlSpot(
          line.spots[i].x,
          line.spots[i].y * progress,
        ));
      }
      
      return line.copyWith(spots: animatedSpots);
    }).toList();
  }

  double _calculateInterval({required List<ChartSeries> series, required bool isHorizontal}) {
    if (series.isEmpty || series.first.data.isEmpty) return 1;

    if (isHorizontal) {
      // Calculate Y interval
      double minY = double.infinity;
      double maxY = double.negativeInfinity;
      
      for (final s in series) {
        for (final point in s.data) {
          minY = minY > point.y ? point.y : minY;
          maxY = maxY < point.y ? point.y : maxY;
        }
      }
      
      final range = maxY - minY;
      return range / 5; // Show 5 horizontal lines
    } else {
      // Calculate X interval
      final dataLength = series.first.data.length;
      return dataLength > 10 ? dataLength / 10 : 1;
    }
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