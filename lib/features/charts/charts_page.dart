import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/chart_models.dart';
import 'providers/chart_provider.dart';
import 'services/chart_data_service.dart';
import 'views/area_chart.dart';
import 'views/bar_chart.dart';
import 'views/line_chart.dart';
import 'views/pie_chart.dart';
import 'views/scatter_chart.dart';
import 'views/radar_chart.dart';
import 'views/candlestick_chart.dart';
import 'views/heatmap_chart.dart';
import 'views/dashboard_charts.dart';

/// Provider for chart state
final chartProvider = ChangeNotifierProvider((ref) => ChartProvider());

/// Main charts showcase page
class ChartsPage extends ConsumerStatefulWidget {
  const ChartsPage({super.key});

  @override
  ConsumerState<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends ConsumerState<ChartsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _dataService = ChartDataService();

  final List<_ChartCategory> _categories = [
    _ChartCategory('Basic Charts', Icons.show_chart, [
      _ChartExample('Area Chart', ChartType.area),
      _ChartExample('Bar Chart', ChartType.bar),
      _ChartExample('Line Chart', ChartType.line),
      _ChartExample('Pie Chart', ChartType.pie),
      _ChartExample('Donut Chart', ChartType.donut),
      _ChartExample('Scatter Chart', ChartType.scatter),
    ]),
    _ChartCategory('Advanced Charts', Icons.analytics, [
      _ChartExample('Radar Chart', ChartType.radar),
      _ChartExample('Radial Bar', ChartType.radialBar),
      _ChartExample('Candlestick', ChartType.candlestick),
      _ChartExample('Heatmap', ChartType.heatmap),
      _ChartExample('Bubble Chart', ChartType.scatter),
    ]),
    _ChartCategory('Dashboard', Icons.dashboard, [
      _ChartExample('Analytics', ChartType.analytics),
      _ChartExample('Revenue', ChartType.revenue),
      _ChartExample('User Growth', ChartType.userGrowth),
      _ChartExample('Conversion', ChartType.conversion),
    ]),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _categories.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Charts & Data Visualization',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Interactive charts with multiple series, animations, and real-time updates',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          // Tab bar
          Container(
            color: colorScheme.surface,
            child: TabBar(
              controller: _tabController,
              labelColor: colorScheme.primary,
              unselectedLabelColor: colorScheme.onSurfaceVariant,
              indicatorColor: colorScheme.primary,
              tabs: _categories.map((category) {
                return Tab(
                  icon: Icon(category.icon),
                  text: category.name,
                );
              }).toList(),
            ),
          ),
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _categories.map((category) {
                return _buildCategoryContent(category);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryContent(_ChartCategory category) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 600,
        childAspectRatio: 1.2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: category.examples.length,
      itemBuilder: (context, index) {
        final example = category.examples[index];
        return _buildChartCard(example);
      },
    );
  }

  Widget _buildChartCard(_ChartExample example) {
    final provider = ref.watch(chartProvider);
    final chartId = '${example.type.name}_chart';
    final isLoading = provider.isLoading(chartId);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  example.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (example.type == ChartType.line || 
                    example.type == ChartType.area ||
                    example.type == ChartType.bar)
                  IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      ref.read(chartProvider).startRealtimeUpdates(chartId);
                    },
                    tooltip: 'Start real-time updates',
                  ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildChart(example, chartId),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(_ChartExample example, String chartId) {
    final provider = ref.watch(chartProvider);
    
    // Initialize chart if needed
    if (provider.getChartData(chartId) == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(chartProvider).initializeChart(chartId, example.type);
      });
      return const Center(child: CircularProgressIndicator());
    }

    final config = ChartConfig(
      type: example.type,
      title: '',
      showLegend: true,
      showTooltip: true,
      animate: true,
    );

    switch (example.type) {
      case ChartType.area:
        return AreaChartWidget(
          series: provider.getChartData(chartId) ?? [],
          config: config,
        );
        
      case ChartType.bar:
      case ChartType.column:
        return BarChartWidget(
          series: provider.getChartData(chartId) ?? [],
          config: config,
          isHorizontal: example.type == ChartType.bar,
        );
        
      case ChartType.line:
        return LineChartWidget(
          series: provider.getChartData(chartId) ?? [],
          config: config,
        );
        
      case ChartType.pie:
        return PieChartWidget(
          series: provider.getChartData(chartId) ?? [],
          config: config,
          isDonut: false,
        );
        
      case ChartType.donut:
        return PieChartWidget(
          series: provider.getChartData(chartId) ?? [],
          config: config,
          isDonut: true,
        );
        
      case ChartType.scatter:
        return example.title == 'Bubble Chart'
            ? BubbleChartWidget(
                series: provider.getChartData(chartId) ?? [],
                config: config,
              )
            : ScatterChartWidget(
                series: provider.getChartData(chartId) ?? [],
                config: config,
              );
        
      case ChartType.radar:
        return RadarChartWidget(
          series: provider.getChartData(chartId) ?? [],
          config: config,
        );
        
      case ChartType.radialBar:
        return RadialBarChartWidget(
          series: provider.getChartData(chartId) ?? [],
          config: config,
        );
        
      case ChartType.candlestick:
        return CandlestickChartWidget(
          series: provider.getChartData(chartId) ?? [],
          config: config,
        );
        
      case ChartType.heatmap:
        return HeatmapChartWidget(
          series: provider.getChartData(chartId) ?? [],
          config: config,
          xLabels: List.generate(24, (i) => '$i:00'),
          yLabels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
        );
        
      case ChartType.analytics:
        final dataSource = provider.getDataSource(chartId);
        if (dataSource == null) return const SizedBox();
        return AnalyticsChartWidget(
          dataSource: dataSource,
          config: config,
        );
        
      case ChartType.revenue:
        final dataSource = provider.getDataSource(chartId);
        if (dataSource == null) return const SizedBox();
        return RevenueChartWidget(
          dataSource: dataSource,
          config: config,
        );
        
      case ChartType.userGrowth:
        final dataSource = provider.getDataSource(chartId);
        if (dataSource == null) return const SizedBox();
        return UserGrowthChartWidget(
          dataSource: dataSource,
          config: config,
        );
        
      case ChartType.conversion:
        final dataSource = provider.getDataSource(chartId);
        if (dataSource == null) return const SizedBox();
        return ConversionChartWidget(
          dataSource: dataSource,
          config: config,
        );
        
      default:
        return Center(
          child: Text('${example.type} chart not implemented'),
        );
    }
  }
}

/// Chart category model
class _ChartCategory {
  final String name;
  final IconData icon;
  final List<_ChartExample> examples;

  const _ChartCategory(this.name, this.icon, this.examples);
}

/// Chart example model
class _ChartExample {
  final String title;
  final ChartType type;

  const _ChartExample(this.title, this.type);
}