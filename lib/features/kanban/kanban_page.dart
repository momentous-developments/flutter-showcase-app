import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/layouts/module_layout.dart';
import 'providers/kanban_providers.dart';
import 'models/simple_models.dart';
import 'views/board_view.dart';
import 'views/board_list_view.dart';
import 'views/task_detail_view.dart';
import 'views/board_settings_view.dart';
import 'views/team_view.dart';
import 'views/analytics_view.dart';

class KanbanPage extends ConsumerStatefulWidget {
  const KanbanPage({super.key});

  @override
  ConsumerState<KanbanPage> createState() => _KanbanPageState();
}

class _KanbanPageState extends ConsumerState<KanbanPage> {
  @override
  Widget build(BuildContext context) {
    final selectedBoardId = ref.watch(selectedBoardIdProvider);
    final selectedTask = ref.watch(selectedTaskProvider);
    
    return ModuleLayout(
      title: 'Kanban Board',
      actions: selectedBoardId != null ? _buildBoardActions() : null,
      body: selectedBoardId == null
          ? const BoardListView()
          : Stack(
              children: [
                const BoardView(),
                if (selectedTask != null)
                  TaskDetailView(
                    task: selectedTask,
                    onClose: () {
                      ref.read(selectedTaskProvider.notifier).clearSelection();
                    },
                  ),
              ],
            ),
    );
  }
  
  List<Widget> _buildBoardActions() {
    return [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _showSearchDialog,
        tooltip: 'Search tasks',
      ),
      IconButton(
        icon: const Icon(Icons.filter_list),
        onPressed: _showFilterDialog,
        tooltip: 'Filter tasks',
      ),
      PopupMenuButton<String>(
        icon: const Icon(Icons.view_module),
        tooltip: 'View options',
        onSelected: (value) {
          switch (value) {
            case 'board':
              ref.read(boardViewTypeProvider.notifier).state = BoardViewType.board;
              break;
            case 'list':
              ref.read(boardViewTypeProvider.notifier).state = BoardViewType.list;
              break;
            case 'calendar':
              ref.read(boardViewTypeProvider.notifier).state = BoardViewType.calendar;
              break;
            case 'timeline':
              ref.read(boardViewTypeProvider.notifier).state = BoardViewType.timeline;
              break;
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'board',
            child: ListTile(
              leading: Icon(Icons.view_column),
              title: Text('Board View'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const PopupMenuItem(
            value: 'list',
            child: ListTile(
              leading: Icon(Icons.list),
              title: Text('List View'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const PopupMenuItem(
            value: 'calendar',
            child: ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Calendar View'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const PopupMenuItem(
            value: 'timeline',
            child: ListTile(
              leading: Icon(Icons.timeline),
              title: Text('Timeline View'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
      PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert),
        tooltip: 'More options',
        onSelected: (value) {
          switch (value) {
            case 'settings':
              _showBoardSettings();
              break;
            case 'team':
              _showTeamView();
              break;
            case 'analytics':
              _showAnalytics();
              break;
            case 'export':
              _exportBoard();
              break;
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'settings',
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text('Board Settings'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const PopupMenuItem(
            value: 'team',
            child: ListTile(
              leading: Icon(Icons.people),
              title: Text('Team Members'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const PopupMenuItem(
            value: 'analytics',
            child: ListTile(
              leading: Icon(Icons.analytics),
              title: Text('Analytics'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const PopupMenuItem(
            value: 'export',
            child: ListTile(
              leading: Icon(Icons.download),
              title: Text('Export Board'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    ];
  }
  
  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Tasks'),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Enter task name or description...',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            ref.read(taskSearchProvider.notifier).updateSearch(value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(taskSearchProvider.notifier).clearSearch();
              Navigator.of(context).pop();
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => const FilterDialog(),
    );
  }
  
  void _showBoardSettings() {
    final boardId = ref.read(selectedBoardIdProvider);
    if (boardId != null) {
      showDialog(
        context: context,
        builder: (context) => BoardSettingsView(boardId: boardId),
      );
    }
  }
  
  void _showTeamView() {
    final boardId = ref.read(selectedBoardIdProvider);
    if (boardId != null) {
      showDialog(
        context: context,
        builder: (context) => TeamView(boardId: boardId),
      );
    }
  }
  
  void _showAnalytics() {
    final boardId = ref.read(selectedBoardIdProvider);
    if (boardId != null) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) => AnalyticsView(
            boardId: boardId,
            scrollController: scrollController,
          ),
        ),
      );
    }
  }
  
  void _exportBoard() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Board exported successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class FilterDialog extends ConsumerWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(taskFilterProvider);
    
    return AlertDialog(
      title: const Text('Filter Tasks'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Priority',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: TaskPriority.values.map((priority) {
                return FilterChip(
                  label: Text(priority.name),
                  selected: filter.priorities.contains(priority),
                  onSelected: (selected) {
                    ref.read(taskFilterProvider.notifier).togglePriority(priority);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Status',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: TaskStatus.values.map((status) {
                return FilterChip(
                  label: Text(status.name),
                  selected: filter.statuses.contains(status),
                  onSelected: (selected) {
                    ref.read(taskFilterProvider.notifier).toggleStatus(status);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Show archived tasks'),
              value: filter.showArchived,
              onChanged: (value) {
                ref.read(taskFilterProvider.notifier).toggleShowArchived();
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            ref.read(taskFilterProvider.notifier).clearFilter();
          },
          child: const Text('Clear All'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}