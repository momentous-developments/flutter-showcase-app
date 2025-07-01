import 'package:flutter/material.dart';
import 'models/statistics_models.dart';

/// Vertical statistics layout card
/// 
/// This component displays statistics in a vertical layout with icon at top,
/// followed by title, subtitle, stats value, and a status chip.
/// Features:
/// - Icon with customizable color and background
/// - Title and subtitle text
/// - Stats value display
/// - Status chip with customizable color
/// - Material 3 styling with hover effects
/// - Accessibility support
class VerticalStats extends StatefulWidget {
  /// Data for the vertical statistics card
  final VerticalStatsData data;
  
  /// Whether the card is interactive (shows hover effects)
  final bool interactive;
  
  /// Custom background color for the card
  final Color? backgroundColor;
  
  /// Chip style variant (filled, outlined, elevated)
  final String chipVariant;
  
  /// Callback when card is tapped
  final VoidCallback? onTap;

  const VerticalStats({
    super.key,
    required this.data,
    this.interactive = true,
    this.backgroundColor,
    this.chipVariant = 'filled',
    this.onTap,
  });

  @override
  State<VerticalStats> createState() => _VerticalStatsState();
}

class _VerticalStatsState extends State<VerticalStats>
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
    final effectiveColor = widget.data.avatarColor ?? colorScheme.primary;
    final chipColor = widget.data.chipColor ?? colorScheme.primary;
    
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
                label: _buildSemanticLabel(),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
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
                            size: (widget.data.avatarSize ?? 56) * 0.5,
                            color: effectiveColor,
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Title
                        Text(
                          widget.data.title,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        const SizedBox(height: 4),
                        
                        // Subtitle
                        Text(
                          widget.data.subtitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Stats value
                        Text(
                          widget.data.stats,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Status chip
                        _buildChip(chipColor, theme, colorScheme),
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

  Widget _buildChip(Color chipColor, ThemeData theme, ColorScheme colorScheme) {
    switch (widget.chipVariant) {
      case 'outlined':
        return Chip(
          label: Text(
            widget.data.chipText,
            style: theme.textTheme.labelSmall?.copyWith(
              color: chipColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.transparent,
          side: BorderSide(color: chipColor, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      
      case 'elevated':
        return Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: chipColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              widget.data.chipText,
              style: theme.textTheme.labelSmall?.copyWith(
                color: chipColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      
      case 'filled':
      default:
        return Chip(
          label: Text(
            widget.data.chipText,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: chipColor,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
    }
  }

  String _buildSemanticLabel() {
    final buffer = StringBuffer();
    buffer.write('${widget.data.title}. ');
    buffer.write('${widget.data.subtitle}. ');
    buffer.write('Value: ${widget.data.stats}. ');
    buffer.write('Status: ${widget.data.chipText}');
    return buffer.toString();
  }
}

/// A collection of vertical statistics cards
class VerticalStatsCollection extends StatelessWidget {
  /// List of vertical statistics data
  final List<VerticalStatsData> statsData;
  
  /// Number of columns in the grid (null for responsive)
  final int? crossAxisCount;
  
  /// Spacing between cards
  final double spacing;
  
  /// Aspect ratio of each card
  final double childAspectRatio;
  
  /// Chip style variant for all cards
  final String chipVariant;
  
  /// Whether cards are interactive
  final bool interactive;
  
  /// Callback when a card is tapped
  final void Function(int index, VerticalStatsData data)? onCardTap;

  const VerticalStatsCollection({
    super.key,
    required this.statsData,
    this.crossAxisCount,
    this.spacing = 16.0,
    this.childAspectRatio = 0.8,
    this.chipVariant = 'filled',
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
            return VerticalStats(
              data: data,
              interactive: interactive,
              chipVariant: chipVariant,
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

/// A row layout for vertical statistics cards
class VerticalStatsRow extends StatelessWidget {
  /// List of vertical statistics data
  final List<VerticalStatsData> statsData;
  
  /// Spacing between cards
  final double spacing;
  
  /// Width of each card
  final double cardWidth;
  
  /// Chip style variant for all cards
  final String chipVariant;
  
  /// Whether cards are interactive
  final bool interactive;
  
  /// Callback when a card is tapped
  final void Function(int index, VerticalStatsData data)? onCardTap;

  const VerticalStatsRow({
    super.key,
    required this.statsData,
    this.spacing = 16.0,
    this.cardWidth = 200.0,
    this.chipVariant = 'filled',
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
              width: cardWidth,
              child: VerticalStats(
                data: statsData[index],
                interactive: interactive,
                chipVariant: chipVariant,
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