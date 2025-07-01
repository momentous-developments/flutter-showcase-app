import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/simple_calendar_models.dart';
import '../providers/calendar_providers.dart';

/// Mini calendar widget for date selection
class MiniCalendar extends ConsumerStatefulWidget {
  const MiniCalendar({
    super.key,
    required this.onDateSelected,
    this.selectedDate,
  });

  final ValueChanged<DateTime> onDateSelected;
  final DateTime? selectedDate;

  @override
  ConsumerState<MiniCalendar> createState() => _MiniCalendarState();
}

class _MiniCalendarState extends ConsumerState<MiniCalendar> {
  late DateTime _currentMonth;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
    _currentMonth = DateTime(_selectedDate.year, _selectedDate.month);
  }

  @override
  void didUpdateWidget(MiniCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != null && widget.selectedDate != _selectedDate) {
      _selectedDate = widget.selectedDate!;
      _currentMonth = DateTime(_selectedDate.year, _selectedDate.month);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final eventsAsync = ref.watch(calendarEventsProvider);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with month navigation
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    DateFormat('MMMM y').format(_currentMonth),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                
                IconButton(
                  onPressed: _previousMonth,
                  icon: const Icon(Icons.chevron_left),
                  iconSize: 20,
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(4),
                ),
                
                IconButton(
                  onPressed: _nextMonth,
                  icon: const Icon(Icons.chevron_right),
                  iconSize: 20,
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(4),
                ),
              ],
            ),
          ),
          
          // Calendar grid
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                // Week day headers
                Row(
                  children: _getWeekDays().map((day) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 4),
                
                // Calendar days
                ..._buildCalendarWeeks(eventsAsync.asData?.value ?? []),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Get week day headers
  List<String> _getWeekDays() {
    return ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
  }

  /// Build calendar weeks
  List<Widget> _buildCalendarWeeks(List<CalendarEvent> events) {
    final weeks = <Widget>[];
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    
    // Calculate first day of the calendar grid (start of week containing first day of month)
    final firstDayOfCalendar = firstDayOfMonth.subtract(
      Duration(days: firstDayOfMonth.weekday - 1),
    );
    
    // Calculate last day of the calendar grid
    final lastDayOfCalendar = lastDayOfMonth.add(
      Duration(days: 7 - lastDayOfMonth.weekday),
    );
    
    DateTime currentDate = firstDayOfCalendar;
    
    while (currentDate.isBefore(lastDayOfCalendar) || currentDate.isAtSameMomentAs(lastDayOfCalendar)) {
      final weekDays = <Widget>[];
      
      for (int i = 0; i < 7; i++) {
        final dayEvents = events.where((event) => event.occursOnDate(currentDate)).toList();
        
        weekDays.add(
          Expanded(
            child: _buildDayCell(currentDate, dayEvents),
          ),
        );
        
        currentDate = currentDate.add(const Duration(days: 1));
      }
      
      weeks.add(
        Row(children: weekDays),
      );
    }
    
    return weeks;
  }

  /// Build individual day cell
  Widget _buildDayCell(DateTime date, List<CalendarEvent> events) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final isToday = _isToday(date);
    final isSelected = _isSameDay(date, _selectedDate);
    final isCurrentMonth = date.month == _currentMonth.month;
    final hasEvents = events.isNotEmpty;
    
    Color? backgroundColor;
    Color? textColor;
    
    if (isSelected) {
      backgroundColor = colorScheme.primary;
      textColor = colorScheme.onPrimary;
    } else if (isToday) {
      backgroundColor = colorScheme.primaryContainer;
      textColor = colorScheme.onPrimaryContainer;
    }
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedDate = date;
        });
        widget.onDateSelected(date);
      },
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 32,
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          children: [
            // Day number
            Center(
              child: Text(
                '${date.day}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: textColor ?? (isCurrentMonth 
                    ? colorScheme.onSurface 
                    : colorScheme.onSurfaceVariant.withOpacity(0.5)),
                  fontWeight: isToday || isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            
            // Event indicator
            if (hasEvents && !isSelected)
              Positioned(
                bottom: 2,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Check if date is today
  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return _isSameDay(date, now);
  }

  /// Check if two dates are the same day
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  /// Navigate to previous month
  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  /// Navigate to next month
  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }
}