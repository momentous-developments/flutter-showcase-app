import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../models/chat_models.dart';

class ChatWebSocketService {
  static final ChatWebSocketService _instance = ChatWebSocketService._internal();
  factory ChatWebSocketService() => _instance;
  ChatWebSocketService._internal();

  io.Socket? _socket;
  bool _isConnected = false;
  String? _currentUserId;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  static const int maxReconnectAttempts = 5;

  // Stream controllers for real-time events
  final StreamController<Message> _messageController = StreamController<Message>.broadcast();
  final StreamController<MessageStatus> _messageStatusController = StreamController<MessageStatus>.broadcast();
  final StreamController<TypingStatus> _typingController = StreamController<TypingStatus>.broadcast();
  final StreamController<User> _userStatusController = StreamController<User>.broadcast();
  final StreamController<bool> _connectionController = StreamController<bool>.broadcast();
  final StreamController<CallSession> _callController = StreamController<CallSession>.broadcast();
  final StreamController<MessageReaction> _reactionController = StreamController<MessageReaction>.broadcast();

  // Getters for streams
  Stream<Message> get messageStream => _messageController.stream;
  Stream<MessageStatus> get messageStatusStream => _messageStatusController.stream;
  Stream<TypingStatus> get typingStream => _typingController.stream;
  Stream<User> get userStatusStream => _userStatusController.stream;
  Stream<bool> get connectionStream => _connectionController.stream;
  Stream<CallSession> get callStream => _callController.stream;
  Stream<MessageReaction> get reactionStream => _reactionController.stream;

  bool get isConnected => _isConnected;

  Future<void> connect(String userId, {String? token}) async {
    try {
      _currentUserId = userId;
      
      final options = io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setExtraHeaders({'Authorization': 'Bearer ${token ?? ''}'})
          .build();

      // Use localhost for development, replace with actual server URL
      _socket = io.io('http://localhost:3000', options);

      _socket!.onConnect((_) {
        debugPrint('WebSocket connected');
        _isConnected = true;
        _reconnectAttempts = 0;
        _connectionController.add(true);
        _startHeartbeat();
        
        // Join user room for direct messages
        _socket!.emit('join-user', {'userId': userId});
      });

      _socket!.onDisconnect((_) {
        debugPrint('WebSocket disconnected');
        _isConnected = false;
        _connectionController.add(false);
        _stopHeartbeat();
        _scheduleReconnect();
      });

      _socket!.onConnectError((error) {
        debugPrint('WebSocket connection error: $error');
        _isConnected = false;
        _connectionController.add(false);
        _scheduleReconnect();
      });

      _socket!.onError((error) {
        debugPrint('WebSocket error: $error');
      });

      // Set up event listeners
      _setupEventListeners();

    } catch (e) {
      debugPrint('Failed to connect WebSocket: $e');
      _scheduleReconnect();
    }
  }

  void _setupEventListeners() {
    // New message received
    _socket!.on('message', (data) {
      try {
        final message = Message.fromJson(data);
        _messageController.add(message);
      } catch (e) {
        debugPrint('Error parsing message: $e');
      }
    });

    // Message status update
    _socket!.on('message-status', (data) {
      try {
        final status = MessageStatus.values.firstWhere(
          (s) => s.name == data['status'],
          orElse: () => MessageStatus.sent,
        );
        _messageStatusController.add(status);
      } catch (e) {
        debugPrint('Error parsing message status: $e');
      }
    });

    // Typing indicator
    _socket!.on('typing', (data) {
      try {
        final typing = TypingStatus.fromJson(data);
        _typingController.add(typing);
      } catch (e) {
        debugPrint('Error parsing typing status: $e');
      }
    });

    // User status update
    _socket!.on('user-status', (data) {
      try {
        final user = User.fromJson(data);
        _userStatusController.add(user);
      } catch (e) {
        debugPrint('Error parsing user status: $e');
      }
    });

    // Call events
    _socket!.on('call-incoming', (data) {
      try {
        final call = CallSession.fromJson(data);
        _callController.add(call);
      } catch (e) {
        debugPrint('Error parsing call session: $e');
      }
    });

    // Message reactions
    _socket!.on('reaction', (data) {
      try {
        final reaction = MessageReaction.fromJson(data);
        _reactionController.add(reaction);
      } catch (e) {
        debugPrint('Error parsing reaction: $e');
      }
    });
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (_isConnected) {
        _socket!.emit('ping');
      }
    });
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  void _scheduleReconnect() {
    if (_reconnectAttempts >= maxReconnectAttempts) {
      debugPrint('Max reconnection attempts reached');
      return;
    }

    _reconnectTimer?.cancel();
    final delay = Duration(seconds: (2 << _reconnectAttempts).clamp(1, 30));
    
    _reconnectTimer = Timer(delay, () {
      _reconnectAttempts++;
      debugPrint('Attempting to reconnect (attempt $_reconnectAttempts)');
      if (_currentUserId != null) {
        connect(_currentUserId!);
      }
    });
  }

  // Send message
  Future<void> sendMessage(Message message) async {
    if (!_isConnected) {
      throw Exception('WebSocket not connected');
    }

    _socket!.emit('send-message', message.toJson());
  }

  // Update message status
  Future<void> updateMessageStatus(String messageId, MessageStatus status) async {
    if (!_isConnected) return;

    _socket!.emit('message-status', {
      'messageId': messageId,
      'status': status.name,
      'userId': _currentUserId,
    });
  }

  // Send typing indicator
  Future<void> sendTyping(String conversationId, bool isTyping) async {
    if (!_isConnected) return;

    _socket!.emit('typing', {
      'conversationId': conversationId,
      'userId': _currentUserId,
      'isTyping': isTyping,
    });
  }

  // Update user status
  Future<void> updateUserStatus(UserStatus status) async {
    if (!_isConnected) return;

    _socket!.emit('user-status', {
      'userId': _currentUserId,
      'status': status.name,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // Join conversation room
  Future<void> joinConversation(String conversationId) async {
    if (!_isConnected) return;

    _socket!.emit('join-conversation', {
      'conversationId': conversationId,
      'userId': _currentUserId,
    });
  }

  // Leave conversation room
  Future<void> leaveConversation(String conversationId) async {
    if (!_isConnected) return;

    _socket!.emit('leave-conversation', {
      'conversationId': conversationId,
      'userId': _currentUserId,
    });
  }

  // Send message reaction
  Future<void> sendReaction(String messageId, String emoji) async {
    if (!_isConnected) return;

    _socket!.emit('reaction', {
      'messageId': messageId,
      'emoji': emoji,
      'userId': _currentUserId,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // Remove message reaction
  Future<void> removeReaction(String messageId, String emoji) async {
    if (!_isConnected) return;

    _socket!.emit('remove-reaction', {
      'messageId': messageId,
      'emoji': emoji,
      'userId': _currentUserId,
    });
  }

  // Initiate call
  Future<void> initiateCall(String conversationId, CallType type) async {
    if (!_isConnected) return;

    _socket!.emit('initiate-call', {
      'conversationId': conversationId,
      'initiatorId': _currentUserId,
      'type': type.name,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // Accept call
  Future<void> acceptCall(String callId) async {
    if (!_isConnected) return;

    _socket!.emit('accept-call', {
      'callId': callId,
      'userId': _currentUserId,
    });
  }

  // Decline call
  Future<void> declineCall(String callId) async {
    if (!_isConnected) return;

    _socket!.emit('decline-call', {
      'callId': callId,
      'userId': _currentUserId,
    });
  }

  // End call
  Future<void> endCall(String callId) async {
    if (!_isConnected) return;

    _socket!.emit('end-call', {
      'callId': callId,
      'userId': _currentUserId,
    });
  }

  Future<void> disconnect() async {
    _stopHeartbeat();
    _reconnectTimer?.cancel();
    
    if (_socket != null) {
      _socket!.disconnect();
      _socket!.dispose();
      _socket = null;
    }
    
    _isConnected = false;
    _currentUserId = null;
    _reconnectAttempts = 0;
    _connectionController.add(false);
  }

  void dispose() {
    disconnect();
    _messageController.close();
    _messageStatusController.close();
    _typingController.close();
    _userStatusController.close();
    _connectionController.close();
    _callController.close();
    _reactionController.close();
  }
}