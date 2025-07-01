import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/simple_models.dart';
import '../services/kanban_service.dart';

class BoardListNotifier extends StateNotifier<AsyncValue<List<Board>>> {
  final KanbanService _service;
  
  BoardListNotifier(this._service) : super(const AsyncValue.loading()) {
    loadBoards();
  }
  
  Future<void> loadBoards() async {
    state = const AsyncValue.loading();
    try {
      final boards = await _service.getBoards();
      state = AsyncValue.data(boards);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
  
  Future<void> createBoard(Board board) async {
    try {
      final newBoard = await _service.createBoard(board);
      state = state.whenData((boards) => [...boards, newBoard]);
    } catch (e) {
      // Handle error
    }
  }
  
  Future<void> updateBoard(String boardId, Board board) async {
    try {
      final updatedBoard = await _service.updateBoard(boardId, board);
      state = state.whenData((boards) {
        return boards.map((b) => b.id == boardId ? updatedBoard : b).toList();
      });
    } catch (e) {
      // Handle error
    }
  }
  
  Future<void> deleteBoard(String boardId) async {
    try {
      await _service.deleteBoard(boardId);
      state = state.whenData((boards) {
        return boards.where((b) => b.id != boardId).toList();
      });
    } catch (e) {
      // Handle error
    }
  }
}

class CurrentBoardNotifier extends StateNotifier<AsyncValue<Board?>> {
  final KanbanService _service;
  
  CurrentBoardNotifier(this._service) : super(const AsyncValue.data(null));
  
  Future<void> loadBoard(String boardId) async {
    state = const AsyncValue.loading();
    try {
      final board = await _service.getBoard(boardId);
      state = AsyncValue.data(board);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
  
  void clearBoard() {
    state = const AsyncValue.data(null);
  }
  
  void updateBoard(Board board) {
    state = AsyncValue.data(board);
  }
}

class ColumnListNotifier extends StateNotifier<AsyncValue<List<BoardColumn>>> {
  final KanbanService _service;
  final String boardId;
  
  ColumnListNotifier(this._service, this.boardId) : super(const AsyncValue.loading()) {
    loadColumns();
  }
  
  Future<void> loadColumns() async {
    state = const AsyncValue.loading();
    try {
      final columns = await _service.getColumns(boardId);
      state = AsyncValue.data(columns);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
  
  Future<void> createColumn(BoardColumn column) async {
    try {
      final newColumn = await _service.createColumn(boardId, column);
      state = state.whenData((columns) => [...columns, newColumn]);
    } catch (e) {
      // Handle error
    }
  }
  
  Future<void> updateColumn(String columnId, ColumnUpdate update) async {
    try {
      final updatedColumn = await _service.updateColumn(boardId, columnId, update);
      state = state.whenData((columns) {
        return columns.map((c) => c.id == columnId ? updatedColumn : c).toList();
      });
    } catch (e) {
      // Handle error
    }
  }
  
  Future<void> deleteColumn(String columnId) async {
    try {
      await _service.deleteColumn(boardId, columnId);
      state = state.whenData((columns) {
        return columns.where((c) => c.id != columnId).toList();
      });
    } catch (e) {
      // Handle error
    }
  }
  
  Future<void> reorderColumns(List<String> columnIds) async {
    try {
      await _service.reorderColumns(boardId, columnIds);
      state = state.whenData((columns) {
        final Map<String, BoardColumn> columnMap = {
          for (var col in columns) col.id: col
        };
        return columnIds.map((id) => columnMap[id]!).toList();
      });
    } catch (e) {
      // Handle error
    }
  }
  
  void moveTaskBetweenColumns(String taskId, String fromColumnId, String toColumnId, int newPosition) {
    state = state.whenData((columns) {
      return columns.map((column) {
        if (column.id == fromColumnId) {
          return column.copyWith(
            tasks: column.tasks.where((t) => t.id != taskId).toList(),
          );
        } else if (column.id == toColumnId) {
          final fromColumn = columns.firstWhere((c) => c.id == fromColumnId);
          final task = fromColumn.tasks.firstWhere((t) => t.id == taskId);
          final updatedTask = task.copyWith(columnId: toColumnId, position: newPosition);
          final newTasks = [...column.tasks];
          newTasks.insert(newPosition, updatedTask);
          // Update positions
          for (int i = 0; i < newTasks.length; i++) {
            newTasks[i] = newTasks[i].copyWith(position: i);
          }
          return column.copyWith(tasks: newTasks);
        }
        return column;
      }).toList();
    });
  }
}

class ActivityListNotifier extends StateNotifier<AsyncValue<List<Activity>>> {
  final KanbanService _service;
  final String boardId;
  
  ActivityListNotifier(this._service, this.boardId) : super(const AsyncValue.loading()) {
    loadActivities();
  }
  
  Future<void> loadActivities() async {
    state = const AsyncValue.loading();
    try {
      final activities = await _service.getBoardActivities(boardId);
      state = AsyncValue.data(activities);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
  
  void addActivity(Activity activity) {
    state = state.whenData((activities) => [activity, ...activities]);
  }
}

class TeamMemberListNotifier extends StateNotifier<AsyncValue<List<TeamMember>>> {
  final KanbanService _service;
  final String boardId;
  
  TeamMemberListNotifier(this._service, this.boardId) : super(const AsyncValue.loading()) {
    loadMembers();
  }
  
  Future<void> loadMembers() async {
    state = const AsyncValue.loading();
    try {
      final members = await _service.getBoardMembers(boardId);
      state = AsyncValue.data(members);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
  
  Future<void> addMember(TeamMember member) async {
    try {
      final newMember = await _service.addBoardMember(boardId, member);
      state = state.whenData((members) => [...members, newMember]);
    } catch (e) {
      // Handle error
    }
  }
  
  Future<void> removeMember(String memberId) async {
    try {
      await _service.removeBoardMember(boardId, memberId);
      state = state.whenData((members) {
        return members.where((m) => m.id != memberId).toList();
      });
    } catch (e) {
      // Handle error
    }
  }
  
  Future<void> updateMemberRole(String memberId, BoardRole role) async {
    try {
      final updatedMember = await _service.updateBoardMemberRole(boardId, memberId, role);
      state = state.whenData((members) {
        return members.map((m) => m.id == memberId ? updatedMember : m).toList();
      });
    } catch (e) {
      // Handle error
    }
  }
}