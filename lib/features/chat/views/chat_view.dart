import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/chat_models.dart';
import '../providers/chat_providers.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/message_input.dart';
import '../widgets/typing_indicator.dart';

class ChatView extends ConsumerStatefulWidget {
  final String conversationId;

  const ChatView({
    super.key,
    required this.conversationId,
  });

  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _messageFocusNode = FocusNode();
  Message? _replyToMessage;
  bool _showScrollToBottomButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    
    // Mark conversation as read when entering
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(conversationsProvider.notifier).markAsRead(widget.conversationId);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  void _onScroll() {
    final showButton = _scrollController.hasClients && 
                     _scrollController.offset > 200;
    if (showButton != _showScrollToBottomButton) {
      setState(() {
        _showScrollToBottomButton = showButton;
      });
    }

    // Load more messages when scrolling to top
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 100) {
      ref.read(messagesProvider(widget.conversationId).notifier)
          .loadMessages(loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(messagesProvider(widget.conversationId));
    final users = ref.watch(usersProvider);
    final currentUser = ref.watch(currentUserProvider);
    final typingUsers = ref.watch(typingProvider(widget.conversationId));
    final conversations = ref.watch(conversationsProvider);

    return Scaffold(
      appBar: _buildAppBar(conversations, users),
      body: Column(
        children: [
          Expanded(
            child: messagesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => _buildErrorWidget(error),
              data: (messages) => _buildMessagesList(messages, users, currentUser, typingUsers),
            ),
          ),
          _buildMessageInput(),
        ],
      ),
      floatingActionButton: _showScrollToBottomButton
          ? FloatingActionButton.small(
              onPressed: _scrollToBottom,
              child: const Icon(Icons.keyboard_arrow_down),
            )
          : null,
    );
  }

  PreferredSizeWidget _buildAppBar(
    AsyncValue<List<Conversation>> conversations,
    AsyncValue<List<User>> users,
  ) {
    return AppBar(
      title: conversations.when(
        loading: () => const Text('Loading...'),
        error: (_, __) => const Text('Chat'),
        data: (convs) {
          final conversation = convs.cast<Conversation?>().firstWhere(
            (c) => c?.id == widget.conversationId,
            orElse: () => null,
          );
          
          if (conversation == null) return const Text('Chat');
          
          return _buildAppBarTitle(conversation, users);
        },
      ),
      actions: [
        IconButton(
          onPressed: () => _showSearchDialog(),
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () => _initiateVideoCall(),
          icon: const Icon(Icons.videocam),
        ),
        IconButton(
          onPressed: () => _initiateAudioCall(),
          icon: const Icon(Icons.call),
        ),
        PopupMenuButton<String>(
          onSelected: _handleMenuAction,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'view_profile',
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('View Profile'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'media_links',
              child: ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Media & Links'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'notifications',
              child: ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'clear_chat',
              child: ListTile(
                leading: Icon(Icons.clear_all),
                title: Text('Clear Chat'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'export_chat',
              child: ListTile(
                leading: Icon(Icons.file_download),
                title: Text('Export Chat'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAppBarTitle(Conversation conversation, AsyncValue<List<User>> users) {
    if (conversation.type == ConversationType.group) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            conversation.name ?? 'Group Chat',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            '${conversation.participantIds.length} members',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      );
    }

    // Direct chat
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return const Text('Chat');

    final otherUserId = conversation.participantIds
        .firstWhere((id) => id != currentUser.id, orElse: () => '');

    return users.when(
      loading: () => const Text('Loading...'),
      error: (_, __) => const Text('Chat'),
      data: (usersList) {
        final otherUser = usersList.cast<User?>().firstWhere(
          (u) => u?.id == otherUserId,
          orElse: () => null,
        );

        if (otherUser == null) return const Text('Chat');

        return Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: otherUser.avatar != null
                  ? ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: otherUser.avatar!,
                        fit: BoxFit.cover,
                        width: 32,
                        height: 32,
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        otherUser.name.isNotEmpty ? otherUser.name[0] : 'U',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  otherUser.name,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  _getUserStatusText(otherUser),
                  style: TextStyle(
                    fontSize: 12,
                    color: _getUserStatusColor(otherUser),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildMessagesList(
    List<Message> messages,
    AsyncValue<List<User>> users,
    User? currentUser,
    Map<String, bool> typingUsers,
  ) {
    if (messages.isEmpty) {
      return _buildEmptyState();
    }

    final typingUsersList = typingUsers.entries
        .where((entry) => entry.value && entry.key != currentUser?.id)
        .map((entry) => entry.key)
        .toList();

    return Stack(
      children: [
        ListView.builder(
          controller: _scrollController,
          reverse: true,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: messages.length + (typingUsersList.isNotEmpty ? 1 : 0),
          itemBuilder: (context, index) {
            // Show typing indicator at the bottom (index 0)
            if (index == 0 && typingUsersList.isNotEmpty) {
              return TypingIndicator(
                typingUsers: typingUsersList,
                isVisible: true,
              );
            }

            final messageIndex = typingUsersList.isNotEmpty ? index - 1 : index;
            final message = messages[messageIndex];
            final isCurrentUser = message.senderId == currentUser?.id;

            // Get sender info
            User? sender;
            users.whenData((usersList) {
              sender = usersList.cast<User?>().firstWhere(
                (u) => u?.id == message.senderId,
                orElse: () => null,
              );
            });

            return ChatBubble(
              message: message,
              sender: sender,
              isCurrentUser: isCurrentUser,
              showAvatar: !isCurrentUser,
              showTimestamp: true,
              onTap: () => _handleMessageTap(message),
              onLongPress: () => _showMessageOptions(message),
              onReaction: (emoji) => _addReaction(message.id, emoji),
              onReply: () => _setReplyMessage(message),
            );
          },
        ),
        if (_replyToMessage != null) _buildReplyOverlay(),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No messages yet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start the conversation by sending a message',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load messages',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => ref.refresh(messagesProvider(widget.conversationId)),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildReplyOverlay() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.9),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Replying to ${_replyToMessage?.senderId}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _replyToMessage?.content ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => _clearReplyMessage(),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return MessageInput(
      onSendMessage: _sendMessage,
      onTypingStart: _startTyping,
      onTypingStop: _stopTyping,
      replyToMessage: _replyToMessage,
      onCancelReply: _clearReplyMessage,
    );
  }

  void _sendMessage(String content, {MessageType type = MessageType.text, List<File>? attachments}) {
    ref.read(messagesProvider(widget.conversationId).notifier).sendMessage(
      content: content,
      type: type,
      attachments: attachments,
      replyToId: _replyToMessage?.id,
    );

    _clearReplyMessage();
    _scrollToBottom();
  }

  void _startTyping() {
    ref.read(typingProvider(widget.conversationId).notifier).setTyping(true);
  }

  void _stopTyping() {
    ref.read(typingProvider(widget.conversationId).notifier).setTyping(false);
  }

  void _handleMessageTap(Message message) {
    // Handle message tap (e.g., view media)
    if (message.type == MessageType.image || message.type == MessageType.video) {
      _showMediaViewer(message);
    }
  }

  void _showMessageOptions(Message message) {
    final currentUser = ref.read(currentUserProvider);
    final isCurrentUser = message.senderId == currentUser?.id;

    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.reply),
            title: const Text('Reply'),
            onTap: () {
              Navigator.pop(context);
              _setReplyMessage(message);
            },
          ),
          ListTile(
            leading: const Icon(Icons.copy),
            title: const Text('Copy'),
            onTap: () {
              Navigator.pop(context);
              _copyMessage(message);
            },
          ),
          ListTile(
            leading: const Icon(Icons.forward),
            title: const Text('Forward'),
            onTap: () {
              Navigator.pop(context);
              _forwardMessage(message);
            },
          ),
          if (isCurrentUser) ...[
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                _editMessage(message);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _deleteMessage(message);
              },
            ),
          ],
        ],
      ),
    );
  }

  void _addReaction(String messageId, String emoji) {
    ref.read(messagesProvider(widget.conversationId).notifier)
        .addReaction(messageId, emoji);
  }

  void _setReplyMessage(Message message) {
    setState(() {
      _replyToMessage = message;
    });
  }

  void _clearReplyMessage() {
    setState(() {
      _replyToMessage = null;
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _showSearchDialog() {
    // TODO: Implement message search dialog
  }

  void _initiateVideoCall() {
    // TODO: Implement video call
  }

  void _initiateAudioCall() {
    // TODO: Implement audio call
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'view_profile':
        _viewProfile();
        break;
      case 'media_links':
        _showMediaLinks();
        break;
      case 'notifications':
        _showNotificationSettings();
        break;
      case 'clear_chat':
        _clearChat();
        break;
      case 'export_chat':
        _exportChat();
        break;
    }
  }

  void _showMediaViewer(Message message) {
    // TODO: Implement media viewer
  }

  void _copyMessage(Message message) {
    // TODO: Implement copy to clipboard
  }

  void _forwardMessage(Message message) {
    // TODO: Implement forward message
  }

  void _editMessage(Message message) {
    // TODO: Implement edit message
  }

  void _deleteMessage(Message message) {
    // TODO: Implement delete message with confirmation
  }

  void _viewProfile() {
    // TODO: Navigate to user profile
  }

  void _showMediaLinks() {
    // TODO: Show media and links view
  }

  void _showNotificationSettings() {
    // TODO: Show notification settings
  }

  void _clearChat() {
    // TODO: Clear chat with confirmation
  }

  void _exportChat() {
    // TODO: Export chat history
  }

  String _getUserStatusText(User user) {
    switch (user.userStatus) {
      case UserStatus.online:
        return 'Online';
      case UserStatus.away:
        return 'Away';
      case UserStatus.busy:
        return 'Busy';
      case UserStatus.offline:
        return 'Last seen ${_formatLastSeen(user.lastSeen)}';
    }
  }

  Color _getUserStatusColor(User user) {
    switch (user.userStatus) {
      case UserStatus.online:
        return Colors.green;
      case UserStatus.away:
        return Colors.orange;
      case UserStatus.busy:
        return Colors.red;
      case UserStatus.offline:
        return Colors.grey;
    }
  }

  String _formatLastSeen(DateTime? lastSeen) {
    if (lastSeen == null) return 'unknown';
    
    final now = DateTime.now();
    final difference = now.difference(lastSeen);
    
    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}