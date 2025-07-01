import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../navigation/navigation_items.dart';
import '../../utils/extensions.dart';

/// Breadcrumb navigation widget for showing current location in app hierarchy
class Breadcrumbs extends StatelessWidget {
  const Breadcrumbs({
    super.key,
    required this.items,
    this.separator,
    this.maxItems = 5,
    this.overflow = BreadcrumbOverflow.ellipsis,
  });

  final List<NavigationItem> items;
  final Widget? separator;
  final int maxItems;
  final BreadcrumbOverflow overflow;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final displayItems = _getDisplayItems();
    final defaultSeparator = separator ?? Icon(
      Icons.chevron_right,
      size: 16,
      color: context.colorScheme.onSurfaceVariant,
    );

    return Wrap(
      children: _buildBreadcrumbWidgets(context, displayItems, defaultSeparator),
    );
  }

  List<NavigationItem> _getDisplayItems() {
    if (items.length <= maxItems) return items;

    switch (overflow) {
      case BreadcrumbOverflow.ellipsis:
        return [
          items.first,
          NavigationItem(
            label: '...',
            icon: Icons.more_horiz,
            selectedIcon: Icons.more_horiz,
            route: '',
          ),
          ...items.skip(items.length - (maxItems - 2)),
        ];
      case BreadcrumbOverflow.scroll:
        return items;
      case BreadcrumbOverflow.wrap:
        return items;
    }
  }

  List<Widget> _buildBreadcrumbWidgets(
    BuildContext context,
    List<NavigationItem> displayItems,
    Widget separator,
  ) {
    final widgets = <Widget>[];

    for (int i = 0; i < displayItems.length; i++) {
      final item = displayItems[i];
      final isLast = i == displayItems.length - 1;
      final isEllipsis = item.label == '...';

      // Add breadcrumb item
      widgets.add(
        isEllipsis
            ? _BreadcrumbEllipsis(item: item)
            : _BreadcrumbItem(
                item: item,
                isLast: isLast,
                onTap: isLast ? null : () => context.go(item.route),
              ),
      );

      // Add separator (except for last item)
      if (!isLast) {
        widgets.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: separator,
        ));
      }
    }

    return widgets;
  }
}

/// Individual breadcrumb item
class _BreadcrumbItem extends StatelessWidget {
  const _BreadcrumbItem({
    required this.item,
    required this.isLast,
    this.onTap,
  });

  final NavigationItem item;
  final bool isLast;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textStyle = isLast
        ? context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
          )
        : context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          );

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isLast ? item.selectedIcon : item.icon,
          size: 16,
          color: isLast 
              ? context.colorScheme.onSurface
              : context.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Text(item.label, style: textStyle),
      ],
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: child,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: child,
    );
  }
}

/// Ellipsis breadcrumb item with dropdown menu
class _BreadcrumbEllipsis extends StatelessWidget {
  const _BreadcrumbEllipsis({required this.item});

  final NavigationItem item;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_horiz,
        size: 16,
        color: context.colorScheme.onSurfaceVariant,
      ),
      tooltip: 'Show hidden breadcrumbs',
      itemBuilder: (context) {
        // This would need to be implemented with actual hidden items
        return <PopupMenuEntry<String>>[];
      },
    );
  }
}

/// Breadcrumb overflow behavior
enum BreadcrumbOverflow {
  /// Show ellipsis for hidden items
  ellipsis,
  /// Allow horizontal scrolling
  scroll,
  /// Wrap to next line
  wrap,
}

/// Animated breadcrumbs that slide in when route changes
class AnimatedBreadcrumbs extends StatefulWidget {
  const AnimatedBreadcrumbs({
    super.key,
    required this.items,
    this.separator,
    this.maxItems = 5,
    this.overflow = BreadcrumbOverflow.ellipsis,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  final List<NavigationItem> items;
  final Widget? separator;
  final int maxItems;
  final BreadcrumbOverflow overflow;
  final Duration animationDuration;

  @override
  State<AnimatedBreadcrumbs> createState() => _AnimatedBreadcrumbsState();
}

class _AnimatedBreadcrumbsState extends State<AnimatedBreadcrumbs>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedBreadcrumbs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-0.1, 0),
          end: Offset.zero,
        ).animate(_animation),
        child: Breadcrumbs(
          items: widget.items,
          separator: widget.separator,
          maxItems: widget.maxItems,
          overflow: widget.overflow,
        ),
      ),
    );
  }
}

/// Breadcrumbs with custom styling for different contexts
class StyledBreadcrumbs extends StatelessWidget {
  const StyledBreadcrumbs({
    super.key,
    required this.items,
    this.style = BreadcrumbStyle.normal,
    this.separator,
    this.maxItems = 5,
  });

  final List<NavigationItem> items;
  final BreadcrumbStyle style;
  final Widget? separator;
  final int maxItems;

  @override
  Widget build(BuildContext context) {
    Widget separator = this.separator ?? _getDefaultSeparator(context, style);

    Widget breadcrumbs = Breadcrumbs(
      items: items,
      separator: separator,
      maxItems: maxItems,
    );

    switch (style) {
      case BreadcrumbStyle.normal:
        return breadcrumbs;
      case BreadcrumbStyle.compact:
        return DefaultTextStyle.merge(
          style: context.textTheme.bodySmall,
          child: breadcrumbs,
        );
      case BreadcrumbStyle.card:
        return Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: breadcrumbs,
          ),
        );
      case BreadcrumbStyle.outlined:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: context.colorScheme.outline),
            borderRadius: BorderRadius.circular(8),
          ),
          child: breadcrumbs,
        );
    }
  }

  Widget _getDefaultSeparator(BuildContext context, BreadcrumbStyle style) {
    final size = style == BreadcrumbStyle.compact ? 14.0 : 16.0;
    return Icon(
      Icons.chevron_right,
      size: size,
      color: context.colorScheme.onSurfaceVariant,
    );
  }
}

/// Breadcrumb styling options
enum BreadcrumbStyle {
  normal,
  compact,
  card,
  outlined,
}