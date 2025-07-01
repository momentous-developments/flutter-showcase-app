import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Responsive helper class for adaptive layouts
class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  /// Get current breakpoint
  static Breakpoint getBreakpoint(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ResponsiveBreakpoints.getBreakpoint(width);
  }

  /// Check if current screen is mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;
  }

  /// Check if current screen is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppConstants.mobileBreakpoint && 
           width < AppConstants.tabletBreakpoint;
  }

  /// Check if current screen is desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.tabletBreakpoint;
  }

  /// Check if current screen is large desktop
  static bool isDesktopLarge(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.desktopBreakpoint;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width >= AppConstants.desktopBreakpoint && desktop != null) {
      return desktop!;
    } else if (width >= AppConstants.tabletBreakpoint && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}

/// Responsive layout information
class ResponsiveLayoutInfo {
  const ResponsiveLayoutInfo({
    required this.breakpoint,
    required this.screenWidth,
    required this.screenHeight,
  });

  final Breakpoint breakpoint;
  final double screenWidth;
  final double screenHeight;

  bool get isMobile => breakpoint == Breakpoint.mobile;
  bool get isTablet => breakpoint == Breakpoint.tablet;
  bool get isDesktop => breakpoint == Breakpoint.desktop;
}

/// Responsive layout builder widget
class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, ResponsiveLayoutInfo info) builder;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final breakpoint = Responsive.getBreakpoint(context);
    
    final info = ResponsiveLayoutInfo(
      breakpoint: breakpoint,
      screenWidth: size.width,
      screenHeight: size.height,
    );

    return builder(context, info);
  }
}

/// Get adaptive value based on screen size
T getAdaptiveValue<T>(
  BuildContext context, {
  required T mobile,
  T? tablet,
  T? desktop,
}) {
  final width = MediaQuery.of(context).size.width;
  
  if (width >= AppConstants.desktopBreakpoint && desktop != null) {
    return desktop;
  } else if (width >= AppConstants.tabletBreakpoint && tablet != null) {
    return tablet;
  } else {
    return mobile;
  }
}

/// Get responsive column count
int getResponsiveColumns(BuildContext context, {
  int mobile = 1,
  int tablet = 2,
  int desktop = 3,
}) {
  final breakpoint = Responsive.getBreakpoint(context);
  
  switch (breakpoint) {
    case Breakpoint.mobile:
      return mobile;
    case Breakpoint.tablet:
      return tablet;
    case Breakpoint.desktop:
      return desktop;
  }
}

/// Get responsive padding
EdgeInsets getResponsivePadding(BuildContext context, {
  EdgeInsets? mobile,
  EdgeInsets? tablet,
  EdgeInsets? desktop,
}) {
  return getAdaptiveValue(
    context,
    mobile: mobile ?? const EdgeInsets.all(16),
    tablet: tablet ?? const EdgeInsets.all(24),
    desktop: desktop ?? const EdgeInsets.all(32),
  );
}

/// Get responsive font size
double getResponsiveFontSize(BuildContext context, {
  double mobile = 14,
  double tablet = 16,
  double desktop = 18,
}) {
  return getAdaptiveValue(
    context,
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
  );
}