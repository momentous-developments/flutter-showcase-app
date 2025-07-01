import 'package:flutter/material.dart';
import 'models/statistics_models.dart';

/// Horizontal statistics card with colored border
/// 
/// This component displays statistics with a distinctive colored bottom border
/// that changes on hover. Includes trend indicators.
/// Features:
/// - Icon and stats value in horizontal layout
/// - Title and trend information
/// - Animated colored bottom border
/// - Hover effects with enhanced border and shadow
/// - Material 3 styling
/// - Accessibility support
class HorizontalWithBorder extends StatefulWidget {
  /// Data for the horizontal statistics card with border
  final HorizontalBorderStatsData data;
  
  /// Whether the card is interactive (shows hover effects)
  final bool interactive;
  
  /// Custom background color for the card
  final Color? backgroundColor;
  
  /// Callback when card is tapped
  final VoidCallback? onTap;

  const HorizontalWithBorder({
    super.key,
    required this.data,
    this.interactive = true,
    this.backgroundColor,
    this.onTap,
  });

  @override
  State<HorizontalWithBorder> createState() => _HorizontalWithBorderState();
}

class _HorizontalWithBorderState extends State<HorizontalWithBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _borderWidthAnimation;
  late Animation<double> _elevationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _borderWidthAnimation = Tween<double>(
      begin: 2.0,
      end: 3.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 8.0,
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
    final effectiveColor = widget.data.color ?? colorScheme.primary;
    
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return MouseRegion(
          onEnter: (_) => _handleHoverEnter(),
          onExit: (_) => _handleHoverExit(),
          child: GestureDetector(
            onTap: widget.onTap,
            child: Semantics(
              label: _buildSemanticLabel(),
              button: widget.onTap != null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                margin: EdgeInsets.only(
                  bottom: _isHovered ? 1.0 : 0.0,
                ),
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: colorScheme.outlineVariant,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withOpacity(0.1),
                      blurRadius: _elevationAnimation.value,
                      offset: Offset(0, _elevationAnimation.value / 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Main content
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Icon and stats row
                          Row(
                            children: [
                              // Icon
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: effectiveColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  widget.data.avatarIcon,
                                  size: 28,
                                  color: effectiveColor,
                                ),
                              ),
                              
                              const SizedBox(width: 16),
                              
                              // Stats value
                              Text(
                                widget.data.stats,
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 8),
                          
                          // Title
                          Text(
                            widget.data.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          const SizedBox(height: 4),
                          
                          // Trend information
                          Row(
                            children: [
                              Text(
                                '${widget.data.trendNumber > 0 ? '+' : ''}${widget.data.trendNumber.toStringAsFixed(1)}%',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'than last week',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Bottom border
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: _borderWidthAnimation.value,
                        decoration: BoxDecoration(
                          color: effectiveColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _buildSemanticLabel() {
    final buffer = StringBuffer();
    buffer.write('${widget.data.title}: ${widget.data.stats}. ');
    buffer.write('Trend: ${widget.data.trendNumber > 0 ? '+' : ''}${widget.data.trendNumber.toStringAsFixed(1)}% than last week');
    return buffer.toString();
  }
}

/// A collection of horizontal border statistics cards
class HorizontalWithBorderCollection extends StatelessWidget {
  /// List of horizontal border statistics data
  final List<HorizontalBorderStatsData> statsData;
  
  /// Spacing between cards
  final double spacing;
  
  /// Whether cards are interactive
  final bool interactive;
  
  /// Callback when a card is tapped
  final void Function(int index, HorizontalBorderStatsData data)? onCardTap;

  const HorizontalWithBorderCollection({
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
          HorizontalWithBorder(
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

/// A grid layout for horizontal border statistics cards
class HorizontalWithBorderGrid extends StatelessWidget {
  /// List of horizontal border statistics data
  final List<HorizontalBorderStatsData> statsData;
  
  /// Number of columns in the grid (null for responsive)
  final int? crossAxisCount;
  
  /// Spacing between cards
  final double spacing;
  
  /// Aspect ratio of each card
  final double childAspectRatio;
  
  /// Whether cards are interactive
  final bool interactive;
  
  /// Callback when a card is tapped
  final void Function(int index, HorizontalBorderStatsData data)? onCardTap;

  const HorizontalWithBorderGrid({
    super.key,
    required this.statsData,
    this.crossAxisCount,
    this.spacing = 16.0,
    this.childAspectRatio = 2.0,
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
            return HorizontalWithBorder(
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