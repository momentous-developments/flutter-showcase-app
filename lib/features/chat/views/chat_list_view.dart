import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_models.dart';
import '../providers/chat_providers.dart';
import '../widgets/user_list_item.dart';

class ChatListView extends ConsumerStatefulWidget {
  final Function(String conversationId)? onConversationSelected;
  final Function(User user)? onUserSelected;

  const ChatListView({
    super.key,
    this.onConversationSelected,
    this.onUserSelected,
  });

  @override
  ConsumerState<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends ConsumerState<ChatListView>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  String _searchQuery = '';
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _searchController.addListener(_onSearchChanged);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _isSearching = _searchQuery.isNotEmpty;
    });
  }

  void _onScroll() {
    // Implement pagination if needed
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      // Load more conversations
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : const Text('Chats'),
        actions: [
          IconButton(
            onPressed: _toggleSearch,
            icon: Icon(_isSearching ? Icons.close : Icons.search),
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
                value: 'new_broadcast',
                child: ListTile(
                  leading: Icon(Icons.campaign),
                  title: Text('New Broadcast'),
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
        bottom: _isSearching ? null : TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Unread'),
            Tab(text: 'Groups'),
            Tab(text: 'Archived'),
          ],
        ),
      ),
      body: _isSearching ? _buildSearchResults() : _buildTabView(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewChatDialog,
        child: const Icon(Icons.chat),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search conversations...',
        border: InputBorder.none,
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchQuery.isEmpty) {
      return const Center(
        child: Text('Start typing to search...'),
      );
    }

    return Column(
      children: [
        _buildSearchFilters(),
        Expanded(child: _buildConversationsList(searchQuery: _searchQuery)),
      ],
    );
  }

  Widget _buildSearchFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          FilterChip(
            label: const Text('Messages'),
            selected: true,
            onSelected: (selected) {},
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('Users'),
            selected: false,
            onSelected: (selected) {},
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('Groups'),
            selected: false,
            onSelected: (selected) {},
          ),
        ],
      ),
    );
  }

  Widget _buildTabView() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildConversationsList(), // All
        _buildConversationsList(unreadOnly: true), // Unread
        _buildConversationsList(groupsOnly: true), // Groups
        _buildConversationsList(archivedOnly: true), // Archived
      ],
    );
  }

  Widget _buildConversationsList({
    bool unreadOnly = false,
    bool groupsOnly = false,
    bool archivedOnly = false,
    String? searchQuery,
  }) {
    final conversationsAsync = ref.watch(conversationsProvider);
    final users = ref.watch(usersProvider);
    final selectedConversation = ref.watch(selectedConversationProvider);

    return conversationsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
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
              'Failed to load conversations',
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
              onPressed: () => ref.refresh(conversationsProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (conversations) {
        var filteredConversations = conversations;

        // Apply filters
        if (unreadOnly) {
          filteredConversations = filteredConversations
              .where((c) => c.unreadCount > 0)
              .toList();
        }
        if (groupsOnly) {
          filteredConversations = filteredConversations
              .where((c) => c.type == ConversationType.group)
              .toList();
        }
        if (archivedOnly) {
          filteredConversations = filteredConversations
              .where((c) => c.isArchived)
              .toList();
        }

        // Apply search
        if (searchQuery != null && searchQuery.isNotEmpty) {
          filteredConversations = filteredConversations
              .where((c) => 
                  c.name?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false)
              .toList();
        }

        if (filteredConversations.isEmpty) {
          return _buildEmptyState();
        }

        return RefreshIndicator(
          onRefresh: () async {
            await ref.refresh(conversationsProvider.future);
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: filteredConversations.length,
            itemBuilder: (context, index) {
              final conversation = filteredConversations[index];
              return _buildConversationItem(
                conversation, 
                selectedConversation == conversation.id,
                users,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildConversationItem(
    Conversation conversation, 
    bool isSelected,
    AsyncValue<List<User>> usersAsync,
  ) {
    // Get the other participant for direct chats
    User? otherUser;
    if (conversation.type == ConversationType.direct && 
        conversation.participantIds.length >= 2) {
      final currentUser = ref.read(currentUserProvider);
      if (currentUser != null) {
        final otherUserId = conversation.participantIds
            .firstWhere((id) => id != currentUser.id, orElse: () => '');
        
        usersAsync.whenData((users) {
          otherUser = users.cast<User?>().firstWhere(
            (u) => u?.id == otherUserId,
            orElse: () => null,
          );
        });
      }
    }

    final displayName = conversation.name ?? otherUser?.name ?? 'Unknown';
    final avatar = conversation.avatar ?? otherUser?.avatar;
    final isOnline = otherUser?.isOnline ?? false;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: UserListItem(
        user: otherUser ?? User(
          id: conversation.id,
          name: displayName,
          email: '',
          avatar: avatar,
        ),
        lastMessage: 'Last message...', // TODO: Get actual last message
        lastMessageTime: conversation.lastActivity,
        unreadCount: conversation.unreadCount,
        isOnline: isOnline,
        isSelected: isSelected,
        onTap: () => _selectConversation(conversation.id),
        onLongPress: () => _showConversationOptions(conversation),
      ),
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
            'No conversations yet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start a conversation by tapping the chat button',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _searchQuery = '';
      }
    });
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'new_group':
        _showNewGroupDialog();
        break;
      case 'new_broadcast':
        _showNewBroadcastDialog();
        break;
      case 'settings':
        _navigateToSettings();
        break;
    }
  }

  void _selectConversation(String conversationId) {
    ref.read(selectedConversationProvider.notifier).state = conversationId;
    widget.onConversationSelected?.call(conversationId);
  }

  void _showConversationOptions(Conversation conversation) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(conversation.isPinned ? Icons.push_pin : Icons.push_pin_outlined),
            title: Text(conversation.isPinned ? 'Unpin' : 'Pin'),
            onTap: () {
              Navigator.pop(context);
              _togglePin(conversation);
            },
          ),
          ListTile(
            leading: Icon(conversation.isMuted ? Icons.notifications : Icons.notifications_off),
            title: Text(conversation.isMuted ? 'Unmute' : 'Mute'),
            onTap: () {
              Navigator.pop(context);
              _toggleMute(conversation);
            },
          ),
          ListTile(
            leading: const Icon(Icons.archive),
            title: const Text('Archive'),
            onTap: () {
              Navigator.pop(context);
              _archiveConversation(conversation);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('Delete', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              _deleteConversation(conversation);
            },
          ),
        ],
      ),
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
                _showUserSelectionDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Create Group'),
              onTap: () {
                Navigator.pop(context);
                _showNewGroupDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showUserSelectionDialog() {
    // TODO: Implement user selection dialog
  }

  void _showNewGroupDialog() {
    // TODO: Implement new group dialog
  }

  void _showNewBroadcastDialog() {
    // TODO: Implement new broadcast dialog
  }

  void _navigateToSettings() {
    // TODO: Navigate to chat settings
  }

  void _togglePin(Conversation conversation) {
    // TODO: Implement pin/unpin
  }

  void _toggleMute(Conversation conversation) {
    // TODO: Implement mute/unmute
  }

  void _archiveConversation(Conversation conversation) {
    // TODO: Implement archive
  }

  void _deleteConversation(Conversation conversation) {
    // TODO: Implement delete with confirmation
  }
}