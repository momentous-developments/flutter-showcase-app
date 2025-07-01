import 'package:flutter/material.dart';
import 'models/statistics_models.dart';

/// Customer analytics card with multiple metrics layout
/// 
/// This component displays customer-related statistics with flexible content options.
/// Features:
/// - Icon with light background
/// - Title with capitalization
/// - Stats value with additional content OR chip label
/// - Description text
/// - Material 3 styling with hover effects
/// - Accessibility support
class CustomerStats extends StatefulWidget {
  /// Data for the customer statistics card
  final CustomerStatsData data;
  
  /// Whether the card is interactive (shows hover effects)
  final bool interactive;
  
  /// Custom background color for the card
  final Color? backgroundColor;
  
  /// Callback when card is tapped
  final VoidCallback? onTap;

  const CustomerStats({
    super.key,
    required this.data,
    this.interactive = true,
    this.backgroundColor,
    this.onTap,
  });

  @override
  State<CustomerStats> createState() => _CustomerStatsState();
}

class _CustomerStatsState extends State<CustomerStats>
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
    final effectiveColor = widget.data.color ?? colorScheme.primary;
    
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
                        // Icon with light background
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: effectiveColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            widget.data.avatarIcon,
                            size: 24,
                            color: effectiveColor,
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Title
                        Text(
                          _capitalizeTitle(widget.data.title),
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Stats section or chip
                        if (widget.data.stats != null) ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                widget.data.stats!,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: effectiveColor,
                                ),
                              ),
                              if (widget.data.content != null) ...[
                                const SizedBox(width: 4),
                                Text(
                                  widget.data.content!,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ] else if (widget.data.chipLabel != null) ...[
                          Chip(
                            label: Text(
                              widget.data.chipLabel!,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: effectiveColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            backgroundColor: effectiveColor.withOpacity(0.1),
                            side: BorderSide(
                              color: effectiveColor.withOpacity(0.2),
                              width: 1,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ],
                        
                        const SizedBox(height: 4),
                        
                        // Description
                        Text(
                          widget.data.description,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
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

  String _capitalizeTitle(String title) {
    return title.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  String _buildSemanticLabel() {
    final buffer = StringBuffer();
    buffer.write('Customer statistics for ${widget.data.title}. ');
    
    if (widget.data.stats != null) {
      buffer.write('Value: ${widget.data.stats}');
      if (widget.data.content != null) {
        buffer.write(' ${widget.data.content}');
      }
      buffer.write('. ');
    } else if (widget.data.chipLabel != null) {
      buffer.write('Status: ${widget.data.chipLabel}. ');
    }
    
    buffer.write(widget.data.description);
    
    return buffer.toString();
  }
}

/// A collection of customer statistics cards arranged in a responsive layout
class CustomerStatsCollection extends StatelessWidget {
  /// List of customer statistics data
  final List<CustomerStatsData> statsData;
  
  /// Number of columns in the grid (null for responsive)
  final int? crossAxisCount;
  
  /// Spacing between cards
  final double spacing;
  
  /// Whether cards are interactive
  final bool interactive;
  
  /// Callback when a card is tapped
  final void Function(int index, CustomerStatsData data)? onCardTap;

  const CustomerStatsCollection({
    super.key,
    required this.statsData,
    this.crossAxisCount,
    this.spacing = 16.0,
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
            childAspectRatio: 1.1,
          ),
          itemCount: statsData.length,
          itemBuilder: (context, index) {
            final data = statsData[index];
            return CustomerStats(
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
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 1;
  }
}