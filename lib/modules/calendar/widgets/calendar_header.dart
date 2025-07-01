import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/simple_calendar_models.dart';
import '../../../core/utils/responsive.dart';

/// Calendar header with view controls and date navigation
class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    super.key,
    required this.currentDate,
    required this.currentView,
    required this.onDateChanged,
    required this.onViewChanged,
    required this.onTodayPressed,
    required this.onCreateEvent,
  });

  final DateTime currentDate;
  final CalendarView currentView;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<CalendarView> onViewChanged;
  final VoidCallback onTodayPressed;
  final VoidCallback onCreateEvent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLargeScreen = Responsive.isLargeScreen(context);
    final isMediumScreen = Responsive.isMediumScreen(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Top row with title and actions
          Row(
            children: [
              // Calendar title
              Expanded(
                child: Text(
                  _getHeaderTitle(),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              
              // Actions
              if (isLargeScreen || isMediumScreen) ...[
                // Search button
                IconButton(
                  onPressed: () => _showSearchDialog(context),
                  icon: const Icon(Icons.search),
                  tooltip: 'Search events',
                ),
                
                // Settings button
                IconButton(
                  onPressed: () => _showSettingsDialog(context),
                  icon: const Icon(Icons.settings),
                  tooltip: 'Calendar settings',
                ),
                
                const SizedBox(width: 8),
                
                // Create event button
                FilledButton.icon(
                  onPressed: onCreateEvent,
                  icon: const Icon(Icons.add),
                  label: const Text('Create'),
                ),
              ] else ...[
                // Compact actions for small screens
                IconButton(
                  onPressed: () => _showSearchDialog(context),
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: onCreateEvent,
                  icon: const Icon(Icons.add),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'settings':
                        _showSettingsDialog(context);
                        break;
                      case 'refresh':
                        // Refresh calendar
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'settings',
                      child: ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Settings'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'refresh',
                      child: ListTile(
                        leading: Icon(Icons.refresh),
                        title: Text('Refresh'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Bottom row with navigation and view controls
          Row(
            children: [
              // Date navigation
              Expanded(
                child: Row(
                  children: [
                    // Today button
                    OutlinedButton(
                      onPressed: onTodayPressed,
                      child: const Text('Today'),
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // Previous period
                    IconButton(
                      onPressed: () => _navigatePrevious(),
                      icon: const Icon(Icons.chevron_left),
                      tooltip: 'Previous ${currentView.displayName.toLowerCase()}',
                    ),
                    
                    // Current period display
                    TextButton(
                      onPressed: () => _showDatePicker(context),
                      child: Text(
                        _getDateRangeText(),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    
                    // Next period
                    IconButton(
                      onPressed: () => _navigateNext(),
                      icon: const Icon(Icons.chevron_right),
                      tooltip: 'Next ${currentView.displayName.toLowerCase()}',
                    ),
                  ],
                ),
              ),
              
              // View selector
              if (isLargeScreen || isMediumScreen)
                _buildViewSelector(theme, colorScheme)
              else
                IconButton(
                  onPressed: () => _showViewSelector(context),
                  icon: Icon(currentView.icon),
                  tooltip: 'Change view',
                ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build view selector for large screens
  Widget _buildViewSelector(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: CalendarView.values.where((view) => view != CalendarView.year).map((view) {
          final isSelected = view == currentView;
          return InkWell(
            onTap: () => onViewChanged(view),
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? colorScheme.primary : null,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    view.icon,
                    size: 16,
                    color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    view.displayName,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Get header title
  String _getHeaderTitle() {
    return 'Calendar';
  }

  /// Get date range text based on current view
  String _getDateRangeText() {
    switch (currentView) {
      case CalendarView.month:
        return DateFormat('MMMM y').format(currentDate);
      
      case CalendarView.week:
        final weekStart = _getWeekStart(currentDate);
        final weekEnd = _getWeekEnd(currentDate);
        
        if (weekStart.month == weekEnd.month) {
          return '${DateFormat('MMMM d').format(weekStart)} - ${DateFormat('d, y').format(weekEnd)}';
        } else if (weekStart.year == weekEnd.year) {
          return '${DateFormat('MMM d').format(weekStart)} - ${DateFormat('MMM d, y').format(weekEnd)}';
        } else {
          return '${DateFormat('MMM d, y').format(weekStart)} - ${DateFormat('MMM d, y').format(weekEnd)}';
        }
      
      case CalendarView.day:
        return DateFormat('EEEE, MMMM d, y').format(currentDate);
      
      case CalendarView.agenda:
        return DateFormat('MMMM y').format(currentDate);
      
      case CalendarView.year:
        return DateFormat('y').format(currentDate);
    }
  }

  /// Navigate to previous period
  void _navigatePrevious() {
    DateTime newDate;
    switch (currentView) {
      case CalendarView.month:
        newDate = DateTime(currentDate.year, currentDate.month - 1, 1);
        break;
      case CalendarView.week:
        newDate = currentDate.subtract(const Duration(days: 7));
        break;
      case CalendarView.day:
        newDate = currentDate.subtract(const Duration(days: 1));
        break;
      case CalendarView.agenda:
        newDate = DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
        break;
      case CalendarView.year:
        newDate = DateTime(currentDate.year - 1, currentDate.month, currentDate.day);
        break;
    }
    onDateChanged(newDate);
  }

  /// Navigate to next period
  void _navigateNext() {
    DateTime newDate;
    switch (currentView) {
      case CalendarView.month:
        newDate = DateTime(currentDate.year, currentDate.month + 1, 1);
        break;
      case CalendarView.week:
        newDate = currentDate.add(const Duration(days: 7));
        break;
      case CalendarView.day:
        newDate = currentDate.add(const Duration(days: 1));
        break;
      case CalendarView.agenda:
        newDate = DateTime(currentDate.year, currentDate.month + 1, currentDate.day);
        break;
      case CalendarView.year:
        newDate = DateTime(currentDate.year + 1, currentDate.month, currentDate.day);
        break;
    }
    onDateChanged(newDate);
  }

  /// Get week start date (Monday)
  DateTime _getWeekStart(DateTime date) {
    final weekday = date.weekday;
    return date.subtract(Duration(days: weekday - 1));
  }

  /// Get week end date (Sunday)
  DateTime _getWeekEnd(DateTime date) {
    final weekday = date.weekday;
    return date.add(Duration(days: 7 - weekday));
  }

  /// Show date picker dialog
  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    ).then((selectedDate) {
      if (selectedDate != null) {
        onDateChanged(selectedDate);
      }
    });
  }

  /// Show view selector dialog for small screens
  void _showViewSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Select View',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ...CalendarView.values.where((view) => view != CalendarView.year).map((view) {
            return ListTile(
              leading: Icon(view.icon),
              title: Text(view.displayName),
              selected: view == currentView,
              onTap: () {
                onViewChanged(view);
                Navigator.of(context).pop();
              },
            );
          }),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Show search dialog
  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Events'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Enter search terms...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              // Implement search
              Navigator.of(context).pop();
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  /// Show settings dialog
  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Calendar Settings'),
        content: const Text('Settings panel coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}