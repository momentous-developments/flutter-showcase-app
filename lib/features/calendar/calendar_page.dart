import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/layouts/module_layout.dart';
import '../../core/utils/responsive.dart';
import 'models/calendar_models.dart';
import 'providers/calendar_providers.dart';
import 'views/month_view.dart';
import 'views/week_view.dart';
import 'views/day_view.dart';
import 'views/agenda_view.dart';
import 'widgets/calendar_sidebar.dart';
import 'widgets/event_detail_dialog.dart';
import 'widgets/calendar_toolbar.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final viewType = ref.watch(calendarViewTypeProvider);
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final isDesktop = Responsive.isDesktop(context);

    return ModuleLayout(
      title: 'Calendar',
      actions: [
        // View Type Toggle
        SegmentedButton<CalendarViewType>(
          segments: const [
            ButtonSegment(
              value: CalendarViewType.month,
              icon: Icon(Icons.calendar_view_month),
              tooltip: 'Month View',
            ),
            ButtonSegment(
              value: CalendarViewType.week,
              icon: Icon(Icons.view_week),
              tooltip: 'Week View',
            ),
            ButtonSegment(
              value: CalendarViewType.day,
              icon: Icon(Icons.view_day),
              tooltip: 'Day View',
            ),
            ButtonSegment(
              value: CalendarViewType.agenda,
              icon: Icon(Icons.view_agenda),
              tooltip: 'Agenda View',
            ),
          ],
          selected: {viewType},
          onSelectionChanged: (Set<CalendarViewType> selected) {
            ref.read(calendarViewTypeProvider.notifier).state = selected.first;
          },
        ),
        const SizedBox(width: 16),
        // Add Event Button
        FilledButton.icon(
          onPressed: () => _showEventDialog(context),
          icon: const Icon(Icons.add),
          label: const Text('Add Event'),
        ),
      ],
      body: Scaffold(
        key: _scaffoldKey,
        drawer: isMobile ? const CalendarSidebar() : null,
        body: Row(
          children: [
            // Sidebar for desktop/tablet
            if (!isMobile)
              SizedBox(
                width: isDesktop ? 300 : 250,
                child: const CalendarSidebar(),
              ),
            // Main calendar view
            Expanded(
              child: Column(
                children: [
                  // Calendar Toolbar
                  CalendarToolbar(
                    onMenuPressed: isMobile
                        ? () => _scaffoldKey.currentState?.openDrawer()
                        : null,
                  ),
                  // Calendar View
                  Expanded(
                    child: _buildCalendarView(viewType),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarView(CalendarViewType viewType) {
    switch (viewType) {
      case CalendarViewType.month:
        return const MonthView();
      case CalendarViewType.week:
        return const WeekView();
      case CalendarViewType.day:
        return const DayView();
      case CalendarViewType.agenda:
        return const AgendaView();
    }
  }

  void _showEventDialog(BuildContext context, {CalendarEvent? event}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => EventDetailDialog(event: event),
    );
  }
}

// Calendar Route Configuration
class CalendarRoute {
  static const String path = '/calendar';
  static const String name = 'calendar';

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (context, state) => const CalendarPage(),
      );
}