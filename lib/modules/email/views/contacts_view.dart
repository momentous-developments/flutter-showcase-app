import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/email_models.dart';
import '../providers/email_providers.dart';
import '../widgets/contact_card.dart';

class ContactsView extends ConsumerStatefulWidget {
  const ContactsView({super.key});

  @override
  ConsumerState<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends ConsumerState<ContactsView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  ContactViewMode _viewMode = ContactViewMode.grid;
  String? _selectedGroupId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildContactsTab(),
                _buildGroupsTab(),
                _buildFrequentTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createContact,
        child: const Icon(Icons.person_add),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Contacts'),
      actions: [
        IconButton(
          icon: Icon(
            _viewMode == ContactViewMode.grid ? Icons.view_list : Icons.view_module,
          ),
          onPressed: _toggleViewMode,
          tooltip: _viewMode == ContactViewMode.grid ? 'List view' : 'Grid view',
        ),
        PopupMenuButton<String>(
          onSelected: _handleMenuAction,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'import',
              child: ListTile(
                leading: Icon(Icons.file_upload),
                title: Text('Import contacts'),
              ),
            ),
            const PopupMenuItem(
              value: 'export',
              child: ListTile(
                leading: Icon(Icons.file_download),
                title: Text('Export contacts'),
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem(
              value: 'settings',
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Contact settings'),
              ),
            ),
          ],
        ),
      ],
      bottom: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: 'All Contacts'),
          Tab(text: 'Groups'),
          Tab(text: 'Frequent'),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        children: [
          SearchBar(
            controller: _searchController,
            hintText: 'Search contacts...',
            leading: const Icon(Icons.search),
            trailing: [
              if (_searchController.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                ),
            ],
          ),
          const SizedBox(height: 8),
          _buildFilterChips(),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterChip(
            label: const Text('All'),
            selected: _selectedGroupId == null,
            onSelected: (selected) {
              setState(() => _selectedGroupId = null);
            },
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('Favorites'),
            selected: _selectedGroupId == 'favorites',
            onSelected: (selected) {
              setState(() => _selectedGroupId = selected ? 'favorites' : null);
            },
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('Work'),
            selected: _selectedGroupId == 'work',
            onSelected: (selected) {
              setState(() => _selectedGroupId = selected ? 'work' : null);
            },
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('Personal'),
            selected: _selectedGroupId == 'personal',
            onSelected: (selected) {
              setState(() => _selectedGroupId = selected ? 'personal' : null);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactsTab() {
    final contactsParams = ContactsParams(
      query: _searchQuery.isEmpty ? null : _searchQuery,
      groupId: _selectedGroupId,
    );

    return ref.watch(contactsProvider(contactsParams)).when(
      data: (contacts) => _buildContactsList(contacts),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => _buildErrorView(error),
    );
  }

  Widget _buildContactsList(List<Contact> contacts) {
    if (contacts.isEmpty) {
      return _buildEmptyContactsView();
    }

    if (_viewMode == ContactViewMode.grid) {
      return _buildContactsGrid(contacts);
    } else {
      return _buildContactsListView(contacts);
    }
  }

  Widget _buildContactsGrid(List<Contact> contacts) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ContactCard(
          contact: contact,
          onTap: () => _viewContact(contact),
          onEdit: () => _editContact(contact),
          onDelete: () => _deleteContact(contact),
        );
      },
    );
  }

  Widget _buildContactsListView(List<Contact> contacts) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ContactListItem(
          contact: contact,
          onTap: () => _viewContact(contact),
          onEdit: () => _editContact(contact),
          onDelete: () => _deleteContact(contact),
        );
      },
    );
  }

  Widget _buildEmptyContactsView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isEmpty ? 'No Contacts' : 'No Results',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isEmpty
                ? 'Add contacts to start building your address book.'
                : 'No contacts match your search criteria.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.person_add),
            label: const Text('Add Contact'),
            onPressed: _createContact,
          ),
        ],
      ),
    );
  }

  Widget _buildGroupsTab() {
    return Column(
      children: [
        _buildGroupsHeader(),
        Expanded(
          child: _buildGroupsList(),
        ),
      ],
    );
  }

  Widget _buildGroupsHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            'Contact Groups',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('New Group'),
            onPressed: _createGroup,
          ),
        ],
      ),
    );
  }

  Widget _buildGroupsList() {
    // Mock groups data for now
    final groups = [
      ContactGroup(
        id: 'work',
        name: 'Work',
        description: 'Work colleagues and business contacts',
        color: Colors.blue,
        contactIds: ['1', '2', '3'],
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      ContactGroup(
        id: 'personal',
        name: 'Personal',
        description: 'Friends and family',
        color: Colors.green,
        contactIds: ['4', '5'],
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
      ),
      ContactGroup(
        id: 'clients',
        name: 'Clients',
        description: 'Important clients',
        color: Colors.orange,
        contactIds: ['6'],
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
    ];

    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return _buildGroupCard(group);
      },
    );
  }

  Widget _buildGroupCard(ContactGroup group) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () => _viewGroup(group),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: group.color?.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.group,
                  color: group.color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (group.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        group.description!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      '${group.contactIds?.length ?? 0} contacts',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (action) => _handleGroupAction(group, action),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Edit'),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(Icons.delete, color: Colors.red),
                      title: Text('Delete', style: TextStyle(color: Colors.red)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFrequentTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.trending_up,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
          ),
          const SizedBox(height: 16),
          Text(
            'Frequent Contacts',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Contacts you email frequently will appear here.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
            textAlign: TextAlign.center,
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
            'Error loading contacts',
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
            onPressed: () => ref.invalidate(contactsProvider),
          ),
        ],
      ),
    );
  }

  void _toggleViewMode() {
    setState(() {
      _viewMode = _viewMode == ContactViewMode.grid
          ? ContactViewMode.list
          : ContactViewMode.grid;
    });
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'import':
        _importContacts();
        break;
      case 'export':
        _exportContacts();
        break;
      case 'settings':
        _showContactSettings();
        break;
    }
  }

  void _createContact() {
    showDialog(
      context: context,
      builder: (context) => _ContactFormDialog(),
    );
  }

  void _editContact(Contact contact) {
    showDialog(
      context: context,
      builder: (context) => _ContactFormDialog(contact: contact),
    );
  }

  void _viewContact(Contact contact) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactDetailView(
          contact: contact,
          onEdit: () => _editContact(contact),
          onDelete: () => _deleteContact(contact),
        ),
      ),
    );
  }

  void _deleteContact(Contact contact) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Contact'),
        content: Text('Are you sure you want to delete ${contact.displayName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final emailService = ref.read(emailServiceProvider);
        await emailService.deleteContact(contact.id);
        ref.invalidate(contactsProvider);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contact deleted')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting contact: $e'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }

  void _createGroup() {
    showDialog(
      context: context,
      builder: (context) => _GroupFormDialog(),
    );
  }

  void _viewGroup(ContactGroup group) {
    setState(() {
      _selectedGroupId = group.id;
      _tabController.animateTo(0); // Switch to contacts tab
    });
  }

  void _handleGroupAction(ContactGroup group, String action) {
    switch (action) {
      case 'edit':
        showDialog(
          context: context,
          builder: (context) => _GroupFormDialog(group: group),
        );
        break;
      case 'delete':
        _deleteGroup(group);
        break;
    }
  }

  void _deleteGroup(ContactGroup group) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Group'),
        content: Text('Are you sure you want to delete "${group.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Group deleted')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _importContacts() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contact import not implemented')),
    );
  }

  void _exportContacts() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contact export not implemented')),
    );
  }

  void _showContactSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contact settings not implemented')),
    );
  }
}

enum ContactViewMode { grid, list }

class _ContactFormDialog extends StatefulWidget {
  final Contact? contact;

  const _ContactFormDialog({this.contact});

  @override
  State<_ContactFormDialog> createState() => _ContactFormDialogState();
}

class _ContactFormDialogState extends State<_ContactFormDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _companyController;
  late final TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name ?? '');
    _emailController = TextEditingController(text: widget.contact?.email ?? '');
    _phoneController = TextEditingController(text: widget.contact?.phone ?? '');
    _companyController = TextEditingController(text: widget.contact?.company ?? '');
    _titleController = TextEditingController(text: widget.contact?.title ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.contact == null ? 'Add Contact' : 'Edit Contact'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _companyController,
              decoration: const InputDecoration(
                labelText: 'Company',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _saveContact,
          child: Text(widget.contact == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }

  void _saveContact() {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name and email are required')),
      );
      return;
    }

    // TODO: Save contact to backend
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.contact == null ? 'Contact added' : 'Contact updated',
        ),
      ),
    );
  }
}

class _GroupFormDialog extends StatefulWidget {
  final ContactGroup? group;

  const _GroupFormDialog({this.group});

  @override
  State<_GroupFormDialog> createState() => _GroupFormDialogState();
}

class _GroupFormDialogState extends State<_GroupFormDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  Color _selectedColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.group?.name ?? '');
    _descriptionController = TextEditingController(text: widget.group?.description ?? '');
    _selectedColor = widget.group?.color ?? Colors.blue;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.group == null ? 'Create Group' : 'Edit Group'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Group Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Color: '),
                const SizedBox(width: 8),
                ...Colors.primaries.take(6).map((color) => GestureDetector(
                  onTap: () => setState(() => _selectedColor = color),
                  child: Container(
                    width: 32,
                    height: 32,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: _selectedColor == color
                          ? Border.all(color: Colors.black, width: 2)
                          : null,
                    ),
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _saveGroup,
          child: Text(widget.group == null ? 'Create' : 'Save'),
        ),
      ],
    );
  }

  void _saveGroup() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Group name is required')),
      );
      return;
    }

    // TODO: Save group to backend
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.group == null ? 'Group created' : 'Group updated',
        ),
      ),
    );
  }
}