import 'package:flutter/material.dart';
import 'dart:async';
import '../models/chart_models.dart';
import '../services/chart_data_service.dart';

/// Provider for managing chart state and data
class ChartProvider extends ChangeNotifier {
  final ChartDataService _dataService = ChartDataService();
  
  // Chart data
  final Map<String, ChartDataSource> _dataSources = {};
  final Map<String, List<ChartSeries>> _chartData = {};
  
  // Chart configurations
  final Map<String, ChartConfig> _chartConfigs = {};
  
  // Active filters
  final Map<String, List<ChartFilter>> _activeFilters = {};
  
  // Real-time data subscriptions
  final Map<String, StreamSubscription> _realtimeSubscriptions = {};
  
  // Loading states
  final Set<String> _loadingCharts = {};
  
  // Selected data points
  final Map<String, List<ChartTooltipData>> _selectedPoints = {};

  /// Get chart data
  List<ChartSeries>? getChartData(String chartId) => _chartData[chartId];
  
  /// Get chart configuration
  ChartConfig? getChartConfig(String chartId) => _chartConfigs[chartId];
  
  /// Get chart data source
  ChartDataSource? getDataSource(String chartId) => _dataSources[chartId];
  
  /// Check if chart is loading
  bool isLoading(String chartId) => _loadingCharts.contains(chartId);
  
  /// Get active filters for a chart
  List<ChartFilter> getFilters(String chartId) => _activeFilters[chartId] ?? [];
  
  /// Get selected points for a chart
  List<ChartTooltipData> getSelectedPoints(String chartId) => _selectedPoints[chartId] ?? [];

  /// Initialize chart with data
  Future<void> initializeChart(String chartId, ChartType type, {ChartConfig? config}) async {
    _loadingCharts.add(chartId);
    notifyListeners();
    
    try {
      // Generate appropriate data based on chart type
      List<ChartSeries> data;
      switch (type) {
        case ChartType.area:
          data = _dataService.generateAreaChartData();
          break;
        case ChartType.bar:
          data = _dataService.generateBarChartData();
          break;
        case ChartType.line:
          data = _dataService.generateLineChartData();
          break;
        case ChartType.pie:
          data = _dataService.generatePieChartData();
          break;
        case ChartType.donut:
          data = _dataService.generatePieChartData();
          break;
        case ChartType.scatter:
          data = _dataService.generateScatterChartData();
          break;
        case ChartType.radar:
          data = _dataService.generateRadarChartData();
          break;
        case ChartType.candlestick:
          data = _dataService.generateCandlestickData();
          break;
        case ChartType.heatmap:
          data = _dataService.generateHeatmapData();
          break;
        case ChartType.column:
          data = _dataService.generateBarChartData();
          break;
        case ChartType.radialBar:
          data = _dataService.generateRadarChartData();
          break;
        case ChartType.analytics:
          final source = _dataService.generateAnalyticsData();
          _dataSources[chartId] = source;
          data = source.series;
          break;
        case ChartType.revenue:
          final source = _dataService.generateRevenueData();
          _dataSources[chartId] = source;
          data = source.series;
          break;
        case ChartType.userGrowth:
          final source = _dataService.generateUserGrowthData();
          _dataSources[chartId] = source;
          data = source.series;
          break;
        case ChartType.conversion:
          final source = _dataService.generateConversionData();
          _dataSources[chartId] = source;
          data = source.series;
          break;
        default:
          data = _dataService.generateLineChartData();
      }
      
      _chartData[chartId] = data;
      _chartConfigs[chartId] = config ?? ChartConfig(type: type);
      
      // Simulate loading delay
      await Future.delayed(const Duration(milliseconds: 500));
    } finally {
      _loadingCharts.remove(chartId);
      notifyListeners();
    }
  }

  /// Update chart data
  void updateChartData(String chartId, List<ChartSeries> data) {
    _chartData[chartId] = data;
    notifyListeners();
  }

  /// Update chart configuration
  void updateChartConfig(String chartId, ChartConfig config) {
    _chartConfigs[chartId] = config;
    notifyListeners();
  }

  /// Apply filter to chart
  void applyFilter(String chartId, ChartFilter filter) {
    _activeFilters[chartId] ??= [];
    
    // Remove existing filter with same name
    _activeFilters[chartId]!.removeWhere((f) => f.name == filter.name);
    
    // Add new filter
    _activeFilters[chartId]!.add(filter);
    
    // Re-filter data
    _applyFilters(chartId);
    notifyListeners();
  }

  /// Remove filter from chart
  void removeFilter(String chartId, String filterName) {
    _activeFilters[chartId]?.removeWhere((f) => f.name == filterName);
    _applyFilters(chartId);
    notifyListeners();
  }

  /// Clear all filters for a chart
  void clearFilters(String chartId) {
    _activeFilters[chartId]?.clear();
    _applyFilters(chartId);
    notifyListeners();
  }

  /// Apply filters to chart data
  void _applyFilters(String chartId) {
    // Implementation depends on specific filter logic
    // This is a placeholder for filter application
  }

  /// Start real-time data updates
  void startRealtimeUpdates(String chartId, {Duration interval = const Duration(seconds: 1)}) {
    // Cancel existing subscription
    _realtimeSubscriptions[chartId]?.cancel();
    
    // Create new subscription
    final subscription = _dataService.generateRealtimeData(interval: interval).listen((point) {
      final currentData = _chartData[chartId];
      if (currentData != null && currentData.isNotEmpty) {
        final series = currentData.first;
        final newData = List<ChartPoint>.from(series.data)..add(point);
        
        // Keep only last 50 points for performance
        if (newData.length > 50) {
          newData.removeAt(0);
          // Adjust x values
          for (int i = 0; i < newData.length; i++) {
            newData[i] = newData[i].copyWith(x: i.toDouble());
          }
        }
        
        _chartData[chartId] = [series.copyWith(data: newData)];
        notifyListeners();
      }
    });
    
    _realtimeSubscriptions[chartId] = subscription;
  }

  /// Stop real-time data updates
  void stopRealtimeUpdates(String chartId) {
    _realtimeSubscriptions[chartId]?.cancel();
    _realtimeSubscriptions.remove(chartId);
  }

  /// Handle chart interaction
  void handleChartInteraction(String chartId, ChartInteractionEvent event) {
    switch (event.type) {
      case ChartInteractionType.tap:
      case ChartInteractionType.hover:
        if (event.data != null) {
          _selectedPoints[chartId] = [event.data!];
          notifyListeners();
        }
        break;
      case ChartInteractionType.doubleTap:
        // Clear selection on double tap
        _selectedPoints[chartId]?.clear();
        notifyListeners();
        break;
      default:
        // Handle other interaction types
        break;
    }
  }

  /// Export chart as image
  Future<void> exportChart(String chartId, ChartExportConfig config) async {
    // Implementation would depend on the specific chart library
    // and platform capabilities
    debugPrint('Exporting chart $chartId as ${config.format}');
  }

  /// Refresh chart data
  Future<void> refreshChart(String chartId) async {
    final config = _chartConfigs[chartId];
    if (config != null) {
      await initializeChart(chartId, config.type, config: config);
    }
  }

  /// Clean up resources
  @override
  void dispose() {
    // Cancel all real-time subscriptions
    for (final subscription in _realtimeSubscriptions.values) {
      subscription.cancel();
    }
    _realtimeSubscriptions.clear();
    
    super.dispose();
  }
}