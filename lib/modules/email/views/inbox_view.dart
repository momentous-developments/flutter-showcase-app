import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/email_models.dart';
import '../providers/email_providers.dart';
import '../widgets/email_list_item.dart';

class InboxView extends ConsumerStatefulWidget {
  final String? folderId;

  const InboxView({
    super.key,
    this.folderId,
  });

  @override
  ConsumerState<InboxView> createState() => _InboxViewState();
}

class _InboxViewState extends ConsumerState<InboxView>
    with TickerProviderStateMixin {
  late final AnimationController _fabAnimationController;
  late final Animation<double> _fabAnimation;
  final ScrollController _scrollController = ScrollController();
  bool _showFab = true;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _fabAnimation = CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.easeInOut,
    );
    _fabAnimationController.forward();

    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_showFab) {
        _fabAnimationController.reverse();
        setState(() => _showFab = false);
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_showFab) {
        _fabAnimationController.forward();
        setState(() => _showFab = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedEmails = ref.watch(selectedEmailsProvider);
    final quickFilters = ref.watch(quickFiltersProvider);
    final emailSort = ref.watch(emailSortProvider);

    return Scaffold(
      body: Column(
        children: [
          _buildToolbar(context, selectedEmails, quickFilters),
          if (selectedEmails.isNotEmpty) _buildBulkActions(),
          _buildFilterBar(quickFilters, emailSort),
          Expanded(child: _buildEmailList()),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabAnimation,
        child: FloatingActionButton(
          onPressed: _composeEmail,
          child: const Icon(Icons.edit),
        ),
      ),
    );
  }

  Widget _buildToolbar(
    BuildContext context,
    Set<String> selectedEmails,
    Map<String, bool> quickFilters,
  ) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          if (selectedEmails.isNotEmpty)
            Checkbox(
              value: true,
              onChanged: (_) => _clearSelection(),
            )
          else
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              selectedEmails.isNotEmpty
                  ? '${selectedEmails.length} selected'
                  : _getFolderTitle(),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearch,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refresh,
          ),
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'select_all',
                enabled: selectedEmails.isEmpty,
                child: const ListTile(
                  leading: Icon(Icons.select_all),
                  title: Text('Select all'),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'mark_all_read',
                child: ListTile(
                  leading: Icon(Icons.mark_email_read),
                  title: Text('Mark all as read'),
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBulkActions() {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(0.3),
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.mark_email_read),
            onPressed: _markSelectedAsRead,
            tooltip: 'Mark as read',
          ),
          IconButton(
            icon: const Icon(Icons.mark_email_unread),
            onPressed: _markSelectedAsUnread,
            tooltip: 'Mark as unread',
          ),
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: _starSelected,
            tooltip: 'Add star',
          ),
          IconButton(
            icon: const Icon(Icons.label_important),
            onPressed: _markSelectedAsImportant,
            tooltip: 'Mark as important',
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.archive),
            onPressed: _archiveSelected,
            tooltip: 'Archive',
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteSelected,
            tooltip: 'Delete',
          ),
          PopupMenuButton<String>(
            onSelected: _handleBulkAction,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'move',
                child: ListTile(
                  leading: Icon(Icons.folder),
                  title: Text('Move to folder'),
                ),
              ),
              const PopupMenuItem(
                value: 'labels',
                child: ListTile(
                  leading: Icon(Icons.label),
                  title: Text('Add labels'),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'spam',
                child: ListTile(
                  leading: Icon(Icons.report),
                  title: Text('Report spam'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(Map<String, bool> quickFilters, EmailSort emailSort) {
    final theme = Theme.of(context);
    
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          _buildFilterChip('Unread', 'unread', quickFilters),
          const SizedBox(width: 8),
          _buildFilterChip('Starred', 'starred', quickFilters),
          const SizedBox(width: 8),
          _buildFilterChip('Important', 'important', quickFilters),
          const SizedBox(width: 8),
          _buildFilterChip('Attachments', 'attachments', quickFilters),
          const Spacer(),
          PopupMenuButton<EmailSortField>(
            child: Chip(
              label: Text('Sort: ${emailSort.field.name}'),
              avatar: Icon(
                emailSort.ascending ? Icons.arrow_upward : Icons.arrow_downward,
                size: 16,
              ),
            ),
            onSelected: (field) => _updateSort(field),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: EmailSortField.date,
                child: Text('Date'),
              ),
              const PopupMenuItem(
                value: EmailSortField.sender,
                child: Text('Sender'),
              ),
              const PopupMenuItem(
                value: EmailSortField.subject,
                child: Text('Subject'),
              ),
              const PopupMenuItem(
                value: EmailSortField.size,
                child: Text('Size'),
              ),
              const PopupMenuItem(
                value: EmailSortField.importance,
                child: Text('Importance'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String key, Map<String, bool> filters) {
    final isActive = filters[key] == true;
    
    return FilterChip(
      label: Text(label),
      selected: isActive,
      onSelected: (selected) => _toggleFilter(key, selected),
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }

  Widget _buildEmailList() {
    final emailsParams = EmailsParams(
      folderId: widget.folderId,
      filter: _buildSearchFilter(),
    );
    
    return ref.watch(emailsProvider(emailsParams)).when(
      data: (emails) => _buildEmailListView(emails),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => _buildErrorView(error),
    );
  }

  Widget _buildEmailListView(List<Email> emails) {
    if (emails.isEmpty) {
      return _buildEmptyView();
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: emails.length,
        itemBuilder: (context, index) {
          final email = emails[index];
          return EmailListItem(
            email: email,
            onTap: () => _openEmail(email),
            onLongPress: () => _toggleEmailSelection(email.id),
          );
        },
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
          ),
          const SizedBox(height: 16),
          Text(
            'No emails found',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your inbox is empty or no emails match the current filters.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.edit),
            label: const Text('Compose Email'),
            onPressed: _composeEmail,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(Object error) {
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
            'Error loading emails',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            onPressed: _refresh,
          ),
        ],
      ),
    );
  }

  String _getFolderTitle() {
    // TODO: Get folder name from folder ID
    switch (widget.folderId) {
      case 'inbox':
        return 'Inbox';
      case 'sent':
        return 'Sent';
      case 'drafts':
        return 'Drafts';
      case 'trash':
        return 'Trash';
      case 'spam':
        return 'Spam';
      case 'archive':
        return 'Archive';
      default:
        return 'Emails';
    }
  }

  EmailSearchFilter _buildSearchFilter() {
    final quickFilters = ref.read(quickFiltersProvider);
    
    return EmailSearchFilter(
      isUnread: quickFilters['unread'] == true ? true : null,
      isStarred: quickFilters['starred'] == true ? true : null,
      isImportant: quickFilters['important'] == true ? true : null,
      hasAttachments: quickFilters['attachments'] == true ? true : null,
    );
  }

  void _toggleFilter(String key, bool selected) {
    final filters = ref.read(quickFiltersProvider.notifier);
    final currentFilters = Map<String, bool>.from(filters.state);
    currentFilters[key] = selected;
    filters.state = currentFilters;
  }

  void _updateSort(EmailSortField field) {
    final sortNotifier = ref.read(emailSortProvider.notifier);
    final currentSort = sortNotifier.state;
    
    if (currentSort.field == field) {
      // Toggle sort direction
      sortNotifier.state = currentSort.copyWith(ascending: !currentSort.ascending);
    } else {
      // Change sort field
      sortNotifier.state = currentSort.copyWith(field: field);
    }
  }

  void _openEmail(Email email) {
    ref.read(currentEmailProvider.notifier).state = email;
    ref.read(emailViewModeProvider.notifier).state = EmailViewMode.thread;
    
    // Mark as read if not already read
    if (!email.isRead) {
      final emailActions = ref.read(emailActionsProvider);
      emailActions.markAsRead(email.id);
    }
  }

  void _toggleEmailSelection(String emailId) {
    final emailActions = ref.read(emailActionsProvider);
    final selectedEmails = ref.read(selectedEmailsProvider);
    
    if (selectedEmails.contains(emailId)) {
      emailActions.deselectEmail(emailId);
    } else {
      emailActions.selectEmail(emailId);
    }
  }

  void _clearSelection() {
    final emailActions = ref.read(emailActionsProvider);
    emailActions.clearSelection();
  }

  void _composeEmail() {
    final composeActions = ref.read(composeActionsProvider);
    composeActions.newEmail();
    ref.read(emailViewModeProvider.notifier).state = EmailViewMode.compose;
  }

  void _showSearch() {
    showSearch(
      context: context,
      delegate: EmailSearchDelegate(ref),
    );
  }

  Future<void> _refresh() async {
    ref.invalidate(emailsProvider);
    ref.invalidate(unreadCountProvider);
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'select_all':
        _selectAll();
        break;
      case 'mark_all_read':
        _markAllAsRead();
        break;
      case 'settings':
        ref.read(emailViewModeProvider.notifier).state = EmailViewMode.settings;
        break;
    }
  }

  void _selectAll() {
    final emailsParams = EmailsParams(
      folderId: widget.folderId,
      filter: _buildSearchFilter(),
    );
    
    ref.read(emailsProvider(emailsParams)).whenData((emails) {
      final emailActions = ref.read(emailActionsProvider);
      emailActions.selectAllEmails(emails.map((e) => e.id).toList());
    });
  }

  void _markAllAsRead() async {
    try {
      final emailService = ref.read(emailServiceProvider);
      await emailService.markAllAsRead(widget.folderId ?? 'inbox');
      _refresh();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All emails marked as read')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _markSelectedAsRead() {
    final bulkOperations = ref.read(bulkOperationsProvider);
    bulkOperations.markAllAsRead();
  }

  void _markSelectedAsUnread() {
    final bulkOperations = ref.read(bulkOperationsProvider);
    bulkOperations.markAllAsRead(read: false);
  }

  void _starSelected() {
    final bulkOperations = ref.read(bulkOperationsProvider);
    bulkOperations.markAllAsStarred();
  }

  void _markSelectedAsImportant() {
    final bulkOperations = ref.read(bulkOperationsProvider);
    bulkOperations.markAllAsImportant();
  }

  void _archiveSelected() {
    final bulkOperations = ref.read(bulkOperationsProvider);
    bulkOperations.moveAllToFolder('archive');
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Emails archived')),
    );
  }

  void _deleteSelected() {
    final selectedCount = ref.read(selectedEmailsProvider).length;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Emails'),
        content: Text('Are you sure you want to delete $selectedCount emails?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              final bulkOperations = ref.read(bulkOperationsProvider);
              bulkOperations.deleteAll();
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$selectedCount emails deleted')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _handleBulkAction(String action) {
    switch (action) {
      case 'move':
        _showMoveToFolderDialog();
        break;
      case 'labels':
        _showAddLabelsDialog();
        break;
      case 'spam':
        _reportSelectedAsSpam();
        break;
    }
  }

  void _showMoveToFolderDialog() {
    // TODO: Implement move to folder dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Move to folder not implemented')),
    );
  }

  void _showAddLabelsDialog() {
    // TODO: Implement add labels dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add labels not implemented')),
    );
  }

  void _reportSelectedAsSpam() {
    final selectedCount = ref.read(selectedEmailsProvider).length;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Spam'),
        content: Text('Are you sure you want to report $selectedCount emails as spam?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              final bulkOperations = ref.read(bulkOperationsProvider);
              bulkOperations.moveAllToFolder('spam');
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$selectedCount emails reported as spam')),
              );
            },
            child: const Text('Report'),
          ),
        ],
      ),
    );
  }
}

class EmailSearchDelegate extends SearchDelegate<String> {
  final WidgetRef ref;

  EmailSearchDelegate(this.ref);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _buildSearchSuggestions();
    } else {
      return _buildSearchResults();
    }
  }

  Widget _buildSearchResults() {
    if (query.isEmpty) {
      return const Center(
        child: Text('Enter a search term'),
      );
    }

    final searchFilter = EmailSearchFilter(query: query);
    
    return ref.watch(emailSearchProvider(searchFilter)).when(
      data: (emails) => ListView.builder(
        itemCount: emails.length,
        itemBuilder: (context, index) {
          final email = emails[index];
          return EmailListItem(
            email: email,
            onTap: () {
              close(context, email.id);
              ref.read(currentEmailProvider.notifier).state = email;
              ref.read(emailViewModeProvider.notifier).state = EmailViewMode.thread;
            },
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
    );
  }

  Widget _buildSearchSuggestions() {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.search),
          title: const Text('Search in subject'),
          onTap: () => query = 'subject:',
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Search by sender'),
          onTap: () => query = 'from:',
        ),
        ListTile(
          leading: const Icon(Icons.attach_file),
          title: const Text('Has attachments'),
          onTap: () => query = 'has:attachment',
        ),
        ListTile(
          leading: const Icon(Icons.star),
          title: const Text('Starred emails'),
          onTap: () => query = 'is:starred',
        ),
        ListTile(
          leading: const Icon(Icons.label_important),
          title: const Text('Important emails'),
          onTap: () => query = 'is:important',
        ),
      ],
    );
  }
}