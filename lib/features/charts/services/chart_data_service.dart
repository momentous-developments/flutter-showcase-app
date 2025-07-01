import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/chart_models.dart';

/// Service for generating and managing chart data
class ChartDataService {
  static final ChartDataService _instance = ChartDataService._internal();
  factory ChartDataService() => _instance;
  ChartDataService._internal();

  final _random = math.Random();

  /// Generate sample data for area chart
  List<ChartSeries> generateAreaChartData({
    int seriesCount = 2,
    int pointCount = 12,
    double minY = 0,
    double maxY = 100,
  }) {
    return List.generate(seriesCount, (seriesIndex) {
      return ChartSeries(
        name: 'Series ${seriesIndex + 1}',
        type: ChartSeriesType.area,
        data: List.generate(pointCount, (index) {
          return ChartPoint(
            x: index.toDouble(),
            y: minY + _random.nextDouble() * (maxY - minY),
            label: 'Point $index',
          );
        }),
      );
    });
  }

  /// Generate sample data for bar chart
  List<ChartSeries> generateBarChartData({
    int seriesCount = 3,
    int categoryCount = 6,
    double minY = 0,
    double maxY = 100,
  }) {
    final categories = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    
    return List.generate(seriesCount, (seriesIndex) {
      return ChartSeries(
        name: 'Series ${seriesIndex + 1}',
        type: ChartSeriesType.bar,
        data: List.generate(categoryCount, (index) {
          return ChartPoint(
            x: index.toDouble(),
            y: minY + _random.nextDouble() * (maxY - minY),
            label: categories[index % categories.length],
          );
        }),
      );
    });
  }

  /// Generate sample data for line chart
  List<ChartSeries> generateLineChartData({
    int seriesCount = 3,
    int pointCount = 20,
    double minY = 0,
    double maxY = 100,
    bool smooth = true,
  }) {
    return List.generate(seriesCount, (seriesIndex) {
      double previousY = (minY + maxY) / 2;
      
      return ChartSeries(
        name: 'Line ${seriesIndex + 1}',
        type: ChartSeriesType.line,
        data: List.generate(pointCount, (index) {
          // Generate smooth continuous data
          if (smooth) {
            final change = (_random.nextDouble() - 0.5) * 20;
            previousY = (previousY + change).clamp(minY, maxY);
          } else {
            previousY = minY + _random.nextDouble() * (maxY - minY);
          }
          
          return ChartPoint(
            x: index.toDouble(),
            y: previousY,
          );
        }),
      );
    });
  }

  /// Generate sample data for pie/donut chart
  List<ChartSeries> generatePieChartData({
    int sliceCount = 5,
  }) {
    final categories = ['Category A', 'Category B', 'Category C', 'Category D', 'Category E'];
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
    ];
    
    final data = List.generate(sliceCount, (index) {
      return ChartPoint(
        x: index.toDouble(),
        y: 10 + _random.nextDouble() * 90,
        label: categories[index % categories.length],
        color: colors[index % colors.length],
      );
    });
    
    return [
      ChartSeries(
        name: 'Distribution',
        type: ChartSeriesType.pie,
        data: data,
      ),
    ];
  }

  /// Generate sample data for scatter chart
  List<ChartSeries> generateScatterChartData({
    int seriesCount = 3,
    int pointCount = 50,
    double minX = 0,
    double maxX = 100,
    double minY = 0,
    double maxY = 100,
  }) {
    return List.generate(seriesCount, (seriesIndex) {
      // Create clusters
      final centerX = minX + _random.nextDouble() * (maxX - minX);
      final centerY = minY + _random.nextDouble() * (maxY - minY);
      final spread = 20.0;
      
      return ChartSeries(
        name: 'Cluster ${seriesIndex + 1}',
        type: ChartSeriesType.scatter,
        data: List.generate(pointCount, (index) {
          return ChartPoint(
            x: (centerX + (_random.nextDouble() - 0.5) * spread).clamp(minX, maxX),
            y: (centerY + (_random.nextDouble() - 0.5) * spread).clamp(minY, maxY),
          );
        }),
      );
    });
  }

  /// Generate sample data for radar chart
  List<ChartSeries> generateRadarChartData({
    int seriesCount = 2,
    int axisCount = 6,
  }) {
    final categories = ['Speed', 'Power', 'Defense', 'Attack', 'Magic', 'Stamina'];
    
    return List.generate(seriesCount, (seriesIndex) {
      return ChartSeries(
        name: 'Player ${seriesIndex + 1}',
        type: ChartSeriesType.radar,
        data: List.generate(axisCount, (index) {
          return ChartPoint(
            x: index.toDouble(),
            y: 20 + _random.nextDouble() * 80,
            label: categories[index % categories.length],
          );
        }),
      );
    });
  }

  /// Generate sample data for candlestick chart
  List<ChartSeries> generateCandlestickData({
    int pointCount = 30,
    double basePrice = 100,
  }) {
    final data = <ChartPoint>[];
    double currentPrice = basePrice;
    final now = DateTime.now();
    
    for (int i = 0; i < pointCount; i++) {
      final open = currentPrice;
      final change = (_random.nextDouble() - 0.5) * 10;
      final close = open + change;
      final high = math.max(open, close) + _random.nextDouble() * 5;
      final low = math.min(open, close) - _random.nextDouble() * 5;
      final volume = 1000 + _random.nextDouble() * 9000;
      
      data.add(FinancialPoint(
        x: i.toDouble(),
        open: open,
        high: high,
        low: low,
        close: close,
        volume: volume,
        timestamp: now.subtract(Duration(days: pointCount - i)),
        color: close >= open ? Colors.green : Colors.red,
      ));
      
      currentPrice = close;
    }
    
    return [
      ChartSeries(
        name: 'Stock Price',
        type: ChartSeriesType.candlestick,
        data: data,
      ),
    ];
  }

  /// Generate sample data for heatmap chart
  List<ChartSeries> generateHeatmapData({
    int rows = 7,
    int columns = 24,
  }) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final data = <ChartPoint>[];
    
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < columns; col++) {
        data.add(ChartPoint(
          x: col.toDouble(),
          y: row.toDouble(),
          customData: {
            'value': _random.nextDouble() * 100,
            'day': days[row],
            'hour': col,
          },
        ));
      }
    }
    
    return [
      ChartSeries(
        name: 'Activity Heatmap',
        type: ChartSeriesType.heatmap,
        data: data,
      ),
    ];
  }

  /// Generate analytics dashboard data
  ChartDataSource generateAnalyticsData() {
    final now = DateTime.now();
    final data = <ChartPoint>[];
    
    // Generate 30 days of data
    for (int i = 0; i < 30; i++) {
      final date = now.subtract(Duration(days: 30 - i));
      data.add(ChartPoint(
        x: i.toDouble(),
        y: 1000 + _random.nextDouble() * 2000,
        customData: {
          'date': date,
          'visitors': 500 + _random.nextInt(1000),
          'pageViews': 1000 + _random.nextInt(2000),
          'bounceRate': 20 + _random.nextDouble() * 40,
        },
      ));
    }
    
    return ChartDataSource(
      id: 'analytics',
      name: 'Website Analytics',
      series: [
        ChartSeries(
          name: 'Page Views',
          type: ChartSeriesType.area,
          data: data,
        ),
      ],
      lastUpdated: now,
      metadata: {
        'totalVisitors': data.fold(0, (sum, point) => sum + (point.customData['visitors'] as int)),
        'avgBounceRate': data.fold(0.0, (sum, point) => sum + point.customData['bounceRate']) / data.length,
      },
    );
  }

  /// Generate revenue dashboard data
  ChartDataSource generateRevenueData() {
    final now = DateTime.now();
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    
    final revenue = <ChartPoint>[];
    final expenses = <ChartPoint>[];
    final profit = <ChartPoint>[];
    
    for (int i = 0; i < 12; i++) {
      final rev = 50000 + _random.nextDouble() * 50000;
      final exp = 30000 + _random.nextDouble() * 30000;
      
      revenue.add(ChartPoint(
        x: i.toDouble(),
        y: rev,
        label: months[i],
      ));
      
      expenses.add(ChartPoint(
        x: i.toDouble(),
        y: exp,
        label: months[i],
      ));
      
      profit.add(ChartPoint(
        x: i.toDouble(),
        y: rev - exp,
        label: months[i],
      ));
    }
    
    return ChartDataSource(
      id: 'revenue',
      name: 'Revenue Overview',
      series: [
        ChartSeries(name: 'Revenue', type: ChartSeriesType.column, data: revenue),
        ChartSeries(name: 'Expenses', type: ChartSeriesType.column, data: expenses),
        ChartSeries(name: 'Profit', type: ChartSeriesType.line, data: profit),
      ],
      lastUpdated: now,
    );
  }

  /// Generate user growth data
  ChartDataSource generateUserGrowthData() {
    final now = DateTime.now();
    final data = <ChartPoint>[];
    double totalUsers = 1000;
    
    // Generate 365 days of data
    for (int i = 0; i < 365; i++) {
      final growth = 10 + _random.nextDouble() * 50;
      totalUsers += growth;
      
      data.add(ChartPoint(
        x: i.toDouble(),
        y: totalUsers,
        customData: {
          'date': now.subtract(Duration(days: 365 - i)),
          'newUsers': growth.round(),
          'activeUsers': (totalUsers * (0.6 + _random.nextDouble() * 0.3)).round(),
        },
      ));
    }
    
    return ChartDataSource(
      id: 'userGrowth',
      name: 'User Growth',
      series: [
        ChartSeries(
          name: 'Total Users',
          type: ChartSeriesType.area,
          data: data,
        ),
      ],
      lastUpdated: now,
      metadata: {
        'totalUsers': totalUsers.round(),
        'monthlyGrowth': ((totalUsers - data[data.length - 30].y) / data[data.length - 30].y * 100).toStringAsFixed(1),
      },
    );
  }

  /// Generate conversion funnel data
  ChartDataSource generateConversionData() {
    final stages = ['Visitors', 'Sign Ups', 'Active Users', 'Paid Users', 'Premium Users'];
    final values = [10000, 4000, 2500, 1000, 300];
    final colors = [Colors.blue, Colors.cyan, Colors.teal, Colors.green, Colors.lime];
    
    final data = <ChartPoint>[];
    for (int i = 0; i < stages.length; i++) {
      data.add(ChartPoint(
        x: i.toDouble(),
        y: values[i].toDouble(),
        label: stages[i],
        color: colors[i],
        customData: {
          'percentage': i == 0 ? 100 : (values[i] / values[0] * 100).toStringAsFixed(1),
          'dropoff': i == 0 ? 0 : (100 - values[i] / values[i - 1] * 100).toStringAsFixed(1),
        },
      ));
    }
    
    return ChartDataSource(
      id: 'conversion',
      name: 'Conversion Funnel',
      series: [
        ChartSeries(
          name: 'Funnel',
          type: ChartSeriesType.bar,
          data: data,
        ),
      ],
      lastUpdated: DateTime.now(),
    );
  }

  /// Generate real-time data stream
  Stream<ChartPoint> generateRealtimeData({
    Duration interval = const Duration(seconds: 1),
    double minY = 0,
    double maxY = 100,
  }) async* {
    int x = 0;
    double previousY = (minY + maxY) / 2;
    
    while (true) {
      await Future.delayed(interval);
      
      final change = (_random.nextDouble() - 0.5) * 10;
      previousY = (previousY + change).clamp(minY, maxY);
      
      yield ChartPoint(
        x: x.toDouble(),
        y: previousY,
        customData: {'timestamp': DateTime.now()},
      );
      
      x++;
    }
  }
}