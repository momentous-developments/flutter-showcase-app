import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/responsive.dart';
import '../../navigation/navigation_items.dart';
import 'app_navigation_rail.dart';
import 'app_bottom_navigation.dart';

/// Adaptive navigation widget that switches between navigation types based on screen size
class AdaptiveNavigation extends StatefulWidget {
  const AdaptiveNavigation({
    super.key,
    required this.child,
    this.currentIndex = 0,
    this.onDestinationSelected,
  });

  final Widget child;
  final int currentIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  State<AdaptiveNavigation> createState() => _AdaptiveNavigationState();
}

class _AdaptiveNavigationState extends State<AdaptiveNavigation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late CurvedAnimation _railAnimation;
  late ReverseAnimation _barAnimation;
  
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _railAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 1.0),
    );
    
    _barAnimation = ReverseAnimation(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateNavigationMode();
  }

  void _updateNavigationMode() {
    final size = MediaQuery.of(context).size;
    final shouldShowRail = size.width >= ResponsiveBreakpoints.standard.medium;
    
    if (shouldShowRail && !_animationController.isCompleted) {
      _animationController.forward();
    } else if (!shouldShowRail && !_animationController.isDismissed) {
      _animationController.reverse();
    }
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    widget.onDestinationSelected?.call(index);
    
    // Navigate to the selected route
    final items = NavigationItems.flatItems;
    if (index < items.length) {
      context.go(items[index].route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth >= ResponsiveBreakpoints.standard.medium;
        final isExtraWideScreen = constraints.maxWidth >= ResponsiveBreakpoints.standard.large;

        if (isWideScreen) {
          return Row(
            children: [
              AppNavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationSelected: _onDestinationSelected,
                extended: isExtraWideScreen,
                animation: _railAnimation,
              ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(child: widget.child),
            ],
          );
        } else {
          return Scaffold(
            body: widget.child,
            bottomNavigationBar: AppBottomNavigation(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onDestinationSelected,
              animation: _barAnimation,
            ),
          );
        }
      },
    );
  }
}

/// Provider for current navigation context
class NavigationProvider extends InheritedWidget {
  const NavigationProvider({
    super.key,
    required this.currentRoute,
    required this.breadcrumbs,
    required super.child,
  });

  final String currentRoute;
  final List<NavigationItem> breadcrumbs;

  static NavigationProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NavigationProvider>();
  }

  @override
  bool updateShouldNotify(NavigationProvider oldWidget) {
    return currentRoute != oldWidget.currentRoute ||
        breadcrumbs != oldWidget.breadcrumbs;
  }
}

/// Navigation state notifier for managing current route and breadcrumbs
class NavigationState extends ChangeNotifier {
  String _currentRoute = '/';
  List<NavigationItem> _breadcrumbs = [];

  String get currentRoute => _currentRoute;
  List<NavigationItem> get breadcrumbs => _breadcrumbs;

  void updateRoute(String route) {
    if (_currentRoute != route) {
      _currentRoute = route;
      _breadcrumbs = NavigationItems.getBreadcrumbs(route);
      notifyListeners();
    }
  }

  int getCurrentIndex() {
    final items = NavigationItems.flatItems;
    for (int i = 0; i < items.length; i++) {
      if (items[i].route == _currentRoute) {
        return i;
      }
    }
    return 0;
  }
}