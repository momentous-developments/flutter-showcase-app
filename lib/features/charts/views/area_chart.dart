import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/chart_models.dart';
import '../widgets/chart_container.dart';
import '../widgets/chart_legend.dart';

/// Area chart widget with multiple series support
class AreaChartWidget extends StatefulWidget {
  final List<ChartSeries> series;
  final ChartConfig config;
  final ChartLegendConfig? legendConfig;
  final Function(ChartTooltipData)? onPointTap;
  final bool showGrid;
  final bool showBorder;
  final bool animate;

  const AreaChartWidget({
    super.key,
    required this.series,
    required this.config,
    this.legendConfig,
    this.onPointTap,
    this.showGrid = true,
    this.showBorder = true,
    this.animate = true,
  });

  @override
  State<AreaChartWidget> createState() => _AreaChartWidgetState();
}

class _AreaChartWidgetState extends State<AreaChartWidget> {
  final Map<int, bool> _visibleSeries = {};
  List<LineChartBarData> _chartBars = [];
  int? _touchedIndex;

  @override
  void initState() {
    super.initState();
    _updateChartData();
  }

  @override
  void didUpdateWidget(AreaChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.series != widget.series) {
      _updateChartData();
    }
  }

  void _updateChartData() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final chartTheme = widget.config.theme ?? ChartTheme.fromColorScheme(colorScheme);

    _chartBars = [];
    for (int i = 0; i < widget.series.length; i++) {
      if (_visibleSeries[i] == false) continue;

      final series = widget.series[i];
      final color = series.color ?? chartTheme.colors[i % chartTheme.colors.length];
      final spots = series.data.map((point) => FlSpot(point.x, point.y)).toList();

      _chartBars.add(
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: color,
          barWidth: 2.5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: series.data.length < 20,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 4,
                color: color,
                strokeWidth: 2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                color.withOpacity(0.4),
                color.withOpacity(0.1),
                color.withOpacity(0.0),
              ],
              stops: const [0.0, 0.7, 1.0],
            ),
          ),
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
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 16),
              child: LineChart(
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
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: chartTheme.gridColor,
                        strokeWidth: 1,
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
                                child: Text(
                                  label,
                                  style: chartTheme.labelStyle ?? theme.textTheme.bodySmall,
                                ),
                              );
                            }
                          }
                          return Text(
                            value.toStringAsFixed(0),
                            style: chartTheme.labelStyle ?? theme.textTheme.bodySmall,
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
                  lineBarsData: _chartBars,
                  lineTouchData: LineTouchData(
                    enabled: widget.config.showTooltip,
                    touchTooltipData: LineTouchTooltipData(
                      tooltipRoundedRadius: 8,
                      tooltipPadding: const EdgeInsets.all(8),
                      tooltipMargin: 8,
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          final series = widget.series[spot.barIndex];
                          final point = series.data[spot.spotIndex];
                          
                          return LineTooltipItem(
                            '${series.name}\n${_formatValue(point.y)}',
                            TextStyle(
                              color: spot.bar.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          );
                        }).toList();
                      },
                    ),
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
                ),
                duration: widget.animate ? widget.config.animationDuration : Duration.zero,
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