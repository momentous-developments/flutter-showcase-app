import 'dart:math';
import '../models/simple_models.dart';

class KanbanService {
  // Mock data storage
  final List<Board> _boards = [];
  final Map<String, List<BoardColumn>> _boardColumns = {};
  final Map<String, List<TeamMember>> _boardMembers = {};
  final Map<String, List<Activity>> _boardActivities = {};
  final List<TaskLabel> _labels = [];
  
  KanbanService() {
    _initializeMockData();
  }
  
  void _initializeMockData() {
    // Create mock boards
    final board1 = Board(
      id: 'board1',
      title: 'Product Development',
      description: 'Main product development board',
      ownerId: 'user1',
      memberIds: ['user1', 'user2', 'user3', 'user4'],
      columns: [],
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
      taskCount: 15,
      completedTaskCount: 5,
    );
    
    final board2 = Board(
      id: 'board2',
      title: 'Marketing Campaign',
      description: 'Q4 Marketing initiatives',
      ownerId: 'user2',
      memberIds: ['user2', 'user3', 'user5'],
      columns: [],
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now(),
      taskCount: 8,
      completedTaskCount: 2,
    );
    
    _boards.addAll([board1, board2]);
    
    // Create columns for board1
    final board1Columns = [
      BoardColumn(
        id: 'col1',
        boardId: 'board1',
        title: 'Backlog',
        position: 0,
        tasks: _generateTasks('board1', 'col1', 5),
        color: '#E3F2FD',
      ),
      BoardColumn(
        id: 'col2',
        boardId: 'board1',
        title: 'To Do',
        position: 1,
        tasks: _generateTasks('board1', 'col2', 3),
        taskLimit: 5,
        color: '#F3E5F5',
      ),
      BoardColumn(
        id: 'col3',
        boardId: 'board1',
        title: 'In Progress',
        position: 2,
        tasks: _generateTasks('board1', 'col3', 4),
        taskLimit: 3,
        color: '#FFF3E0',
      ),
      BoardColumn(
        id: 'col4',
        boardId: 'board1',
        title: 'Review',
        position: 3,
        tasks: _generateTasks('board1', 'col4', 2),
        color: '#E8F5E9',
      ),
      BoardColumn(
        id: 'col5',
        boardId: 'board1',
        title: 'Done',
        position: 4,
        tasks: _generateTasks('board1', 'col5', 5, isDone: true),
        color: '#E0F2F1',
      ),
    ];
    
    _boardColumns['board1'] = board1Columns;
    
    // Create columns for board2
    final board2Columns = [
      BoardColumn(
        id: 'col6',
        boardId: 'board2',
        title: 'Ideas',
        position: 0,
        tasks: _generateTasks('board2', 'col6', 3),
      ),
      BoardColumn(
        id: 'col7',
        boardId: 'board2',
        title: 'Planning',
        position: 1,
        tasks: _generateTasks('board2', 'col7', 2),
      ),
      BoardColumn(
        id: 'col8',
        boardId: 'board2',
        title: 'Execution',
        position: 2,
        tasks: _generateTasks('board2', 'col8', 2),
      ),
      BoardColumn(
        id: 'col9',
        boardId: 'board2',
        title: 'Completed',
        position: 3,
        tasks: _generateTasks('board2', 'col9', 1, isDone: true),
      ),
    ];
    
    _boardColumns['board2'] = board2Columns;
    
    // Create team members
    _boardMembers['board1'] = _generateTeamMembers('board1', 4);
    _boardMembers['board2'] = _generateTeamMembers('board2', 3);
    
    // Create labels
    _labels.addAll([
      TaskLabel(id: 'label1', name: 'Bug', color: '#F44336', boardId: 'board1'),
      TaskLabel(id: 'label2', name: 'Feature', color: '#4CAF50', boardId: 'board1'),
      TaskLabel(id: 'label3', name: 'Enhancement', color: '#2196F3', boardId: 'board1'),
      TaskLabel(id: 'label4', name: 'Documentation', color: '#FF9800', boardId: 'board1'),
      TaskLabel(id: 'label5', name: 'High Priority', color: '#E91E63', boardId: 'board1'),
    ]);
    
    // Generate activities
    _boardActivities['board1'] = _generateActivities('board1', 20);
    _boardActivities['board2'] = _generateActivities('board2', 10);
  }
  
  List<Task> _generateTasks(String boardId, String columnId, int count, {bool isDone = false}) {
    final random = Random();
    final tasks = <Task>[];
    final taskTitles = [
      'Implement user authentication',
      'Design dashboard UI',
      'Fix navigation bug',
      'Add data export feature',
      'Update documentation',
      'Optimize database queries',
      'Create API endpoints',
      'Write unit tests',
      'Review code changes',
      'Deploy to production',
      'Setup CI/CD pipeline',
      'Migrate to new framework',
      'Implement search functionality',
      'Add dark mode support',
      'Fix responsive layout issues',
    ];
    
    for (int i = 0; i < count; i++) {
      final hasAssignee = random.nextBool();
      final hasDueDate = random.nextBool();
      final hasLabels = random.nextBool();
      final hasComments = random.nextBool();
      final hasChecklist = random.nextBool();
      
      tasks.add(Task(
        id: 'task_${columnId}_$i',
        boardId: boardId,
        columnId: columnId,
        title: taskTitles[random.nextInt(taskTitles.length)],
        description: 'This is a detailed description of the task that needs to be completed.',
        position: i,
        createdAt: DateTime.now().subtract(Duration(days: random.nextInt(30))),
        updatedAt: DateTime.now().subtract(Duration(hours: random.nextInt(48))),
        dueDate: hasDueDate ? DateTime.now().add(Duration(days: random.nextInt(14))) : null,
        priority: TaskPriority.values[random.nextInt(TaskPriority.values.length)],
        status: isDone ? TaskStatus.done : TaskStatus.values[random.nextInt(TaskStatus.values.length - 1)],
        assigneeIds: hasAssignee ? ['user${random.nextInt(4) + 1}'] : [],
        labelIds: hasLabels ? ['label${random.nextInt(5) + 1}'] : [],
        comments: hasComments ? _generateComments('task_${columnId}_$i', random.nextInt(3) + 1) : [],
        checklists: hasChecklist ? [_generateChecklist('task_${columnId}_$i')] : [],
        progress: isDone ? 1.0 : random.nextDouble(),
        timeSpent: random.nextInt(480),
        estimatedTime: random.nextInt(480) + 60,
      ));
    }
    
    return tasks;
  }
  
  List<Comment> _generateComments(String taskId, int count) {
    final comments = <Comment>[];
    for (int i = 0; i < count; i++) {
      comments.add(Comment(
        id: 'comment_${taskId}_$i',
        taskId: taskId,
        userId: 'user${Random().nextInt(4) + 1}',
        content: 'This is a comment on the task. Great work so far!',
        createdAt: DateTime.now().subtract(Duration(hours: Random().nextInt(48))),
      ));
    }
    return comments;
  }
  
  TaskChecklist _generateChecklist(String taskId) {
    return TaskChecklist(
      id: 'checklist_$taskId',
      taskId: taskId,
      title: 'Task Checklist',
      items: [
        ChecklistItem(
          id: 'item1',
          title: 'Review requirements',
          isCompleted: true,
          completedAt: DateTime.now().subtract(const Duration(days: 1)),
          position: 0,
        ),
        ChecklistItem(
          id: 'item2',
          title: 'Implement feature',
          isCompleted: true,
          completedAt: DateTime.now().subtract(const Duration(hours: 6)),
          position: 1,
        ),
        ChecklistItem(
          id: 'item3',
          title: 'Write tests',
          isCompleted: false,
          position: 2,
        ),
        ChecklistItem(
          id: 'item4',
          title: 'Update documentation',
          isCompleted: false,
          position: 3,
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    );
  }
  
  List<TeamMember> _generateTeamMembers(String boardId, int count) {
    final members = <TeamMember>[];
    final names = ['John Doe', 'Jane Smith', 'Mike Johnson', 'Sarah Williams', 'Tom Brown'];
    final avatars = [
      'https://i.pravatar.cc/150?img=1',
      'https://i.pravatar.cc/150?img=2',
      'https://i.pravatar.cc/150?img=3',
      'https://i.pravatar.cc/150?img=4',
      'https://i.pravatar.cc/150?img=5',
    ];
    
    for (int i = 0; i < count; i++) {
      members.add(TeamMember(
        id: 'member_${boardId}_$i',
        userId: 'user${i + 1}',
        boardId: boardId,
        name: names[i],
        email: '${names[i].toLowerCase().replaceAll(' ', '.')}@example.com',
        avatarUrl: avatars[i],
        role: i == 0 ? BoardRole.owner : BoardRole.values[Random().nextInt(BoardRole.values.length - 1) + 1],
        joinedAt: DateTime.now().subtract(Duration(days: Random().nextInt(30))),
        tasksAssigned: Random().nextInt(10),
        tasksCompleted: Random().nextInt(5),
        lastActiveAt: DateTime.now().subtract(Duration(hours: Random().nextInt(24))),
      ));
    }
    
    return members;
  }
  
  List<Activity> _generateActivities(String boardId, int count) {
    final activities = <Activity>[];
    final random = Random();
    
    for (int i = 0; i < count; i++) {
      activities.add(Activity(
        id: 'activity_${boardId}_$i',
        boardId: boardId,
        userId: 'user${random.nextInt(4) + 1}',
        type: ActivityType.values[random.nextInt(ActivityType.values.length)],
        description: _getActivityDescription(ActivityType.values[random.nextInt(ActivityType.values.length)]),
        createdAt: DateTime.now().subtract(Duration(hours: i * 2)),
      ));
    }
    
    return activities;
  }
  
  String _getActivityDescription(ActivityType type) {
    switch (type) {
      case ActivityType.taskCreated:
        return 'created a new task';
      case ActivityType.taskUpdated:
        return 'updated task details';
      case ActivityType.taskMoved:
        return 'moved task to another column';
      case ActivityType.taskCompleted:
        return 'marked task as completed';
      case ActivityType.commentAdded:
        return 'added a comment';
      case ActivityType.memberAdded:
        return 'joined the board';
      default:
        return 'performed an action';
    }
  }
  
  // API Methods
  Future<List<Board>> getBoards() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _boards;
  }
  
  Future<Board> getBoard(String boardId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _boards.firstWhere((b) => b.id == boardId);
  }
  
  Future<Board> createBoard(Board board) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final newBoard = board.copyWith(
      id: 'board${_boards.length + 1}',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _boards.add(newBoard);
    _boardColumns[newBoard.id] = [];
    _boardMembers[newBoard.id] = [];
    _boardActivities[newBoard.id] = [];
    return newBoard;
  }
  
  Future<Board> updateBoard(String boardId, Board board) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _boards.indexWhere((b) => b.id == boardId);
    if (index != -1) {
      _boards[index] = board.copyWith(updatedAt: DateTime.now());
      return _boards[index];
    }
    throw Exception('Board not found');
  }
  
  Future<void> deleteBoard(String boardId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _boards.removeWhere((b) => b.id == boardId);
    _boardColumns.remove(boardId);
    _boardMembers.remove(boardId);
    _boardActivities.remove(boardId);
  }
  
  Future<List<BoardColumn>> getColumns(String boardId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _boardColumns[boardId] ?? [];
  }
  
  Future<BoardColumn> createColumn(String boardId, BoardColumn column) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final columns = _boardColumns[boardId] ?? [];
    final newColumn = column.copyWith(
      id: 'col${DateTime.now().millisecondsSinceEpoch}',
      boardId: boardId,
      position: columns.length,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    columns.add(newColumn);
    _boardColumns[boardId] = columns;
    return newColumn;
  }
  
  Future<BoardColumn> updateColumn(String boardId, String columnId, ColumnUpdate update) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final columns = _boardColumns[boardId] ?? [];
    final index = columns.indexWhere((c) => c.id == columnId);
    if (index != -1) {
      final column = columns[index];
      columns[index] = column.copyWith(
        title: update.title ?? column.title,
        position: update.position ?? column.position,
        taskLimit: update.taskLimit ?? column.taskLimit,
        color: update.color ?? column.color,
        isCollapsed: update.isCollapsed ?? column.isCollapsed,
        updatedAt: DateTime.now(),
      );
      return columns[index];
    }
    throw Exception('Column not found');
  }
  
  Future<void> deleteColumn(String boardId, String columnId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final columns = _boardColumns[boardId] ?? [];
    columns.removeWhere((c) => c.id == columnId);
    _boardColumns[boardId] = columns;
  }
  
  Future<void> reorderColumns(String boardId, List<String> columnIds) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final columns = _boardColumns[boardId] ?? [];
    final Map<String, BoardColumn> columnMap = {
      for (var col in columns) col.id: col
    };
    _boardColumns[boardId] = columnIds
        .asMap()
        .entries
        .map((entry) => columnMap[entry.value]!.copyWith(position: entry.key))
        .toList();
  }
  
  Future<List<Task>> getTasksByColumn(String columnId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    for (final columns in _boardColumns.values) {
      final column = columns.firstWhere((c) => c.id == columnId, orElse: () => BoardColumn(id: '', boardId: '', title: '', position: 0));
      if (column.id.isNotEmpty) {
        return column.tasks;
      }
    }
    return [];
  }
  
  Future<Task> createTask(Task task) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final newTask = task.copyWith(
      id: 'task${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    // Add task to column
    for (final columns in _boardColumns.values) {
      final columnIndex = columns.indexWhere((c) => c.id == task.columnId);
      if (columnIndex != -1) {
        final tasks = [...columns[columnIndex].tasks, newTask];
        columns[columnIndex] = columns[columnIndex].copyWith(tasks: tasks);
        break;
      }
    }
    
    return newTask;
  }
  
  Future<Task> updateTask(String taskId, Task task) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Update task in column
    for (final columns in _boardColumns.values) {
      for (int i = 0; i < columns.length; i++) {
        final taskIndex = columns[i].tasks.indexWhere((t) => t.id == taskId);
        if (taskIndex != -1) {
          final tasks = [...columns[i].tasks];
          tasks[taskIndex] = task.copyWith(updatedAt: DateTime.now());
          columns[i] = columns[i].copyWith(tasks: tasks);
          return tasks[taskIndex];
        }
      }
    }
    throw Exception('Task not found');
  }
  
  Future<void> deleteTask(String taskId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Remove task from column
    for (final columns in _boardColumns.values) {
      for (int i = 0; i < columns.length; i++) {
        final tasks = columns[i].tasks.where((t) => t.id != taskId).toList();
        if (tasks.length < columns[i].tasks.length) {
          columns[i] = columns[i].copyWith(tasks: tasks);
          return;
        }
      }
    }
  }
  
  Future<void> reorderTasks(String columnId, List<String> taskIds) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Reorder tasks in column
    for (final columns in _boardColumns.values) {
      final columnIndex = columns.indexWhere((c) => c.id == columnId);
      if (columnIndex != -1) {
        final Map<String, Task> taskMap = {
          for (var task in columns[columnIndex].tasks) task.id: task
        };
        final reorderedTasks = taskIds
            .asMap()
            .entries
            .map((entry) => taskMap[entry.value]!.copyWith(position: entry.key))
            .toList();
        columns[columnIndex] = columns[columnIndex].copyWith(tasks: reorderedTasks);
        break;
      }
    }
  }
  
  Future<void> moveTask(String taskId, String fromColumnId, String toColumnId, int position) async {
    await Future.delayed(const Duration(milliseconds: 300));
    Task? taskToMove;
    
    // Find and remove task from source column
    for (final columns in _boardColumns.values) {
      final fromColumnIndex = columns.indexWhere((c) => c.id == fromColumnId);
      if (fromColumnIndex != -1) {
        final taskIndex = columns[fromColumnIndex].tasks.indexWhere((t) => t.id == taskId);
        if (taskIndex != -1) {
          taskToMove = columns[fromColumnIndex].tasks[taskIndex];
          final tasks = [...columns[fromColumnIndex].tasks];
          tasks.removeAt(taskIndex);
          columns[fromColumnIndex] = columns[fromColumnIndex].copyWith(tasks: tasks);
          break;
        }
      }
    }
    
    // Add task to destination column
    if (taskToMove != null) {
      for (final columns in _boardColumns.values) {
        final toColumnIndex = columns.indexWhere((c) => c.id == toColumnId);
        if (toColumnIndex != -1) {
          final tasks = [...columns[toColumnIndex].tasks];
          final updatedTask = taskToMove.copyWith(
            columnId: toColumnId,
            position: position,
            updatedAt: DateTime.now(),
          );
          tasks.insert(position, updatedTask);
          
          // Update positions
          for (int i = 0; i < tasks.length; i++) {
            tasks[i] = tasks[i].copyWith(position: i);
          }
          
          columns[toColumnIndex] = columns[toColumnIndex].copyWith(tasks: tasks);
          break;
        }
      }
    }
  }
  
  Future<List<TeamMember>> getBoardMembers(String boardId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _boardMembers[boardId] ?? [];
  }
  
  Future<TeamMember> addBoardMember(String boardId, TeamMember member) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final members = _boardMembers[boardId] ?? [];
    final newMember = member.copyWith(
      id: 'member${DateTime.now().millisecondsSinceEpoch}',
      joinedAt: DateTime.now(),
    );
    members.add(newMember);
    _boardMembers[boardId] = members;
    return newMember;
  }
  
  Future<void> removeBoardMember(String boardId, String memberId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final members = _boardMembers[boardId] ?? [];
    members.removeWhere((m) => m.id == memberId);
    _boardMembers[boardId] = members;
  }
  
  Future<TeamMember> updateBoardMemberRole(String boardId, String memberId, BoardRole role) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final members = _boardMembers[boardId] ?? [];
    final index = members.indexWhere((m) => m.id == memberId);
    if (index != -1) {
      members[index] = members[index].copyWith(role: role);
      return members[index];
    }
    throw Exception('Member not found');
  }
  
  Future<List<Activity>> getBoardActivities(String boardId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _boardActivities[boardId] ?? [];
  }
  
  Future<List<TaskLabel>> getBoardLabels(String boardId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _labels.where((l) => l.boardId == boardId).toList();
  }
  
  Future<TaskLabel> createLabel(TaskLabel label) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final newLabel = label.copyWith(
      id: 'label${DateTime.now().millisecondsSinceEpoch}',
    );
    _labels.add(newLabel);
    return newLabel;
  }
  
  Future<void> deleteLabel(String labelId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _labels.removeWhere((l) => l.id == labelId);
  }
}