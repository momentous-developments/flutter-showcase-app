import 'package:flutter/material.dart';
import 'models/statistics_models.dart';

/// Square metric card with icon, value, label, and color-coded background
/// 
/// This component displays statistics in a square format with a centered layout.
/// Features:
/// - Icon with customizable color and size
/// - Large stats value
/// - Descriptive title below stats
/// - Material 3 styling with hover effects
/// - Accessibility support
class CardStatsSquare extends StatefulWidget {
  /// Data for the statistics card
  final SquareStatsData data;
  
  /// Whether the card is interactive (shows hover effects)
  final bool interactive;
  
  /// Custom background color for the card
  final Color? backgroundColor;
  
  /// Callback when card is tapped
  final VoidCallback? onTap;

  const CardStatsSquare({
    super.key,
    required this.data,
    this.interactive = true,
    this.backgroundColor,
    this.onTap,
  });

  @override
  State<CardStatsSquare> createState() => _CardStatsSquareState();
}

class _CardStatsSquareState extends State<CardStatsSquare>
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
      end: 1.02,
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
                label: '${widget.data.statsTitle}: ${widget.data.stats}',
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
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icon with background
                        Container(
                          width: widget.data.avatarSize ?? 56,
                          height: widget.data.avatarSize ?? 56,
                          decoration: BoxDecoration(
                            color: (widget.data.avatarColor ?? colorScheme.primary)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            widget.data.avatarIcon,
                            size: (widget.data.avatarSize ?? 56) * 0.5,
                            color: widget.data.avatarColor ?? colorScheme.primary,
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
                          textAlign: TextAlign.center,
                        ),
                        
                        const SizedBox(height: 4),
                        
                        // Stats title
                        Text(
                          widget.data.statsTitle,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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

/// A collection of square statistics cards arranged in a grid
class SquareStatsGrid extends StatelessWidget {
  /// List of square statistics data
  final List<SquareStatsData> statsData;
  
  /// Number of columns in the grid
  final int crossAxisCount;
  
  /// Spacing between grid items
  final double spacing;
  
  /// Aspect ratio of each card
  final double childAspectRatio;
  
  /// Whether cards are interactive
  final bool interactive;
  
  /// Callback when a card is tapped
  final void Function(int index, SquareStatsData data)? onCardTap;

  const SquareStatsGrid({
    super.key,
    required this.statsData,
    this.crossAxisCount = 2,
    this.spacing = 16.0,
    this.childAspectRatio = 1.0,
    this.interactive = true,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: statsData.length,
      itemBuilder: (context, index) {
        final data = statsData[index];
        return CardStatsSquare(
          data: data,
          interactive: interactive,
          onTap: onCardTap != null ? () => onCardTap!(index, data) : null,
        );
      },
    );
  }
}