// Simple model implementations without freezed for quick prototyping

// Board Model
class Board {
  final String id;
  final String title;
  final String? description;
  final String ownerId;
  final List<String> memberIds;
  final List<BoardColumn> columns;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final String template;
  final Map<String, dynamic>? settings;
  final List<String> labelIds;
  final int taskCount;
  final int completedTaskCount;

  Board({
    required this.id,
    required this.title,
    this.description,
    required this.ownerId,
    required this.memberIds,
    required this.columns,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
    this.template = 'default',
    this.settings,
    this.labelIds = const [],
    this.taskCount = 0,
    this.completedTaskCount = 0,
  });

  Board copyWith({
    String? id,
    String? title,
    String? description,
    String? ownerId,
    List<String>? memberIds,
    List<BoardColumn>? columns,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    String? template,
    Map<String, dynamic>? settings,
    List<String>? labelIds,
    int? taskCount,
    int? completedTaskCount,
  }) {
    return Board(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      ownerId: ownerId ?? this.ownerId,
      memberIds: memberIds ?? this.memberIds,
      columns: columns ?? this.columns,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      template: template ?? this.template,
      settings: settings ?? this.settings,
      labelIds: labelIds ?? this.labelIds,
      taskCount: taskCount ?? this.taskCount,
      completedTaskCount: completedTaskCount ?? this.completedTaskCount,
    );
  }
}

// Board Settings
class BoardSettings {
  final bool showTaskNumbers;
  final bool allowComments;
  final bool allowAttachments;
  final bool allowSubtasks;
  final bool allowTimeTracking;
  final bool allowLabels;
  final bool allowDueDates;
  final bool showProgress;
  final String defaultView;
  final String primaryColor;
  final Map<String, bool> permissions;

  const BoardSettings({
    this.showTaskNumbers = true,
    this.allowComments = true,
    this.allowAttachments = true,
    this.allowSubtasks = true,
    this.allowTimeTracking = true,
    this.allowLabels = true,
    this.allowDueDates = true,
    this.showProgress = true,
    this.defaultView = 'list',
    this.primaryColor = '#3F51B5',
    this.permissions = const {},
  });

  BoardSettings copyWith({
    bool? showTaskNumbers,
    bool? allowComments,
    bool? allowAttachments,
    bool? allowSubtasks,
    bool? allowTimeTracking,
    bool? allowLabels,
    bool? allowDueDates,
    bool? showProgress,
    String? defaultView,
    String? primaryColor,
    Map<String, bool>? permissions,
  }) {
    return BoardSettings(
      showTaskNumbers: showTaskNumbers ?? this.showTaskNumbers,
      allowComments: allowComments ?? this.allowComments,
      allowAttachments: allowAttachments ?? this.allowAttachments,
      allowSubtasks: allowSubtasks ?? this.allowSubtasks,
      allowTimeTracking: allowTimeTracking ?? this.allowTimeTracking,
      allowLabels: allowLabels ?? this.allowLabels,
      allowDueDates: allowDueDates ?? this.allowDueDates,
      showProgress: showProgress ?? this.showProgress,
      defaultView: defaultView ?? this.defaultView,
      primaryColor: primaryColor ?? this.primaryColor,
      permissions: permissions ?? this.permissions,
    );
  }

  Map<String, dynamic> toJson() => {
    'showTaskNumbers': showTaskNumbers,
    'allowComments': allowComments,
    'allowAttachments': allowAttachments,
    'allowSubtasks': allowSubtasks,
    'allowTimeTracking': allowTimeTracking,
    'allowLabels': allowLabels,
    'allowDueDates': allowDueDates,
    'showProgress': showProgress,
    'defaultView': defaultView,
    'primaryColor': primaryColor,
    'permissions': permissions,
  };

  factory BoardSettings.fromJson(Map<String, dynamic> json) => BoardSettings(
    showTaskNumbers: json['showTaskNumbers'] ?? true,
    allowComments: json['allowComments'] ?? true,
    allowAttachments: json['allowAttachments'] ?? true,
    allowSubtasks: json['allowSubtasks'] ?? true,
    allowTimeTracking: json['allowTimeTracking'] ?? true,
    allowLabels: json['allowLabels'] ?? true,
    allowDueDates: json['allowDueDates'] ?? true,
    showProgress: json['showProgress'] ?? true,
    defaultView: json['defaultView'] ?? 'list',
    primaryColor: json['primaryColor'] ?? '#3F51B5',
    permissions: Map<String, bool>.from(json['permissions'] ?? {}),
  );
}

// Column Model
class BoardColumn {
  final String id;
  final String boardId;
  final String title;
  final int position;
  final List<Task> tasks;
  final int taskLimit;
  final String? color;
  final bool isCollapsed;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BoardColumn({
    required this.id,
    required this.boardId,
    required this.title,
    required this.position,
    this.tasks = const [],
    this.taskLimit = 0,
    this.color,
    this.isCollapsed = false,
    this.createdAt,
    this.updatedAt,
  });

  BoardColumn copyWith({
    String? id,
    String? boardId,
    String? title,
    int? position,
    List<Task>? tasks,
    int? taskLimit,
    String? color,
    bool? isCollapsed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BoardColumn(
      id: id ?? this.id,
      boardId: boardId ?? this.boardId,
      title: title ?? this.title,
      position: position ?? this.position,
      tasks: tasks ?? this.tasks,
      taskLimit: taskLimit ?? this.taskLimit,
      color: color ?? this.color,
      isCollapsed: isCollapsed ?? this.isCollapsed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ColumnUpdate {
  final String? title;
  final int? position;
  final int? taskLimit;
  final String? color;
  final bool? isCollapsed;

  const ColumnUpdate({
    this.title,
    this.position,
    this.taskLimit,
    this.color,
    this.isCollapsed,
  });
}

// Task Model
class Task {
  final String id;
  final String boardId;
  final String columnId;
  final String title;
  final String? description;
  final int position;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? dueDate;
  final DateTime? startDate;
  final TaskPriority priority;
  final TaskStatus status;
  final List<String> assigneeIds;
  final List<String> labelIds;
  final List<String> attachmentIds;
  final List<Comment> comments;
  final List<TaskChecklist> checklists;
  final int timeSpent;
  final int? estimatedTime;
  final double progress;
  final String? coverImage;
  final Map<String, dynamic> customFields;
  final String? createdBy;
  final String? lastModifiedBy;
  final List<String> watcherIds;
  final bool isArchived;
  final List<String> tagIds;
  final String? parentTaskId;
  final List<String> subtaskIds;
  final List<Activity> activities;

  Task({
    required this.id,
    required this.boardId,
    required this.columnId,
    required this.title,
    this.description,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
    this.dueDate,
    this.startDate,
    this.priority = TaskPriority.medium,
    this.status = TaskStatus.todo,
    this.assigneeIds = const [],
    this.labelIds = const [],
    this.attachmentIds = const [],
    this.comments = const [],
    this.checklists = const [],
    this.timeSpent = 0,
    this.estimatedTime,
    this.progress = 0.0,
    this.coverImage,
    this.customFields = const {},
    this.createdBy,
    this.lastModifiedBy,
    this.watcherIds = const [],
    this.isArchived = false,
    this.tagIds = const [],
    this.parentTaskId,
    this.subtaskIds = const [],
    this.activities = const [],
  });

  Task copyWith({
    String? id,
    String? boardId,
    String? columnId,
    String? title,
    String? description,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? dueDate,
    DateTime? startDate,
    TaskPriority? priority,
    TaskStatus? status,
    List<String>? assigneeIds,
    List<String>? labelIds,
    List<String>? attachmentIds,
    List<Comment>? comments,
    List<TaskChecklist>? checklists,
    int? timeSpent,
    int? estimatedTime,
    double? progress,
    String? coverImage,
    Map<String, dynamic>? customFields,
    String? createdBy,
    String? lastModifiedBy,
    List<String>? watcherIds,
    bool? isArchived,
    List<String>? tagIds,
    String? parentTaskId,
    List<String>? subtaskIds,
    List<Activity>? activities,
  }) {
    return Task(
      id: id ?? this.id,
      boardId: boardId ?? this.boardId,
      columnId: columnId ?? this.columnId,
      title: title ?? this.title,
      description: description ?? this.description,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dueDate: dueDate ?? this.dueDate,
      startDate: startDate ?? this.startDate,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      assigneeIds: assigneeIds ?? this.assigneeIds,
      labelIds: labelIds ?? this.labelIds,
      attachmentIds: attachmentIds ?? this.attachmentIds,
      comments: comments ?? this.comments,
      checklists: checklists ?? this.checklists,
      timeSpent: timeSpent ?? this.timeSpent,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      progress: progress ?? this.progress,
      coverImage: coverImage ?? this.coverImage,
      customFields: customFields ?? this.customFields,
      createdBy: createdBy ?? this.createdBy,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
      watcherIds: watcherIds ?? this.watcherIds,
      isArchived: isArchived ?? this.isArchived,
      tagIds: tagIds ?? this.tagIds,
      parentTaskId: parentTaskId ?? this.parentTaskId,
      subtaskIds: subtaskIds ?? this.subtaskIds,
      activities: activities ?? this.activities,
    );
  }
}

enum TaskPriority { urgent, high, medium, low }
enum TaskStatus { todo, inProgress, inReview, done, cancelled }

class TaskLabel {
  final String id;
  final String name;
  final String color;
  final String? description;
  final String boardId;

  TaskLabel({
    required this.id,
    required this.name,
    required this.color,
    this.description,
    required this.boardId,
  });

  TaskLabel copyWith({
    String? id,
    String? name,
    String? color,
    String? description,
    String? boardId,
  }) {
    return TaskLabel(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      description: description ?? this.description,
      boardId: boardId ?? this.boardId,
    );
  }
}

// Comment Model
class Comment {
  final String id;
  final String taskId;
  final String userId;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<String> mentionedUserIds;
  final List<String> attachmentIds;
  final String? parentCommentId;
  final List<String> replyIds;
  final bool isEdited;
  final bool isDeleted;

  Comment({
    required this.id,
    required this.taskId,
    required this.userId,
    required this.content,
    required this.createdAt,
    this.updatedAt,
    this.mentionedUserIds = const [],
    this.attachmentIds = const [],
    this.parentCommentId,
    this.replyIds = const [],
    this.isEdited = false,
    this.isDeleted = false,
  });

  Comment copyWith({
    String? id,
    String? taskId,
    String? userId,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? mentionedUserIds,
    List<String>? attachmentIds,
    String? parentCommentId,
    List<String>? replyIds,
    bool? isEdited,
    bool? isDeleted,
  }) {
    return Comment(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      mentionedUserIds: mentionedUserIds ?? this.mentionedUserIds,
      attachmentIds: attachmentIds ?? this.attachmentIds,
      parentCommentId: parentCommentId ?? this.parentCommentId,
      replyIds: replyIds ?? this.replyIds,
      isEdited: isEdited ?? this.isEdited,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

// Attachment Model
class TaskAttachment {
  final String id;
  final String taskId;
  final String fileName;
  final String fileUrl;
  final int fileSize;
  final String mimeType;
  final String uploadedBy;
  final DateTime uploadedAt;
  final String? thumbnailUrl;
  final Map<String, dynamic> metadata;

  TaskAttachment({
    required this.id,
    required this.taskId,
    required this.fileName,
    required this.fileUrl,
    required this.fileSize,
    required this.mimeType,
    required this.uploadedBy,
    required this.uploadedAt,
    this.thumbnailUrl,
    this.metadata = const {},
  });
}

// Checklist Model
class TaskChecklist {
  final String id;
  final String taskId;
  final String title;
  final List<ChecklistItem> items;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int position;

  TaskChecklist({
    required this.id,
    required this.taskId,
    required this.title,
    required this.items,
    required this.createdAt,
    this.updatedAt,
    this.position = 0,
  });

  TaskChecklist copyWith({
    String? id,
    String? taskId,
    String? title,
    List<ChecklistItem>? items,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? position,
  }) {
    return TaskChecklist(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      position: position ?? this.position,
    );
  }
}

class ChecklistItem {
  final String id;
  final String title;
  final bool isCompleted;
  final DateTime? completedAt;
  final String? completedBy;
  final int position;
  final String? assigneeId;
  final DateTime? dueDate;

  ChecklistItem({
    required this.id,
    required this.title,
    required this.isCompleted,
    this.completedAt,
    this.completedBy,
    required this.position,
    this.assigneeId,
    this.dueDate,
  });

  ChecklistItem copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    DateTime? completedAt,
    String? completedBy,
    int? position,
    String? assigneeId,
    DateTime? dueDate,
  }) {
    return ChecklistItem(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      completedBy: completedBy ?? this.completedBy,
      position: position ?? this.position,
      assigneeId: assigneeId ?? this.assigneeId,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}

// Activity Model
class Activity {
  final String id;
  final String boardId;
  final String? taskId;
  final String userId;
  final ActivityType type;
  final String description;
  final DateTime createdAt;
  final Map<String, dynamic> metadata;
  final String? entityId;
  final String? entityType;
  final Map<String, dynamic>? changes;

  Activity({
    required this.id,
    required this.boardId,
    this.taskId,
    required this.userId,
    required this.type,
    required this.description,
    required this.createdAt,
    this.metadata = const {},
    this.entityId,
    this.entityType,
    this.changes,
  });
}

enum ActivityType {
  taskCreated,
  taskUpdated,
  taskDeleted,
  taskMoved,
  taskAssigned,
  taskUnassigned,
  taskCompleted,
  taskReopened,
  commentAdded,
  commentUpdated,
  commentDeleted,
  attachmentAdded,
  attachmentRemoved,
  checklistAdded,
  checklistUpdated,
  checklistRemoved,
  columnCreated,
  columnUpdated,
  columnDeleted,
  boardUpdated,
  memberAdded,
  memberRemoved,
  labelAdded,
  labelRemoved,
  dueDateChanged,
  priorityChanged,
}

// Team Member Model
class TeamMember {
  final String id;
  final String userId;
  final String boardId;
  final String name;
  final String email;
  final String? avatarUrl;
  final BoardRole role;
  final DateTime joinedAt;
  final bool isActive;
  final Map<String, bool> permissions;
  final int tasksAssigned;
  final int tasksCompleted;
  final DateTime? lastActiveAt;

  TeamMember({
    required this.id,
    required this.userId,
    required this.boardId,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.role,
    required this.joinedAt,
    this.isActive = true,
    this.permissions = const {},
    this.tasksAssigned = 0,
    this.tasksCompleted = 0,
    this.lastActiveAt,
  });

  TeamMember copyWith({
    String? id,
    String? userId,
    String? boardId,
    String? name,
    String? email,
    String? avatarUrl,
    BoardRole? role,
    DateTime? joinedAt,
    bool? isActive,
    Map<String, bool>? permissions,
    int? tasksAssigned,
    int? tasksCompleted,
    DateTime? lastActiveAt,
  }) {
    return TeamMember(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      boardId: boardId ?? this.boardId,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      isActive: isActive ?? this.isActive,
      permissions: permissions ?? this.permissions,
      tasksAssigned: tasksAssigned ?? this.tasksAssigned,
      tasksCompleted: tasksCompleted ?? this.tasksCompleted,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
    );
  }
}

enum BoardRole { owner, admin, member, viewer }