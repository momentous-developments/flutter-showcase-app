import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../navigation/navigation_items.dart';
import '../../providers/theme_provider.dart';
import '../../constants/app_constants.dart';
import '../../utils/extensions.dart';
import 'navigation_animations.dart';

/// Custom navigation rail with enhanced Material 3 styling
class AppNavigationRail extends ConsumerWidget {
  const AppNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.extended = false,
    this.animation,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final bool extended;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final destinations = NavigationItems.flatItems
        .take(8) // Limit to prevent overflow
        .map((item) => item.toNavigationRailDestination())
        .toList();

    final rail = NavigationRail(
      extended: extended,
      destinations: destinations,
      selectedIndex: selectedIndex.clamp(0, destinations.length - 1),
      onDestinationSelected: onDestinationSelected,
      labelType: extended 
          ? NavigationRailLabelType.none 
          : NavigationRailLabelType.all,
      leading: _buildLeading(context, ref),
      trailing: _buildTrailing(context, ref),
      groupAlignment: 0.0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: null,
      indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
      selectedIconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
      ),
      unselectedIconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      selectedLabelTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
      ),
      unselectedLabelTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );

    if (animation != null) {
      return RailTransition(
        animation: animation!,
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: rail,
      );
    }

    return rail;
  }

  Widget? _buildLeading(BuildContext context, WidgetRef ref) {
    if (!extended) return null;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: context.colorScheme.primaryContainer,
            child: Icon(
              Icons.flutter_dash,
              size: 28,
              color: context.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Flutter Demo',
            style: context.textTheme.titleSmall?.copyWith(
              color: context.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget? _buildTrailing(BuildContext context, WidgetRef ref) {
    return Flexible(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: extended
              ? _ExtendedTrailingActions(ref: ref)
              : _CompactTrailingActions(ref: ref),
        ),
      ),
    );
  }
}

/// Extended trailing actions for wide navigation rail
class _ExtendedTrailingActions extends StatelessWidget {
  const _ExtendedTrailingActions({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);
    final colorIndex = ref.watch(currentColorSeedIndexProvider);
    final colorSeed = AppConstants.colorSeeds[colorIndex];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme Settings',
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            
            // Color scheme indicator
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: colorSeed.color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.colorScheme.outline.withOpacity(0.5),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    colorSeed.label,
                    style: context.textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Theme mode
            Text(
              'Mode: ${_getThemeModeLabel(themeState.themeMode)}',
              style: context.textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            
            // Material version
            Text(
              'Material 3',
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            
            // Quick actions
            Wrap(
              spacing: 4,
              children: [
                _ThemeActionButton(
                  icon: _getThemeModeIcon(themeState.themeMode),
                  tooltip: 'Toggle theme mode',
                  onPressed: () => ref.read(themeProvider.notifier).toggleThemeMode(),
                ),
                _ThemeActionButton(
                  icon: Icons.palette_outlined,
                  tooltip: 'Change color',
                  onPressed: () => _showColorPicker(context, ref),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showColorPicker(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Color'),
        content: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: AppConstants.colorSeeds.asMap().entries.map((entry) {
            final index = entry.key;
            final seed = entry.value;
            return GestureDetector(
              onTap: () {
                ref.read(themeProvider.notifier).updateColorSeedByIndex(index);
                Navigator.of(context).pop();
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: seed.color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 2,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
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
}

/// Compact trailing actions for normal navigation rail
class _CompactTrailingActions extends StatelessWidget {
  const _CompactTrailingActions({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ThemeActionButton(
          icon: _getThemeModeIcon(themeState.themeMode),
          tooltip: 'Toggle theme mode',
          onPressed: () => ref.read(themeProvider.notifier).toggleThemeMode(),
        ),
        const SizedBox(height: 8),
        _ThemeActionButton(
          icon: Icons.palette_outlined,
          tooltip: 'Change color',
          onPressed: () => _showColorPicker(context, ref),
        ),
      ],
    );
  }

  void _showColorPicker(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Color'),
        content: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: AppConstants.colorSeeds.asMap().entries.map((entry) {
            final index = entry.key;
            final seed = entry.value;
            return GestureDetector(
              onTap: () {
                ref.read(themeProvider.notifier).updateColorSeedByIndex(index);
                Navigator.of(context).pop();
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: seed.color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 2,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
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
}

/// Reusable theme action button
class _ThemeActionButton extends StatelessWidget {
  const _ThemeActionButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon),
        iconSize: 20,
        onPressed: onPressed,
        style: IconButton.styleFrom(
          minimumSize: const Size(32, 32),
          maximumSize: const Size(32, 32),
        ),
      ),
    );
  }
}