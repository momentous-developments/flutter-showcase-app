import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'models/statistics_models.dart';

/// Statistics card with integrated area chart
/// 
/// This component displays statistics with a mini area chart for trend visualization.
/// Features:
/// - Icon with customizable color and background
/// - Stats value and title
/// - Mini area chart with gradient fill
/// - Material 3 styling with hover effects
/// - Accessibility support
/// - Responsive chart sizing
class StatsWithAreaChart extends StatefulWidget {
  /// Data for the statistics card with area chart
  final StatsWithAreaChartData data;
  
  /// Whether the card is interactive (shows hover effects)
  final bool interactive;
  
  /// Custom background color for the card
  final Color? backgroundColor;
  
  /// Height of the chart area
  final double chartHeight;
  
  /// Callback when card is tapped
  final VoidCallback? onTap;

  const StatsWithAreaChart({
    super.key,
    required this.data,
    this.interactive = true,
    this.backgroundColor,
    this.chartHeight = 100.0,
    this.onTap,
  });

  @override
  State<StatsWithAreaChart> createState() => _StatsWithAreaChartState();
}

class _StatsWithAreaChartState extends State<StatsWithAreaChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.01,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleHoverEnter() {
    if (!widget.interactive) return;
    setState(() => _isHovered = true);
    _animationController.forward();
  }

  void _handleHoverExit() {
    if (!widget.interactive) return;
    setState(() => _isHovered = false);
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final effectiveColor = widget.data.avatarColor ?? colorScheme.primary;
    final chartColor = widget.data.chartColor ?? colorScheme.primary;
    
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) => _handleHoverEnter(),
            onExit: (_) => _handleHoverExit(),
            child: GestureDetector(
              onTap: widget.onTap,
              child: Semantics(
                label: '${widget.data.title}: ${widget.data.stats}. Chart showing trend data.',
                button: widget.onTap != null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: widget.backgroundColor ?? 
                           (_isHovered ? colorScheme.surfaceContainerHigh : colorScheme.surface),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _isHovered ? colorScheme.outline : colorScheme.outlineVariant,
                      width: _isHovered ? 2 : 1,
                    ),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: colorScheme.shadow.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header with icon, stats, and title
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Icon
                            Container(
                              width: widget.data.avatarSize ?? 56,
                              height: widget.data.avatarSize ?? 56,
                              decoration: BoxDecoration(
                                color: effectiveColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                widget.data.avatarIcon,
                                size: (widget.data.avatarSize ?? 56) * 0.45,
                                color: effectiveColor,
                              ),
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Stats value
                            Text(
                              widget.data.stats,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            
                            const SizedBox(height: 4),
                            
                            // Title
                            Text(
                              widget.data.title,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      
                      // Chart area
                      SizedBox(
                        height: widget.chartHeight,
                        child: _buildChart(chartColor, colorScheme),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChart(Color chartColor, ColorScheme colorScheme) {
    if (widget.data.chartSeries.isEmpty) {
      return Container(
        height: widget.chartHeight,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'No chart data',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    final series = widget.data.chartSeries.first;
    final spots = series.data.map((point) => FlSpot(point.x, point.y)).toList();
    
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: chartColor,
              barWidth: 2.5,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    chartColor.withOpacity(0.4),
                    chartColor.withOpacity(0.1),
                    chartColor.withOpacity(0.0),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ],
          lineTouchData: const LineTouchData(enabled: false),
          clipData: const FlClipData.all(),
        ),
        duration: const Duration(milliseconds: 250),
      ),
    );
  }
}

/// A collection of statistics with area chart cards
class StatsWithAreaChartCollection extends StatelessWidget {
  /// List of statistics with chart data
  final List<StatsWithAreaChartData> statsData;
  
  /// Number of columns in the grid (null for responsive)
  final int? crossAxisCount;
  
  /// Spacing between cards
  final double spacing;
  
  /// Aspect ratio of each card
  final double childAspectRatio;
  
  /// Height of chart area for all cards
  final double chartHeight;
  
  /// Whether cards are interactive
  final bool interactive;
  
  /// Callback when a card is tapped
  final void Function(int index, StatsWithAreaChartData data)? onCardTap;

  const StatsWithAreaChartCollection({
    super.key,
    required this.statsData,
    this.crossAxisCount,
    this.spacing = 16.0,
    this.childAspectRatio = 1.0,
    this.chartHeight = 100.0,
    this.interactive = true,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final effectiveCrossAxisCount = crossAxisCount ?? 
            _getResponsiveCrossAxisCount(constraints.maxWidth);
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: effectiveCrossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: statsData.length,
          itemBuilder: (context, index) {
            final data = statsData[index];
            return StatsWithAreaChart(
              data: data,
              interactive: interactive,
              chartHeight: chartHeight,
              onTap: onCardTap != null ? () => onCardTap!(index, data) : null,
            );
          },
        );
      },
    );
  }

  int _getResponsiveCrossAxisCount(double width) {
    if (width > 1200) return 4;
    if (width > 900) return 3;
    if (width > 600) return 2;
    return 1;
  }
}

/// A row layout for statistics with area chart cards
class StatsWithAreaChartRow extends StatelessWidget {
  /// List of statistics with chart data
  final List<StatsWithAreaChartData> statsData;
  
  /// Spacing between cards
  final double spacing;
  
  /// Height of chart area for all cards
  final double chartHeight;
  
  /// Whether cards are interactive
  final bool interactive;
  
  /// Callback when a card is tapped
  final void Function(int index, StatsWithAreaChartData data)? onCardTap;

  const StatsWithAreaChartRow({
    super.key,
    required this.statsData,
    this.spacing = 16.0,
    this.chartHeight = 100.0,
    this.interactive = true,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int index = 0; index < statsData.length; index++) ...[
            SizedBox(
              width: 200,
              child: StatsWithAreaChart(
                data: statsData[index],
                interactive: interactive,
                chartHeight: chartHeight,
                onTap: onCardTap != null ? () => onCardTap!(index, statsData[index]) : null,
              ),
            ),
            if (index < statsData.length - 1) SizedBox(width: spacing),
          ],
        ],
      ),
    );
  }
}