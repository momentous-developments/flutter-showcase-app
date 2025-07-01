import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_constants.dart';
import '../providers/theme_provider.dart';
import '../utils/responsive.dart';
import '../utils/extensions.dart';

/// Base scaffold with responsive navigation
class BaseScaffold extends ConsumerStatefulWidget {
  const BaseScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends ConsumerState<BaseScaffold> {
  int _selectedIndex = 0;

  final List<NavigationDestination> _destinations = const [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.widgets_outlined),
      selectedIcon: Icon(Icons.widgets),
      label: 'Components',
    ),
    NavigationDestination(
      icon: Icon(Icons.palette_outlined),
      selectedIcon: Icon(Icons.palette),
      label: 'Theme',
    ),
    NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  final List<String> _routes = [
    '/',
    '/components',
    '/theme',
    '/settings',
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    final showRail = context.showNavigationRail;
    final showExtendedRail = context.showExtendedNavigationRail;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Row(
        children: [
          // Navigation Rail for larger screens
          if (showRail) ...[
            NavigationRail(
              extended: showExtendedRail,
              destinations: _destinations.map((dest) {
                return NavigationRailDestination(
                  icon: dest.icon,
                  selectedIcon: dest.selectedIcon,
                  label: Text(dest.label),
                );
              }).toList(),
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onDestinationSelected,
              labelType: showExtendedRail
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.all,
              leading: _buildRailLeading(context),
              trailing: _buildRailTrailing(context),
              elevation: null,
            ),
            const VerticalDivider(thickness: 1, width: 1),
          ],
          // Main content
          Expanded(
            child: widget.child,
          ),
        ],
      ),
      // Bottom Navigation Bar for mobile
      bottomNavigationBar: !showRail
          ? NavigationBar(
              destinations: _destinations,
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onDestinationSelected,
            )
          : null,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Material 3 Demo'),
      actions: [
        // Theme mode toggle
        _ThemeModeToggle(),
        const SizedBox(width: 8),
        // Color picker
        _ColorPickerButton(),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget? _buildRailLeading(BuildContext context) {
    if (!context.showExtendedNavigationRail) return null;
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 28,
        backgroundColor: context.colorScheme.primaryContainer,
        child: Icon(
          Icons.flutter_dash,
          size: 32,
          color: context.colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }

  Widget? _buildRailTrailing(BuildContext context) {
    return const Flexible(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: _ThemeInfoCard(),
        ),
      ),
    );
  }
}

/// Theme mode toggle button
class _ThemeModeToggle extends ConsumerWidget {
  const _ThemeModeToggle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider.select((state) => state.themeMode));
    
    return IconButton(
      icon: Icon(_getThemeModeIcon(themeMode)),
      tooltip: _getThemeModeTooltip(themeMode),
      onPressed: () {
        ref.read(themeProvider.notifier).toggleThemeMode();
      },
    );
  }

  IconData _getThemeModeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  String _getThemeModeTooltip(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light mode';
      case ThemeMode.dark:
        return 'Dark mode';
      case ThemeMode.system:
        return 'System mode';
    }
  }
}


/// Color picker button
class _ColorPickerButton extends ConsumerWidget {
  const _ColorPickerButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorSeed = ref.watch(themeProvider.select((state) => state.colorSeed));
    
    return PopupMenuButton<int>(
      icon: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: colorSeed,
          shape: BoxShape.circle,
          border: Border.all(
            color: context.colorScheme.outline,
            width: 2,
          ),
        ),
      ),
      tooltip: 'Change color',
      itemBuilder: (context) {
        return AppConstants.colorSeeds.asMap().entries.map((entry) {
          final index = entry.key;
          final seed = entry.value;
          
          return PopupMenuItem<int>(
            value: index,
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: seed.color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.colorScheme.outline,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(seed.label),
              ],
            ),
          );
        }).toList();
      },
      onSelected: (index) {
        ref.read(themeProvider.notifier).updateColorSeedByIndex(index);
      },
    );
  }
}

/// Theme info card for navigation rail
class _ThemeInfoCard extends ConsumerWidget {
  const _ThemeInfoCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final colorIndex = ref.watch(currentColorSeedIndexProvider);
    final colorSeed = AppConstants.colorSeeds[colorIndex];
    
    if (!context.showExtendedNavigationRail) {
      return const SizedBox.shrink();
    }
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme Settings',
              style: context.textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: colorSeed.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  colorSeed.label,
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Mode: ${_getThemeModeLabel(themeState.themeMode)}',
              style: context.textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Text(
              'Material 3',
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  String _getThemeModeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }
}