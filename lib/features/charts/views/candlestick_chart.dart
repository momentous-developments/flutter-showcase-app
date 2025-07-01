import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/chart_models.dart';
import '../widgets/chart_container.dart';
import 'package:intl/intl.dart';

/// Candlestick chart widget for financial data
class CandlestickChartWidget extends StatefulWidget {
  final List<ChartSeries> series;
  final ChartConfig config;
  final Function(ChartTooltipData)? onCandleTap;
  final bool showGrid;
  final bool showBorder;
  final bool animate;
  final bool showVolume;
  final double candleWidth;

  const CandlestickChartWidget({
    super.key,
    required this.series,
    required this.config,
    this.onCandleTap,
    this.showGrid = true,
    this.showBorder = true,
    this.animate = true,
    this.showVolume = true,
    this.candleWidth = 0.7,
  });

  @override
  State<CandlestickChartWidget> createState() => _CandlestickChartWidgetState();
}

class _CandlestickChartWidgetState extends State<CandlestickChartWidget> {
  int _touchedIndex = -1;
  double _minPrice = double.infinity;
  double _maxPrice = double.negativeInfinity;
  double _maxVolume = 0;

  @override
  void initState() {
    super.initState();
    _calculatePriceRange();
  }

  @override
  void didUpdateWidget(CandlestickChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.series != widget.series) {
      _calculatePriceRange();
    }
  }

  void _calculatePriceRange() {
    if (widget.series.isEmpty || widget.series.first.data.isEmpty) return;

    for (final point in widget.series.first.data) {
      if (point is FinancialPoint) {
        _minPrice = _minPrice > point.low ? point.low : _minPrice;
        _maxPrice = _maxPrice < point.high ? point.high : _maxPrice;
        _maxVolume = _maxVolume < (point.volume ?? 0) ? (point.volume ?? 0) : _maxVolume;
      }
    }

    // Add padding to price range
    final priceRange = _maxPrice - _minPrice;
    _minPrice -= priceRange * 0.1;
    _maxPrice += priceRange * 0.1;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final chartTheme = widget.config.theme ?? ChartTheme.fromColorScheme(colorScheme);

    if (widget.series.isEmpty || widget.series.first.data.isEmpty) {
      return ChartContainer(
        title: widget.config.title,
        subtitle: widget.config.subtitle,
        child: Center(
          child: Text(
            'No data available',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return ChartContainer(
      title: widget.config.title,
      subtitle: widget.config.subtitle,
      showToolbar: widget.config.enableZoom || widget.config.enablePan,
      child: Column(
        children: [
          Expanded(
            flex: widget.showVolume ? 3 : 1,
            child: _buildCandlestickChart(chartTheme),
          ),
          if (widget.showVolume) ...[
            const SizedBox(height: 16),
            Expanded(
              flex: 1,
              child: _buildVolumeChart(chartTheme),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCandlestickChart(ChartTheme chartTheme) {
    final theme = Theme.of(context);
    final spots = <BarChartGroupData>[];
    final series = widget.series.first;

    for (int i = 0; i < series.data.length; i++) {
      final point = series.data[i];
      if (point is FinancialPoint) {
        final isBullish = point.close >= point.open;
        final color = isBullish ? Colors.green : Colors.red;
        final isTouched = i == _touchedIndex;

        spots.add(
          BarChartGroupData(
            x: i,
            barRods: [
              // High-Low line (wick)
              BarChartRodData(
                fromY: point.low,
                toY: point.high,
                color: color,
                width: 2,
              ),
              // Open-Close body
              BarChartRodData(
                fromY: isBullish ? point.open : point.close,
                toY: isBullish ? point.close : point.open,
                color: isTouched ? color.withOpacity(0.7) : color,
                width: widget.candleWidth * 10,
                borderRadius: BorderRadius.circular(2),
              ),
            ],
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 16),
      child: BarChart(
        BarChartData(
          minY: _minPrice,
          maxY: _maxPrice,
          gridData: FlGridData(
            show: widget.showGrid,
            drawVerticalLine: false,
            drawHorizontalLine: true,
            horizontalInterval: (_maxPrice - _minPrice) / 5,
            getDrawingHorizontalLine: (value) {
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
                    _formatPrice(value),
                    style: chartTheme.labelStyle ?? theme.textTheme.bodySmall,
                  );
                },
                reservedSize: 60,
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
                  if (index % 5 == 0 && index < series.data.length) {
                    final point = series.data[index];
                    if (point is FinancialPoint) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          _formatDate(point.timestamp),
                          style: chartTheme.labelStyle ?? theme.textTheme.bodySmall,
                        ),
                      );
                    }
                  }
                  return const SizedBox.shrink();
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
          barGroups: spots,
          barTouchData: BarTouchData(
            enabled: widget.config.showTooltip,
            touchTooltipData: BarTouchTooltipData(
              tooltipRoundedRadius: 8,
              tooltipPadding: const EdgeInsets.all(12),
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                if (rodIndex != 1) return null; // Only show tooltip for body

                final point = series.data[groupIndex];
                if (point is FinancialPoint) {
                  return BarTooltipItem(
                    '${_formatDate(point.timestamp)}\n'
                    'O: ${_formatPrice(point.open)}\n'
                    'H: ${_formatPrice(point.high)}\n'
                    'L: ${_formatPrice(point.low)}\n'
                    'C: ${_formatPrice(point.close)}',
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  );
                }
                return null;
              },
            ),
            touchCallback: (event, response) {
              setState(() {
                if (response != null && response.spot != null) {
                  _touchedIndex = response.spot!.touchedBarGroupIndex;
                  
                  if (event is FlTapUpEvent && widget.onCandleTap != null) {
                    final point = series.data[_touchedIndex];
                    widget.onCandleTap!(ChartTooltipData(
                      point: point,
                      series: series,
                      seriesIndex: 0,
                      pointIndex: _touchedIndex,
                    ));
                  }
                } else {
                  _touchedIndex = -1;
                }
              });
            },
          ),
        ),
        swapAnimationDuration: widget.animate ? widget.config.animationDuration : Duration.zero,
      ),
    );
  }

  Widget _buildVolumeChart(ChartTheme chartTheme) {
    final theme = Theme.of(context);
    final spots = <BarChartGroupData>[];
    final series = widget.series.first;

    for (int i = 0; i < series.data.length; i++) {
      final point = series.data[i];
      if (point is FinancialPoint && point.volume != null) {
        final isBullish = point.close >= point.open;
        final color = isBullish ? Colors.green.withOpacity(0.5) : Colors.red.withOpacity(0.5);

        spots.add(
          BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: point.volume!,
                color: color,
                width: widget.candleWidth * 10,
                borderRadius: BorderRadius.circular(2),
              ),
            ],
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: BarChart(
        BarChartData(
          minY: 0,
          maxY: _maxVolume * 1.1,
          gridData: FlGridData(
            show: widget.showGrid,
            drawVerticalLine: false,
            drawHorizontalLine: true,
            horizontalInterval: _maxVolume / 2,
            getDrawingHorizontalLine: (value) {
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
                    _formatVolume(value),
                    style: chartTheme.labelStyle ?? theme.textTheme.bodySmall,
                  );
                },
                reservedSize: 60,
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(
            show: widget.showBorder,
            border: Border(
              left: BorderSide(color: chartTheme.axisColor, width: 1),
              bottom: BorderSide(color: chartTheme.axisColor, width: 1),
            ),
          ),
          barGroups: spots,
          barTouchData: BarTouchData(enabled: false),
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    return '\$${price.toStringAsFixed(2)}';
  }

  String _formatVolume(double volume) {
    if (volume >= 1000000) {
      return '${(volume / 1000000).toStringAsFixed(1)}M';
    } else if (volume >= 1000) {
      return '${(volume / 1000).toStringAsFixed(1)}K';
    }
    return volume.toStringAsFixed(0);
  }

  String _formatDate(DateTime date) {
    return DateFormat('MM/dd').format(date);
  }
}