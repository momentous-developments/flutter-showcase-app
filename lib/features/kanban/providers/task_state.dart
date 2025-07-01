import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/simple_models.dart';
import '../services/kanban_service.dart';

class TaskListNotifier extends StateNotifier<AsyncValue<List<Task>>> {
  final KanbanService _service;
  final String columnId;
  
  TaskListNotifier(this._service, this.columnId) : super(const AsyncValue.loading()) {
    loadTasks();
  }
  
  Future<void> loadTasks() async {
    state = const AsyncValue.loading();
    try {
      final tasks = await _service.getTasksByColumn(columnId);
      state = AsyncValue.data(tasks);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
  
  Future<void> createTask(Task task) async {
    try {
      final newTask = await _service.createTask(task);
      state = state.whenData((tasks) => [...tasks, newTask]);
    } catch (e) {
      // Handle error
    }
  }
  
  Future<void> updateTask(String taskId, Task task) async {
    try {
      final updatedTask = await _service.updateTask(taskId, task);
      state = state.whenData((tasks) {
        return tasks.map((t) => t.id == taskId ? updatedTask : t).toList();
      });
    } catch (e) {
      // Handle error
    }
  }
  
  Future<void> deleteTask(String taskId) async {
    try {
      await _service.deleteTask(taskId);
      state = state.whenData((tasks) {
        return tasks.where((t) => t.id != taskId).toList();
      });
    } catch (e) {
      // Handle error
    }
  }
  
  Future<void> reorderTasks(List<String> taskIds) async {
    try {
      await _service.reorderTasks(columnId, taskIds);
      state = state.whenData((tasks) {
        final Map<String, Task> taskMap = {
          for (var task in tasks) task.id: task
        };
        return taskIds.map((id) => taskMap[id]!).toList();
      });
    } catch (e) {
      // Handle error
    }
  }
}

class SelectedTaskNotifier extends StateNotifier<Task?> {
  SelectedTaskNotifier() : super(null);
  
  void selectTask(Task task) {
    state = task;
  }
  
  void clearSelection() {
    state = null;
  }
  
  void updateSelectedTask(Task task) {
    if (state?.id == task.id) {
      state = task;
    }
  }
}

class TaskSearchNotifier extends StateNotifier<String> {
  TaskSearchNotifier() : super('');
  
  void updateSearch(String query) {
    state = query;
  }
  
  void clearSearch() {
    state = '';
  }
}

class TaskFilter {
  final Set<String> assigneeIds;
  final Set<String> labelIds;
  final Set<TaskPriority> priorities;
  final Set<TaskStatus> statuses;
  final DateTime? dueDateFrom;
  final DateTime? dueDateTo;
  final bool showArchived;
  
  TaskFilter({
    this.assigneeIds = const {},
    this.labelIds = const {},
    this.priorities = const {},
    this.statuses = const {},
    this.dueDateFrom,
    this.dueDateTo,
    this.showArchived = false,
  });
  
  TaskFilter copyWith({
    Set<String>? assigneeIds,
    Set<String>? labelIds,
    Set<TaskPriority>? priorities,
    Set<TaskStatus>? statuses,
    DateTime? dueDateFrom,
    DateTime? dueDateTo,
    bool? showArchived,
  }) {
    return TaskFilter(
      assigneeIds: assigneeIds ?? this.assigneeIds,
      labelIds: labelIds ?? this.labelIds,
      priorities: priorities ?? this.priorities,
      statuses: statuses ?? this.statuses,
      dueDateFrom: dueDateFrom ?? this.dueDateFrom,
      dueDateTo: dueDateTo ?? this.dueDateTo,
      showArchived: showArchived ?? this.showArchived,
    );
  }
  
  bool matches(Task task) {
    if (!showArchived && task.isArchived) return false;
    if (assigneeIds.isNotEmpty && !task.assigneeIds.any((id) => assigneeIds.contains(id))) return false;
    if (labelIds.isNotEmpty && !task.labelIds.any((id) => labelIds.contains(id))) return false;
    if (priorities.isNotEmpty && !priorities.contains(task.priority)) return false;
    if (statuses.isNotEmpty && !statuses.contains(task.status)) return false;
    if (dueDateFrom != null && task.dueDate != null && task.dueDate!.isBefore(dueDateFrom!)) return false;
    if (dueDateTo != null && task.dueDate != null && task.dueDate!.isAfter(dueDateTo!)) return false;
    return true;
  }
}

class TaskFilterNotifier extends StateNotifier<TaskFilter> {
  TaskFilterNotifier() : super(TaskFilter());
  
  void updateFilter(TaskFilter filter) {
    state = filter;
  }
  
  void clearFilter() {
    state = TaskFilter();
  }
  
  void toggleAssignee(String assigneeId) {
    final newAssignees = Set<String>.from(state.assigneeIds);
    if (newAssignees.contains(assigneeId)) {
      newAssignees.remove(assigneeId);
    } else {
      newAssignees.add(assigneeId);
    }
    state = state.copyWith(assigneeIds: newAssignees);
  }
  
  void toggleLabel(String labelId) {
    final newLabels = Set<String>.from(state.labelIds);
    if (newLabels.contains(labelId)) {
      newLabels.remove(labelId);
    } else {
      newLabels.add(labelId);
    }
    state = state.copyWith(labelIds: newLabels);
  }
  
  void togglePriority(TaskPriority priority) {
    final newPriorities = Set<TaskPriority>.from(state.priorities);
    if (newPriorities.contains(priority)) {
      newPriorities.remove(priority);
    } else {
      newPriorities.add(priority);
    }
    state = state.copyWith(priorities: newPriorities);
  }
  
  void toggleStatus(TaskStatus status) {
    final newStatuses = Set<TaskStatus>.from(state.statuses);
    if (newStatuses.contains(status)) {
      newStatuses.remove(status);
    } else {
      newStatuses.add(status);
    }
    state = state.copyWith(statuses: newStatuses);
  }
  
  void setDateRange(DateTime? from, DateTime? to) {
    state = state.copyWith(dueDateFrom: from, dueDateTo: to);
  }
  
  void toggleShowArchived() {
    state = state.copyWith(showArchived: !state.showArchived);
  }
}