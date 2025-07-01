import 'package:flutter/material.dart';
import 'models/simple_chat_models.dart';

class SimpleChatPage extends StatefulWidget {
  const SimpleChatPage({super.key});

  @override
  State<SimpleChatPage> createState() => _SimpleChatPageState();
}

class _SimpleChatPageState extends State<SimpleChatPage> {
  String? selectedConversationId;
  final List<User> _users = [
    const User(
      id: 'user1',
      name: 'Alice Johnson',
      email: 'alice@example.com',
      userStatus: UserStatus.online,
      isOnline: true,
    ),
    const User(
      id: 'user2',
      name: 'Bob Smith',
      email: 'bob@example.com',
      userStatus: UserStatus.away,
      isOnline: false,
    ),
    const User(
      id: 'user3',
      name: 'Carol Davis',
      email: 'carol@example.com',
      userStatus: UserStatus.busy,
      isOnline: true,
    ),
    const User(
      id: 'user4',
      name: 'David Wilson',
      email: 'david@example.com',
      userStatus: UserStatus.offline,
      isOnline: false,
    ),
  ];

  final List<Conversation> _conversations = [
    const Conversation(
      id: 'conv1',
      name: 'Alice Johnson',
      type: ConversationType.direct,
      participantIds: ['current_user', 'user1'],
      lastActivity: null,
      unreadCount: 3,
    ),
    const Conversation(
      id: 'conv2',
      name: 'Bob Smith',
      type: ConversationType.direct,
      participantIds: ['current_user', 'user2'],
      lastActivity: null,
      unreadCount: 0,
    ),
    const Conversation(
      id: 'conv3',
      name: 'Team Chat',
      type: ConversationType.group,
      participantIds: ['current_user', 'user1', 'user2', 'user3'],
      lastActivity: null,
      unreadCount: 1,
    ),
    const Conversation(
      id: 'conv4',
      name: 'Carol Davis',
      type: ConversationType.direct,
      participantIds: ['current_user', 'user3'],
      lastActivity: null,
      unreadCount: 0,
    ),
  ];

  final List<Message> _messages = [
    const Message(
      id: 'msg1',
      conversationId: 'conv1',
      senderId: 'user1',
      content: 'Hey! How are you doing?',
      timestamp: null,
      status: MessageStatus.read,
    ),
    const Message(
      id: 'msg2',
      conversationId: 'conv1',
      senderId: 'current_user',
      content: 'I\'m doing great! Thanks for asking. How about you?',
      timestamp: null,
      status: MessageStatus.read,
    ),
    const Message(
      id: 'msg3',
      conversationId: 'conv1',
      senderId: 'user1',
      content: 'Pretty good! Working on some exciting projects.',
      timestamp: null,
      status: MessageStatus.delivered,
    ),
    const Message(
      id: 'msg4',
      conversationId: 'conv3',
      senderId: 'user2',
      content: 'Welcome to the team chat everyone!',
      timestamp: null,
      status: MessageStatus.read,
    ),
    const Message(
      id: 'msg5',
      conversationId: 'conv3',
      senderId: 'user1',
      content: 'Thanks Bob! Excited to be here.',
      timestamp: null,
      status: MessageStatus.read,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth > 600;
        
        if (isWideScreen) {
          return _buildWideScreenLayout();
        } else {
          return _buildNarrowScreenLayout();
        }
      },
    );
  }

  Widget _buildWideScreenLayout() {
    return Scaffold(
      body: Row(
        children: [
          // Chat list sidebar
          SizedBox(
            width: 350,
            child: Card(
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: _buildChatList(),
            ),
          ),
          // Chat view
          Expanded(
            child: selectedConversationId != null
                ? _buildChatView()
                : _buildEmptyState(),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowScreenLayout() {
    if (selectedConversationId != null) {
      return _buildChatView();
    }
    return _buildChatList();
  }

  Widget _buildChatList() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'new_group',
                child: ListTile(
                  leading: Icon(Icons.group_add),
                  title: Text('New Group'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _conversations.length,
        itemBuilder: (context, index) {
          final conversation = _conversations[index];
          final user = _getUserForConversation(conversation);
          final lastMessage = _getLastMessage(conversation.id);
          
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: ListTile(
              leading: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      conversation.type == ConversationType.group
                          ? 'G'
                          : (user?.name.isNotEmpty ?? false)
                              ? user!.name[0].toUpperCase()
                              : 'U',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  if (conversation.type == ConversationType.direct && user?.isOnline == true)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.surface,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              title: Text(
                conversation.name ?? user?.name ?? 'Unknown',
                style: TextStyle(
                  fontWeight: conversation.unreadCount > 0 
                      ? FontWeight.bold 
                      : FontWeight.normal,
                ),
              ),
              subtitle: Text(
                lastMessage?.content ?? 'No messages yet',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: conversation.unreadCount > 0 
                      ? FontWeight.w500 
                      : FontWeight.normal,
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    '12:30 PM',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  if (conversation.unreadCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                      child: Text(
                        conversation.unreadCount > 99 
                            ? '99+' 
                            : conversation.unreadCount.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onError,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
              onTap: () => _selectConversation(conversation.id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewChatDialog,
        child: const Icon(Icons.chat),
      ),
    );
  }

  Widget _buildChatView() {
    final conversation = _conversations.firstWhere(
      (c) => c.id == selectedConversationId,
    );
    final messages = _messages.where((m) => m.conversationId == selectedConversationId).toList();
    final user = _getUserForConversation(conversation);

    return Scaffold(
      appBar: AppBar(
        leading: MediaQuery.of(context).size.width <= 600
            ? IconButton(
                onPressed: () => setState(() {
                  selectedConversationId = null;
                }),
                icon: const Icon(Icons.arrow_back),
              )
            : null,
        automaticallyImplyLeading: MediaQuery.of(context).size.width <= 600,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              radius: 16,
              child: Text(
                conversation.type == ConversationType.group
                    ? 'G'
                    : (user?.name.isNotEmpty ?? false)
                        ? user!.name[0].toUpperCase()
                        : 'U',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conversation.name ?? user?.name ?? 'Unknown',
                  style: const TextStyle(fontSize: 16),
                ),
                if (conversation.type == ConversationType.direct && user != null)
                  Text(
                    _getUserStatusText(user),
                    style: TextStyle(
                      fontSize: 12,
                      color: _getUserStatusColor(user),
                    ),
                  ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {},
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
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? _buildEmptyMessagesState()
                : ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[messages.length - 1 - index];
                      final isCurrentUser = message.senderId == 'current_user';
                      final sender = _users.firstWhere(
                        (u) => u.id == message.senderId,
                        orElse: () => const User(
                          id: 'current_user',
                          name: 'You',
                          email: 'you@example.com',
                        ),
                      );

                      return _buildMessageBubble(message, sender, isCurrentUser);
                    },
                  ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message, User sender, bool isCurrentUser) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isCurrentUser) ...[
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              radius: 16,
              child: Text(
                sender.name.isNotEmpty ? sender.name[0].toUpperCase() : 'U',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: BoxDecoration(
                color: isCurrentUser
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isCurrentUser ? 16 : 4),
                  bottomRight: Radius.circular(isCurrentUser ? 4 : 16),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isCurrentUser)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        sender.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  Text(
                    message.content,
                    style: TextStyle(
                      color: isCurrentUser
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '12:30 PM',
                        style: TextStyle(
                          fontSize: 10,
                          color: isCurrentUser
                              ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.7)
                              : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      if (isCurrentUser) ...[
                        const SizedBox(width: 4),
                        Icon(
                          _getStatusIcon(message.status),
                          size: 12,
                          color: message.status == MessageStatus.read
                              ? Colors.blue
                              : Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isCurrentUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              radius: 16,
              child: Text(
                'Y',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                maxLines: 5,
                minLines: 1,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 120,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome to Chat',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Select a conversation from the sidebar to start chatting',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyMessagesState() {
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

  User? _getUserForConversation(Conversation conversation) {
    if (conversation.type == ConversationType.direct) {
      final otherUserId = conversation.participantIds
          .firstWhere((id) => id != 'current_user', orElse: () => '');
      return _users.cast<User?>().firstWhere(
        (u) => u?.id == otherUserId,
        orElse: () => null,
      );
    }
    return null;
  }

  Message? _getLastMessage(String conversationId) {
    final messages = _messages.where((m) => m.conversationId == conversationId).toList();
    return messages.isNotEmpty ? messages.last : null;
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
        return 'Last seen recently';
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

  IconData _getStatusIcon(MessageStatus status) {
    switch (status) {
      case MessageStatus.sending:
        return Icons.schedule;
      case MessageStatus.sent:
        return Icons.check;
      case MessageStatus.delivered:
        return Icons.done_all;
      case MessageStatus.read:
        return Icons.done_all;
      case MessageStatus.failed:
        return Icons.error;
    }
  }

  void _selectConversation(String conversationId) {
    setState(() {
      selectedConversationId = conversationId;
    });
  }

  void _handleMenuAction(String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$action selected')),
    );
  }

  void _showNewChatDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Start New Chat'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Direct Message'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Start Direct Message')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Create Group'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Create Group Chat')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}