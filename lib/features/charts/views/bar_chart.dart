import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/chart_models.dart';
import '../widgets/chart_container.dart';
import '../widgets/chart_legend.dart';

/// Bar chart widget with grouped and stacked support
class BarChartWidget extends StatefulWidget {
  final List<ChartSeries> series;
  final ChartConfig config;
  final ChartLegendConfig? legendConfig;
  final Function(ChartTooltipData)? onBarTap;
  final bool isHorizontal;
  final bool isStacked;
  final bool showGrid;
  final bool showBorder;
  final bool animate;
  final double barWidth;
  final double barSpacing;

  const BarChartWidget({
    super.key,
    required this.series,
    required this.config,
    this.legendConfig,
    this.onBarTap,
    this.isHorizontal = false,
    this.isStacked = false,
    this.showGrid = true,
    this.showBorder = true,
    this.animate = true,
    this.barWidth = 0.7,
    this.barSpacing = 0.1,
  });

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  final Map<int, bool> _visibleSeries = {};
  int _touchedGroupIndex = -1;
  int _touchedBarIndex = -1;

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
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(
                    show: widget.showGrid,
                    drawVerticalLine: !widget.isHorizontal,
                    drawHorizontalLine: widget.isHorizontal,
                    horizontalInterval: _calculateInterval(isHorizontal: true),
                    verticalInterval: _calculateInterval(isHorizontal: false),
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
                        showTitles: !widget.isHorizontal,
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
                          if (widget.isHorizontal) {
                            return Text(
                              _formatAxisValue(value),
                              style: chartTheme.labelStyle ?? theme.textTheme.bodySmall,
                            );
                          } else {
                            final index = value.toInt();
                            if (widget.series.isNotEmpty && 
                                index >= 0 && 
                                index < widget.series.first.data.length) {
                              final label = widget.series.first.data[index].label;
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  label ?? value.toStringAsFixed(0),
                                  style: chartTheme.labelStyle ?? theme.textTheme.bodySmall,
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          }
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
                  barGroups: _generateBarGroups(chartTheme),
                  barTouchData: BarTouchData(
                    enabled: widget.config.showTooltip,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipRoundedRadius: 8,
                      tooltipPadding: const EdgeInsets.all(8),
                      tooltipMargin: 8,
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final series = widget.series[rodIndex];
                        final value = widget.isStacked 
                            ? rod.toY - rod.fromY
                            : rod.toY;
                        
                        return BarTooltipItem(
                          '${series.name}\n${_formatValue(value)}',
                          TextStyle(
                            color: rod.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                    touchCallback: (event, response) {
                      setState(() {
                        if (response != null && response.spot != null) {
                          _touchedGroupIndex = response.spot!.touchedBarGroupIndex;
                          _touchedBarIndex = response.spot!.touchedRodDataIndex;
                          
                          if (event is FlTapUpEvent && widget.onBarTap != null) {
                            final series = widget.series[_touchedBarIndex];
                            final point = series.data[_touchedGroupIndex];
                            
                            widget.onBarTap!(ChartTooltipData(
                              point: point,
                              series: series,
                              seriesIndex: _touchedBarIndex,
                              pointIndex: _touchedGroupIndex,
                            ));
                          }
                        } else {
                          _touchedGroupIndex = -1;
                          _touchedBarIndex = -1;
                        }
                      });
                    },
                  ),
                ),
                swapAnimationDuration: widget.animate ? widget.config.animationDuration : Duration.zero,
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

  List<BarChartGroupData> _generateBarGroups(ChartTheme chartTheme) {
    if (widget.series.isEmpty || widget.series.first.data.isEmpty) return [];

    final groups = <BarChartGroupData>[];
    final dataLength = widget.series.first.data.length;
    
    for (int i = 0; i < dataLength; i++) {
      final rods = <BarChartRodData>[];
      double stackedY = 0;
      
      for (int j = 0; j < widget.series.length; j++) {
        if (_visibleSeries[j] == false) continue;
        
        final series = widget.series[j];
        if (i >= series.data.length) continue;
        
        final point = series.data[i];
        final color = series.color ?? chartTheme.colors[j % chartTheme.colors.length];
        final isTouched = _touchedGroupIndex == i && _touchedBarIndex == j;
        
        rods.add(
          BarChartRodData(
            fromY: widget.isStacked ? stackedY : 0,
            toY: widget.isStacked ? stackedY + point.y : point.y,
            color: isTouched ? color.withOpacity(0.7) : color,
            width: widget.barWidth * 20 / widget.series.length,
            borderRadius: BorderRadius.circular(4),
            backDrawRodData: BackgroundBarChartRodData(
              show: false,
            ),
          ),
        );
        
        if (widget.isStacked) {
          stackedY += point.y;
        }
      }
      
      groups.add(
        BarChartGroupData(
          x: i,
          barRods: rods,
          barsSpace: widget.isStacked ? 0 : widget.barSpacing * 20,
        ),
      );
    }
    
    return groups;
  }

  double _calculateInterval({required bool isHorizontal}) {
    if (widget.series.isEmpty || widget.series.first.data.isEmpty) return 1;

    double minValue = 0;
    double maxValue = 0;
    
    for (final series in widget.series) {
      for (final point in series.data) {
        if (widget.isStacked) {
          maxValue += point.y;
        } else {
          maxValue = maxValue < point.y ? point.y : maxValue;
        }
      }
    }
    
    final range = maxValue - minValue;
    return range / 5; // Show 5 lines
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