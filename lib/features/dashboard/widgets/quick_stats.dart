import 'package:flutter/material.dart';

/// Quick stat item widget
class QuickStatItem extends StatelessWidget {
  const QuickStatItem({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.color,
    this.trend,
    this.trendDirection = TrendDirection.neutral,
    this.onTap,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color? color;
  final String? trend;
  final TrendDirection trendDirection;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Theme.of(context).colorScheme.primary;
    
    return Card(
      elevation: 0,
      color: effectiveColor.withOpacity(0.05),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: effectiveColor,
                    size: 20,
                  ),
                  const Spacer(),
                  if (trend != null) ...[
                    Icon(
                      _getTrendIcon(),
                      size: 14,
                      color: _getTrendColor(context),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      trend!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _getTrendColor(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: effectiveColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getTrendIcon() {
    switch (trendDirection) {
      case TrendDirection.up:
        return Icons.trending_up;
      case TrendDirection.down:
        return Icons.trending_down;
      case TrendDirection.neutral:
        return Icons.trending_flat;
    }
  }

  Color _getTrendColor(BuildContext context) {
    switch (trendDirection) {
      case TrendDirection.up:
        return Colors.green;
      case TrendDirection.down:
        return Colors.red;
      case TrendDirection.neutral:
        return Theme.of(context).colorScheme.onSurfaceVariant;
    }
  }
}

/// Trend direction for stats
enum TrendDirection {
  up,
  down,
  neutral,
}

/// Compact stat item for smaller spaces
class CompactStatItem extends StatelessWidget {
  const CompactStatItem({
    super.key,
    required this.title,
    required this.value,
    this.color,
    this.onTap,
  });

  final String title;
  final String value;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Theme.of(context).colorScheme.primary;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: effectiveColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Stats row widget for horizontal display
class StatsRow extends StatelessWidget {
  const StatsRow({
    super.key,
    required this.stats,
    this.spacing = 16.0,
  });

  final List<Widget> stats;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: stats
          .asMap()
          .entries
          .map((entry) {
            final index = entry.key;
            final stat = entry.value;
            
            return [
              Expanded(child: stat),
              if (index < stats.length - 1) SizedBox(width: spacing),
            ];
          })
          .expand((widgets) => widgets)
          .toList(),
    );
  }
}

/// Animated stat item with counter animation
class AnimatedStatItem extends StatefulWidget {
  const AnimatedStatItem({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.color,
    this.duration = const Duration(seconds: 2),
    this.onTap,
  });

  final String title;
  final int value;
  final IconData icon;
  final Color? color;
  final Duration duration;
  final VoidCallback? onTap;

  @override
  State<AnimatedStatItem> createState() => _AnimatedStatItemState();
}

class _AnimatedStatItemState extends State<AnimatedStatItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = IntTween(
      begin: 0,
      end: widget.value,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return QuickStatItem(
          title: widget.title,
          value: _animation.value.toString(),
          icon: widget.icon,
          color: widget.color,
          onTap: widget.onTap,
        );
      },
    );
  }
}

/// Metric card with detailed information
class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    this.icon,
    this.color,
    this.trend,
    this.trendDirection = TrendDirection.neutral,
    this.chart,
    this.onTap,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData? icon;
  final Color? color;
  final String? trend;
  final TrendDirection trendDirection;
  final Widget? chart;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Theme.of(context).colorScheme.primary;
    
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon!,
                      color: effectiveColor,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (trend != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getTrendColor(context).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getTrendIcon(),
                            size: 14,
                            color: _getTrendColor(context),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            trend!,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: _getTrendColor(context),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: effectiveColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              if (chart != null) ...[
                const SizedBox(height: 16),
                SizedBox(
                  height: 60,
                  child: chart!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _getTrendIcon() {
    switch (trendDirection) {
      case TrendDirection.up:
        return Icons.trending_up;
      case TrendDirection.down:
        return Icons.trending_down;
      case TrendDirection.neutral:
        return Icons.trending_flat;
    }
  }

  Color _getTrendColor(BuildContext context) {
    switch (trendDirection) {
      case TrendDirection.up:
        return Colors.green;
      case TrendDirection.down:
        return Colors.red;
      case TrendDirection.neutral:
        return Theme.of(context).colorScheme.onSurfaceVariant;
    }
  }
}