import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/kanban_providers.dart';
import '../models/simple_models.dart';
import '../widgets/kanban_column.dart';
import '../widgets/add_column_button.dart';

class BoardView extends ConsumerStatefulWidget {
  const BoardView({super.key});

  @override
  ConsumerState<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends ConsumerState<BoardView> {
  final ScrollController _scrollController = ScrollController();
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final selectedBoardId = ref.watch(selectedBoardIdProvider);
    final viewType = ref.watch(boardViewTypeProvider);
    
    if (selectedBoardId == null) {
      return const Center(child: Text('No board selected'));
    }
    
    switch (viewType) {
      case BoardViewType.board:
        return _buildBoardView(selectedBoardId);
      case BoardViewType.list:
        return _buildListView(selectedBoardId);
      case BoardViewType.calendar:
        return _buildCalendarView(selectedBoardId);
      case BoardViewType.timeline:
        return _buildTimelineView(selectedBoardId);
    }
  }
  
  Widget _buildBoardView(String boardId) {
    final columnsAsync = ref.watch(boardColumnsProvider(boardId));
    final boardAsync = ref.watch(currentBoardProvider);
    
    return Column(
      children: [
        // Board header
        boardAsync.when(
          data: (board) => board != null
              ? Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          ref.read(selectedBoardIdProvider.notifier).state = null;
                          ref.read(currentBoardProvider.notifier).clearBoard();
                        },
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              board.title,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            if (board.description != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                board.description!,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      _buildBoardStats(board),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          loading: () => const LinearProgressIndicator(),
          error: (_, __) => const SizedBox.shrink(),
        ),
        
        // Columns
        Expanded(
          child: columnsAsync.when(
            data: (columns) => DragTarget<Task>(
              onWillAccept: (task) => true,
              onAcceptWithDetails: (details) {
                // Handle task drop on empty space (could create new column)
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...columns.map((column) => Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: KanbanColumn(
                            column: column,
                            onColumnUpdate: (update) {
                              ref.read(boardColumnsProvider(boardId).notifier)
                                  .updateColumn(column.id, update);
                            },
                            onColumnDelete: () {
                              _confirmDeleteColumn(context, boardId, column);
                            },
                            onTaskMove: (taskId, fromColumnId, toColumnId, position) {
                              ref.read(boardColumnsProvider(boardId).notifier)
                                  .moveTaskBetweenColumns(taskId, fromColumnId, toColumnId, position);
                              _moveTaskOnServer(taskId, fromColumnId, toColumnId, position);
                            },
                          ),
                        )),
                        AddColumnButton(
                          onAdd: (title) {
                            _addColumn(boardId, title);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text('Error loading columns: $error'),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildBoardStats(Board board) {
    return Row(
      children: [
        _buildStatChip(
          icon: Icons.list_alt,
          label: '${board.taskCount}',
          tooltip: 'Total tasks',
        ),
        const SizedBox(width: 8),
        _buildStatChip(
          icon: Icons.check_circle,
          label: '${board.completedTaskCount}',
          tooltip: 'Completed tasks',
          color: Colors.green,
        ),
        const SizedBox(width: 8),
        _buildStatChip(
          icon: Icons.people,
          label: '${board.memberIds.length}',
          tooltip: 'Team members',
        ),
      ],
    );
  }
  
  Widget _buildStatChip({
    required IconData icon,
    required String label,
    required String tooltip,
    Color? color,
  }) {
    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: (color ?? Theme.of(context).colorScheme.primary).withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: color ?? Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color ?? Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildListView(String boardId) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.list,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'List View',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          const Text('List view is coming soon'),
        ],
      ),
    );
  }
  
  Widget _buildCalendarView(String boardId) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'Calendar View',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          const Text('Calendar view is coming soon'),
        ],
      ),
    );
  }
  
  Widget _buildTimelineView(String boardId) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timeline,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'Timeline View',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          const Text('Timeline view is coming soon'),
        ],
      ),
    );
  }
  
  void _addColumn(String boardId, String title) {
    final column = BoardColumn(
      id: '',
      boardId: boardId,
      title: title,
      position: 0,
    );
    ref.read(boardColumnsProvider(boardId).notifier).createColumn(column);
  }
  
  void _confirmDeleteColumn(BuildContext context, String boardId, BoardColumn column) {
    if (column.tasks.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Column'),
          content: Text(
            'The column "${column.title}" contains ${column.tasks.length} task(s). '
            'All tasks will be permanently deleted. This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
              onPressed: () {
                ref.read(boardColumnsProvider(boardId).notifier).deleteColumn(column.id);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      );
    } else {
      ref.read(boardColumnsProvider(boardId).notifier).deleteColumn(column.id);
    }
  }
  
  void _moveTaskOnServer(String taskId, String fromColumnId, String toColumnId, int position) async {
    try {
      await ref.read(kanbanServiceProvider).moveTask(taskId, fromColumnId, toColumnId, position);
    } catch (e) {
      // Handle error - potentially revert the UI change
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to move task: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}