import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/email_models.dart';
import '../providers/email_providers.dart';
import '../widgets/email_viewer.dart';

class EmailDetailView extends ConsumerStatefulWidget {
  final Email? initialEmail;

  const EmailDetailView({
    super.key,
    this.initialEmail,
  });

  @override
  ConsumerState<EmailDetailView> createState() => _EmailDetailViewState();
}

class _EmailDetailViewState extends ConsumerState<EmailDetailView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  bool _showThread = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Set initial email if provided
    if (widget.initialEmail != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(currentEmailProvider.notifier).state = widget.initialEmail;
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
    final currentEmail = ref.watch(currentEmailProvider);
    
    if (currentEmail == null) {
      return _buildEmptyState();
    }

    return Scaffold(
      appBar: _buildAppBar(currentEmail),
      body: _buildBody(currentEmail),
    );
  }

  Widget _buildEmptyState() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.email,
              size: 64,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'No Email Selected',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Select an email from the inbox to view its contents.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.inbox),
              label: const Text('Go to Inbox'),
              onPressed: () {
                ref.read(emailViewModeProvider.notifier).state = EmailViewMode.list;
              },
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(Email email) {
    return AppBar(
      title: Text(
        email.displaySubject,
        overflow: TextOverflow.ellipsis,
      ),
      actions: [
        IconButton(
          icon: Icon(
            email.isStarred ? Icons.star : Icons.star_border,
            color: email.isStarred ? Colors.amber : null,
          ),
          onPressed: () => _toggleStar(email),
          tooltip: email.isStarred ? 'Remove star' : 'Add star',
        ),
        IconButton(
          icon: Icon(
            email.isImportant ? Icons.label_important : Icons.label_important_outline,
            color: email.isImportant ? Colors.amber : null,
          ),
          onPressed: () => _toggleImportant(email),
          tooltip: email.isImportant ? 'Mark as not important' : 'Mark as important',
        ),
        PopupMenuButton<String>(
          onSelected: (action) => _handleAction(email, action),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'read',
              child: ListTile(
                leading: Icon(email.isRead ? Icons.mark_email_unread : Icons.mark_email_read),
                title: Text(email.isRead ? 'Mark as unread' : 'Mark as read'),
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem(
              value: 'reply',
              child: ListTile(
                leading: Icon(Icons.reply),
                title: Text('Reply'),
              ),
            ),
            const PopupMenuItem(
              value: 'reply_all',
              child: ListTile(
                leading: Icon(Icons.reply_all),
                title: Text('Reply All'),
              ),
            ),
            const PopupMenuItem(
              value: 'forward',
              child: ListTile(
                leading: Icon(Icons.forward),
                title: Text('Forward'),
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem(
              value: 'print',
              child: ListTile(
                leading: Icon(Icons.print),
                title: Text('Print'),
              ),
            ),
            const PopupMenuItem(
              value: 'download',
              child: ListTile(
                leading: Icon(Icons.download),
                title: Text('Download'),
              ),
            ),
            const PopupMenuDivider(),
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
              value: 'archive',
              child: ListTile(
                leading: Icon(Icons.archive),
                title: Text('Archive'),
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
              ),
            ),
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
      bottom: email.threadId != null ? TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: 'Email'),
          Tab(text: 'Thread'),
        ],
      ) : null,
    );
  }

  Widget _buildBody(Email email) {
    if (email.threadId != null) {
      return TabBarView(
        controller: _tabController,
        children: [
          _buildEmailView(email),
          _buildThreadView(email),
        ],
      );
    } else {
      return _buildEmailView(email);
    }
  }

  Widget _buildEmailView(Email email) {
    return EmailViewer(
      email: email,
      showThread: false,
      onClose: () {
        ref.read(currentEmailProvider.notifier).state = null;
        ref.read(emailViewModeProvider.notifier).state = EmailViewMode.list;
      },
    );
  }

  Widget _buildThreadView(Email email) {
    if (email.threadId == null) {
      return const Center(
        child: Text('This email is not part of a thread'),
      );
    }

    return ref.watch(emailThreadProvider(email.threadId!)).when(
      data: (thread) => _buildThreadContent(thread),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => _buildThreadError(error),
    );
  }

  Widget _buildThreadContent(EmailThread thread) {
    return Column(
      children: [
        _buildThreadHeader(thread),
        Expanded(
          child: ListView.builder(
            itemCount: thread.emails.length,
            itemBuilder: (context, index) {
              final email = thread.emails[index];
              final isCurrentEmail = email.id == ref.watch(currentEmailProvider)?.id;
              
              return _buildThreadEmailItem(email, isCurrentEmail, index);
            },
          ),
        ),
        _buildThreadActions(thread),
      ],
    );
  }

  Widget _buildThreadHeader(EmailThread thread) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.forum,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  thread.subject,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${thread.messageCount} messages with ${thread.participants.length} participants',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          if (thread.unreadCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${thread.unreadCount}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildThreadEmailItem(Email email, bool isCurrentEmail, int index) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: isCurrentEmail ? 4 : 1,
      color: isCurrentEmail 
          ? theme.colorScheme.primaryContainer.withOpacity(0.3)
          : null,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          backgroundImage: email.sender.avatar != null
              ? NetworkImage(email.sender.avatar!)
              : null,
          child: email.sender.avatar == null
              ? Text(
                  email.sender.initials,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                )
              : null,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                email.sender.displayName,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: email.isRead ? FontWeight.normal : FontWeight.w600,
                ),
              ),
            ),
            if (!email.isRead)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        subtitle: Text(
          email.previewText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          _formatTimestamp(email.timestamp),
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        initiallyExpanded: isCurrentEmail,
        onExpansionChanged: (expanded) {
          if (expanded && !email.isRead) {
            final emailActions = ref.read(emailActionsProvider);
            emailActions.markAsRead(email.id);
          }
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  email.body,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                  ),
                ),
                if (email.attachments.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _buildAttachmentsList(email.attachments),
                ],
                const SizedBox(height: 16),
                _buildEmailActions(email),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentsList(List<Attachment> attachments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attachments (${attachments.length})',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: attachments.map((attachment) => Chip(
            avatar: Icon(
              attachment.isImage ? Icons.image : Icons.attach_file,
              size: 16,
            ),
            label: Text(
              attachment.name,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            onDeleted: () => _downloadAttachment(attachment),
            deleteIcon: const Icon(Icons.download, size: 16),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildEmailActions(Email email) {
    return Row(
      children: [
        TextButton.icon(
          icon: const Icon(Icons.reply),
          label: const Text('Reply'),
          onPressed: () => _reply(email),
        ),
        TextButton.icon(
          icon: const Icon(Icons.reply_all),
          label: const Text('Reply All'),
          onPressed: () => _replyAll(email),
        ),
        TextButton.icon(
          icon: const Icon(Icons.forward),
          label: const Text('Forward'),
          onPressed: () => _forward(email),
        ),
      ],
    );
  }

  Widget _buildThreadActions(EmailThread thread) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.reply),
            label: const Text('Reply to Thread'),
            onPressed: () => _replyToThread(thread),
          ),
          const SizedBox(width: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.archive),
            label: const Text('Archive Thread'),
            onPressed: () => _archiveThread(thread),
          ),
          const Spacer(),
          if (thread.isMuted == true)
            OutlinedButton.icon(
              icon: const Icon(Icons.volume_up),
              label: const Text('Unmute'),
              onPressed: () => _unmuteThread(thread),
            )
          else
            OutlinedButton.icon(
              icon: const Icon(Icons.volume_off),
              label: const Text('Mute'),
              onPressed: () => _muteThread(thread),
            ),
        ],
      ),
    );
  }

  Widget _buildThreadError(Object error) {
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
            'Error loading thread',
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
            onPressed: () {
              final email = ref.read(currentEmailProvider);
              if (email?.threadId != null) {
                ref.invalidate(emailThreadProvider(email!.threadId!));
              }
            },
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }

  void _toggleStar(Email email) {
    final emailActions = ref.read(emailActionsProvider);
    emailActions.markAsStarred(email.id, starred: !email.isStarred);
  }

  void _toggleImportant(Email email) {
    final emailActions = ref.read(emailActionsProvider);
    emailActions.markAsImportant(email.id, important: !email.isImportant);
  }

  void _reply(Email email) {
    final composeActions = ref.read(composeActionsProvider);
    composeActions.replyToEmail(email);
    ref.read(emailViewModeProvider.notifier).state = EmailViewMode.compose;
  }

  void _replyAll(Email email) {
    final composeActions = ref.read(composeActionsProvider);
    composeActions.replyAllToEmail(email);
    ref.read(emailViewModeProvider.notifier).state = EmailViewMode.compose;
  }

  void _forward(Email email) {
    final composeActions = ref.read(composeActionsProvider);
    composeActions.forwardEmail(email);
    ref.read(emailViewModeProvider.notifier).state = EmailViewMode.compose;
  }

  void _replyToThread(EmailThread thread) {
    if (thread.emails.isNotEmpty) {
      _reply(thread.emails.last);
    }
  }

  void _archiveThread(EmailThread thread) {
    final emailActions = ref.read(emailActionsProvider);
    for (final email in thread.emails) {
      emailActions.moveToFolder(email.id, 'archive');
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Thread archived')),
    );
  }

  void _muteThread(EmailThread thread) {
    // TODO: Implement thread muting
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Thread muted')),
    );
  }

  void _unmuteThread(EmailThread thread) {
    // TODO: Implement thread unmuting
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Thread unmuted')),
    );
  }

  void _downloadAttachment(Attachment attachment) async {
    try {
      final emailService = ref.read(emailServiceProvider);
      final bytes = await emailService.downloadAttachment(attachment.id);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Downloaded ${attachment.name}'),
            action: SnackBarAction(
              label: 'Open',
              onPressed: () {
                // TODO: Implement file opening
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading ${attachment.name}: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  void _handleAction(Email email, String action) {
    final emailActions = ref.read(emailActionsProvider);
    
    switch (action) {
      case 'read':
        emailActions.markAsRead(email.id, read: !email.isRead);
        break;
      case 'reply':
        _reply(email);
        break;
      case 'reply_all':
        _replyAll(email);
        break;
      case 'forward':
        _forward(email);
        break;
      case 'print':
        _print();
        break;
      case 'download':
        _downloadEmail(email);
        break;
      case 'move':
        _showMoveDialog();
        break;
      case 'labels':
        _showLabelsDialog();
        break;
      case 'archive':
        _archive(email);
        break;
      case 'delete':
        _delete(email);
        break;
      case 'spam':
        _reportSpam(email);
        break;
    }
  }

  void _print() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Print functionality not implemented')),
    );
  }

  void _downloadEmail(Email email) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email download not implemented')),
    );
  }

  void _showMoveDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Move to folder not implemented')),
    );
  }

  void _showLabelsDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add labels not implemented')),
    );
  }

  void _archive(Email email) {
    final emailActions = ref.read(emailActionsProvider);
    emailActions.moveToFolder(email.id, 'archive');
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email archived')),
    );
  }

  void _delete(Email email) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Email'),
        content: const Text('Are you sure you want to delete this email?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              final emailActions = ref.read(emailActionsProvider);
              emailActions.deleteEmail(email.id);
              
              // Navigate back to list
              ref.read(currentEmailProvider.notifier).state = null;
              ref.read(emailViewModeProvider.notifier).state = EmailViewMode.list;
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Email deleted')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _reportSpam(Email email) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Spam'),
        content: const Text('Are you sure you want to report this email as spam?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              final emailActions = ref.read(emailActionsProvider);
              emailActions.moveToFolder(email.id, 'spam');
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Email reported as spam')),
              );
            },
            child: const Text('Report'),
          ),
        ],
      ),
    );
  }
}