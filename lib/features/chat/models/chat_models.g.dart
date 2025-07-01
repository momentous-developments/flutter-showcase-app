// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String?,
      status: json['status'] as String?,
      userStatus:
          $enumDecodeNullable(_$UserStatusEnumMap, json['userStatus']) ??
              UserStatus.offline,
      isOnline: json['isOnline'] as bool? ?? false,
      lastSeen: json['lastSeen'] == null
          ? null
          : DateTime.parse(json['lastSeen'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
      'status': instance.status,
      'userStatus': _$UserStatusEnumMap[instance.userStatus]!,
      'isOnline': instance.isOnline,
      'lastSeen': instance.lastSeen?.toIso8601String(),
      'metadata': instance.metadata,
    };

const _$UserStatusEnumMap = {
  UserStatus.online: 'online',
  UserStatus.away: 'away',
  UserStatus.busy: 'busy',
  UserStatus.offline: 'offline',
};

_$ConversationImpl _$$ConversationImplFromJson(Map<String, dynamic> json) =>
    _$ConversationImpl(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      avatar: json['avatar'] as String?,
      type: $enumDecode(_$ConversationTypeEnumMap, json['type']),
      participantIds: (json['participantIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lastMessageId: json['lastMessageId'] as String?,
      lastActivity: json['lastActivity'] == null
          ? null
          : DateTime.parse(json['lastActivity'] as String),
      unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
      isPinned: json['isPinned'] as bool? ?? false,
      isMuted: json['isMuted'] as bool? ?? false,
      isArchived: json['isArchived'] as bool? ?? false,
      settings: json['settings'] as Map<String, dynamic>? ?? const {},
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ConversationImplToJson(_$ConversationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'avatar': instance.avatar,
      'type': _$ConversationTypeEnumMap[instance.type]!,
      'participantIds': instance.participantIds,
      'lastMessageId': instance.lastMessageId,
      'lastActivity': instance.lastActivity?.toIso8601String(),
      'unreadCount': instance.unreadCount,
      'isPinned': instance.isPinned,
      'isMuted': instance.isMuted,
      'isArchived': instance.isArchived,
      'settings': instance.settings,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$ConversationTypeEnumMap = {
  ConversationType.direct: 'direct',
  ConversationType.group: 'group',
  ConversationType.channel: 'channel',
  ConversationType.bot: 'bot',
};

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: json['id'] as String,
      conversationId: json['conversationId'] as String,
      senderId: json['senderId'] as String,
      content: json['content'] as String,
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']) ??
          MessageType.text,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']) ??
          MessageStatus.sending,
      replyToId: json['replyToId'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map(
                  (e) => MessageAttachment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      reactions: (json['reactions'] as List<dynamic>?)
              ?.map((e) => MessageReaction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isEdited: json['isEdited'] as bool? ?? false,
      editedAt: json['editedAt'] == null
          ? null
          : DateTime.parse(json['editedAt'] as String),
      isDeleted: json['isDeleted'] as bool? ?? false,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'senderId': instance.senderId,
      'content': instance.content,
      'type': _$MessageTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp?.toIso8601String(),
      'status': _$MessageStatusEnumMap[instance.status]!,
      'replyToId': instance.replyToId,
      'attachments': instance.attachments,
      'reactions': instance.reactions,
      'isEdited': instance.isEdited,
      'editedAt': instance.editedAt?.toIso8601String(),
      'isDeleted': instance.isDeleted,
      'metadata': instance.metadata,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.video: 'video',
  MessageType.audio: 'audio',
  MessageType.voice: 'voice',
  MessageType.file: 'file',
  MessageType.location: 'location',
  MessageType.contact: 'contact',
  MessageType.sticker: 'sticker',
  MessageType.gif: 'gif',
  MessageType.system: 'system',
};

const _$MessageStatusEnumMap = {
  MessageStatus.sending: 'sending',
  MessageStatus.sent: 'sent',
  MessageStatus.delivered: 'delivered',
  MessageStatus.read: 'read',
  MessageStatus.failed: 'failed',
};

_$MessageAttachmentImpl _$$MessageAttachmentImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageAttachmentImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      type: $enumDecode(_$AttachmentTypeEnumMap, json['type']),
      size: (json['size'] as num?)?.toInt(),
      mimeType: json['mimeType'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      thumbnail: json['thumbnail'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$MessageAttachmentImplToJson(
        _$MessageAttachmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'type': _$AttachmentTypeEnumMap[instance.type]!,
      'size': instance.size,
      'mimeType': instance.mimeType,
      'duration': instance.duration,
      'thumbnail': instance.thumbnail,
      'metadata': instance.metadata,
    };

const _$AttachmentTypeEnumMap = {
  AttachmentType.image: 'image',
  AttachmentType.video: 'video',
  AttachmentType.audio: 'audio',
  AttachmentType.document: 'document',
  AttachmentType.voice: 'voice',
  AttachmentType.sticker: 'sticker',
  AttachmentType.gif: 'gif',
};

_$MessageReactionImpl _$$MessageReactionImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageReactionImpl(
      emoji: json['emoji'] as String,
      userId: json['userId'] as String,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$MessageReactionImplToJson(
        _$MessageReactionImpl instance) =>
    <String, dynamic>{
      'emoji': instance.emoji,
      'userId': instance.userId,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

_$TypingStatusImpl _$$TypingStatusImplFromJson(Map<String, dynamic> json) =>
    _$TypingStatusImpl(
      userId: json['userId'] as String,
      conversationId: json['conversationId'] as String,
      isTyping: json['isTyping'] as bool,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$TypingStatusImplToJson(_$TypingStatusImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'conversationId': instance.conversationId,
      'isTyping': instance.isTyping,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

_$ChatSettingsImpl _$$ChatSettingsImplFromJson(Map<String, dynamic> json) =>
    _$ChatSettingsImpl(
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      vibrationEnabled: json['vibrationEnabled'] as bool? ?? true,
      theme: $enumDecodeNullable(_$ChatThemeEnumMap, json['theme']) ??
          ChatTheme.material,
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? 14.0,
      showOnlineStatus: json['showOnlineStatus'] as bool? ?? true,
      showReadReceipts: json['showReadReceipts'] as bool? ?? true,
      autoDeleteMessages: json['autoDeleteMessages'] as bool? ?? false,
      autoDeleteDays: (json['autoDeleteDays'] as num?)?.toInt() ?? 30,
      bubbleStyle:
          $enumDecodeNullable(_$ChatBubbleStyleEnumMap, json['bubbleStyle']) ??
              ChatBubbleStyle.modern,
      language: json['language'] as String? ?? 'en',
      customSettings:
          json['customSettings'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$ChatSettingsImplToJson(_$ChatSettingsImpl instance) =>
    <String, dynamic>{
      'notificationsEnabled': instance.notificationsEnabled,
      'soundEnabled': instance.soundEnabled,
      'vibrationEnabled': instance.vibrationEnabled,
      'theme': _$ChatThemeEnumMap[instance.theme]!,
      'fontSize': instance.fontSize,
      'showOnlineStatus': instance.showOnlineStatus,
      'showReadReceipts': instance.showReadReceipts,
      'autoDeleteMessages': instance.autoDeleteMessages,
      'autoDeleteDays': instance.autoDeleteDays,
      'bubbleStyle': _$ChatBubbleStyleEnumMap[instance.bubbleStyle]!,
      'language': instance.language,
      'customSettings': instance.customSettings,
    };

const _$ChatThemeEnumMap = {
  ChatTheme.material: 'material',
  ChatTheme.ios: 'ios',
  ChatTheme.whatsapp: 'whatsapp',
  ChatTheme.telegram: 'telegram',
  ChatTheme.discord: 'discord',
  ChatTheme.custom: 'custom',
};

const _$ChatBubbleStyleEnumMap = {
  ChatBubbleStyle.modern: 'modern',
  ChatBubbleStyle.classic: 'classic',
  ChatBubbleStyle.minimal: 'minimal',
  ChatBubbleStyle.rounded: 'rounded',
  ChatBubbleStyle.square: 'square',
};

_$VoiceMessageImpl _$$VoiceMessageImplFromJson(Map<String, dynamic> json) =>
    _$VoiceMessageImpl(
      id: json['id'] as String,
      url: json['url'] as String,
      duration: (json['duration'] as num).toInt(),
      waveform: (json['waveform'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      isPlaying: json['isPlaying'] as bool? ?? false,
      currentPosition: (json['currentPosition'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$VoiceMessageImplToJson(_$VoiceMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'duration': instance.duration,
      'waveform': instance.waveform,
      'isPlaying': instance.isPlaying,
      'currentPosition': instance.currentPosition,
    };

_$CallSessionImpl _$$CallSessionImplFromJson(Map<String, dynamic> json) =>
    _$CallSessionImpl(
      id: json['id'] as String,
      conversationId: json['conversationId'] as String,
      initiatorId: json['initiatorId'] as String,
      participantIds: (json['participantIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      type: $enumDecode(_$CallTypeEnumMap, json['type']),
      status: $enumDecodeNullable(_$CallStatusEnumMap, json['status']) ??
          CallStatus.ringing,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$CallSessionImplToJson(_$CallSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'initiatorId': instance.initiatorId,
      'participantIds': instance.participantIds,
      'type': _$CallTypeEnumMap[instance.type]!,
      'status': _$CallStatusEnumMap[instance.status]!,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'duration': instance.duration,
      'metadata': instance.metadata,
    };

const _$CallTypeEnumMap = {
  CallType.audio: 'audio',
  CallType.video: 'video',
};

const _$CallStatusEnumMap = {
  CallStatus.ringing: 'ringing',
  CallStatus.connecting: 'connecting',
  CallStatus.connected: 'connected',
  CallStatus.ended: 'ended',
  CallStatus.declined: 'declined',
  CallStatus.missed: 'missed',
  CallStatus.failed: 'failed',
};
