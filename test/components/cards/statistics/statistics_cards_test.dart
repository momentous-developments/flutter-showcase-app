import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_demo/components/cards/statistics/index.dart';

void main() {
  group('Statistics Cards Tests', () {
    testWidgets('CardStatsSquare renders correctly', (WidgetTester tester) async {
      const data = SquareStatsData(
        avatarIcon: Icons.trending_up,
        avatarColor: Colors.blue,
        stats: '230k',
        statsTitle: 'Sales',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CardStatsSquare(data: data),
          ),
        ),
      );

      expect(find.text('230k'), findsOneWidget);
      expect(find.text('Sales'), findsOneWidget);
      expect(find.byIcon(Icons.trending_up), findsOneWidget);
    });

    testWidgets('CustomerStats renders correctly', (WidgetTester tester) async {
      const data = CustomerStatsData(
        title: 'New Customers',
        avatarIcon: Icons.person_add,
        color: Colors.blue,
        description: 'Total 48.5% growth',
        stats: '92.6k',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomerStats(data: data),
          ),
        ),
      );

      expect(find.text('New Customers'), findsOneWidget);
      expect(find.text('92.6k'), findsOneWidget);
      expect(find.text('Total 48.5% growth'), findsOneWidget);
      expect(find.byIcon(Icons.person_add), findsOneWidget);
    });

    testWidgets('HorizontalStats renders correctly', (WidgetTester tester) async {
      const data = HorizontalStatsData(
        title: 'Total Revenue',
        stats: '97.5k',
        avatarIcon: Icons.trending_up,
        avatarColor: Colors.blue,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HorizontalStats(data: data),
          ),
        ),
      );

      expect(find.text('Total Revenue'), findsOneWidget);
      expect(find.text('97.5k'), findsOneWidget);
      expect(find.byIcon(Icons.trending_up), findsOneWidget);
    });

    testWidgets('HorizontalWithAvatar renders correctly', (WidgetTester tester) async {
      const data = HorizontalStatsData(
        title: 'Active Users',
        stats: '1.15k',
        avatarIcon: Icons.person,
        avatarColor: Colors.orange,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HorizontalWithAvatar(data: data),
          ),
        ),
      );

      expect(find.text('Active Users'), findsOneWidget);
      expect(find.text('1.15k'), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('HorizontalWithBorder renders correctly', (WidgetTester tester) async {
      const data = HorizontalBorderStatsData(
        title: 'Monthly Sales',
        stats: '15,420',
        trendNumber: 12.5,
        avatarIcon: Icons.shopping_cart,
        color: Colors.blue,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HorizontalWithBorder(data: data),
          ),
        ),
      );

      expect(find.text('Monthly Sales'), findsOneWidget);
      expect(find.text('15,420'), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
    });

    testWidgets('HorizontalWithSubtitle renders correctly', (WidgetTester tester) async {
      const data = HorizontalSubtitleStatsData(
        title: 'Revenue Growth',
        stats: '25.8k',
        avatarIcon: Icons.trending_up,
        avatarColor: Colors.green,
        trend: TrendDirection.positive,
        trendNumber: '15.2',
        subtitle: 'Compared to last month',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HorizontalWithSubtitle(data: data),
          ),
        ),
      );

      expect(find.text('Revenue Growth'), findsOneWidget);
      expect(find.text('25.8k'), findsOneWidget);
      expect(find.text('Compared to last month'), findsOneWidget);
      expect(find.byIcon(Icons.trending_up), findsOneWidget);
    });

    testWidgets('VerticalStats renders correctly', (WidgetTester tester) async {
      const data = VerticalStatsData(
        title: 'Total Profit',
        subtitle: 'Last week analytics',
        stats: '15k',
        avatarIcon: Icons.trending_up,
        avatarColor: Colors.blue,
        chipText: '+25.8%',
        chipColor: Colors.green,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VerticalStats(data: data),
          ),
        ),
      );

      expect(find.text('Total Profit'), findsOneWidget);
      expect(find.text('Last week analytics'), findsOneWidget);
      expect(find.text('15k'), findsOneWidget);
      expect(find.text('+25.8%'), findsOneWidget);
      expect(find.byIcon(Icons.trending_up), findsOneWidget);
    });

    testWidgets('StatsWithAreaChart renders correctly', (WidgetTester tester) async {
      final data = StatsWithAreaChartData(
        stats: '97.5k',
        title: 'Revenue',
        avatarIcon: Icons.trending_up,
        chartSeries: const [
          ChartSeries(
            name: 'Revenue',
            data: [
              ChartDataPoint(1, 30),
              ChartDataPoint(2, 40),
              ChartDataPoint(3, 35),
              ChartDataPoint(4, 50),
            ],
            color: Colors.blue,
          ),
        ],
        avatarColor: Colors.blue,
        chartColor: Colors.blue,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatsWithAreaChart(data: data),
          ),
        ),
      );

      expect(find.text('97.5k'), findsOneWidget);
      expect(find.text('Revenue'), findsOneWidget);
      expect(find.byIcon(Icons.trending_up), findsOneWidget);
    });

    group('Collection widgets', () {
      testWidgets('SquareStatsGrid renders multiple cards', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SquareStatsGrid(
                statsData: SampleStatisticsData.squareStats,
              ),
            ),
          ),
        );

        expect(find.text('230k'), findsOneWidget);
        expect(find.text('8.549k'), findsOneWidget);
        expect(find.text('Sales'), findsOneWidget);
        expect(find.text('Customers'), findsOneWidget);
      });

      testWidgets('HorizontalStatsCollection renders multiple cards', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: HorizontalStatsCollection(
                statsData: SampleStatisticsData.horizontalStats,
              ),
            ),
          ),
        );

        expect(find.text('Total Revenue'), findsOneWidget);
        expect(find.text('Total Orders'), findsOneWidget);
        expect(find.text('Active Users'), findsOneWidget);
      });

      testWidgets('VerticalStatsCollection renders multiple cards', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: VerticalStatsCollection(
                statsData: SampleStatisticsData.verticalStats,
              ),
            ),
          ),
        );

        expect(find.text('Total Profit'), findsOneWidget);
        expect(find.text('Refunds'), findsOneWidget);
        expect(find.text('+25.8%'), findsOneWidget);
        expect(find.text('-12.2%'), findsOneWidget);
      });
    });

    group('Interaction tests', () {
      testWidgets('CardStatsSquare onTap callback works', (WidgetTester tester) async {
        bool tapped = false;
        const data = SquareStatsData(
          avatarIcon: Icons.trending_up,
          stats: '230k',
          statsTitle: 'Sales',
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CardStatsSquare(
                data: data,
                onTap: () => tapped = true,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(CardStatsSquare));
        expect(tapped, isTrue);
      });

      testWidgets('CustomerStats onTap callback works', (WidgetTester tester) async {
        bool tapped = false;
        const data = CustomerStatsData(
          title: 'New Customers',
          avatarIcon: Icons.person_add,
          description: 'Total 48.5% growth',
          stats: '92.6k',
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomerStats(
                data: data,
                onTap: () => tapped = true,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(CustomerStats));
        expect(tapped, isTrue);
      });
    });
  });
}