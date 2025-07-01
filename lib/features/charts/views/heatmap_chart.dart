import 'package:flutter/material.dart';
import '../models/chart_models.dart';
import '../widgets/chart_container.dart';

/// Heatmap chart widget
class HeatmapChartWidget extends StatefulWidget {
  final List<ChartSeries> series;
  final ChartConfig config;
  final Function(ChartTooltipData)? onCellTap;
  final List<String>? xLabels;
  final List<String>? yLabels;
  final double cellSize;
  final double cellSpacing;
  final bool showLabels;
  final bool showValues;
  final bool animate;
  final Color? minColor;
  final Color? maxColor;

  const HeatmapChartWidget({
    super.key,
    required this.series,
    required this.config,
    this.onCellTap,
    this.xLabels,
    this.yLabels,
    this.cellSize = 40,
    this.cellSpacing = 2,
    this.showLabels = true,
    this.showValues = false,
    this.animate = true,
    this.minColor,
    this.maxColor,
  });

  @override
  State<HeatmapChartWidget> createState() => _HeatmapChartWidgetState();
}

class _HeatmapChartWidgetState extends State<HeatmapChartWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int? _hoveredX;
  int? _hoveredY;
  double _minValue = double.infinity;
  double _maxValue = double.negativeInfinity;

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
    
    _calculateValueRange();
    
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
  void didUpdateWidget(HeatmapChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.series != widget.series) {
      _calculateValueRange();
      if (widget.animate) {
        _animationController.forward(from: 0);
      }
    }
  }

  void _calculateValueRange() {
    if (widget.series.isEmpty || widget.series.first.data.isEmpty) return;

    for (final point in widget.series.first.data) {
      final value = point.customData?['value'] ?? point.y;
      _minValue = _minValue > value ? value : _minValue;
      _maxValue = _maxValue < value ? value : _maxValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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

    // Determine grid dimensions
    final series = widget.series.first;
    int maxX = 0;
    int maxY = 0;
    
    for (final point in series.data) {
      maxX = maxX < point.x.toInt() ? point.x.toInt() : maxX;
      maxY = maxY < point.y.toInt() ? point.y.toInt() : maxY;
    }

    return ChartContainer(
      title: widget.config.title,
      subtitle: widget.config.subtitle,
      showToolbar: false,
      child: Column(
        children: [
          if (widget.showLabels && widget.xLabels != null)
            _buildXLabels(maxX + 1),
          Expanded(
            child: Row(
              children: [
                if (widget.showLabels && widget.yLabels != null)
                  _buildYLabels(maxY + 1),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: _buildHeatmap(maxX + 1, maxY + 1),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildColorScale(),
        ],
      ),
    );
  }

  Widget _buildXLabels(int count) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(left: widget.yLabels != null ? 60 : 0),
      child: Row(
        children: List.generate(count, (index) {
          final label = widget.xLabels != null && index < widget.xLabels!.length
              ? widget.xLabels![index]
              : index.toString();
          
          return Container(
            width: widget.cellSize + widget.cellSpacing,
            alignment: Alignment.center,
            child: RotatedBox(
              quarterTurns: -1,
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildYLabels(int count) {
    return Container(
      width: 60,
      margin: EdgeInsets.only(top: widget.xLabels != null ? 40 : 0),
      child: Column(
        children: List.generate(count, (index) {
          final label = widget.yLabels != null && index < widget.yLabels!.length
              ? widget.yLabels![index]
              : index.toString();
          
          return Container(
            height: widget.cellSize + widget.cellSpacing,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeatmap(int columns, int rows) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final minColor = widget.minColor ?? colorScheme.primary.withOpacity(0.1);
    final maxColor = widget.maxColor ?? colorScheme.primary;

    // Create a map for quick lookup
    final dataMap = <String, ChartPoint>{};
    for (final point in widget.series.first.data) {
      dataMap['${point.x.toInt()},${point.y.toInt()}'] = point;
    }

    return Container(
      padding: EdgeInsets.only(
        top: widget.xLabels != null ? 0 : 8,
        left: widget.yLabels != null ? 0 : 8,
      ),
      child: Column(
        children: List.generate(rows, (y) {
          return Row(
            children: List.generate(columns, (x) {
              final key = '$x,$y';
              final point = dataMap[key];
              final value = point?.customData?['value'] ?? point?.y ?? 0;
              final normalizedValue = (_maxValue > _minValue)
                  ? (value - _minValue) / (_maxValue - _minValue)
                  : 0.0;
              
              final color = Color.lerp(
                minColor,
                maxColor,
                normalizedValue * _animation.value,
              )!;

              final isHovered = _hoveredX == x && _hoveredY == y;

              return GestureDetector(
                onTap: () {
                  if (point != null && widget.onCellTap != null) {
                    widget.onCellTap!(ChartTooltipData(
                      point: point,
                      series: widget.series.first,
                      seriesIndex: 0,
                      pointIndex: widget.series.first.data.indexOf(point),
                    ));
                  }
                },
                child: MouseRegion(
                  onEnter: (_) => setState(() {
                    _hoveredX = x;
                    _hoveredY = y;
                  }),
                  onExit: (_) => setState(() {
                    _hoveredX = null;
                    _hoveredY = null;
                  }),
                  cursor: point != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: widget.cellSize,
                    height: widget.cellSize,
                    margin: EdgeInsets.all(widget.cellSpacing / 2),
                    decoration: BoxDecoration(
                      color: point != null ? color : colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                      border: isHovered
                          ? Border.all(color: colorScheme.primary, width: 2)
                          : null,
                      boxShadow: isHovered
                          ? [
                              BoxShadow(
                                color: colorScheme.shadow.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: widget.showValues && point != null
                          ? Text(
                              value.toStringAsFixed(0),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: normalizedValue > 0.5
                                    ? Colors.white
                                    : colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }

  Widget _buildColorScale() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final minColor = widget.minColor ?? colorScheme.primary.withOpacity(0.1);
    final maxColor = widget.maxColor ?? colorScheme.primary;

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            _minValue.toStringAsFixed(0),
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: List.generate(10, (index) {
                    return Color.lerp(minColor, maxColor, index / 9)!;
                  }),
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: colorScheme.outline,
                  width: 1,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _maxValue.toStringAsFixed(0),
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}