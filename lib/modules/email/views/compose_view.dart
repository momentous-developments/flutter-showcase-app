import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/email_models.dart';
import '../providers/email_providers.dart';
import '../widgets/email_composer.dart';

class ComposeView extends ConsumerStatefulWidget {
  final ComposeState? initialState;

  const ComposeView({
    super.key,
    this.initialState,
  });

  @override
  ConsumerState<ComposeView> createState() => _ComposeViewState();
}

class _ComposeViewState extends ConsumerState<ComposeView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  bool _isMinimized = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Initialize compose state if provided
    if (widget.initialState != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(composeStateProvider.notifier).state = widget.initialState;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final composeState = ref.watch(composeStateProvider);
    
    if (composeState == null) {
      return _buildEmptyState();
    }

    return _isMinimized ? _buildMinimizedComposer() : _buildFullComposer();
  }

  Widget _buildEmptyState() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit,
              size: 64,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'No Active Composition',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start composing a new email to see the editor here.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('Compose Email'),
              onPressed: _startNewComposition,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMinimizedComposer() {
    final composeState = ref.watch(composeStateProvider)!;
    
    return Positioned(
      bottom: 16,
      right: 16,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  composeState.subject?.isEmpty == false
                      ? composeState.subject!
                      : 'New Message',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.expand_less,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                onPressed: () => setState(() => _isMinimized = false),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                onPressed: _closeComposer,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFullComposer() {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getComposerTitle()),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.minimize),
            onPressed: () => setState(() => _isMinimized = true),
            tooltip: 'Minimize',
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: _closeComposer,
            tooltip: 'Close',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Compose'),
            Tab(text: 'Templates'),
            Tab(text: 'Drafts'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildComposeTab(),
          _buildTemplatesTab(),
          _buildDraftsTab(),
        ],
      ),
    );
  }

  Widget _buildComposeTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: EmailComposer(
        initialState: ref.watch(composeStateProvider),
        onClose: _closeComposer,
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return ref.watch(emailTemplatesProvider(const TemplatesParams())).when(
      data: (templates) => _buildTemplatesList(templates),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text('Error loading templates: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.invalidate(emailTemplatesProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplatesList(List<EmailTemplate> templates) {
    if (templates.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.description,
              size: 64,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'No Templates',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Create templates to speed up your email composition.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Create Template'),
              onPressed: _createTemplate,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                'Email Templates',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('New Template'),
                onPressed: _createTemplate,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: templates.length,
            itemBuilder: (context, index) {
              final template = templates[index];
              return _buildTemplateCard(template);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTemplateCard(EmailTemplate template) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () => _useTemplate(template),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          template.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (template.description != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            template.description!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (template.type != null)
                    Chip(
                      label: Text(
                        template.type!.name.toUpperCase(),
                        style: theme.textTheme.labelSmall,
                      ),
                      backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    ),
                  PopupMenuButton<String>(
                    onSelected: (action) => _handleTemplateAction(template, action),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: ListTile(
                          leading: Icon(Icons.edit),
                          title: Text('Edit'),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'duplicate',
                        child: ListTile(
                          leading: Icon(Icons.copy),
                          title: Text('Duplicate'),
                        ),
                      ),
                      const PopupMenuDivider(),
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
              const SizedBox(height: 8),
              Text(
                template.subject,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                template.body.length > 100
                    ? '${template.body.substring(0, 100)}...'
                    : template.body,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (template.tags?.isNotEmpty == true) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: template.tags!.take(3).map((tag) => Chip(
                    label: Text(
                      tag,
                      style: theme.textTheme.labelSmall,
                    ),
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )).toList(),
                ),
              ],
              const SizedBox(height: 8),
              Row(
                children: [
                  if (template.useCount != null) ...[
                    Icon(
                      Icons.analytics,
                      size: 16,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Used ${template.useCount} times',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => _useTemplate(template),
                    child: const Text('Use Template'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDraftsTab() {
    return ref.watch(draftsProvider).when(
      data: (drafts) => _buildDraftsList(drafts),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text('Error loading drafts: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.invalidate(draftsProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDraftsList(List<Email> drafts) {
    if (drafts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.drafts,
              size: 64,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'No Drafts',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your draft emails will appear here.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: drafts.length,
      itemBuilder: (context, index) {
        final draft = drafts[index];
        return _buildDraftCard(draft);
      },
    );
  }

  Widget _buildDraftCard(Email draft) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () => _editDraft(draft),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      draft.displaySubject,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (action) => _handleDraftAction(draft, action),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: ListTile(
                          leading: Icon(Icons.edit),
                          title: Text('Edit'),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'duplicate',
                        child: ListTile(
                          leading: Icon(Icons.copy),
                          title: Text('Duplicate'),
                        ),
                      ),
                      const PopupMenuDivider(),
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
              const SizedBox(height: 8),
              if (draft.recipients.isNotEmpty)
                Text(
                  'To: ${draft.recipients.map((c) => c.displayName).join(', ')}',
                  style: theme.textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 4),
              Text(
                draft.previewText,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Last saved ${_formatTime(draft.timestamp)}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => _editDraft(draft),
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getComposerTitle() {
    final composeState = ref.watch(composeStateProvider);
    switch (composeState?.mode) {
      case ComposeMode.reply:
        return 'Reply';
      case ComposeMode.replyAll:
        return 'Reply All';
      case ComposeMode.forward:
        return 'Forward';
      case ComposeMode.draft:
        return 'Edit Draft';
      default:
        return 'Compose Email';
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  void _startNewComposition() {
    final composeActions = ref.read(composeActionsProvider);
    composeActions.newEmail();
  }

  void _closeComposer() {
    final composeActions = ref.read(composeActionsProvider);
    composeActions.clearCompose();
    ref.read(emailViewModeProvider.notifier).state = EmailViewMode.list;
  }

  void _useTemplate(EmailTemplate template) {
    final currentState = ref.read(composeStateProvider) ?? const ComposeState();
    final newState = currentState.copyWith(
      subject: template.subject,
      body: template.body,
    );
    ref.read(composeStateProvider.notifier).state = newState;
    _tabController.animateTo(0); // Switch to compose tab
  }

  void _editDraft(Email draft) {
    final composeState = ComposeState(
      to: draft.recipients.map((c) => c.email).join(', '),
      cc: draft.ccRecipients.map((c) => c.email).join(', '),
      bcc: draft.bccRecipients.map((c) => c.email).join(', '),
      subject: draft.subject,
      body: draft.body,
      attachments: draft.attachments,
      priority: draft.priority,
      isDraft: true,
      mode: ComposeMode.draft,
    );
    
    ref.read(composeStateProvider.notifier).state = composeState;
    _tabController.animateTo(0); // Switch to compose tab
  }

  void _createTemplate() {
    // TODO: Implement template creation dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Template creation not implemented')),
    );
  }

  void _handleTemplateAction(EmailTemplate template, String action) {
    switch (action) {
      case 'edit':
        // TODO: Implement template editing
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Template editing not implemented')),
        );
        break;
      case 'duplicate':
        _duplicateTemplate(template);
        break;
      case 'delete':
        _deleteTemplate(template);
        break;
    }
  }

  void _handleDraftAction(Email draft, String action) {
    switch (action) {
      case 'edit':
        _editDraft(draft);
        break;
      case 'duplicate':
        _duplicateDraft(draft);
        break;
      case 'delete':
        _deleteDraft(draft);
        break;
    }
  }

  void _duplicateTemplate(EmailTemplate template) {
    // TODO: Implement template duplication
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Template duplication not implemented')),
    );
  }

  void _deleteTemplate(EmailTemplate template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Template'),
        content: Text('Are you sure you want to delete "${template.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement template deletion
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Template deleted')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _duplicateDraft(Email draft) {
    final composeState = ComposeState(
      to: draft.recipients.map((c) => c.email).join(', '),
      cc: draft.ccRecipients.map((c) => c.email).join(', '),
      bcc: draft.bccRecipients.map((c) => c.email).join(', '),
      subject: 'Copy of ${draft.subject}',
      body: draft.body,
      attachments: draft.attachments,
      priority: draft.priority,
      mode: ComposeMode.new_,
    );
    
    ref.read(composeStateProvider.notifier).state = composeState;
    _tabController.animateTo(0); // Switch to compose tab
  }

  void _deleteDraft(Email draft) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Draft'),
        content: const Text('Are you sure you want to delete this draft?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              final emailActions = ref.read(emailActionsProvider);
              emailActions.deleteEmail(draft.id);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Draft deleted')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}