import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/chart_models.dart';
import '../widgets/chart_container.dart';
import '../widgets/chart_legend.dart';

/// Radar/Spider chart widget
class RadarChartWidget extends StatefulWidget {
  final List<ChartSeries> series;
  final ChartConfig config;
  final ChartLegendConfig? legendConfig;
  final Function(ChartTooltipData)? onDataTap;
  final bool showGrid;
  final bool showLabels;
  final bool animate;
  final double maxValue;
  final int gridLevels;

  const RadarChartWidget({
    super.key,
    required this.series,
    required this.config,
    this.legendConfig,
    this.onDataTap,
    this.showGrid = true,
    this.showLabels = true,
    this.animate = true,
    this.maxValue = 100,
    this.gridLevels = 5,
  });

  @override
  State<RadarChartWidget> createState() => _RadarChartWidgetState();
}

class _RadarChartWidgetState extends State<RadarChartWidget> with SingleTickerProviderStateMixin {
  final Map<int, bool> _visibleSeries = {};
  late AnimationController _animationController;
  late Animation<double> _animation;
  int? _touchedSeriesIndex;

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
  void didUpdateWidget(RadarChartWidget oldWidget) {
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

    return ChartContainer(
      title: widget.config.title,
      subtitle: widget.config.subtitle,
      showToolbar: false,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return RadarChart(
                    RadarChartData(
                      dataSets: _generateDataSets(chartTheme, _animation.value),
                      radarBackgroundColor: Colors.transparent,
                      borderData: FlBorderData(show: false),
                      radarBorderData: BorderSide(
                        color: chartTheme.gridColor,
                        width: 2,
                      ),
                      titlePositionPercentageOffset: 0.2,
                      titleTextStyle: chartTheme.labelStyle ?? theme.textTheme.bodySmall,
                      getTitle: (index, angle) {
                        if (!widget.showLabels) return const RadarChartTitle(text: '');
                        
                        final dataPoint = widget.series.first.data[index % widget.series.first.data.length];
                        return RadarChartTitle(
                          text: dataPoint.label ?? 'Axis ${index + 1}',
                          angle: 0,
                        );
                      },
                      tickCount: widget.gridLevels,
                      ticksTextStyle: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 10,
                      ),
                      tickBorderData: BorderSide(
                        color: chartTheme.gridColor.withOpacity(0.5),
                        width: 1,
                      ),
                      gridBorderData: BorderSide(
                        color: chartTheme.gridColor.withOpacity(0.3),
                        width: 1,
                      ),
                      radarTouchData: RadarTouchData(
                        enabled: widget.config.showTooltip,
                        touchCallback: (event, response) {
                          setState(() {
                            if (response != null && response.touchedSpot != null) {
                              _touchedSeriesIndex = response.touchedSpot!.touchedDataSetIndex;
                              
                              if (event is FlTapUpEvent && widget.onDataTap != null) {
                                final series = widget.series[_touchedSeriesIndex!];
                                final pointIndex = response.touchedSpot!.touchedRadarEntryIndex;
                                
                                widget.onDataTap!(ChartTooltipData(
                                  point: series.data[pointIndex],
                                  series: series,
                                  seriesIndex: _touchedSeriesIndex!,
                                  pointIndex: pointIndex,
                                ));
                              }
                            } else {
                              _touchedSeriesIndex = null;
                            }
                          });
                        },
                      ),
                    ),
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

  List<RadarDataSet> _generateDataSets(ChartTheme chartTheme, double animationValue) {
    final dataSets = <RadarDataSet>[];
    
    for (int i = 0; i < widget.series.length; i++) {
      if (_visibleSeries[i] == false) continue;
      
      final series = widget.series[i];
      final color = series.color ?? chartTheme.colors[i % chartTheme.colors.length];
      final isTouched = _touchedSeriesIndex == i;
      
      dataSets.add(
        RadarDataSet(
          fillColor: color.withOpacity(isTouched ? 0.4 : 0.2),
          borderColor: color,
          borderWidth: isTouched ? 3 : 2,
          entryRadius: isTouched ? 5 : 3,
          dataEntries: series.data.map((point) {
            return RadarEntry(
              value: point.y * animationValue,
            );
          }).toList(),
        ),
      );
    }
    
    return dataSets;
  }
}

/// Radial bar chart widget
class RadialBarChartWidget extends StatefulWidget {
  final List<ChartSeries> series;
  final ChartConfig config;
  final ChartLegendConfig? legendConfig;
  final Function(ChartTooltipData)? onSectionTap;
  final bool animate;
  final double centerSpaceRadius;
  final double barWidth;
  final double startAngle;
  final bool showLabels;

  const RadialBarChartWidget({
    super.key,
    required this.series,
    required this.config,
    this.legendConfig,
    this.onSectionTap,
    this.animate = true,
    this.centerSpaceRadius = 50,
    this.barWidth = 20,
    this.startAngle = -90,
    this.showLabels = true,
  });

  @override
  State<RadialBarChartWidget> createState() => _RadialBarChartWidgetState();
}

class _RadialBarChartWidgetState extends State<RadialBarChartWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int _touchedIndex = -1;

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
                        startDegreeOffset: widget.startAngle,
                        sections: _generateSections(chartTheme, _animation.value),
                        centerSpaceRadius: widget.centerSpaceRadius,
                        sectionsSpace: 4,
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
                      ),
                    );
                  },
                ),
                if (widget.showLabels)
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
                          '${widget.series.first.data[_touchedIndex].y.toStringAsFixed(0)}%',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: colorScheme.primary,
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
              child: ChartLegend(
                series: widget.series,
                position: ChartLegendPosition.right,
                alignment: widget.legendConfig?.alignment ?? ChartLegendAlignment.center,
                showValues: widget.legendConfig?.showValues ?? true,
              ),
            ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _generateSections(ChartTheme chartTheme, double animationValue) {
    final series = widget.series.first;
    final sections = <PieChartSectionData>[];
    final maxRadius = 100.0;
    
    for (int i = 0; i < series.data.length; i++) {
      final point = series.data[i];
      final color = point.color ?? chartTheme.colors[i % chartTheme.colors.length];
      final isTouched = i == _touchedIndex;
      
      // Calculate radius based on index to create concentric rings
      final radiusOffset = i * (widget.barWidth + 5);
      final innerRadius = widget.centerSpaceRadius + radiusOffset;
      final outerRadius = innerRadius + widget.barWidth;
      
      sections.add(
        PieChartSectionData(
          color: color,
          value: point.y * animationValue,
          title: '',
          radius: outerRadius * animationValue,
          // innerRadius is handled by centerSpaceRadius in the parent widget
          borderSide: isTouched 
              ? BorderSide(color: Colors.white, width: 3)
              : BorderSide.none,
        ),
      );
    }
    
    return sections;
  }
}