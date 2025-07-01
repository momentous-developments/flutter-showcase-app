import 'package:flutter/material.dart';

/// Enum for trend direction
enum TrendDirection { positive, negative }

/// Data model for basic statistics card
class StatisticsCardData {
  final String title;
  final String value;
  final IconData? icon;
  final Color? iconColor;
  final String? subtitle;
  final TrendDirection? trend;
  final String? trendValue;
  final String? chipLabel;
  final Color? chipColor;
  final String? description;

  const StatisticsCardData({
    required this.title,
    required this.value,
    this.icon,
    this.iconColor,
    this.subtitle,
    this.trend,
    this.trendValue,
    this.chipLabel,
    this.chipColor,
    this.description,
  });
}

/// Data model for horizontal statistics card with avatar
class HorizontalStatsData {
  final String title;
  final String stats;
  final IconData avatarIcon;
  final Color? avatarColor;
  final double? avatarSize;

  const HorizontalStatsData({
    required this.title,
    required this.stats,
    required this.avatarIcon,
    this.avatarColor,
    this.avatarSize = 42,
  });
}

/// Data model for horizontal statistics card with border
class HorizontalBorderStatsData {
  final String title;
  final String stats;
  final double trendNumber;
  final IconData avatarIcon;
  final Color? color;

  const HorizontalBorderStatsData({
    required this.title,
    required this.stats,
    required this.trendNumber,
    required this.avatarIcon,
    this.color,
  });
}

/// Data model for horizontal statistics card with subtitle
class HorizontalSubtitleStatsData {
  final String title;
  final String stats;
  final IconData avatarIcon;
  final Color? avatarColor;
  final TrendDirection trend;
  final String trendNumber;
  final String subtitle;

  const HorizontalSubtitleStatsData({
    required this.title,
    required this.stats,
    required this.avatarIcon,
    this.avatarColor,
    required this.trend,
    required this.trendNumber,
    required this.subtitle,
  });
}

/// Data model for customer statistics card
class CustomerStatsData {
  final String title;
  final IconData avatarIcon;
  final Color? color;
  final String description;
  final String? stats;
  final String? content;
  final String? chipLabel;

  const CustomerStatsData({
    required this.title,
    required this.avatarIcon,
    this.color,
    required this.description,
    this.stats,
    this.content,
    this.chipLabel,
  });
}

/// Data model for square statistics card
class SquareStatsData {
  final IconData avatarIcon;
  final Color? avatarColor;
  final double? avatarSize;
  final String stats;
  final String statsTitle;

  const SquareStatsData({
    required this.avatarIcon,
    this.avatarColor,
    this.avatarSize = 56,
    required this.stats,
    required this.statsTitle,
  });
}

/// Data model for vertical statistics card
class VerticalStatsData {
  final String title;
  final String subtitle;
  final String stats;
  final IconData avatarIcon;
  final double? avatarSize;
  final Color? avatarColor;
  final String chipText;
  final Color? chipColor;

  const VerticalStatsData({
    required this.title,
    required this.subtitle,
    required this.stats,
    required this.avatarIcon,
    this.avatarSize = 56,
    this.avatarColor,
    required this.chipText,
    this.chipColor,
  });
}

/// Data model for chart data points
class ChartDataPoint {
  final double x;
  final double y;

  const ChartDataPoint(this.x, this.y);
}

/// Data model for area chart series
class ChartSeries {
  final String name;
  final List<ChartDataPoint> data;
  final Color? color;

  const ChartSeries({
    required this.name,
    required this.data,
    this.color,
  });
}

/// Data model for statistics card with area chart
class StatsWithAreaChartData {
  final String stats;
  final String title;
  final IconData avatarIcon;
  final List<ChartSeries> chartSeries;
  final double? avatarSize;
  final Color? chartColor;
  final Color? avatarColor;

  const StatsWithAreaChartData({
    required this.stats,
    required this.title,
    required this.avatarIcon,
    required this.chartSeries,
    this.avatarSize = 56,
    this.chartColor,
    this.avatarColor,
  });
}

/// Sample data for testing and showcase
class SampleStatisticsData {
  static const squareStats = [
    SquareStatsData(
      avatarIcon: Icons.trending_up,
      avatarColor: Colors.blue,
      stats: '230k',
      statsTitle: 'Sales',
    ),
    SquareStatsData(
      avatarIcon: Icons.people,
      avatarColor: Colors.purple,
      stats: '8.549k',
      statsTitle: 'Customers',
    ),
    SquareStatsData(
      avatarIcon: Icons.shopping_cart,
      avatarColor: Colors.green,
      stats: '1.423k',
      statsTitle: 'Products',
    ),
    SquareStatsData(
      avatarIcon: Icons.attach_money,
      avatarColor: Colors.orange,
      stats: '9745',
      statsTitle: 'Revenue',
    ),
  ];

  static const horizontalStats = [
    HorizontalStatsData(
      title: 'Total Revenue',
      stats: '97.5k',
      avatarIcon: Icons.trending_up,
      avatarColor: Colors.blue,
    ),
    HorizontalStatsData(
      title: 'Total Orders',
      stats: '13.7k',
      avatarIcon: Icons.shopping_bag,
      avatarColor: Colors.green,
    ),
    HorizontalStatsData(
      title: 'Active Users',
      stats: '1.15k',
      avatarIcon: Icons.person,
      avatarColor: Colors.orange,
    ),
  ];

  static const verticalStats = [
    VerticalStatsData(
      title: 'Total Profit',
      subtitle: 'Last week analytics',
      stats: '15k',
      avatarIcon: Icons.trending_up,
      avatarColor: Colors.blue,
      chipText: '+25.8%',
      chipColor: Colors.green,
    ),
    VerticalStatsData(
      title: 'Refunds',
      subtitle: 'Last week analytics',
      stats: '236',
      avatarIcon: Icons.refresh,
      avatarColor: Colors.purple,
      chipText: '-12.2%',
      chipColor: Colors.red,
    ),
  ];

  static const customerStats = [
    CustomerStatsData(
      title: 'New Customers',
      avatarIcon: Icons.person_add,
      color: Colors.blue,
      description: 'Total 48.5% growth',
      stats: '92.6k',
    ),
    CustomerStatsData(
      title: 'Total Orders',
      avatarIcon: Icons.shopping_cart,
      color: Colors.green,
      description: 'Weekly report',
      chipLabel: 'Daily',
    ),
  ];

  static final chartSeries = [
    ChartSeries(
      name: 'Revenue',
      data: const [
        ChartDataPoint(1, 30),
        ChartDataPoint(2, 40),
        ChartDataPoint(3, 35),
        ChartDataPoint(4, 50),
        ChartDataPoint(5, 49),
        ChartDataPoint(6, 60),
        ChartDataPoint(7, 70),
        ChartDataPoint(8, 91),
      ],
      color: Colors.blue,
    ),
  ];

  static final statsWithChart = [
    StatsWithAreaChartData(
      stats: '97.5k',
      title: 'Revenue',
      avatarIcon: Icons.trending_up,
      chartSeries: chartSeries,
      avatarColor: Colors.blue,
      chartColor: Colors.blue,
    ),
    StatsWithAreaChartData(
      stats: '13.2k',
      title: 'Orders',
      avatarIcon: Icons.shopping_bag,
      chartSeries: chartSeries,
      avatarColor: Colors.green,
      chartColor: Colors.green,
    ),
  ];
}