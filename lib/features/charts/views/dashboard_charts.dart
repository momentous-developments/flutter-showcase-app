import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/chart_models.dart';
import '../widgets/chart_container.dart';
import '../widgets/chart_legend.dart';
import 'area_chart.dart';
import 'bar_chart.dart';
import 'line_chart.dart';
import 'pie_chart.dart';

/// Analytics dashboard chart
class AnalyticsChartWidget extends StatelessWidget {
  final ChartDataSource dataSource;
  final ChartConfig config;
  final VoidCallback? onViewDetails;

  const AnalyticsChartWidget({
    super.key,
    required this.dataSource,
    required this.config,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ChartContainer(
      title: config.title.isEmpty ? 'Website Analytics' : config.title,
      subtitle: 'Page views and visitor trends',
      height: 400,
      actions: [
        if (onViewDetails != null)
          TextButton.icon(
            onPressed: onViewDetails,
            icon: const Icon(Icons.analytics, size: 16),
            label: const Text('View Details'),
          ),
      ],
      child: Column(
        children: [
          // Summary cards
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                _buildMetricCard(
                  context,
                  'Total Visitors',
                  dataSource.metadata['totalVisitors']?.toString() ?? '0',
                  Icons.people,
                  colorScheme.primary,
                ),
                const SizedBox(width: 16),
                _buildMetricCard(
                  context,
                  'Avg Bounce Rate',
                  '${dataSource.metadata['avgBounceRate']?.toStringAsFixed(1) ?? '0'}%',
                  Icons.trending_down,
                  colorScheme.secondary,
                ),
                const SizedBox(width: 16),
                _buildMetricCard(
                  context,
                  'Page Views',
                  _formatNumber(dataSource.series.first.data.fold(
                    0.0,
                    (sum, point) => sum + point.y,
                  )),
                  Icons.pageview,
                  colorScheme.tertiary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Main chart
          Expanded(
            child: AreaChartWidget(
              series: dataSource.series,
              config: config.copyWith(
                showLegend: false,
                animate: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return value.toStringAsFixed(0);
  }
}

/// Revenue dashboard chart
class RevenueChartWidget extends StatefulWidget {
  final ChartDataSource dataSource;
  final ChartConfig config;
  final VoidCallback? onExport;

  const RevenueChartWidget({
    super.key,
    required this.dataSource,
    required this.config,
    this.onExport,
  });

  @override
  State<RevenueChartWidget> createState() => _RevenueChartWidgetState();
}

class _RevenueChartWidgetState extends State<RevenueChartWidget> {
  String _selectedPeriod = 'Monthly';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Separate series by type
    final columnSeries = widget.dataSource.series
        .where((s) => s.type == ChartSeriesType.column)
        .toList();
    final lineSeries = widget.dataSource.series
        .where((s) => s.type == ChartSeriesType.line)
        .toList();

    return ChartContainer(
      title: widget.config.title.isEmpty ? 'Revenue Overview' : widget.config.title,
      subtitle: 'Revenue, expenses, and profit trends',
      height: 400,
      actions: [
        DropdownButton<String>(
          value: _selectedPeriod,
          underline: const SizedBox(),
          items: ['Daily', 'Weekly', 'Monthly', 'Yearly']
              .map((period) => DropdownMenuItem(
                    value: period,
                    child: Text(period),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedPeriod = value!;
            });
          },
        ),
        const SizedBox(width: 8),
        if (widget.onExport != null)
          IconButton(
            onPressed: widget.onExport,
            icon: const Icon(Icons.download),
            tooltip: 'Export data',
          ),
      ],
      child: Stack(
        children: [
          // Bar chart for revenue and expenses
          BarChartWidget(
            series: columnSeries,
            config: widget.config.copyWith(
              showLegend: true,
              animate: true,
            ),
            legendConfig: const ChartLegendConfig(
              position: ChartLegendPosition.top,
              alignment: ChartLegendAlignment.end,
            ),
          ),
          // Overlay line chart for profit
          if (lineSeries.isNotEmpty)
            IgnorePointer(
              child: LineChartWidget(
                series: lineSeries,
                config: widget.config.copyWith(
                  showLegend: false,
                  animate: true,
                ),
                showGrid: false,
                showBorder: false,
              ),
            ),
        ],
      ),
    );
  }
}

/// User growth dashboard chart
class UserGrowthChartWidget extends StatelessWidget {
  final ChartDataSource dataSource;
  final ChartConfig config;
  final bool showMilestones;

  const UserGrowthChartWidget({
    super.key,
    required this.dataSource,
    required this.config,
    this.showMilestones = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ChartContainer(
      title: config.title.isEmpty ? 'User Growth' : config.title,
      subtitle: 'Total users over time',
      height: 400,
      child: Column(
        children: [
          // Growth metrics
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildGrowthMetric(
                  context,
                  'Total Users',
                  dataSource.metadata['totalUsers']?.toString() ?? '0',
                  Icons.group,
                ),
                _buildGrowthMetric(
                  context,
                  'Monthly Growth',
                  '+${dataSource.metadata['monthlyGrowth'] ?? '0'}%',
                  Icons.trending_up,
                ),
                _buildGrowthMetric(
                  context,
                  'Active Users',
                  _calculateActiveUsers(dataSource),
                  Icons.person_pin,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Growth chart
          Expanded(
            child: AreaChartWidget(
              series: dataSource.series,
              config: config.copyWith(
                showLegend: false,
                animate: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthMetric(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Icon(
          icon,
          color: colorScheme.primary,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  String _calculateActiveUsers(ChartDataSource dataSource) {
    if (dataSource.series.isEmpty || dataSource.series.first.data.isEmpty) {
      return '0';
    }
    
    final lastPoint = dataSource.series.first.data.last;
    final activeUsers = lastPoint.customData?['activeUsers'] ?? 0;
    
    if (activeUsers >= 1000) {
      return '${(activeUsers / 1000).toStringAsFixed(1)}K';
    }
    return activeUsers.toString();
  }
}

/// Conversion funnel dashboard chart
class ConversionChartWidget extends StatelessWidget {
  final ChartDataSource dataSource;
  final ChartConfig config;
  final bool showPercentages;

  const ConversionChartWidget({
    super.key,
    required this.dataSource,
    required this.config,
    this.showPercentages = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ChartContainer(
      title: config.title.isEmpty ? 'Conversion Funnel' : config.title,
      subtitle: 'User journey from visitor to premium',
      height: 400,
      child: CustomPaint(
        painter: _FunnelChartPainter(
          data: dataSource.series.first.data,
          theme: theme,
          showPercentages: showPercentages,
        ),
        child: Container(),
      ),
    );
  }
}

/// Custom painter for funnel chart
class _FunnelChartPainter extends CustomPainter {
  final List<ChartPoint> data;
  final ThemeData theme;
  final bool showPercentages;

  _FunnelChartPainter({
    required this.data,
    required this.theme,
    required this.showPercentages,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()..style = PaintingStyle.fill;
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final segmentHeight = size.height / data.length;
    final maxWidth = size.width * 0.8;
    final centerX = size.width / 2;

    for (int i = 0; i < data.length; i++) {
      final point = data[i];
      final percentage = point.customData?['percentage'] ?? 100;
      final segmentWidth = maxWidth * (percentage / 100);
      
      // Calculate trapezoid points
      final topY = i * segmentHeight;
      final bottomY = (i + 1) * segmentHeight;
      final topHalfWidth = i == 0 ? maxWidth / 2 : (maxWidth * (data[i - 1].customData?['percentage'] ?? 100) / 100) / 2;
      final bottomHalfWidth = segmentWidth / 2;
      
      final path = Path()
        ..moveTo(centerX - topHalfWidth, topY)
        ..lineTo(centerX + topHalfWidth, topY)
        ..lineTo(centerX + bottomHalfWidth, bottomY)
        ..lineTo(centerX - bottomHalfWidth, bottomY)
        ..close();
      
      paint.color = point.color ?? theme.colorScheme.primary;
      canvas.drawPath(path, paint);
      
      // Draw label
      textPainter.text = TextSpan(
        text: '${point.label}\n${point.y.toStringAsFixed(0)}',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      
      final textX = centerX - textPainter.width / 2;
      final textY = topY + (segmentHeight - textPainter.height) / 2;
      textPainter.paint(canvas, Offset(textX, textY));
      
      // Draw percentage
      if (showPercentages) {
        textPainter.text = TextSpan(
          text: '$percentage%',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        );
        textPainter.layout();
        
        final percentX = centerX + bottomHalfWidth + 10;
        final percentY = topY + segmentHeight / 2 - textPainter.height / 2;
        textPainter.paint(canvas, Offset(percentX, percentY));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}