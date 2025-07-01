import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import '../models/chat_models.dart';
import '../services/chat_api_service.dart';
import '../services/chat_websocket_service.dart';

part 'chat_providers.freezed.dart';
part 'chat_providers.g.dart';

// Service providers
final chatApiServiceProvider = Provider<ChatApiService>((ref) {
  return ChatApiService();
});

final chatWebSocketServiceProvider = Provider<ChatWebSocketService>((ref) {
  return ChatWebSocketService();
});

// State providers
final currentUserProvider = StateProvider<User?>((ref) => null);

final selectedConversationProvider = StateProvider<String?>((ref) => null);

final chatSettingsProvider = StateProvider<ChatSettings>((ref) {
  return const ChatSettings();
});

final isTypingProvider = StateProvider<Map<String, bool>>((ref) => {});

final onlineUsersProvider = StateProvider<Set<String>>((ref) => {});

// Conversations provider
final conversationsProvider = StateNotifierProvider<ConversationsNotifier, AsyncValue<List<Conversation>>>((ref) {
  return ConversationsNotifier(ref);
});

class ConversationsNotifier extends StateNotifier<AsyncValue<List<Conversation>>> {
  ConversationsNotifier(this.ref) : super(const AsyncValue.loading()) {
    _initialize();
  }

  final Ref ref;
  final List<Conversation> _conversations = [];

  Future<void> _initialize() async {
    try {
      await loadConversations();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> loadConversations({String? search}) async {
    try {
      state = const AsyncValue.loading();
      final apiService = ref.read(chatApiServiceProvider);
      final conversations = await apiService.getConversations(search: search);
      
      _conversations.clear();
      _conversations.addAll(conversations);
      state = AsyncValue.data(List.from(_conversations));
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> createConversation({
    required ConversationType type,
    required List<String> participantIds,
    String? name,
  }) async {
    try {
      final apiService = ref.read(chatApiServiceProvider);
      final conversation = await apiService.createConversation(
        type: type,
        participantIds: participantIds,
        name: name,
      );
      
      _conversations.insert(0, conversation);
      state = AsyncValue.data(List.from(_conversations));
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void updateConversation(Conversation updatedConversation) {
    final index = _conversations.indexWhere((c) => c.id == updatedConversation.id);
    if (index != -1) {
      _conversations[index] = updatedConversation;
      state = AsyncValue.data(List.from(_conversations));
    }
  }

  void updateLastMessage(String conversationId, Message message) {
    final index = _conversations.indexWhere((c) => c.id == conversationId);
    if (index != -1) {
      final conversation = _conversations[index];
      _conversations[index] = conversation.copyWith(
        lastMessageId: message.id,
        lastActivity: message.timestamp,
      );
      state = AsyncValue.data(List.from(_conversations));
    }
  }

  void incrementUnreadCount(String conversationId) {
    final index = _conversations.indexWhere((c) => c.id == conversationId);
    if (index != -1) {
      final conversation = _conversations[index];
      _conversations[index] = conversation.copyWith(
        unreadCount: conversation.unreadCount + 1,
      );
      state = AsyncValue.data(List.from(_conversations));
    }
  }

  void markAsRead(String conversationId) {
    final index = _conversations.indexWhere((c) => c.id == conversationId);
    if (index != -1) {
      final conversation = _conversations[index];
      _conversations[index] = conversation.copyWith(unreadCount: 0);
      state = AsyncValue.data(List.from(_conversations));
    }
  }
}

// Messages provider
final messagesProvider = StateNotifierProvider.family<MessagesNotifier, AsyncValue<List<Message>>, String>((ref, conversationId) {
  return MessagesNotifier(ref, conversationId);
});

class MessagesNotifier extends StateNotifier<AsyncValue<List<Message>>> {
  MessagesNotifier(this.ref, this.conversationId) : super(const AsyncValue.loading()) {
    _initialize();
  }

  final Ref ref;
  final String conversationId;
  final List<Message> _messages = [];
  bool _hasMore = true;
  int _currentPage = 1;

  Future<void> _initialize() async {
    try {
      await loadMessages();
      _listenToWebSocket();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void _listenToWebSocket() {
    final webSocketService = ref.read(chatWebSocketServiceProvider);
    
    webSocketService.messageStream.listen((message) {
      if (message.conversationId == conversationId) {
        _addMessage(message);
      }
    });

    webSocketService.messageStatusStream.listen((status) {
      // Update message status
      _updateMessageStatus(status);
    });
  }

  Future<void> loadMessages({bool loadMore = false}) async {
    try {
      if (!loadMore) {
        state = const AsyncValue.loading();
        _currentPage = 1;
        _hasMore = true;
      }

      if (!_hasMore) return;

      final apiService = ref.read(chatApiServiceProvider);
      final messages = await apiService.getMessages(
        conversationId,
        page: _currentPage,
        limit: 50,
      );

      if (loadMore) {
        _messages.addAll(messages);
      } else {
        _messages.clear();
        _messages.addAll(messages);
      }

      _hasMore = messages.length == 50;
      _currentPage++;
      
      state = AsyncValue.data(List.from(_messages));
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> sendMessage({
    required String content,
    MessageType type = MessageType.text,
    String? replyToId,
    List<File>? attachments,
  }) async {
    try {
      final currentUser = ref.read(currentUserProvider);
      if (currentUser == null) return;

      // Create temporary message
      final tempMessage = Message(
        id: const Uuid().v4(),
        conversationId: conversationId,
        senderId: currentUser.id,
        content: content,
        type: type,
        timestamp: DateTime.now(),
        status: MessageStatus.sending,
        replyToId: replyToId,
      );

      _addMessage(tempMessage);

      // Send via API
      final apiService = ref.read(chatApiServiceProvider);
      final sentMessage = await apiService.sendMessage(
        conversationId: conversationId,
        content: content,
        type: type,
        replyToId: replyToId,
        attachments: attachments,
      );

      // Replace temporary message with sent message
      _replaceMessage(tempMessage.id, sentMessage);

      // Update conversation
      ref.read(conversationsProvider.notifier).updateLastMessage(conversationId, sentMessage);

    } catch (e) {
      // Mark message as failed
      _updateMessageStatus(MessageStatus.failed);
      rethrow;
    }
  }

  Future<void> editMessage(String messageId, String newContent) async {
    try {
      final apiService = ref.read(chatApiServiceProvider);
      final editedMessage = await apiService.editMessage(messageId, newContent);
      _replaceMessage(messageId, editedMessage);
    } catch (e) {
      debugPrint('Error editing message: $e');
    }
  }

  Future<void> deleteMessage(String messageId, {bool deleteForEveryone = false}) async {
    try {
      final apiService = ref.read(chatApiServiceProvider);
      await apiService.deleteMessage(messageId, deleteForEveryone: deleteForEveryone);
      _removeMessage(messageId);
    } catch (e) {
      debugPrint('Error deleting message: $e');
    }
  }

  void _addMessage(Message message) {
    _messages.insert(0, message);
    state = AsyncValue.data(List.from(_messages));
  }

  void _replaceMessage(String messageId, Message newMessage) {
    final index = _messages.indexWhere((m) => m.id == messageId);
    if (index != -1) {
      _messages[index] = newMessage;
      state = AsyncValue.data(List.from(_messages));
    }
  }

  void _removeMessage(String messageId) {
    _messages.removeWhere((m) => m.id == messageId);
    state = AsyncValue.data(List.from(_messages));
  }

  void _updateMessageStatus(MessageStatus status) {
    // Update status for pending messages
    for (int i = 0; i < _messages.length; i++) {
      if (_messages[i].status == MessageStatus.sending) {
        _messages[i] = _messages[i].copyWith(status: status);
        break;
      }
    }
    state = AsyncValue.data(List.from(_messages));
  }

  void addReaction(String messageId, String emoji) {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    final index = _messages.indexWhere((m) => m.id == messageId);
    if (index != -1) {
      final message = _messages[index];
      final reactions = List<MessageReaction>.from(message.reactions);
      
      // Check if user already reacted with this emoji
      final existingReaction = reactions.firstWhere(
        (r) => r.userId == currentUser.id && r.emoji == emoji,
        orElse: () => const MessageReaction(emoji: '', userId: '', timestamp: null),
      );

      if (existingReaction.userId.isEmpty) {
        // Add new reaction
        reactions.add(MessageReaction(
          emoji: emoji,
          userId: currentUser.id,
          timestamp: DateTime.now(),
        ));
      } else {
        // Remove existing reaction
        reactions.removeWhere((r) => r.userId == currentUser.id && r.emoji == emoji);
      }

      _messages[index] = message.copyWith(reactions: reactions);
      state = AsyncValue.data(List.from(_messages));
    }
  }
}

// Users provider
final usersProvider = StateNotifierProvider<UsersNotifier, AsyncValue<List<User>>>((ref) {
  return UsersNotifier(ref);
});

class UsersNotifier extends StateNotifier<AsyncValue<List<User>>> {
  UsersNotifier(this.ref) : super(const AsyncValue.loading()) {
    _initialize();
  }

  final Ref ref;
  final List<User> _users = [];

  Future<void> _initialize() async {
    try {
      await loadUsers();
      _listenToWebSocket();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void _listenToWebSocket() {
    final webSocketService = ref.read(chatWebSocketServiceProvider);
    
    webSocketService.userStatusStream.listen((user) {
      updateUser(user);
    });
  }

  Future<void> loadUsers({String? search}) async {
    try {
      state = const AsyncValue.loading();
      final apiService = ref.read(chatApiServiceProvider);
      final users = await apiService.getUsers(search: search);
      
      _users.clear();
      _users.addAll(users);
      state = AsyncValue.data(List.from(_users));
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void updateUser(User updatedUser) {
    final index = _users.indexWhere((u) => u.id == updatedUser.id);
    if (index != -1) {
      _users[index] = updatedUser;
      state = AsyncValue.data(List.from(_users));
    } else {
      _users.add(updatedUser);
      state = AsyncValue.data(List.from(_users));
    }
  }

  User? getUserById(String userId) {
    try {
      return _users.firstWhere((u) => u.id == userId);
    } catch (e) {
      return null;
    }
  }
}

// Typing provider
final typingProvider = StateNotifierProvider.family<TypingNotifier, Map<String, bool>, String>((ref, conversationId) {
  return TypingNotifier(ref, conversationId);
});

class TypingNotifier extends StateNotifier<Map<String, bool>> {
  TypingNotifier(this.ref, this.conversationId) : super({}) {
    _listenToWebSocket();
  }

  final Ref ref;
  final String conversationId;

  void _listenToWebSocket() {
    final webSocketService = ref.read(chatWebSocketServiceProvider);
    
    webSocketService.typingStream.listen((typingStatus) {
      if (typingStatus.conversationId == conversationId) {
        final newState = Map<String, bool>.from(state);
        newState[typingStatus.userId] = typingStatus.isTyping;
        state = newState;
      }
    });
  }

  void setTyping(bool isTyping) {
    final webSocketService = ref.read(chatWebSocketServiceProvider);
    webSocketService.sendTyping(conversationId, isTyping);
  }
}

// Voice recording provider
final voiceRecordingProvider = StateNotifierProvider<VoiceRecordingNotifier, VoiceRecordingState>((ref) {
  return VoiceRecordingNotifier();
});

class VoiceRecordingNotifier extends StateNotifier<VoiceRecordingState> {
  VoiceRecordingNotifier() : super(const VoiceRecordingState());

  void startRecording() {
    state = state.copyWith(
      isRecording: true,
      startTime: DateTime.now(),
    );
  }

  void stopRecording() {
    state = state.copyWith(
      isRecording: false,
      endTime: DateTime.now(),
    );
  }

  void cancelRecording() {
    state = const VoiceRecordingState();
  }

  void updateAmplitude(double amplitude) {
    state = state.copyWith(amplitude: amplitude);
  }
}

@freezed
class VoiceRecordingState with _$VoiceRecordingState {
  const factory VoiceRecordingState({
    @Default(false) bool isRecording,
    @Default(0.0) double amplitude,
    DateTime? startTime,
    DateTime? endTime,
  }) = _VoiceRecordingState;

  factory VoiceRecordingState.fromJson(Map<String, dynamic> json) => _$VoiceRecordingStateFromJson(json);
}

// Chat search provider
final chatSearchProvider = StateNotifierProvider<ChatSearchNotifier, AsyncValue<List<Message>>>((ref) {
  return ChatSearchNotifier(ref);
});

class ChatSearchNotifier extends StateNotifier<AsyncValue<List<Message>>> {
  ChatSearchNotifier(this.ref) : super(const AsyncValue.data([]));

  final Ref ref;

  Future<void> searchMessages(String query, {String? conversationId}) async {
    if (query.trim().isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    try {
      state = const AsyncValue.loading();
      final apiService = ref.read(chatApiServiceProvider);
      final messages = await apiService.searchMessages(
        query,
        conversationId: conversationId,
      );
      state = AsyncValue.data(messages);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void clearSearch() {
    state = const AsyncValue.data([]);
  }
}