import 'package:flutter/material.dart';

/// Navigation item model for defining menu items in the app
class NavigationItem {
  const NavigationItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.route,
    this.children = const [],
    this.tooltip,
    this.badge,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String route;
  final List<NavigationItem> children;
  final String? tooltip;
  final Widget? badge;
}

/// Enum for main navigation sections
enum NavigationSection {
  main,
  components,
  modules,
  pages,
  settings,
}

/// All navigation items organized by section
class NavigationItems {
  static const List<NavigationItem> mainItems = [
    NavigationItem(
      label: 'Dashboard',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
      route: '/',
      tooltip: 'Main dashboard with overview',
    ),
  ];

  static const List<NavigationItem> componentItems = [
    NavigationItem(
      label: 'Components',
      icon: Icons.widgets_outlined,
      selectedIcon: Icons.widgets,
      route: '/components',
      tooltip: 'All UI components showcase',
      children: [
        NavigationItem(
          label: 'Cards',
          icon: Icons.credit_card_outlined,
          selectedIcon: Icons.credit_card,
          route: '/components/cards',
          tooltip: 'Card components',
        ),
        NavigationItem(
          label: 'Dialogs',
          icon: Icons.chat_bubble_outline,
          selectedIcon: Icons.chat_bubble,
          route: '/components/dialogs',
          tooltip: 'Dialog and modal components',
        ),
        NavigationItem(
          label: 'Forms',
          icon: Icons.edit_outlined,
          selectedIcon: Icons.edit,
          route: '/components/forms',
          tooltip: 'Form components and inputs',
        ),
        NavigationItem(
          label: 'Tables',
          icon: Icons.table_chart_outlined,
          selectedIcon: Icons.table_chart,
          route: '/components/tables',
          tooltip: 'Data table components',
        ),
        NavigationItem(
          label: 'Charts',
          icon: Icons.analytics_outlined,
          selectedIcon: Icons.analytics,
          route: '/components/charts',
          tooltip: 'Chart and graph components',
        ),
        NavigationItem(
          label: 'Buttons',
          icon: Icons.smart_button_outlined,
          selectedIcon: Icons.smart_button,
          route: '/components/buttons',
          tooltip: 'Button components',
        ),
        NavigationItem(
          label: 'Navigation',
          icon: Icons.navigation_outlined,
          selectedIcon: Icons.navigation,
          route: '/components/navigation',
          tooltip: 'Navigation components',
        ),
        NavigationItem(
          label: 'Inputs',
          icon: Icons.input_outlined,
          selectedIcon: Icons.input,
          route: '/components/inputs',
          tooltip: 'Input field components',
        ),
      ],
    ),
  ];

  static const List<NavigationItem> moduleItems = [
    NavigationItem(
      label: 'Modules',
      icon: Icons.apps_outlined,
      selectedIcon: Icons.apps,
      route: '/modules',
      tooltip: 'Application modules',
      children: [
        NavigationItem(
          label: 'Academy',
          icon: Icons.school_outlined,
          selectedIcon: Icons.school,
          route: '/modules/academy',
          tooltip: 'Learning management system',
        ),
        NavigationItem(
          label: 'E-commerce',
          icon: Icons.shopping_cart_outlined,
          selectedIcon: Icons.shopping_cart,
          route: '/modules/ecommerce',
          tooltip: 'Online store and shopping',
        ),
        NavigationItem(
          label: 'Email',
          icon: Icons.email_outlined,
          selectedIcon: Icons.email,
          route: '/modules/email',
          tooltip: 'Email management system',
        ),
        NavigationItem(
          label: 'Chat',
          icon: Icons.chat_outlined,
          selectedIcon: Icons.chat,
          route: '/modules/chat',
          tooltip: 'Real-time messaging',
        ),
        NavigationItem(
          label: 'Calendar',
          icon: Icons.calendar_today_outlined,
          selectedIcon: Icons.calendar_today,
          route: '/modules/calendar',
          tooltip: 'Event and schedule management',
        ),
        NavigationItem(
          label: 'Kanban',
          icon: Icons.view_kanban_outlined,
          selectedIcon: Icons.view_kanban,
          route: '/modules/kanban',
          tooltip: 'Project management board',
        ),
        NavigationItem(
          label: 'Invoice',
          icon: Icons.receipt_long_outlined,
          selectedIcon: Icons.receipt_long,
          route: '/modules/invoice',
          tooltip: 'Billing and invoicing',
        ),
        NavigationItem(
          label: 'Logistics',
          icon: Icons.local_shipping_outlined,
          selectedIcon: Icons.local_shipping,
          route: '/modules/logistics',
          tooltip: 'Supply chain management',
        ),
      ],
    ),
  ];

  static const List<NavigationItem> pageItems = [
    NavigationItem(
      label: 'Pages',
      icon: Icons.pages_outlined,
      selectedIcon: Icons.pages,
      route: '/pages',
      tooltip: 'Static pages and layouts',
      children: [
        NavigationItem(
          label: 'Authentication',
          icon: Icons.security_outlined,
          selectedIcon: Icons.security,
          route: '/pages/auth',
          tooltip: 'Login and registration pages',
        ),
        NavigationItem(
          label: 'Account',
          icon: Icons.account_circle_outlined,
          selectedIcon: Icons.account_circle,
          route: '/pages/account',
          tooltip: 'User account management',
        ),
        NavigationItem(
          label: 'Marketing',
          icon: Icons.campaign_outlined,
          selectedIcon: Icons.campaign,
          route: '/pages/marketing',
          tooltip: 'Marketing and promotional pages',
        ),
        NavigationItem(
          label: 'Miscellaneous',
          icon: Icons.more_horiz_outlined,
          selectedIcon: Icons.more_horiz,
          route: '/pages/misc',
          tooltip: 'Additional utility pages',
        ),
      ],
    ),
  ];

  static const List<NavigationItem> settingsItems = [
    NavigationItem(
      label: 'Settings',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      route: '/settings',
      tooltip: 'Application settings and preferences',
    ),
  ];

  /// Get all flat navigation items (for bottom navigation)
  static List<NavigationItem> get flatItems => [
    ...mainItems,
    ...componentItems.first.children.take(5), // Show first 5 component categories
    ...settingsItems,
  ];

  /// Get hierarchical navigation items (for navigation rail/drawer)
  static List<NavigationItem> get hierarchicalItems => [
    ...mainItems,
    ...componentItems,
    ...moduleItems,
    ...pageItems,
    ...settingsItems,
  ];

  /// Get navigation item by route
  static NavigationItem? getItemByRoute(String route) {
    return _findItemByRoute(hierarchicalItems, route);
  }

  static NavigationItem? _findItemByRoute(List<NavigationItem> items, String route) {
    for (final item in items) {
      if (item.route == route) {
        return item;
      }
      if (item.children.isNotEmpty) {
        final found = _findItemByRoute(item.children, route);
        if (found != null) {
          return found;
        }
      }
    }
    return null;
  }

  /// Get breadcrumb trail for a route
  static List<NavigationItem> getBreadcrumbs(String route) {
    final breadcrumbs = <NavigationItem>[];
    _buildBreadcrumbs(hierarchicalItems, route, breadcrumbs);
    return breadcrumbs;
  }

  static bool _buildBreadcrumbs(
    List<NavigationItem> items,
    String route,
    List<NavigationItem> breadcrumbs,
  ) {
    for (final item in items) {
      breadcrumbs.add(item);
      
      if (item.route == route) {
        return true;
      }
      
      if (item.children.isNotEmpty) {
        if (_buildBreadcrumbs(item.children, route, breadcrumbs)) {
          return true;
        }
      }
      
      breadcrumbs.removeLast();
    }
    return false;
  }
}

/// Extension for NavigationDestination conversion
extension NavigationItemExtension on NavigationItem {
  NavigationDestination toNavigationDestination() {
    return NavigationDestination(
      icon: Icon(icon),
      selectedIcon: Icon(selectedIcon),
      label: label,
      tooltip: tooltip,
    );
  }

  NavigationRailDestination toNavigationRailDestination() {
    return NavigationRailDestination(
      icon: Tooltip(
        message: tooltip ?? label,
        child: Icon(icon),
      ),
      selectedIcon: Tooltip(
        message: tooltip ?? label,
        child: Icon(selectedIcon),
      ),
      label: Text(label),
    );
  }
}