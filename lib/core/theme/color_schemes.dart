import 'package:flutter/material.dart';

/// Manages color scheme generation for Material 3 theming
class ColorSchemes {
  ColorSchemes._();

  /// Generates a light color scheme from the given seed color
  static ColorScheme lightColorScheme(Color seedColor) {
    return ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    );
  }

  /// Generates a dark color scheme from the given seed color
  static ColorScheme darkColorScheme(Color seedColor) {
    return ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    );
  }

  /// Creates a color scheme from an image (placeholder for future implementation)
  static Future<ColorScheme> fromImageProvider({
    required ImageProvider imageProvider,
    required Brightness brightness,
  }) async {
    // This is a placeholder for dynamic color extraction from images
    // In a real implementation, you would use the dynamic_color package
    // or material_color_utilities to extract colors from the image
    
    // For now, return a default color scheme
    return brightness == Brightness.light
        ? lightColorScheme(Colors.blue)
        : darkColorScheme(Colors.blue);
  }

  /// Get predefined baseline light color scheme
  static ColorScheme get baselineLight => lightColorScheme(const Color(0xff6750a4));
  
  /// Get predefined baseline dark color scheme
  static ColorScheme get baselineDark => darkColorScheme(const Color(0xff6750a4));
  
  /// Get predefined ocean light color scheme
  static ColorScheme get oceanLight => lightColorScheme(Colors.blue);
  
  /// Get predefined ocean dark color scheme
  static ColorScheme get oceanDark => darkColorScheme(Colors.blue);
  
  /// Get predefined forest light color scheme
  static ColorScheme get forestLight => lightColorScheme(Colors.green);
  
  /// Get predefined forest dark color scheme
  static ColorScheme get forestDark => darkColorScheme(Colors.green);
  
  /// Get predefined sunset light color scheme
  static ColorScheme get sunsetLight => lightColorScheme(Colors.deepOrange);
  
  /// Get predefined sunset dark color scheme
  static ColorScheme get sunsetDark => darkColorScheme(Colors.deepOrange);
  
  /// Get predefined rose light color scheme
  static ColorScheme get roseLight => lightColorScheme(Colors.pink);
  
  /// Get predefined rose dark color scheme
  static ColorScheme get roseDark => darkColorScheme(Colors.pink);

  /// Custom color harmonization for brand consistency
  static Color harmonizeWithPrimary(Color color, ColorScheme scheme) {
    // This would use Material Color Utilities to harmonize colors
    // For now, return the color as-is
    return color;
  }

  /// Generate a monochromatic color scheme
  static ColorScheme monochromatic({
    required Color baseColor,
    required Brightness brightness,
  }) {
    final hslColor = HSLColor.fromColor(baseColor);
    
    if (brightness == Brightness.light) {
      return ColorScheme(
        brightness: brightness,
        primary: baseColor,
        onPrimary: Colors.white,
        primaryContainer: hslColor.withLightness(0.9).toColor(),
        onPrimaryContainer: hslColor.withLightness(0.1).toColor(),
        secondary: hslColor.withSaturation(0.3).toColor(),
        onSecondary: Colors.white,
        secondaryContainer: hslColor.withSaturation(0.3).withLightness(0.9).toColor(),
        onSecondaryContainer: hslColor.withSaturation(0.3).withLightness(0.1).toColor(),
        tertiary: hslColor.withHue((hslColor.hue + 60) % 360).toColor(),
        onTertiary: Colors.white,
        tertiaryContainer: hslColor.withHue((hslColor.hue + 60) % 360).withLightness(0.9).toColor(),
        onTertiaryContainer: hslColor.withHue((hslColor.hue + 60) % 360).withLightness(0.1).toColor(),
        error: const Color(0xFFBA1A1A),
        onError: Colors.white,
        errorContainer: const Color(0xFFFFDAD6),
        onErrorContainer: const Color(0xFF410002),
        surface: const Color(0xFFFFFBFF),
        onSurface: const Color(0xFF1C1B1E),
        surfaceVariant: const Color(0xFFE7E0EC),
        onSurfaceVariant: const Color(0xFF49454E),
        outline: const Color(0xFF7A757F),
        outlineVariant: const Color(0xFFCAC4CF),
        shadow: Colors.black,
        scrim: Colors.black,
        inverseSurface: const Color(0xFF313033),
        onInverseSurface: const Color(0xFFF4EFF4),
        inversePrimary: hslColor.withLightness(0.8).toColor(),
        surfaceTint: baseColor,
      );
    } else {
      return ColorScheme(
        brightness: brightness,
        primary: hslColor.withLightness(0.8).toColor(),
        onPrimary: hslColor.withLightness(0.2).toColor(),
        primaryContainer: hslColor.withLightness(0.3).toColor(),
        onPrimaryContainer: hslColor.withLightness(0.9).toColor(),
        secondary: hslColor.withSaturation(0.3).withLightness(0.8).toColor(),
        onSecondary: hslColor.withSaturation(0.3).withLightness(0.2).toColor(),
        secondaryContainer: hslColor.withSaturation(0.3).withLightness(0.3).toColor(),
        onSecondaryContainer: hslColor.withSaturation(0.3).withLightness(0.9).toColor(),
        tertiary: hslColor.withHue((hslColor.hue + 60) % 360).withLightness(0.8).toColor(),
        onTertiary: hslColor.withHue((hslColor.hue + 60) % 360).withLightness(0.2).toColor(),
        tertiaryContainer: hslColor.withHue((hslColor.hue + 60) % 360).withLightness(0.3).toColor(),
        onTertiaryContainer: hslColor.withHue((hslColor.hue + 60) % 360).withLightness(0.9).toColor(),
        error: const Color(0xFFFFB4AB),
        onError: const Color(0xFF690005),
        errorContainer: const Color(0xFF93000A),
        onErrorContainer: const Color(0xFFFFDAD6),
        surface: const Color(0xFF1C1B1E),
        onSurface: const Color(0xFFE6E1E6),
        surfaceVariant: const Color(0xFF49454E),
        onSurfaceVariant: const Color(0xFFCAC4CF),
        outline: const Color(0xFF948F99),
        outlineVariant: const Color(0xFF49454E),
        shadow: Colors.black,
        scrim: Colors.black,
        inverseSurface: const Color(0xFFE6E1E6),
        onInverseSurface: const Color(0xFF313033),
        inversePrimary: baseColor,
        surfaceTint: hslColor.withLightness(0.8).toColor(),
      );
    }
  }
}