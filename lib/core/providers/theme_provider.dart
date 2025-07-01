import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../services/storage_service.dart';

/// Theme state model
@immutable
class ThemeState {
  const ThemeState({
    required this.colorSeed,
    required this.themeMode,
  });

  final Color colorSeed;
  final ThemeMode themeMode;

  ThemeState copyWith({
    Color? colorSeed,
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      colorSeed: colorSeed ?? this.colorSeed,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ThemeState &&
        other.colorSeed == colorSeed &&
        other.themeMode == themeMode;
  }

  @override
  int get hashCode => Object.hash(colorSeed, themeMode);
}

/// Theme provider that manages theme state and persistence
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  final storage = ref.watch(storageServiceProvider);
  return ThemeNotifier(storage);
});

/// Theme notifier that handles theme changes and persistence
class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier(this._storage) : super(_getInitialTheme(_storage)) {
    _loadThemeFromStorage();
  }

  final StorageService _storage;

  /// Get initial theme state from storage or defaults
  static ThemeState _getInitialTheme(StorageService storage) {
    final colorIndex = storage.getInt(AppConstants.themeColorKey) ?? 
        AppConstants.defaultColorSeedIndex;
    final themeModeIndex = storage.getInt(AppConstants.themeModeKey) ?? 
        AppConstants.defaultThemeMode.index;

    return ThemeState(
      colorSeed: AppConstants.colorSeeds[colorIndex].color,
      themeMode: ThemeMode.values[themeModeIndex],
    );
  }

  /// Load theme settings from storage
  Future<void> _loadThemeFromStorage() async {
    final colorIndex = _storage.getInt(AppConstants.themeColorKey) ?? 
        AppConstants.defaultColorSeedIndex;
    final themeModeIndex = _storage.getInt(AppConstants.themeModeKey) ?? 
        AppConstants.defaultThemeMode.index;

    state = ThemeState(
      colorSeed: AppConstants.colorSeeds[colorIndex].color,
      themeMode: ThemeMode.values[themeModeIndex],
    );
  }

  /// Update color seed
  Future<void> updateColorSeed(Color color) async {
    // Find the index of the color in the predefined list
    final colorIndex = AppConstants.colorSeeds.indexWhere(
      (seed) => seed.color == color,
    );
    
    if (colorIndex != -1) {
      await _storage.setInt(AppConstants.themeColorKey, colorIndex);
    }
    
    state = state.copyWith(colorSeed: color);
  }

  /// Update color seed by index
  Future<void> updateColorSeedByIndex(int index) async {
    if (index >= 0 && index < AppConstants.colorSeeds.length) {
      await _storage.setInt(AppConstants.themeColorKey, index);
      state = state.copyWith(colorSeed: AppConstants.colorSeeds[index].color);
    }
  }

  /// Update theme mode
  Future<void> updateThemeMode(ThemeMode mode) async {
    await _storage.setInt(AppConstants.themeModeKey, mode.index);
    state = state.copyWith(themeMode: mode);
  }

  /// Toggle theme mode between light and dark
  Future<void> toggleThemeMode() async {
    final newMode = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : state.themeMode == ThemeMode.dark
            ? ThemeMode.system
            : ThemeMode.light;
    
    await updateThemeMode(newMode);
  }


  /// Reset theme to defaults
  Future<void> resetTheme() async {
    await _storage.remove(AppConstants.themeColorKey);
    await _storage.remove(AppConstants.themeModeKey);
    
    state = ThemeState(
      colorSeed: AppConstants.colorSeeds[AppConstants.defaultColorSeedIndex].color,
      themeMode: AppConstants.defaultThemeMode,
    );
  }

  /// Update theme from image (placeholder for future implementation)
  Future<void> updateColorFromImage(ImageProvider imageProvider) async {
    // TODO: Implement dynamic color extraction from image
    // This would use the dynamic_color package or material_color_utilities
    // For now, just use the first color seed
    await updateColorSeedByIndex(0);
  }
}

/// Provider for current color seed index
final currentColorSeedIndexProvider = Provider<int>((ref) {
  final themeState = ref.watch(themeProvider);
  return AppConstants.colorSeeds.indexWhere(
    (seed) => seed.color == themeState.colorSeed,
  );
});

/// Provider for checking if dark mode is active
final isDarkModeProvider = Provider<bool>((ref) {
  final themeMode = ref.watch(themeProvider.select((state) => state.themeMode));
  
  if (themeMode == ThemeMode.system) {
    // In a real app, you would check the system brightness
    // For now, default to light mode
    return false;
  }
  
  return themeMode == ThemeMode.dark;
});