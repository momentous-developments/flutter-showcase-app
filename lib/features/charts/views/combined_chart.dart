import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/chart_models.dart';
import '../widgets/chart_container.dart';
import '../widgets/chart_legend.dart';

/// Combined chart widget that overlays multiple chart types
class CombinedChartWidget extends StatefulWidget {
  final List<ChartSeries> series;
  final ChartConfig config;
  final ChartLegendConfig? legendConfig;
  final bool showGrid;
  final bool showBorder;
  final bool animate;
  final double barWidth;

  const CombinedChartWidget({
    super.key,
    required this.series,
    required this.config,
    this.legendConfig,
    this.showGrid = true,
    this.showBorder = true,
    this.animate = true,
    this.barWidth = 0.7,
  });

  @override
  State<CombinedChartWidget> createState() => _CombinedChartWidgetState();
}

class _CombinedChartWidgetState extends State<CombinedChartWidget> with SingleTickerProviderStateMixin {
  final Map<int, bool> _visibleSeries = {};
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final chartTheme = widget.config.theme ?? ChartTheme.fromColorScheme(colorScheme);

    // Separate series by type
    final barSeries = <ChartSeries>[];
    final lineSeries = <ChartSeries>[];
    final areaSeries = <ChartSeries>[];

    for (int i = 0; i < widget.series.length; i++) {
      if (_visibleSeries[i] == false) continue;
      
      final series = widget.series[i];
      switch (series.type) {
        case ChartSeriesType.bar:
        case ChartSeriesType.column:
          barSeries.add(series);
          break;
        case ChartSeriesType.line:
          lineSeries.add(series);
          break;
        case ChartSeriesType.area:
          areaSeries.add(series);
          break;
        default:
          // Treat other types as line for combined chart
          lineSeries.add(series);
      }
    }

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
                  return Stack(
                    children: [
                      // Base layer: Bar chart
                      if (barSeries.isNotEmpty)
                        _buildBarChart(barSeries, chartTheme),
                      // Middle layer: Area chart
                      if (areaSeries.isNotEmpty)
                        IgnorePointer(
                          child: _buildAreaChart(areaSeries, chartTheme),
                        ),
                      // Top layer: Line chart
                      if (lineSeries.isNotEmpty)
                        IgnorePointer(
                          child: _buildLineChart(lineSeries, chartTheme),
                        ),
                    ],
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

  Widget _buildBarChart(List<ChartSeries> series, ChartTheme chartTheme) {
    final theme = Theme.of(context);
    final groups = <BarChartGroupData>[];
    
    if (series.isNotEmpty && series.first.data.isNotEmpty) {
      final dataLength = series.first.data.length;
      
      for (int i = 0; i < dataLength; i++) {
        final rods = <BarChartRodData>[];
        
        for (int j = 0; j < series.length; j++) {
          final s = series[j];
          if (i >= s.data.length) continue;
          
          final point = s.data[i];
          final seriesIndex = widget.series.indexOf(s);
          final color = s.color ?? chartTheme.colors[seriesIndex % chartTheme.colors.length];
          
          rods.add(
            BarChartRodData(
              toY: point.y * _animation.value,
              color: color.withOpacity(0.7),
              width: widget.barWidth * 16 / series.length,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }
        
        groups.add(
          BarChartGroupData(
            x: i,
            barRods: rods,
            barsSpace: 2,
          ),
        );
      }
    }

    return BarChart(
      BarChartData(
        gridData: FlGridData(
          show: widget.showGrid,
          drawVerticalLine: false,
          drawHorizontalLine: true,
          horizontalInterval: _calculateInterval(),
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: chartTheme.gridColor,
              strokeWidth: 1,
              dashArray: [5, 5],
            );
          },
        ),
        titlesData: _buildTitlesData(theme, chartTheme),
        borderData: FlBorderData(
          show: widget.showBorder,
          border: Border(
            left: BorderSide(color: chartTheme.axisColor, width: 1),
            bottom: BorderSide(color: chartTheme.axisColor, width: 1),
          ),
        ),
        barGroups: groups,
        barTouchData: BarTouchData(
          enabled: widget.config.showTooltip,
          touchTooltipData: BarTouchTooltipData(
            tooltipRoundedRadius: 8,
            tooltipPadding: const EdgeInsets.all(8),
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final series = widget.series[rodIndex];
              return BarTooltipItem(
                '${series.name}\n${rod.toY.toStringAsFixed(2)}',
                TextStyle(
                  color: rod.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLineChart(List<ChartSeries> series, ChartTheme chartTheme) {
    final lineBars = <LineChartBarData>[];
    
    for (final s in series) {
      final seriesIndex = widget.series.indexOf(s);
      final color = s.color ?? chartTheme.colors[seriesIndex % chartTheme.colors.length];
      final spots = s.data.map((point) => FlSpot(point.x, point.y * _animation.value)).toList();
      
      lineBars.add(
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: color,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: s.data.length < 20,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 4,
                color: color,
                strokeWidth: 2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(show: false),
        ),
      );
    }

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: lineBars,
        lineTouchData: const LineTouchData(enabled: false),
      ),
    );
  }

  Widget _buildAreaChart(List<ChartSeries> series, ChartTheme chartTheme) {
    final lineBars = <LineChartBarData>[];
    
    for (final s in series) {
      final seriesIndex = widget.series.indexOf(s);
      final color = s.color ?? chartTheme.colors[seriesIndex % chartTheme.colors.length];
      final spots = s.data.map((point) => FlSpot(point.x, point.y * _animation.value)).toList();
      
      lineBars.add(
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: color,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                color.withOpacity(0.3),
                color.withOpacity(0.1),
                color.withOpacity(0.0),
              ],
            ),
          ),
        ),
      );
    }

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: lineBars,
        lineTouchData: const LineTouchData(enabled: false),
      ),
    );
  }

  FlTitlesData _buildTitlesData(ThemeData theme, ChartTheme chartTheme) {
    return FlTitlesData(
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
          },
          reservedSize: 32,
        ),
      ),
    );
  }

  double _calculateInterval() {
    if (widget.series.isEmpty || widget.series.first.data.isEmpty) return 1;

    double minY = 0;
    double maxY = 0;
    
    for (final series in widget.series) {
      for (final point in series.data) {
        maxY = maxY < point.y ? point.y : maxY;
      }
    }
    
    return (maxY - minY) / 5;
  }

  String _formatAxisValue(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return value.toStringAsFixed(0);
  }
}