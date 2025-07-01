import 'package:flutter/material.dart';
import '../../navigation/navigation_items.dart';
import 'navigation_animations.dart';

/// Custom bottom navigation bar with Material 3 styling
class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.animation,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    // Get the main navigation items for bottom navigation
    // Limit to 5 items to fit properly on mobile screens
    final destinations = NavigationItems.flatItems
        .take(5)
        .map((item) => item.toNavigationDestination())
        .toList();

    final navigationBar = NavigationBar(
      destinations: destinations,
      selectedIndex: selectedIndex.clamp(0, destinations.length - 1),
      onDestinationSelected: onDestinationSelected,
      height: 80,
      elevation: 3,
      backgroundColor: Theme.of(context).colorScheme.surface,
      indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
      shadowColor: Theme.of(context).colorScheme.shadow,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      animationDuration: const Duration(milliseconds: 300),
    );

    if (animation != null) {
      return BarTransition(
        animation: animation!,
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: navigationBar,
      );
    }

    return navigationBar;
  }
}

/// Alternative bottom navigation bar using BottomNavigationBar (Material 2 style)
class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.animation,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    final items = NavigationItems.flatItems.take(5).toList();
    
    final bottomNavBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex.clamp(0, items.length - 1),
      onTap: onDestinationSelected,
      elevation: 8,
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
      selectedLabelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: Theme.of(context).textTheme.labelSmall,
      items: items.map((item) => BottomNavigationBarItem(
        icon: Icon(item.icon),
        activeIcon: Icon(item.selectedIcon),
        label: item.label,
        tooltip: item.tooltip ?? item.label,
      )).toList(),
    );

    if (animation != null) {
      return BarTransition(
        animation: animation!,
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: bottomNavBar,
      );
    }

    return bottomNavBar;
  }
}

/// Floating Action Button for bottom navigation
class NavigationFab extends StatelessWidget {
  const NavigationFab({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
    this.tooltip = 'Add',
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      child: Icon(icon),
    );
  }
}

/// Extended floating action button with label
class NavigationExtendedFab extends StatelessWidget {
  const NavigationExtendedFab({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon = Icons.add,
    this.tooltip,
  });

  final VoidCallback onPressed;
  final String label;
  final IconData icon;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      tooltip: tooltip ?? label,
    );
  }
}