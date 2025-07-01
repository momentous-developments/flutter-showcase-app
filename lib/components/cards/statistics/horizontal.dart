import 'package:flutter/material.dart';
import 'models/statistics_models.dart';

/// Horizontal statistics layout card
/// 
/// This component displays statistics in a horizontal layout with stats on the left
/// and an icon on the right.
/// Features:
/// - Large stats value
/// - Title below stats
/// - Icon with customizable color and background
/// - Material 3 styling with hover effects
/// - Accessibility support
class HorizontalStats extends StatefulWidget {
  /// Data for the horizontal statistics card
  final HorizontalStatsData data;
  
  /// Whether the card is interactive (shows hover effects)
  final bool interactive;
  
  /// Custom background color for the card
  final Color? backgroundColor;
  
  /// Callback when card is tapped
  final VoidCallback? onTap;

  const HorizontalStats({
    super.key,
    required this.data,
    this.interactive = true,
    this.backgroundColor,
    this.onTap,
  });

  @override
  State<HorizontalStats> createState() => _HorizontalStatsState();
}

class _HorizontalStatsState extends State<HorizontalStats>
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
                label: '${widget.data.title}: ${widget.data.stats}',
                button: widget.onTap != null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Stats content (left side)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(width: 16),
                        
                        // Icon (right side)
                        Container(
                          width: widget.data.avatarSize ?? 42,
                          height: widget.data.avatarSize ?? 42,
                          decoration: BoxDecoration(
                            color: effectiveColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            widget.data.avatarIcon,
                            size: (widget.data.avatarSize ?? 42) * 0.6,
                            color: effectiveColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// A collection of horizontal statistics cards arranged vertically
class HorizontalStatsCollection extends StatelessWidget {
  /// List of horizontal statistics data
  final List<HorizontalStatsData> statsData;
  
  /// Spacing between cards
  final double spacing;
  
  /// Whether cards are interactive
  final bool interactive;
  
  /// Callback when a card is tapped
  final void Function(int index, HorizontalStatsData data)? onCardTap;

  const HorizontalStatsCollection({
    super.key,
    required this.statsData,
    this.spacing = 12.0,
    this.interactive = true,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int index = 0; index < statsData.length; index++) ...[
          HorizontalStats(
            data: statsData[index],
            interactive: interactive,
            onTap: onCardTap != null ? () => onCardTap!(index, statsData[index]) : null,
          ),
          if (index < statsData.length - 1) SizedBox(height: spacing),
        ],
      ],
    );
  }
}

/// A grid layout for horizontal statistics cards
class HorizontalStatsGrid extends StatelessWidget {
  /// List of horizontal statistics data
  final List<HorizontalStatsData> statsData;
  
  /// Number of columns in the grid (null for responsive)
  final int? crossAxisCount;
  
  /// Spacing between cards
  final double spacing;
  
  /// Aspect ratio of each card
  final double childAspectRatio;
  
  /// Whether cards are interactive
  final bool interactive;
  
  /// Callback when a card is tapped
  final void Function(int index, HorizontalStatsData data)? onCardTap;

  const HorizontalStatsGrid({
    super.key,
    required this.statsData,
    this.crossAxisCount,
    this.spacing = 16.0,
    this.childAspectRatio = 2.5,
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
            return HorizontalStats(
              data: data,
              interactive: interactive,
              onTap: onCardTap != null ? () => onCardTap!(index, data) : null,
            );
          },
        );
      },
    );
  }

  int _getResponsiveCrossAxisCount(double width) {
    if (width > 1200) return 3;
    if (width > 800) return 2;
    return 1;
  }
}