import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/simple_models.dart';
import '../services/kanban_service.dart';
import 'board_state.dart';
import 'task_state.dart';

// Service Provider
final kanbanServiceProvider = Provider<KanbanService>((ref) {
  return KanbanService();
});

// Board Providers
final boardListProvider = StateNotifierProvider<BoardListNotifier, AsyncValue<List<Board>>>((ref) {
  return BoardListNotifier(ref.watch(kanbanServiceProvider));
});

final currentBoardProvider = StateNotifierProvider<CurrentBoardNotifier, AsyncValue<Board?>>((ref) {
  return CurrentBoardNotifier(ref.watch(kanbanServiceProvider));
});

final boardActivitiesProvider = StateNotifierProvider.family<ActivityListNotifier, AsyncValue<List<Activity>>, String>((ref, boardId) {
  return ActivityListNotifier(ref.watch(kanbanServiceProvider), boardId);
});

// Column Providers
final boardColumnsProvider = StateNotifierProvider.family<ColumnListNotifier, AsyncValue<List<BoardColumn>>, String>((ref, boardId) {
  return ColumnListNotifier(ref.watch(kanbanServiceProvider), boardId);
});

// Task Providers
final tasksByColumnProvider = StateNotifierProvider.family<TaskListNotifier, AsyncValue<List<Task>>, String>((ref, columnId) {
  return TaskListNotifier(ref.watch(kanbanServiceProvider), columnId);
});

final selectedTaskProvider = StateNotifierProvider<SelectedTaskNotifier, Task?>((ref) {
  return SelectedTaskNotifier();
});

final taskSearchProvider = StateNotifierProvider<TaskSearchNotifier, String>((ref) {
  return TaskSearchNotifier();
});

final taskFilterProvider = StateNotifierProvider<TaskFilterNotifier, TaskFilter>((ref) {
  return TaskFilterNotifier();
});

// Team Providers
final boardMembersProvider = StateNotifierProvider.family<TeamMemberListNotifier, AsyncValue<List<TeamMember>>, String>((ref, boardId) {
  return TeamMemberListNotifier(ref.watch(kanbanServiceProvider), boardId);
});

// UI State Providers
final draggedTaskProvider = StateProvider<Task?>((ref) => null);
final hoveredColumnProvider = StateProvider<String?>((ref) => null);
final selectedBoardIdProvider = StateProvider<String?>((ref) => null);
final boardViewTypeProvider = StateProvider<BoardViewType>((ref) => BoardViewType.board);

// Analytics Providers
final boardAnalyticsProvider = Provider.family<BoardAnalytics, String>((ref, boardId) {
  final board = ref.watch(currentBoardProvider).value;
  final columns = ref.watch(boardColumnsProvider(boardId)).value ?? [];
  final activities = ref.watch(boardActivitiesProvider(boardId)).value ?? [];
  
  int totalTasks = 0;
  int completedTasks = 0;
  int overdueTasks = 0;
  
  for (final column in columns) {
    totalTasks += column.tasks.length;
    for (final task in column.tasks) {
      if (task.status == TaskStatus.done) {
        completedTasks++;
      }
      if (task.dueDate != null && task.dueDate!.isBefore(DateTime.now()) && task.status != TaskStatus.done) {
        overdueTasks++;
      }
    }
  }
  
  return BoardAnalytics(
    totalTasks: totalTasks,
    completedTasks: completedTasks,
    overdueTasks: overdueTasks,
    completionRate: totalTasks > 0 ? completedTasks / totalTasks : 0,
    recentActivities: activities.take(10).toList(),
  );
});

// Enums
enum BoardViewType { board, list, calendar, timeline }

// Analytics Model
class BoardAnalytics {
  final int totalTasks;
  final int completedTasks;
  final int overdueTasks;
  final double completionRate;
  final List<Activity> recentActivities;
  
  BoardAnalytics({
    required this.totalTasks,
    required this.completedTasks,
    required this.overdueTasks,
    required this.completionRate,
    required this.recentActivities,
  });
}