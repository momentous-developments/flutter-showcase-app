import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../constants/app_constants.dart';

/// Responsive layout wrapper that adapts to different screen sizes
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.breakpoints,
  });

  /// Widget to show on mobile screens
  final Widget mobile;
  
  /// Widget to show on tablet screens (defaults to mobile if not provided)
  final Widget? tablet;
  
  /// Widget to show on desktop screens (defaults to tablet or mobile if not provided)
  final Widget? desktop;
  
  /// Custom breakpoints (optional)
  final Map<String, double>? breakpoints;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 1000 && desktop != null) {
      return desktop!;
    } else if (screenWidth >= 600 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}



/// Device type enum
enum DeviceType {
  mobile,
  tablet,
  desktop,
}

/// Responsive grid layout
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
  });

  final List<Widget> children;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    int columns;
    if (screenWidth >= AppConstants.tabletBreakpoint) {
      columns = desktopColumns;
    } else if (screenWidth >= AppConstants.mobileBreakpoint) {
      columns = tabletColumns;
    } else {
      columns = mobileColumns;
    }

    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: children.map((child) {
        final itemWidth = (screenWidth - (spacing * (columns - 1))) / columns;
        return SizedBox(
          width: itemWidth,
          child: child,
        );
      }).toList(),
    );
  }
}

/// Responsive container with adaptive padding and margins
class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({
    super.key,
    required this.child,
    this.mobilePadding = const EdgeInsets.all(16),
    this.tabletPadding = const EdgeInsets.all(24),
    this.desktopPadding = const EdgeInsets.all(32),
    this.mobileMargin = EdgeInsets.zero,
    this.tabletMargin = EdgeInsets.zero,
    this.desktopMargin = EdgeInsets.zero,
    this.maxWidth,
    this.alignment = Alignment.topCenter,
  });

  final Widget child;
  final EdgeInsets mobilePadding;
  final EdgeInsets tabletPadding;
  final EdgeInsets desktopPadding;
  final EdgeInsets mobileMargin;
  final EdgeInsets tabletMargin;
  final EdgeInsets desktopMargin;
  final double? maxWidth;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    EdgeInsets padding;
    EdgeInsets margin;

    if (screenWidth >= AppConstants.tabletBreakpoint) {
      padding = desktopPadding;
      margin = desktopMargin;
    } else if (screenWidth >= AppConstants.mobileBreakpoint) {
      padding = tabletPadding;
      margin = tabletMargin;
    } else {
      padding = mobilePadding;
      margin = mobileMargin;
    }

    Widget container = Container(
      padding: padding,
      margin: margin,
      child: child,
    );

    if (maxWidth != null) {
      container = ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth!),
        child: container,
      );
    }

    return Align(
      alignment: alignment,
      child: container,
    );
  }
}

/// Responsive row with adaptive flex values
class ResponsiveRow extends StatelessWidget {
  const ResponsiveRow({
    super.key,
    required this.children,
    this.mobileDirection = Axis.vertical,
    this.tabletDirection = Axis.horizontal,
    this.desktopDirection = Axis.horizontal,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.spacing = 16.0,
  });

  final List<Widget> children;
  final Axis mobileDirection;
  final Axis tabletDirection;
  final Axis desktopDirection;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    Axis direction;
    if (screenWidth >= AppConstants.tabletBreakpoint) {
      direction = desktopDirection;
    } else if (screenWidth >= AppConstants.mobileBreakpoint) {
      direction = tabletDirection;
    } else {
      direction = mobileDirection;
    }

    final spacedChildren = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(
          direction == Axis.horizontal
              ? SizedBox(width: spacing)
              : SizedBox(height: spacing),
        );
      }
    }

    if (direction == Axis.horizontal) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: spacedChildren,
      );
    } else {
      return Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: spacedChildren,
      );
    }
  }
}