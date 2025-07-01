import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/chat_models.dart';
import 'providers/chat_providers.dart';
import 'services/chat_api_service.dart';
import 'services/chat_websocket_service.dart';
import 'views/chat_list_view.dart';
import 'views/chat_view.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  String? selectedConversationId;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    try {
      // Initialize API service
      final apiService = ref.read(chatApiServiceProvider);
      apiService.initialize(
        baseUrl: 'http://localhost:3000/api', // Development URL
        authToken: 'demo_token', // In real app, get from auth service
        userId: 'current_user_id', // In real app, get from user service
      );

      // Initialize WebSocket service
      final webSocketService = ref.read(chatWebSocketServiceProvider);
      await webSocketService.connect('current_user_id', token: 'demo_token');

      // Set current user
      ref.read(currentUserProvider.notifier).state = const User(
        id: 'current_user_id',
        name: 'Current User',
        email: 'user@example.com',
        userStatus: UserStatus.online,
        isOnline: true,
      );

      // Load initial data
      await ref.read(conversationsProvider.notifier).loadConversations();
      await ref.read(usersProvider.notifier).loadUsers();

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      debugPrint('Failed to initialize chat: $e');
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to initialize chat: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Initializing Chat...'),
            ],
          ),
        ),
      );
    }

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
              child: ChatListView(
                onConversationSelected: (conversationId) {
                  setState(() {
                    selectedConversationId = conversationId;
                  });
                },
              ),
            ),
          ),
          // Chat view
          Expanded(
            child: selectedConversationId != null
                ? ChatView(conversationId: selectedConversationId!)
                : _buildEmptyState(),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowScreenLayout() {
    return Navigator(
      onGenerateRoute: (settings) {
        if (settings.name == '/chat' && settings.arguments is String) {
          final conversationId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => ChatView(conversationId: conversationId),
          );
        }
        
        return MaterialPageRoute(
          builder: (context) => ChatListView(
            onConversationSelected: (conversationId) {
              Navigator.of(context).pushNamed('/chat', arguments: conversationId);
            },
          ),
        );
      },
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
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => _startNewChat(),
              icon: const Icon(Icons.add),
              label: const Text('Start New Chat'),
            ),
          ],
        ),
      ),
    );
  }

  void _startNewChat() {
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
              subtitle: const Text('Chat with a specific person'),
              onTap: () {
                Navigator.pop(context);
                _showUserSelectionDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Create Group'),
              subtitle: const Text('Start a group conversation'),
              onTap: () {
                Navigator.pop(context);
                _showGroupCreationDialog();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showUserSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select User'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: Consumer(
            builder: (context, ref, child) {
              final usersAsync = ref.watch(usersProvider);
              
              return usersAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text('Error loading users: $error'),
                ),
                data: (users) => ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(user.name.isNotEmpty ? user.name[0] : 'U'),
                      ),
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      onTap: () => _createDirectChat(user),
                    );
                  },
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showGroupCreationDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final List<String> selectedUserIds = [];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Group'),
        content: SizedBox(
          width: double.maxFinite,
          height: 500,
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Group Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              const Text('Select Members:'),
              const SizedBox(height: 8),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final usersAsync = ref.watch(usersProvider);
                    
                    return usersAsync.when(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Center(
                        child: Text('Error loading users: $error'),
                      ),
                      data: (users) => ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          final isSelected = selectedUserIds.contains(user.id);
                          
                          return CheckboxListTile(
                            title: Text(user.name),
                            subtitle: Text(user.email),
                            value: isSelected,
                            onChanged: (selected) {
                              // setState for dialog would require StatefulBuilder
                              if (selected == true) {
                                selectedUserIds.add(user.id);
                              } else {
                                selectedUserIds.remove(user.id);
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => _createGroupChat(
              nameController.text,
              descriptionController.text,
              selectedUserIds,
            ),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  Future<void> _createDirectChat(User user) async {
    try {
      Navigator.pop(context); // Close user selection dialog
      
      final currentUser = ref.read(currentUserProvider);
      if (currentUser == null) return;

      await ref.read(conversationsProvider.notifier).createConversation(
        type: ConversationType.direct,
        participantIds: [currentUser.id, user.id],
      );

      // Refresh conversations to get the new one
      await ref.refresh(conversationsProvider.future);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Started chat with ${user.name}'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create chat: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _createGroupChat(
    String name,
    String description,
    List<String> selectedUserIds,
  ) async {
    try {
      Navigator.pop(context); // Close group creation dialog
      
      if (name.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Group name is required'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (selectedUserIds.length < 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Select at least 2 members for a group'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final currentUser = ref.read(currentUserProvider);
      if (currentUser == null) return;

      // Add current user to participants
      final participantIds = [currentUser.id, ...selectedUserIds];

      await ref.read(conversationsProvider.notifier).createConversation(
        type: ConversationType.group,
        participantIds: participantIds,
        name: name.trim(),
      );

      // Refresh conversations to get the new one
      await ref.refresh(conversationsProvider.future);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Created group "$name"'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create group: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    // Clean up WebSocket connection
    ref.read(chatWebSocketServiceProvider).disconnect();
    super.dispose();
  }
}