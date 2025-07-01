import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../utils/responsive.dart';
import '../providers/theme_provider.dart';
import '../constants/app_constants.dart';
import '../utils/extensions.dart';
import '../widgets/navigation/navigation_animations.dart';
import '../widgets/navigation/app_navigation_rail.dart';
import '../widgets/navigation/app_bottom_navigation.dart';
import '../widgets/navigation/breadcrumbs.dart';
import 'navigation_items.dart';

/// Main navigation widget similar to material3-example/src/home.dart
/// Provides adaptive navigation that switches between bottom navigation bar and navigation rail
class AppNavigation extends ConsumerStatefulWidget {
  const AppNavigation({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends ConsumerState<AppNavigation>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late final AnimationController controller;
  late final CurvedAnimation railAnimation;
  late final ReverseAnimation barAnimation;
  
  bool controllerInitialized = false;
  bool showMediumSizeLayout = false;
  bool showLargeSizeLayout = false;
  
  int _selectedIndex = 0;
  String _currentRoute = '/';

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: NavigationAnimations.transitionDuration,
      value: 0,
      vsync: this,
    );
    railAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0),
    );
    barAnimation = ReverseAnimation(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5),
      ),
    );
    
    // Update route and index when widget is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateCurrentRoute();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateLayoutState();
    _updateCurrentRoute();
  }

  void _updateLayoutState() {
    final double width = MediaQuery.of(context).size.width;
    final AnimationStatus status = controller.status;
    
    if (width > AppConstants.mobileBreakpoint) {
      if (width > AppConstants.tabletBreakpoint) {
        showMediumSizeLayout = false;
        showLargeSizeLayout = true;
      } else {
        showMediumSizeLayout = true;
        showLargeSizeLayout = false;
      }
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        controller.forward();
      }
    } else {
      showMediumSizeLayout = false;
      showLargeSizeLayout = false;
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        controller.reverse();
      }
    }
    
    if (!controllerInitialized) {
      controllerInitialized = true;
      controller.value = width > AppConstants.mobileBreakpoint ? 1 : 0;
    }
  }

  void _updateCurrentRoute() {
    final location = GoRouterState.of(context).uri.path;
    if (_currentRoute != location) {
      setState(() {
        _currentRoute = location;
        _selectedIndex = _getIndexForRoute(location);
      });
    }
  }

  int _getIndexForRoute(String route) {
    final items = NavigationItems.flatItems;
    for (int i = 0; i < items.length; i++) {
      if (items[i].route == route) {
        return i;
      }
    }
    return 0;
  }

  void _onDestinationSelected(int index) {
    final items = NavigationItems.flatItems;
    if (index < items.length) {
      final route = items[index].route;
      if (route != _currentRoute) {
        context.go(route);
      }
    }
  }

  PreferredSizeWidget _buildAppBar() {
    final breadcrumbs = NavigationItems.getBreadcrumbs(_currentRoute);
    
    return AppBar(
      title: Row(
        children: [
          const Text('Flutter Demo'),
          if (breadcrumbs.isNotEmpty && (showMediumSizeLayout || showLargeSizeLayout)) ...[
            const SizedBox(width: 16),
            const Text('•', style: TextStyle(color: Colors.grey)),
            const SizedBox(width: 16),
            Expanded(
              child: AnimatedBreadcrumbs(
                items: breadcrumbs,
                maxItems: showLargeSizeLayout ? 5 : 3,
              ),
            ),
          ],
        ],
      ),
      actions: !showMediumSizeLayout && !showLargeSizeLayout
          ? [
              _ThemeModeToggle(),
              const SizedBox(width: 8),
              _ColorPickerButton(),
              const SizedBox(width: 16),
            ]
          : null,
      elevation: 0,
      scrolledUnderElevation: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return NavigationLayoutTransition(
          scaffoldKey: scaffoldKey,
          animationController: controller,
          railAnimation: railAnimation,
          appBar: _buildAppBar(),
          body: widget.child,
          navigationRail: AppNavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            extended: showLargeSizeLayout,
            animation: railAnimation,
          ),
          navigationBar: AppBottomNavigation(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            animation: barAnimation,
          ),
        );
      },
    );
  }
}

/// Theme mode toggle button
class _ThemeModeToggle extends ConsumerWidget {
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