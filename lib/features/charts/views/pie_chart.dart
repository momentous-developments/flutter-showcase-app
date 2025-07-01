import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/chart_models.dart';
import '../widgets/chart_container.dart';
import '../widgets/chart_legend.dart';

/// Pie and Donut chart widget
class PieChartWidget extends StatefulWidget {
  final List<ChartSeries> series;
  final ChartConfig config;
  final ChartLegendConfig? legendConfig;
  final Function(ChartTooltipData)? onSectionTap;
  final bool isDonut;
  final double centerSpaceRadius;
  final bool showSectionLabels;
  final bool showPercentages;
  final bool animate;
  final double sectionSpace;
  final double startAngle;

  const PieChartWidget({
    super.key,
    required this.series,
    required this.config,
    this.legendConfig,
    this.onSectionTap,
    this.isDonut = false,
    this.centerSpaceRadius = 0,
    this.showSectionLabels = true,
    this.showPercentages = true,
    this.animate = true,
    this.sectionSpace = 2,
    this.startAngle = -90,
  });

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> with SingleTickerProviderStateMixin {
  int _touchedIndex = -1;
  final Map<int, bool> _visibleSections = {};
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
  void didUpdateWidget(PieChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.series != widget.series && widget.animate) {
      _animationController.forward(from: 0);
    }
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

    final effectiveCenterRadius = widget.isDonut 
        ? widget.centerSpaceRadius > 0 
            ? widget.centerSpaceRadius 
            : 50.0
        : 0.0;

    return ChartContainer(
      title: widget.config.title,
      subtitle: widget.config.subtitle,
      showToolbar: false,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          enabled: widget.config.showTooltip,
                          touchCallback: (event, response) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  response == null ||
                                  response.touchedSection == null) {
                                _touchedIndex = -1;
                                return;
                              }
                              
                              _touchedIndex = response.touchedSection!.touchedSectionIndex;
                              
                              if (event is FlTapUpEvent && widget.onSectionTap != null) {
                                final series = widget.series.first;
                                final point = series.data[_touchedIndex];
                                
                                widget.onSectionTap!(ChartTooltipData(
                                  point: point,
                                  series: series,
                                  seriesIndex: 0,
                                  pointIndex: _touchedIndex,
                                ));
                              }
                            });
                          },
                        ),
                        startDegreeOffset: widget.startAngle,
                        sections: _generateSections(chartTheme, _animation.value),
                        centerSpaceRadius: effectiveCenterRadius,
                        sectionsSpace: widget.sectionSpace,
                      ),
                    );
                  },
                ),
                if (widget.isDonut && widget.config.title.isNotEmpty)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_touchedIndex >= 0 && _touchedIndex < widget.series.first.data.length) ...[
                        Text(
                          widget.series.first.data[_touchedIndex].label ?? '',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _formatValue(widget.series.first.data[_touchedIndex].y),
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ] else ...[
                        Text(
                          'Total',
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          _formatValue(_calculateTotal()),
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
              ],
            ),
          ),
          if (widget.legendConfig?.show ?? widget.config.showLegend)
            Expanded(
              flex: 1,
              child: _buildCustomLegend(chartTheme),
            ),
        ],
      ),
    );
  }

  Widget _buildCustomLegend(ChartTheme chartTheme) {
    final series = widget.series.first;
    final total = _calculateTotal();
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < series.data.length; i++)
            if (_visibleSections[i] != false)
              _buildLegendItem(
                series.data[i],
                i,
                chartTheme,
                (series.data[i].y / total * 100),
              ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(ChartPoint point, int index, ChartTheme chartTheme, double percentage) {
    final theme = Theme.of(context);
    final color = point.color ?? chartTheme.colors[index % chartTheme.colors.length];
    final isHovered = _touchedIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _touchedIndex = index;
        });
        
        if (widget.onSectionTap != null) {
          widget.onSectionTap!(ChartTooltipData(
            point: point,
            series: widget.series.first,
            seriesIndex: 0,
            pointIndex: index,
          ));
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: isHovered ? color.withOpacity(0.1) : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      point.label ?? '',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: isHovered ? FontWeight.bold : null,
                      ),
                    ),
                    Text(
                      '${_formatValue(point.y)} (${percentage.toStringAsFixed(1)}%)',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _generateSections(ChartTheme chartTheme, double animationValue) {
    final series = widget.series.first;
    final total = _calculateTotal();
    final sections = <PieChartSectionData>[];
    
    for (int i = 0; i < series.data.length; i++) {
      if (_visibleSections[i] == false) continue;
      
      final point = series.data[i];
      final color = point.color ?? chartTheme.colors[i % chartTheme.colors.length];
      final percentage = (point.y / total * 100);
      final isTouched = i == _touchedIndex;
      final radius = isTouched ? 110.0 : 100.0;
      
      sections.add(
        PieChartSectionData(
          color: color,
          value: point.y * animationValue,
          title: widget.showSectionLabels 
              ? widget.showPercentages 
                  ? '${percentage.toStringAsFixed(1)}%'
                  : _formatValue(point.y)
              : '',
          radius: radius * animationValue,
          titleStyle: TextStyle(
            fontSize: isTouched ? 14 : 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          badgeWidget: isTouched && !widget.showSectionLabels
              ? Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    point.label ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                )
              : null,
          badgePositionPercentageOffset: 1.2,
        ),
      );
    }
    
    return sections;
  }

  double _calculateTotal() {
    return widget.series.first.data
        .where((point) => _visibleSections[widget.series.first.data.indexOf(point)] != false)
        .fold(0.0, (sum, point) => sum + point.y);
  }

  String _formatValue(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return value.toStringAsFixed(0);
  }
}