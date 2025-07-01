import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_demo_app/core/widgets/navigation/breadcrumbs.dart';
import 'package:flutter_demo_app/core/navigation/navigation_items.dart';

void main() {
  group('Breadcrumbs Widget', () {
    testWidgets('should render breadcrumb items', (WidgetTester tester) async {
      const items = [
        NavigationItem(
          label: 'Home',
          icon: Icons.home,
          selectedIcon: Icons.home,
          route: '/',
        ),
        NavigationItem(
          label: 'Components',
          icon: Icons.widgets,
          selectedIcon: Icons.widgets,
          route: '/components',
        ),
        NavigationItem(
          label: 'Cards',
          icon: Icons.credit_card,
          selectedIcon: Icons.credit_card,
          route: '/components/cards',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Breadcrumbs(items: items),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Components'), findsOneWidget);
      expect(find.text('Cards'), findsOneWidget);
      
      // Should have separators
      expect(find.byIcon(Icons.chevron_right), findsNWidgets(2));
    });

    testWidgets('should handle empty items list', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Breadcrumbs(items: []),
          ),
        ),
      );

      expect(find.byType(Breadcrumbs), findsOneWidget);
      // Should render as SizedBox.shrink()
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('should limit items with ellipsis overflow', (WidgetTester tester) async {
      final items = List.generate(
        10,
        (index) => NavigationItem(
          label: 'Item $index',
          icon: Icons.circle,
          selectedIcon: Icons.circle,
          route: '/item$index',
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Breadcrumbs(
              items: items,
              maxItems: 3,
              overflow: BreadcrumbOverflow.ellipsis,
            ),
          ),
        ),
      );

      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('...'), findsOneWidget);
      expect(find.text('Item 9'), findsOneWidget);
      expect(find.text('Item 5'), findsNothing); // Should be hidden
    });

    testWidgets('should show all items when under max limit', (WidgetTester tester) async {
      const items = [
        NavigationItem(
          label: 'Home',
          icon: Icons.home,
          selectedIcon: Icons.home,
          route: '/',
        ),
        NavigationItem(
          label: 'Components',
          icon: Icons.widgets,
          selectedIcon: Icons.widgets,
          route: '/components',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Breadcrumbs(
              items: items,
              maxItems: 5,
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Components'), findsOneWidget);
      expect(find.text('...'), findsNothing);
    });
  });

  group('AnimatedBreadcrumbs Widget', () {
    testWidgets('should animate breadcrumb changes', (WidgetTester tester) async {
      const initialItems = [
        NavigationItem(
          label: 'Home',
          icon: Icons.home,
          selectedIcon: Icons.home,
          route: '/',
        ),
      ];

      const updatedItems = [
        NavigationItem(
          label: 'Home',
          icon: Icons.home,
          selectedIcon: Icons.home,
          route: '/',
        ),
        NavigationItem(
          label: 'Components',
          icon: Icons.widgets,
          selectedIcon: Icons.widgets,
          route: '/components',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedBreadcrumbs(
              items: initialItems,
              animationDuration: const Duration(milliseconds: 100),
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Components'), findsNothing);

      // Update with new items
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedBreadcrumbs(
              items: updatedItems,
              animationDuration: const Duration(milliseconds: 100),
            ),
          ),
        ),
      );

      // Should find animation widgets
      expect(find.byType(FadeTransition), findsOneWidget);
      expect(find.byType(SlideTransition), findsOneWidget);

      // Wait for animation to complete
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Components'), findsOneWidget);
    });
  });

  group('StyledBreadcrumbs Widget', () {
    testWidgets('should render with normal style', (WidgetTester tester) async {
      const items = [
        NavigationItem(
          label: 'Home',
          icon: Icons.home,
          selectedIcon: Icons.home,
          route: '/',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StyledBreadcrumbs(
              items: items,
              style: BreadcrumbStyle.normal,
            ),
          ),
        ),
      );

      expect(find.byType(Breadcrumbs), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('should render with card style', (WidgetTester tester) async {
      const items = [
        NavigationItem(
          label: 'Home',
          icon: Icons.home,
          selectedIcon: Icons.home,
          route: '/',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StyledBreadcrumbs(
              items: items,
              style: BreadcrumbStyle.card,
            ),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('should render with outlined style', (WidgetTester tester) async {
      const items = [
        NavigationItem(
          label: 'Home',
          icon: Icons.home,
          selectedIcon: Icons.home,
          route: '/',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StyledBreadcrumbs(
              items: items,
              style: BreadcrumbStyle.outlined,
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
    });
  });
}