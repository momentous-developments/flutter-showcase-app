import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_demo_app/core/navigation/navigation_items.dart';

void main() {
  group('NavigationItems', () {
    test('should have main items', () {
      expect(NavigationItems.mainItems, isNotEmpty);
      expect(NavigationItems.mainItems.first.label, equals('Dashboard'));
      expect(NavigationItems.mainItems.first.route, equals('/'));
    });

    test('should have component items with children', () {
      expect(NavigationItems.componentItems, isNotEmpty);
      expect(NavigationItems.componentItems.first.label, equals('Components'));
      expect(NavigationItems.componentItems.first.children, isNotEmpty);
      
      final cardsItem = NavigationItems.componentItems.first.children
          .firstWhere((item) => item.label == 'Cards');
      expect(cardsItem.route, equals('/components/cards'));
    });

    test('should have module items with children', () {
      expect(NavigationItems.moduleItems, isNotEmpty);
      expect(NavigationItems.moduleItems.first.label, equals('Modules'));
      expect(NavigationItems.moduleItems.first.children, isNotEmpty);
      
      final academyItem = NavigationItems.moduleItems.first.children
          .firstWhere((item) => item.label == 'Academy');
      expect(academyItem.route, equals('/modules/academy'));
    });

    test('should have hierarchical items', () {
      final hierarchical = NavigationItems.hierarchicalItems;
      expect(hierarchical, isNotEmpty);
      expect(hierarchical.length, greaterThan(3));
    });

    test('should have flat items', () {
      final flat = NavigationItems.flatItems;
      expect(flat, isNotEmpty);
      expect(flat.length, greaterThan(5));
    });

    test('should find item by route', () {
      final dashboardItem = NavigationItems.getItemByRoute('/');
      expect(dashboardItem, isNotNull);
      expect(dashboardItem!.label, equals('Dashboard'));

      final cardsItem = NavigationItems.getItemByRoute('/components/cards');
      expect(cardsItem, isNotNull);
      expect(cardsItem!.label, equals('Cards'));

      final nonExistentItem = NavigationItems.getItemByRoute('/non-existent');
      expect(nonExistentItem, isNull);
    });

    test('should generate breadcrumbs', () {
      final breadcrumbs = NavigationItems.getBreadcrumbs('/components/cards');
      expect(breadcrumbs, isNotEmpty);
      expect(breadcrumbs.length, greaterThan(1));
      expect(breadcrumbs.last.label, equals('Cards'));
    });

    test('should generate empty breadcrumbs for invalid route', () {
      final breadcrumbs = NavigationItems.getBreadcrumbs('/invalid/route');
      expect(breadcrumbs, isEmpty);
    });
  });

  group('NavigationItem', () {
    test('should create navigation destination', () {
      const item = NavigationItem(
        label: 'Test',
        icon: Icons.test_tube,
        selectedIcon: Icons.test_tube_outlined,
        route: '/test',
      );

      final destination = item.toNavigationDestination();
      expect(destination.label, equals('Test'));
    });

    test('should create navigation rail destination', () {
      const item = NavigationItem(
        label: 'Test',
        icon: Icons.test_tube,
        selectedIcon: Icons.test_tube_outlined,
        route: '/test',
        tooltip: 'Test tooltip',
      );

      final destination = item.toNavigationRailDestination();
      expect(destination.label, isA<Text>());
    });
  });
}