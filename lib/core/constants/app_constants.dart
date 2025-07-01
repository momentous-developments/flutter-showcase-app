import 'package:flutter/material.dart';

/// Core application constants
class AppConstants {
  AppConstants._();

  // App Information
  static const String appName = 'Flutter Material 3 Demo';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String apiBaseUrl = 'https://api.example.com';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // Color Seeds - 9 predefined options for Material 3 theming
  static const List<ColorSeed> colorSeeds = [
    ColorSeed('M3 Baseline', Color(0xff6750a4)),
    ColorSeed('Indigo', Colors.indigo),
    ColorSeed('Blue', Colors.blue),
    ColorSeed('Teal', Colors.teal),
    ColorSeed('Green', Colors.green),
    ColorSeed('Yellow', Colors.yellow),
    ColorSeed('Orange', Colors.orange),
    ColorSeed('Deep Orange', Colors.deepOrange),
    ColorSeed('Pink', Colors.pink),
  ];
  
  // Responsive Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1000;
  static const double desktopBreakpoint = 1500;
  
  // Navigation Rail Breakpoints
  static const double compactNavigationRailBreakpoint = 1000;
  static const double extendedNavigationRailBreakpoint = 1500;
  
  // Animation Durations
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);
  static const Duration pageTransitionAnimation = Duration(milliseconds: 400);
  
  // Asset Paths
  static const String assetsPath = 'assets';
  static const String imagesPath = '$assetsPath/images';
  static const String iconsPath = '$assetsPath/icons';
  static const String fontsPath = '$assetsPath/fonts';
  static const String animationsPath = '$assetsPath/animations';
  
  // Padding and Spacing
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
  static const double spacing48 = 48.0;
  static const double spacing64 = 64.0;
  
  // Border Radius
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusExtraLarge = 16.0;
  static const double radiusRound = 24.0;
  static const double radiusCircle = 999.0;
  
  // Storage Keys
  static const String themeColorKey = 'theme_color_seed';
  static const String themeModeKey = 'theme_mode';
  static const String languageKey = 'language';
  static const String userTokenKey = 'user_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String onboardingCompleteKey = 'onboarding_complete';
  
  // Default Values
  static const int defaultColorSeedIndex = 0;
  static const ThemeMode defaultThemeMode = ThemeMode.system;
  static const String defaultLanguage = 'en';
}

/// Represents a color seed option for Material 3 theming
class ColorSeed {
  const ColorSeed(this.label, this.color);
  
  final String label;
  final Color color;
}

/// Responsive breakpoint enum
enum Breakpoint {
  mobile,
  tablet,
  desktop,
}

/// Responsive breakpoints utility class
class ResponsiveBreakpoints {
  ResponsiveBreakpoints._();
  
  static Breakpoint getBreakpoint(double width) {
    if (width < AppConstants.mobileBreakpoint) {
      return Breakpoint.mobile;
    } else if (width < AppConstants.tabletBreakpoint) {
      return Breakpoint.tablet;
    } else {
      return Breakpoint.desktop;
    }
  }
  
  static bool isMobile(double width) => width < AppConstants.mobileBreakpoint;
  static bool isTablet(double width) => width >= AppConstants.mobileBreakpoint && width < AppConstants.tabletBreakpoint;
  static bool isDesktop(double width) => width >= AppConstants.tabletBreakpoint;
}