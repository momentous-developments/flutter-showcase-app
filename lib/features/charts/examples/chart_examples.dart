import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../charts.dart';

/// Example page showing all chart types and features
class ChartExamplesPage extends ConsumerStatefulWidget {
  const ChartExamplesPage({super.key});

  @override
  ConsumerState<ChartExamplesPage> createState() => _ChartExamplesPageState();
}

class _ChartExamplesPageState extends ConsumerState<ChartExamplesPage> {
  final _dataService = ChartDataService();
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chart Examples'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            'Area Chart',
            'Smooth area charts with gradient fills',
            AreaChartWidget(
              series: _dataService.generateAreaChartData(),
              config: const ChartConfig(
                type: ChartType.area,
                title: 'Monthly Revenue',
                subtitle: 'Revenue trend over the last 12 months',
              ),
            ),
          ),
          _buildSection(
            'Bar Chart',
            'Vertical and horizontal bar charts',
            BarChartWidget(
              series: _dataService.generateBarChartData(),
              config: const ChartConfig(
                type: ChartType.bar,
                title: 'Product Sales',
                subtitle: 'Sales by category',
              ),
            ),
          ),
          _buildSection(
            'Line Chart',
            'Multiple series line charts with animations',
            LineChartWidget(
              series: _dataService.generateLineChartData(),
              config: const ChartConfig(
                type: ChartType.line,
                title: 'Performance Metrics',
                subtitle: 'Key performance indicators',
              ),
            ),
          ),
          _buildSection(
            'Pie Chart',
            'Interactive pie charts with legends',
            PieChartWidget(
              series: _dataService.generatePieChartData(),
              config: const ChartConfig(
                type: ChartType.pie,
                title: 'Market Share',
                subtitle: 'Distribution by segment',
              ),
              isDonut: false,
            ),
          ),
          _buildSection(
            'Donut Chart',
            'Donut charts with center text',
            PieChartWidget(
              series: _dataService.generatePieChartData(),
              config: const ChartConfig(
                type: ChartType.donut,
                title: 'Budget Allocation',
                subtitle: 'Department spending',
              ),
              isDonut: true,
              centerSpaceRadius: 60,
            ),
          ),
          _buildSection(
            'Scatter Chart',
            'Scatter plots with multiple clusters',
            ScatterChartWidget(
              series: _dataService.generateScatterChartData(),
              config: const ChartConfig(
                type: ChartType.scatter,
                title: 'Data Distribution',
                subtitle: 'Clustered data points',
              ),
            ),
          ),
          _buildSection(
            'Radar Chart',
            'Multi-axis radar charts',
            RadarChartWidget(
              series: _dataService.generateRadarChartData(),
              config: const ChartConfig(
                type: ChartType.radar,
                title: 'Skills Assessment',
                subtitle: 'Player comparison',
              ),
            ),
          ),
          _buildSection(
            'Candlestick Chart',
            'Financial candlestick charts',
            CandlestickChartWidget(
              series: _dataService.generateCandlestickData(),
              config: const ChartConfig(
                type: ChartType.candlestick,
                title: 'Stock Prices',
                subtitle: '30-day price history',
              ),
            ),
          ),
          _buildSection(
            'Heatmap Chart',
            'Activity heatmap visualization',
            HeatmapChartWidget(
              series: _dataService.generateHeatmapData(),
              config: const ChartConfig(
                type: ChartType.heatmap,
                title: 'Weekly Activity',
                subtitle: 'User activity by hour',
              ),
              xLabels: List.generate(24, (i) => '$i:00'),
              yLabels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            ),
          ),
          _buildSection(
            'Combined Chart',
            'Multiple chart types in one view',
            CombinedChartWidget(
              series: [
                ..._dataService.generateBarChartData(seriesCount: 2),
                ..._dataService.generateLineChartData(seriesCount: 1).map(
                  (s) => s.copyWith(
                    type: ChartSeriesType.line,
                    style: {'showArea': false},
                  ),
                ),
              ],
              config: const ChartConfig(
                type: ChartType.bar,
                title: 'Sales & Trends',
                subtitle: 'Bar chart with trend line overlay',
              ),
            ),
          ),
          // Dashboard examples
          _buildSection(
            'Analytics Dashboard',
            'Complete analytics visualization',
            AnalyticsChartWidget(
              dataSource: _dataService.generateAnalyticsData(),
              config: const ChartConfig(
                type: ChartType.analytics,
              ),
            ),
          ),
          _buildSection(
            'Revenue Dashboard',
            'Revenue tracking with multiple metrics',
            RevenueChartWidget(
              dataSource: _dataService.generateRevenueData(),
              config: const ChartConfig(
                type: ChartType.revenue,
              ),
            ),
          ),
          _buildSection(
            'User Growth',
            'User growth visualization',
            UserGrowthChartWidget(
              dataSource: _dataService.generateUserGrowthData(),
              config: const ChartConfig(
                type: ChartType.userGrowth,
              ),
            ),
          ),
          _buildSection(
            'Conversion Funnel',
            'Conversion rate visualization',
            ConversionChartWidget(
              dataSource: _dataService.generateConversionData(),
              config: const ChartConfig(
                type: ChartType.conversion,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSection(String title, String description, Widget chart) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 400,
            child: chart,
          ),
        ],
      ),
    );
  }
}