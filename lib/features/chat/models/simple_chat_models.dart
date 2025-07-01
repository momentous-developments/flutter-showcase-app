import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final String? status;
  final UserStatus userStatus;
  final bool isOnline;
  final DateTime? lastSeen;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.status,
    this.userStatus = UserStatus.offline,
    this.isOnline = false,
    this.lastSeen,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    String? status,
    UserStatus? userStatus,
    bool? isOnline,
    DateTime? lastSeen,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      status: status ?? this.status,
      userStatus: userStatus ?? this.userStatus,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }
}

class Conversation {
  final String id;
  final String? name;
  final String? description;
  final String? avatar;
  final ConversationType type;
  final List<String> participantIds;
  final String? lastMessageId;
  final DateTime? lastActivity;
  final int unreadCount;
  final bool isPinned;
  final bool isMuted;
  final bool isArchived;

  const Conversation({
    required this.id,
    this.name,
    this.description,
    this.avatar,
    required this.type,
    required this.participantIds,
    this.lastMessageId,
    this.lastActivity,
    this.unreadCount = 0,
    this.isPinned = false,
    this.isMuted = false,
    this.isArchived = false,
  });

  Conversation copyWith({
    String? id,
    String? name,
    String? description,
    String? avatar,
    ConversationType? type,
    List<String>? participantIds,
    String? lastMessageId,
    DateTime? lastActivity,
    int? unreadCount,
    bool? isPinned,
    bool? isMuted,
    bool? isArchived,
  }) {
    return Conversation(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      avatar: avatar ?? this.avatar,
      type: type ?? this.type,
      participantIds: participantIds ?? this.participantIds,
      lastMessageId: lastMessageId ?? this.lastMessageId,
      lastActivity: lastActivity ?? this.lastActivity,
      unreadCount: unreadCount ?? this.unreadCount,
      isPinned: isPinned ?? this.isPinned,
      isMuted: isMuted ?? this.isMuted,
      isArchived: isArchived ?? this.isArchived,
    );
  }
}

class Message {
  final String id;
  final String conversationId;
  final String senderId;
  final String content;
  final MessageType type;
  final DateTime? timestamp;
  final MessageStatus status;
  final String? replyToId;
  final List<MessageAttachment> attachments;
  final List<MessageReaction> reactions;
  final bool isEdited;
  final DateTime? editedAt;
  final bool isDeleted;

  const Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    this.type = MessageType.text,
    this.timestamp,
    this.status = MessageStatus.sending,
    this.replyToId,
    this.attachments = const [],
    this.reactions = const [],
    this.isEdited = false,
    this.editedAt,
    this.isDeleted = false,
  });

  Message copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? content,
    MessageType? type,
    DateTime? timestamp,
    MessageStatus? status,
    String? replyToId,
    List<MessageAttachment>? attachments,
    List<MessageReaction>? reactions,
    bool? isEdited,
    DateTime? editedAt,
    bool? isDeleted,
  }) {
    return Message(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      replyToId: replyToId ?? this.replyToId,
      attachments: attachments ?? this.attachments,
      reactions: reactions ?? this.reactions,
      isEdited: isEdited ?? this.isEdited,
      editedAt: editedAt ?? this.editedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class MessageAttachment {
  final String id;
  final String name;
  final String url;
  final AttachmentType type;
  final int? size;
  final String? mimeType;
  final int? duration;
  final String? thumbnail;

  const MessageAttachment({
    required this.id,
    required this.name,
    required this.url,
    required this.type,
    this.size,
    this.mimeType,
    this.duration,
    this.thumbnail,
  });
}

class MessageReaction {
  final String emoji;
  final String userId;
  final DateTime? timestamp;

  const MessageReaction({
    required this.emoji,
    required this.userId,
    this.timestamp,
  });
}

class ChatSettings {
  final bool notificationsEnabled;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final ChatTheme theme;
  final double fontSize;
  final bool showOnlineStatus;
  final bool showReadReceipts;
  final bool autoDeleteMessages;
  final int autoDeleteDays;
  final ChatBubbleStyle bubbleStyle;
  final String language;

  const ChatSettings({
    this.notificationsEnabled = true,
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.theme = ChatTheme.material,
    this.fontSize = 14.0,
    this.showOnlineStatus = true,
    this.showReadReceipts = true,
    this.autoDeleteMessages = false,
    this.autoDeleteDays = 30,
    this.bubbleStyle = ChatBubbleStyle.modern,
    this.language = 'en',
  });

  ChatSettings copyWith({
    bool? notificationsEnabled,
    bool? soundEnabled,
    bool? vibrationEnabled,
    ChatTheme? theme,
    double? fontSize,
    bool? showOnlineStatus,
    bool? showReadReceipts,
    bool? autoDeleteMessages,
    int? autoDeleteDays,
    ChatBubbleStyle? bubbleStyle,
    String? language,
  }) {
    return ChatSettings(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      theme: theme ?? this.theme,
      fontSize: fontSize ?? this.fontSize,
      showOnlineStatus: showOnlineStatus ?? this.showOnlineStatus,
      showReadReceipts: showReadReceipts ?? this.showReadReceipts,
      autoDeleteMessages: autoDeleteMessages ?? this.autoDeleteMessages,
      autoDeleteDays: autoDeleteDays ?? this.autoDeleteDays,
      bubbleStyle: bubbleStyle ?? this.bubbleStyle,
      language: language ?? this.language,
    );
  }
}

enum UserStatus {
  online,
  away,
  busy,
  offline,
}

enum ConversationType {
  direct,
  group,
  channel,
  bot,
}

enum MessageType {
  text,
  image,
  video,
  audio,
  voice,
  file,
  location,
  contact,
  sticker,
  gif,
  system,
}

enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
  failed,
}

enum AttachmentType {
  image,
  video,
  audio,
  document,
  voice,
  sticker,
  gif,
}

enum ChatTheme {
  material,
  ios,
  whatsapp,
  telegram,
  discord,
  custom,
}

enum ChatBubbleStyle {
  modern,
  classic,
  minimal,
  rounded,
  square,
}