import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'chat_models.freezed.dart';
part 'chat_models.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    String? avatar,
    String? status,
    @Default(UserStatus.offline) UserStatus userStatus,
    @Default(false) bool isOnline,
    DateTime? lastSeen,
    @Default({}) Map<String, dynamic> metadata,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    String? name,
    String? description,
    String? avatar,
    required ConversationType type,
    required List<String> participantIds,
    String? lastMessageId,
    DateTime? lastActivity,
    @Default(0) int unreadCount,
    @Default(false) bool isPinned,
    @Default(false) bool isMuted,
    @Default(false) bool isArchived,
    @Default({}) Map<String, dynamic> settings,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);
}

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String conversationId,
    required String senderId,
    required String content,
    @Default(MessageType.text) MessageType type,
    DateTime? timestamp,
    @Default(MessageStatus.sending) MessageStatus status,
    String? replyToId,
    @Default([]) List<MessageAttachment> attachments,
    @Default([]) List<MessageReaction> reactions,
    @Default(false) bool isEdited,
    DateTime? editedAt,
    @Default(false) bool isDeleted,
    @Default({}) Map<String, dynamic> metadata,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}

@freezed
class MessageAttachment with _$MessageAttachment {
  const factory MessageAttachment({
    required String id,
    required String name,
    required String url,
    required AttachmentType type,
    int? size,
    String? mimeType,
    int? duration, // for audio/video
    String? thumbnail,
    @Default({}) Map<String, dynamic> metadata,
  }) = _MessageAttachment;

  factory MessageAttachment.fromJson(Map<String, dynamic> json) => _$MessageAttachmentFromJson(json);
}

@freezed
class MessageReaction with _$MessageReaction {
  const factory MessageReaction({
    required String emoji,
    required String userId,
    DateTime? timestamp,
  }) = _MessageReaction;

  factory MessageReaction.fromJson(Map<String, dynamic> json) => _$MessageReactionFromJson(json);
}

@freezed
class TypingStatus with _$TypingStatus {
  const factory TypingStatus({
    required String userId,
    required String conversationId,
    required bool isTyping,
    DateTime? timestamp,
  }) = _TypingStatus;

  factory TypingStatus.fromJson(Map<String, dynamic> json) => _$TypingStatusFromJson(json);
}

@freezed
class ChatSettings with _$ChatSettings {
  const factory ChatSettings({
    @Default(true) bool notificationsEnabled,
    @Default(true) bool soundEnabled,
    @Default(true) bool vibrationEnabled,
    @Default(ChatTheme.material) ChatTheme theme,
    @Default(14.0) double fontSize,
    @Default(true) bool showOnlineStatus,
    @Default(true) bool showReadReceipts,
    @Default(false) bool autoDeleteMessages,
    @Default(30) int autoDeleteDays,
    @Default(ChatBubbleStyle.modern) ChatBubbleStyle bubbleStyle,
    @Default('en') String language,
    @Default({}) Map<String, dynamic> customSettings,
  }) = _ChatSettings;

  factory ChatSettings.fromJson(Map<String, dynamic> json) => _$ChatSettingsFromJson(json);
}

@freezed
class VoiceMessage with _$VoiceMessage {
  const factory VoiceMessage({
    required String id,
    required String url,
    required int duration,
    required List<double> waveform,
    @Default(false) bool isPlaying,
    @Default(0) int currentPosition,
  }) = _VoiceMessage;

  factory VoiceMessage.fromJson(Map<String, dynamic> json) => _$VoiceMessageFromJson(json);
}

@freezed
class CallSession with _$CallSession {
  const factory CallSession({
    required String id,
    required String conversationId,
    required String initiatorId,
    required List<String> participantIds,
    required CallType type,
    @Default(CallStatus.ringing) CallStatus status,
    DateTime? startTime,
    DateTime? endTime,
    @Default(0) int duration,
    @Default({}) Map<String, dynamic> metadata,
  }) = _CallSession;

  factory CallSession.fromJson(Map<String, dynamic> json) => _$CallSessionFromJson(json);
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

enum CallType {
  audio,
  video,
}

enum CallStatus {
  ringing,
  connecting,
  connected,
  ended,
  declined,
  missed,
  failed,
}