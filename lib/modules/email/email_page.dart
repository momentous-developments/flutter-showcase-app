import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/email_models.dart';
import 'providers/email_providers.dart';
import 'views/inbox_view.dart';
import 'views/compose_view.dart';
import 'views/email_detail_view.dart';
import 'views/contacts_view.dart';
import 'views/email_settings_view.dart';
import 'views/templates_view.dart';

class EmailPage extends ConsumerStatefulWidget {
  const EmailPage({super.key});

  @override
  ConsumerState<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends ConsumerState<EmailPage>
    with TickerProviderStateMixin {
  late final AnimationController _sidebarAnimationController;
  late final Animation<double> _sidebarAnimation;
  
  bool _showSidebar = true;
  String _currentFolderId = 'inbox';

  @override
  void initState() {
    super.initState();
    _sidebarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _sidebarAnimation = CurvedAnimation(
      parent: _sidebarAnimationController,
      curve: Curves.easeInOut,
    );
    _sidebarAnimationController.forward();
  }

  @override
  void dispose() {
    _sidebarAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailViewMode = ref.watch(emailViewModeProvider);

    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          if (_showSidebar)
            SizeTransition(
              sizeFactor: _sidebarAnimation,
              axis: Axis.horizontal,
              child: Container(
                width: 280,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  border: Border(
                    right: BorderSide(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                ),
                child: _buildSidebar(),
              ),
            ),
          
          // Main content
          Expanded(
            child: _buildMainContent(emailViewMode),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Column(
      children: [
        _buildSidebarHeader(),
        Expanded(child: _buildSidebarContent()),
        _buildSidebarFooter(),
      ],
    );
  }

  Widget _buildSidebarHeader() {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.email,
            color: theme.colorScheme.primary,
            size: 28,
          ),
          const SizedBox(width: 12),
          Text(
            'Email',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.primary,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.menu_open),
            onPressed: _toggleSidebar,
            tooltip: 'Hide sidebar',
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        // Quick actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.edit),
            label: const Text('Compose'),
            onPressed: _composeEmail,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 40),
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Folders
        _buildSidebarSection('Folders', [
          _buildFolderItem('inbox', 'Inbox', Icons.inbox, badgeCount: ref.watch(unreadCountProvider).valueOrNull),
          _buildFolderItem('sent', 'Sent', Icons.send),
          _buildFolderItem('drafts', 'Drafts', Icons.drafts),
          _buildFolderItem('archive', 'Archive', Icons.archive),
          _buildFolderItem('spam', 'Spam', Icons.report),
          _buildFolderItem('trash', 'Trash', Icons.delete),
        ]),
        
        const SizedBox(height: 16),
        
        // Smart folders
        _buildSidebarSection('Smart Folders', [
          _buildFolderItem('starred', 'Starred', Icons.star, color: Colors.amber),
          _buildFolderItem('important', 'Important', Icons.label_important, color: Colors.orange),
          _buildFolderItem('attachments', 'Has Attachments', Icons.attach_file),
          _buildFolderItem('unread', 'Unread', Icons.mark_email_unread),
        ]),
        
        const SizedBox(height: 16),
        
        // Labels
        ref.watch(emailLabelsProvider).when(
          data: (labels) => _buildSidebarSection('Labels', 
            labels.map((label) => _buildLabelItem(label)).toList(),
          ),
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),
        
        const SizedBox(height: 16),
        
        // Tools
        _buildSidebarSection('Tools', [
          _buildToolItem('contacts', 'Contacts', Icons.people),
          _buildToolItem('templates', 'Templates', Icons.description),
          _buildToolItem('settings', 'Settings', Icons.settings),
        ]),
      ],
    );
  }

  Widget _buildSidebarSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildFolderItem(
    String folderId,
    String title,
    IconData icon, {
    Color? color,
    int? badgeCount,
  }) {
    final isSelected = _currentFolderId == folderId;
    final theme = Theme.of(context);
    
    return ListTile(
      selected: isSelected,
      leading: Icon(
        icon,
        color: color ?? (isSelected ? theme.colorScheme.primary : null),
      ),
      title: Text(title),
      trailing: badgeCount != null && badgeCount > 0
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badgeCount > 99 ? '99+' : badgeCount.toString(),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      onTap: () => _selectFolder(folderId),
    );
  }

  Widget _buildLabelItem(EmailLabel label) {
    return ListTile(
      leading: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: label.color ?? Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
      ),
      title: Text(label.name),
      onTap: () {
        // TODO: Filter by label
      },
    );
  }

  Widget _buildToolItem(String toolId, String title, IconData icon) {
    final emailViewMode = ref.watch(emailViewModeProvider);
    final isSelected = (toolId == 'contacts' && emailViewMode == EmailViewMode.contacts) ||
                      (toolId == 'templates' && emailViewMode == EmailViewMode.templates) ||
                      (toolId == 'settings' && emailViewMode == EmailViewMode.settings);
    
    return ListTile(
      selected: isSelected,
      leading: Icon(icon),
      title: Text(title),
      onTap: () => _selectTool(toolId),
    );
  }

  Widget _buildSidebarFooter() {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.storage,
                size: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 8),
              Text(
                'Storage: 2.5 GB / 15 GB',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 2.5 / 15,
            backgroundColor: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(EmailViewMode viewMode) {
    switch (viewMode) {
      case EmailViewMode.list:
        return InboxView(folderId: _currentFolderId);
      case EmailViewMode.compose:
        return const ComposeView();
      case EmailViewMode.thread:
        return const EmailDetailView();
      case EmailViewMode.contacts:
        return const ContactsView();
      case EmailViewMode.templates:
        return const TemplatesView();
      case EmailViewMode.settings:
        return const EmailSettingsView();
    }
  }

  void _toggleSidebar() {
    setState(() {
      _showSidebar = !_showSidebar;
      if (_showSidebar) {
        _sidebarAnimationController.forward();
      } else {
        _sidebarAnimationController.reverse();
      }
    });
  }

  void _selectFolder(String folderId) {
    setState(() {
      _currentFolderId = folderId;
    });
    
    // Update view mode and clear current email
    ref.read(emailViewModeProvider.notifier).state = EmailViewMode.list;
    ref.read(currentEmailProvider.notifier).state = null;
    ref.read(selectedEmailsProvider.notifier).state = {};
  }

  void _selectTool(String toolId) {
    switch (toolId) {
      case 'contacts':
        ref.read(emailViewModeProvider.notifier).state = EmailViewMode.contacts;
        break;
      case 'templates':
        ref.read(emailViewModeProvider.notifier).state = EmailViewMode.templates;
        break;
      case 'settings':
        ref.read(emailViewModeProvider.notifier).state = EmailViewMode.settings;
        break;
    }
  }

  void _composeEmail() {
    final composeActions = ref.read(composeActionsProvider);
    composeActions.newEmail();
    ref.read(emailViewModeProvider.notifier).state = EmailViewMode.compose;
  }
}

// Enhanced email list item for the sidebar integration
class SidebarAwareInboxView extends ConsumerWidget {
  final String? folderId;

  const SidebarAwareInboxView({
    super.key,
    this.folderId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _buildTopBar(context, ref),
        Expanded(
          child: InboxView(folderId: folderId),
        ),
      ],
    );
  }

  Widget _buildTopBar(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final emailViewMode = ref.watch(emailViewModeProvider);
    
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
          // Back button for mobile/narrow screens
          if (MediaQuery.of(context).size.width < 800) ...[
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // TODO: Show sidebar as drawer on mobile
              },
            ),
            const SizedBox(width: 8),
          ],
          
          // Breadcrumb navigation
          if (emailViewMode == EmailViewMode.thread) ...[
            TextButton.icon(
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Inbox'),
              onPressed: () {
                ref.read(emailViewModeProvider.notifier).state = EmailViewMode.list;
                ref.read(currentEmailProvider.notifier).state = null;
              },
            ),
          ] else ...[
            Text(
              _getFolderDisplayName(folderId),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          
          const Spacer(),
          
          // Quick actions
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // TODO: Show search
                },
                tooltip: 'Search',
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  ref.invalidate(emailsProvider);
                },
                tooltip: 'Refresh',
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (action) {
                  // TODO: Handle actions
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'mark_all_read',
                    child: ListTile(
                      leading: Icon(Icons.mark_email_read),
                      title: Text('Mark all as read'),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'select_all',
                    child: ListTile(
                      leading: Icon(Icons.select_all),
                      title: Text('Select all'),
                    ),
                  ),
                  const PopupMenuDivider(),
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
        ],
      ),
    );
  }

  String _getFolderDisplayName(String? folderId) {
    switch (folderId) {
      case 'inbox':
        return 'Inbox';
      case 'sent':
        return 'Sent';
      case 'drafts':
        return 'Drafts';
      case 'archive':
        return 'Archive';
      case 'spam':
        return 'Spam';
      case 'trash':
        return 'Trash';
      case 'starred':
        return 'Starred';
      case 'important':
        return 'Important';
      case 'attachments':
        return 'Has Attachments';
      case 'unread':
        return 'Unread';
      default:
        return 'Emails';
    }
  }
}

// Mobile responsive email page
class ResponsiveEmailPage extends ConsumerStatefulWidget {
  const ResponsiveEmailPage({super.key});

  @override
  ConsumerState<ResponsiveEmailPage> createState() => _ResponsiveEmailPageState();
}

class _ResponsiveEmailPageState extends ConsumerState<ResponsiveEmailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final emailViewMode = ref.watch(emailViewModeProvider);
    
    if (screenWidth < 800) {
      return _buildMobileLayout();
    } else {
      return const EmailPage();
    }
  }

  Widget _buildMobileLayout() {
    final emailViewMode = ref.watch(emailViewModeProvider);
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildMobileAppBar(),
      drawer: _buildMobileDrawer(),
      body: _buildMobileContent(emailViewMode),
      floatingActionButton: emailViewMode == EmailViewMode.list
          ? FloatingActionButton(
              onPressed: _composeEmail,
              child: const Icon(Icons.edit),
            )
          : null,
    );
  }

  PreferredSizeWidget _buildMobileAppBar() {
    final emailViewMode = ref.watch(emailViewModeProvider);
    
    return AppBar(
      title: Text(_getAppBarTitle(emailViewMode)),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // TODO: Show search
          },
        ),
        if (emailViewMode == EmailViewMode.list)
          PopupMenuButton<String>(
            onSelected: (action) {
              // TODO: Handle actions
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'refresh',
                child: ListTile(
                  leading: Icon(Icons.refresh),
                  title: Text('Refresh'),
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
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.email,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  size: 32,
                ),
                const SizedBox(width: 16),
                Text(
                  'Email',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.inbox),
                  title: const Text('Inbox'),
                  onTap: () => _selectMobileFolder('inbox'),
                ),
                ListTile(
                  leading: const Icon(Icons.send),
                  title: const Text('Sent'),
                  onTap: () => _selectMobileFolder('sent'),
                ),
                ListTile(
                  leading: const Icon(Icons.drafts),
                  title: const Text('Drafts'),
                  onTap: () => _selectMobileFolder('drafts'),
                ),
                ListTile(
                  leading: const Icon(Icons.star),
                  title: const Text('Starred'),
                  onTap: () => _selectMobileFolder('starred'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.people),
                  title: const Text('Contacts'),
                  onTap: () => _selectMobileTool('contacts'),
                ),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('Templates'),
                  onTap: () => _selectMobileTool('templates'),
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () => _selectMobileTool('settings'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileContent(EmailViewMode viewMode) {
    switch (viewMode) {
      case EmailViewMode.list:
        return const InboxView(folderId: 'inbox');
      case EmailViewMode.compose:
        return const ComposeView();
      case EmailViewMode.thread:
        return const EmailDetailView();
      case EmailViewMode.contacts:
        return const ContactsView();
      case EmailViewMode.templates:
        return const TemplatesView();
      case EmailViewMode.settings:
        return const EmailSettingsView();
    }
  }

  String _getAppBarTitle(EmailViewMode viewMode) {
    switch (viewMode) {
      case EmailViewMode.list:
        return 'Inbox';
      case EmailViewMode.compose:
        return 'Compose';
      case EmailViewMode.thread:
        return 'Email';
      case EmailViewMode.contacts:
        return 'Contacts';
      case EmailViewMode.templates:
        return 'Templates';
      case EmailViewMode.settings:
        return 'Settings';
    }
  }

  void _selectMobileFolder(String folderId) {
    Navigator.of(context).pop(); // Close drawer
    ref.read(emailViewModeProvider.notifier).state = EmailViewMode.list;
    // TODO: Set current folder
  }

  void _selectMobileTool(String toolId) {
    Navigator.of(context).pop(); // Close drawer
    switch (toolId) {
      case 'contacts':
        ref.read(emailViewModeProvider.notifier).state = EmailViewMode.contacts;
        break;
      case 'templates':
        ref.read(emailViewModeProvider.notifier).state = EmailViewMode.templates;
        break;
      case 'settings':
        ref.read(emailViewModeProvider.notifier).state = EmailViewMode.settings;
        break;
    }
  }

  void _composeEmail() {
    final composeActions = ref.read(composeActionsProvider);
    composeActions.newEmail();
    ref.read(emailViewModeProvider.notifier).state = EmailViewMode.compose;
  }
}