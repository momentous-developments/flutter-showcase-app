import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:crypto/crypto.dart';
import '../models/chat_models.dart';

class ChatApiService {
  static final ChatApiService _instance = ChatApiService._internal();
  factory ChatApiService() => _instance;
  ChatApiService._internal();

  late final Dio _dio;
  String? _authToken;
  String? _currentUserId;

  void initialize({
    required String baseUrl,
    String? authToken,
    String? userId,
  }) {
    _authToken = authToken;
    _currentUserId = userId;
    
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    ));

    // Add interceptors
    _dio.interceptors.add(LogInterceptor(
      requestBody: kDebugMode,
      responseBody: kDebugMode,
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        debugPrint('API Error: ${error.message}');
        handler.next(error);
      },
    ));
  }

  // Conversations
  Future<List<Conversation>> getConversations({
    int page = 1,
    int limit = 20,
    String? search,
  }) async {
    try {
      final response = await _dio.get('/conversations', queryParameters: {
        'page': page,
        'limit': limit,
        if (search != null) 'search': search,
      });

      final List<dynamic> data = response.data['conversations'] ?? [];
      return data.map((json) => Conversation.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching conversations: $e');
      throw _handleError(e);
    }
  }

  Future<Conversation?> getConversation(String conversationId) async {
    try {
      final response = await _dio.get('/conversations/$conversationId');
      return Conversation.fromJson(response.data);
    } catch (e) {
      debugPrint('Error fetching conversation: $e');
      throw _handleError(e);
    }
  }

  Future<Conversation> createConversation({
    required ConversationType type,
    required List<String> participantIds,
    String? name,
    String? description,
  }) async {
    try {
      final response = await _dio.post('/conversations', data: {
        'type': type.name,
        'participantIds': participantIds,
        if (name != null) 'name': name,
        if (description != null) 'description': description,
      });

      return Conversation.fromJson(response.data);
    } catch (e) {
      debugPrint('Error creating conversation: $e');
      throw _handleError(e);
    }
  }

  Future<Conversation> updateConversation(
    String conversationId,
    Map<String, dynamic> updates,
  ) async {
    try {
      final response = await _dio.patch('/conversations/$conversationId', data: updates);
      return Conversation.fromJson(response.data);
    } catch (e) {
      debugPrint('Error updating conversation: $e');
      throw _handleError(e);
    }
  }

  Future<void> deleteConversation(String conversationId) async {
    try {
      await _dio.delete('/conversations/$conversationId');
    } catch (e) {
      debugPrint('Error deleting conversation: $e');
      throw _handleError(e);
    }
  }

  // Messages
  Future<List<Message>> getMessages(
    String conversationId, {
    int page = 1,
    int limit = 50,
    String? before,
    String? after,
  }) async {
    try {
      final response = await _dio.get('/conversations/$conversationId/messages', 
        queryParameters: {
          'page': page,
          'limit': limit,
          if (before != null) 'before': before,
          if (after != null) 'after': after,
        },
      );

      final List<dynamic> data = response.data['messages'] ?? [];
      return data.map((json) => Message.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching messages: $e');
      throw _handleError(e);
    }
  }

  Future<Message> sendMessage({
    required String conversationId,
    required String content,
    MessageType type = MessageType.text,
    String? replyToId,
    List<File>? attachments,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'conversationId': conversationId,
        'content': content,
        'type': type.name,
        'senderId': _currentUserId,
        if (replyToId != null) 'replyToId': replyToId,
      });

      // Handle file attachments
      if (attachments != null && attachments.isNotEmpty) {
        for (int i = 0; i < attachments.length; i++) {
          final file = attachments[i];
          final fileName = path.basename(file.path);
          formData.files.add(MapEntry(
            'attachments',
            await MultipartFile.fromFile(file.path, filename: fileName),
          ));
        }
      }

      final response = await _dio.post('/messages', data: formData);
      return Message.fromJson(response.data);
    } catch (e) {
      debugPrint('Error sending message: $e');
      throw _handleError(e);
    }
  }

  Future<Message> editMessage(String messageId, String newContent) async {
    try {
      final response = await _dio.patch('/messages/$messageId', data: {
        'content': newContent,
        'isEdited': true,
        'editedAt': DateTime.now().toIso8601String(),
      });

      return Message.fromJson(response.data);
    } catch (e) {
      debugPrint('Error editing message: $e');
      throw _handleError(e);
    }
  }

  Future<void> deleteMessage(String messageId, {bool deleteForEveryone = false}) async {
    try {
      await _dio.delete('/messages/$messageId', queryParameters: {
        'deleteForEveryone': deleteForEveryone,
      });
    } catch (e) {
      debugPrint('Error deleting message: $e');
      throw _handleError(e);
    }
  }

  Future<List<Message>> searchMessages(
    String query, {
    String? conversationId,
    MessageType? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final response = await _dio.get('/messages/search', queryParameters: {
        'query': query,
        if (conversationId != null) 'conversationId': conversationId,
        if (type != null) 'type': type.name,
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
      });

      final List<dynamic> data = response.data['messages'] ?? [];
      return data.map((json) => Message.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error searching messages: $e');
      throw _handleError(e);
    }
  }

  // Users
  Future<List<User>> getUsers({
    String? search,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get('/users', queryParameters: {
        if (search != null) 'search': search,
        'page': page,
        'limit': limit,
      });

      final List<dynamic> data = response.data['users'] ?? [];
      return data.map((json) => User.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching users: $e');
      throw _handleError(e);
    }
  }

  Future<User?> getUser(String userId) async {
    try {
      final response = await _dio.get('/users/$userId');
      return User.fromJson(response.data);
    } catch (e) {
      debugPrint('Error fetching user: $e');
      throw _handleError(e);
    }
  }

  Future<User> updateUserProfile(Map<String, dynamic> updates) async {
    try {
      final response = await _dio.patch('/users/$_currentUserId', data: updates);
      return User.fromJson(response.data);
    } catch (e) {
      debugPrint('Error updating user profile: $e');
      throw _handleError(e);
    }
  }

  Future<void> blockUser(String userId) async {
    try {
      await _dio.post('/users/$userId/block');
    } catch (e) {
      debugPrint('Error blocking user: $e');
      throw _handleError(e);
    }
  }

  Future<void> unblockUser(String userId) async {
    try {
      await _dio.delete('/users/$userId/block');
    } catch (e) {
      debugPrint('Error unblocking user: $e');
      throw _handleError(e);
    }
  }

  // File upload
  Future<MessageAttachment> uploadFile(File file, AttachmentType type) async {
    try {
      final fileName = path.basename(file.path);
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
        'type': type.name,
      });

      final response = await _dio.post('/upload', data: formData);
      return MessageAttachment.fromJson(response.data);
    } catch (e) {
      debugPrint('Error uploading file: $e');
      throw _handleError(e);
    }
  }

  // Voice message
  Future<VoiceMessage> uploadVoiceMessage(
    File audioFile,
    int duration,
    List<double> waveform,
  ) async {
    try {
      final fileName = path.basename(audioFile.path);
      final formData = FormData.fromMap({
        'audio': await MultipartFile.fromFile(audioFile.path, filename: fileName),
        'duration': duration,
        'waveform': jsonEncode(waveform),
      });

      final response = await _dio.post('/voice-messages', data: formData);
      return VoiceMessage.fromJson(response.data);
    } catch (e) {
      debugPrint('Error uploading voice message: $e');
      throw _handleError(e);
    }
  }

  // Message reactions
  Future<void> addReaction(String messageId, String emoji) async {
    try {
      await _dio.post('/messages/$messageId/reactions', data: {
        'emoji': emoji,
        'userId': _currentUserId,
      });
    } catch (e) {
      debugPrint('Error adding reaction: $e');
      throw _handleError(e);
    }
  }

  Future<void> removeReaction(String messageId, String emoji) async {
    try {
      await _dio.delete('/messages/$messageId/reactions', data: {
        'emoji': emoji,
        'userId': _currentUserId,
      });
    } catch (e) {
      debugPrint('Error removing reaction: $e');
      throw _handleError(e);
    }
  }

  // Chat settings
  Future<ChatSettings> getChatSettings() async {
    try {
      final response = await _dio.get('/users/$_currentUserId/chat-settings');
      return ChatSettings.fromJson(response.data);
    } catch (e) {
      debugPrint('Error fetching chat settings: $e');
      throw _handleError(e);
    }
  }

  Future<ChatSettings> updateChatSettings(ChatSettings settings) async {
    try {
      final response = await _dio.put('/users/$_currentUserId/chat-settings', 
        data: settings.toJson());
      return ChatSettings.fromJson(response.data);
    } catch (e) {
      debugPrint('Error updating chat settings: $e');
      throw _handleError(e);
    }
  }

  // Encryption
  String encryptMessage(String message, String key) {
    final bytes = utf8.encode(message);
    final keyBytes = utf8.encode(key);
    final hmacSha256 = Hmac(sha256, keyBytes);
    final digest = hmacSha256.convert(bytes);
    return base64.encode(bytes) + '.' + digest.toString();
  }

  String decryptMessage(String encryptedMessage, String key) {
    final parts = encryptedMessage.split('.');
    if (parts.length != 2) throw Exception('Invalid encrypted message format');
    
    final messageBytes = base64.decode(parts[0]);
    final expectedDigest = parts[1];
    
    final keyBytes = utf8.encode(key);
    final hmacSha256 = Hmac(sha256, keyBytes);
    final actualDigest = hmacSha256.convert(messageBytes).toString();
    
    if (expectedDigest != actualDigest) {
      throw Exception('Message integrity check failed');
    }
    
    return utf8.decode(messageBytes);
  }

  // Chat backup
  Future<String> exportChatHistory(String conversationId) async {
    try {
      final response = await _dio.get('/conversations/$conversationId/export');
      return response.data['downloadUrl'];
    } catch (e) {
      debugPrint('Error exporting chat history: $e');
      throw _handleError(e);
    }
  }

  Future<void> importChatHistory(File backupFile) async {
    try {
      final formData = FormData.fromMap({
        'backup': await MultipartFile.fromFile(backupFile.path),
      });

      await _dio.post('/chat/import', data: formData);
    } catch (e) {
      debugPrint('Error importing chat history: $e');
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          return Exception('Connection timeout. Please check your internet connection.');
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          final message = error.response?.data?['message'] ?? 'Server error';
          return Exception('Server error ($statusCode): $message');
        case DioExceptionType.cancel:
          return Exception('Request was cancelled');
        default:
          return Exception('Network error: ${error.message}');
      }
    }
    return Exception('Unexpected error: $error');
  }

  void updateAuthToken(String token) {
    _authToken = token;
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void setCurrentUserId(String userId) {
    _currentUserId = userId;
  }
}