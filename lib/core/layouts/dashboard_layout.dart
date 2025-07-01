import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import 'responsive_layout.dart';

/// Dashboard-specific layout with responsive grid and sections
class DashboardLayout extends StatelessWidget {
  const DashboardLayout({
    super.key,
    required this.children,
    this.header,
    this.footer,
    this.padding = const EdgeInsets.all(24),
    this.spacing = 24.0,
    this.maxWidth = 1400,
  });

  final List<Widget> children;
  final Widget? header;
  final Widget? footer;
  final EdgeInsets padding;
  final double spacing;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      maxWidth: maxWidth,
      mobilePadding: const EdgeInsets.all(16),
      tabletPadding: const EdgeInsets.all(20),
      desktopPadding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null) ...[
            header!,
            SizedBox(height: spacing),
          ],
          Expanded(
            child: ResponsiveLayoutBuilder(
              builder: (context, info) {
                return _buildDashboardGrid(context, info);
              },
            ),
          ),
          if (footer != null) ...[
            SizedBox(height: spacing),
            footer!,
          ],
        ],
      ),
    );
  }

  Widget _buildDashboardGrid(BuildContext context, ResponsiveLayoutInfo info) {
    int crossAxisCount;
    double childAspectRatio;

    if (info.isDesktop) {
      crossAxisCount = 4;
      childAspectRatio = 0.8;  // Taller cards for desktop
    } else if (info.isTablet) {
      crossAxisCount = 2;
      childAspectRatio = 0.9;  // Taller cards for tablet
    } else {
      crossAxisCount = 1;
      childAspectRatio = 1.4;  // More reasonable height for mobile
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}

/// Dashboard card wrapper with consistent styling
class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.actions,
    this.padding = const EdgeInsets.all(20),
    this.elevation,
    this.color,
    this.borderRadius,
  });

  final Widget child;
  final String? title;
  final String? subtitle;
  final List<Widget>? actions;
  final EdgeInsets padding;
  final double? elevation;
  final Color? color;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null || actions != null) ...[
              Row(
                children: [
                  if (title != null) ...[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title!,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (subtitle != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              subtitle!,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                  if (actions != null) ...actions!,
                ],
              ),
              const SizedBox(height: 16),
            ],
            Flexible(child: child),
          ],
        ),
      ),
    );
  }
}

/// Dashboard section header
class DashboardSectionHeader extends StatelessWidget {
  const DashboardSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
  });

  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}

/// Dashboard stats card
class DashboardStatsCard extends StatelessWidget {
  const DashboardStatsCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.trend,
    this.trendDirection = TrendDirection.neutral,
    this.color,
    this.onTap,
  });

  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final String? trend;
  final TrendDirection trendDirection;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cardColor = color ?? colorScheme.primaryContainer;
    final onCardColor = color != null 
        ? _getOnColor(color!, colorScheme)
        : colorScheme.onPrimaryContainer;

    return DashboardCard(
      color: cardColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon != null) ...[
                Icon(
                  icon!,
                  color: onCardColor.withOpacity(0.8),
                  size: 32,
                ),
                const SizedBox(height: 12),
              ],
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: onCardColor.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: onCardColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitle != null || trend != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (subtitle != null) ...[
                      Expanded(
                        child: Text(
                          subtitle!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: onCardColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                    if (trend != null) ...[
                      Icon(
                        _getTrendIcon(),
                        size: 16,
                        color: _getTrendColor(colorScheme),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        trend!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getTrendColor(colorScheme),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getOnColor(Color color, ColorScheme colorScheme) {
    return color.computeLuminance() > 0.5 
        ? colorScheme.onSurface
        : colorScheme.surface;
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

  Color _getTrendColor(ColorScheme colorScheme) {
    switch (trendDirection) {
      case TrendDirection.up:
        return Colors.green;
      case TrendDirection.down:
        return Colors.red;
      case TrendDirection.neutral:
        return colorScheme.onSurfaceVariant;
    }
  }
}

/// Trend direction for stats
enum TrendDirection {
  up,
  down,
  neutral,
}

/// Dashboard quick action card
class DashboardQuickAction extends StatelessWidget {
  const DashboardQuickAction({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.subtitle,
    this.color,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final actionColor = color ?? colorScheme.primary;

    return DashboardCard(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: actionColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: actionColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}