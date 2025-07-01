import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/email_models.dart';
import '../providers/email_providers.dart';
import 'attachment_widget.dart';
import 'email_list_item.dart';

class EmailViewer extends ConsumerWidget {
  final Email email;
  final bool showThread;
  final VoidCallback? onClose;

  const EmailViewer({
    super.key,
    required this.email,
    this.showThread = false,
    this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      child: Column(
        children: [
          _buildHeader(context, ref, theme),
          const Divider(height: 1),
          Expanded(
            child: _buildBody(context, ref, theme),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  email.displaySubject,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _buildHeaderActions(context, ref),
            ],
          ),
          const SizedBox(height: 16),
          _buildSenderInfo(theme),
          const SizedBox(height: 8),
          _buildRecipientInfo(theme),
          const SizedBox(height: 8),
          _buildMetadata(theme),
        ],
      ),
    );
  }

  Widget _buildHeaderActions(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            email.isStarred ? Icons.star : Icons.star_border,
            color: email.isStarred ? Colors.amber : null,
          ),
          onPressed: () => _toggleStar(ref),
          tooltip: email.isStarred ? 'Remove star' : 'Add star',
        ),
        IconButton(
          icon: Icon(
            email.isImportant ? Icons.label_important : Icons.label_important_outline,
            color: email.isImportant ? Colors.amber : null,
          ),
          onPressed: () => _toggleImportant(ref),
          tooltip: email.isImportant ? 'Mark as not important' : 'Mark as important',
        ),
        PopupMenuButton<String>(
          onSelected: (action) => _handleAction(context, ref, action),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'read',
              child: ListTile(
                leading: Icon(email.isRead ? Icons.mark_email_unread : Icons.mark_email_read),
                title: Text(email.isRead ? 'Mark as unread' : 'Mark as read'),
              ),
            ),
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
        if (onClose != null)
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onClose,
          ),
      ],
    );
  }

  Widget _buildSenderInfo(ThemeData theme) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: theme.colorScheme.primaryContainer,
          backgroundImage: email.sender.avatar != null 
              ? NetworkImage(email.sender.avatar!)
              : null,
          child: email.sender.avatar == null
              ? Text(
                  email.sender.initials,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                )
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                email.sender.displayName,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                email.sender.email,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
        Text(
          DateFormat('MMM d, yyyy \'at\' h:mm a').format(email.timestamp),
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildRecipientInfo(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (email.recipients.isNotEmpty)
          _buildRecipientRow('To:', email.recipients, theme),
        if (email.ccRecipients.isNotEmpty)
          _buildRecipientRow('Cc:', email.ccRecipients, theme),
        if (email.bccRecipients.isNotEmpty)
          _buildRecipientRow('Bcc:', email.bccRecipients, theme),
      ],
    );
  }

  Widget _buildRecipientRow(String label, List<Contact> recipients, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Wrap(
              spacing: 4,
              runSpacing: 4,
              children: recipients.map((contact) => Chip(
                label: Text(
                  contact.displayName,
                  style: theme.textTheme.bodySmall,
                ),
                avatar: contact.avatar != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(contact.avatar!),
                      )
                    : CircleAvatar(
                        child: Text(
                          contact.initials,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetadata(ThemeData theme) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        if (email.priority != EmailPriority.normal)
          Chip(
            label: Text(
              email.priority.name.toUpperCase(),
              style: theme.textTheme.labelSmall,
            ),
            backgroundColor: _getPriorityColor(email.priority),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ...email.labels.map((label) => Chip(
          label: Text(
            label.name,
            style: theme.textTheme.labelSmall?.copyWith(
              color: _getContrastColor(label.color ?? theme.colorScheme.primary),
            ),
          ),
          backgroundColor: label.color ?? theme.colorScheme.primaryContainer,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        )),
        if (email.readReceipt == true)
          Chip(
            label: Text(
              'READ RECEIPT',
              style: theme.textTheme.labelSmall,
            ),
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email body
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: SelectableText(
              email.body,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.5,
              ),
            ),
          ),
          
          // Attachments
          if (email.attachments.isNotEmpty) ...[
            const SizedBox(height: 24),
            AttachmentList(
              attachments: email.attachments,
            ),
          ],
          
          // Thread
          if (showThread && email.threadId != null) ...[
            const SizedBox(height: 24),
            _buildThreadView(context, ref, theme),
          ],
          
          // Quick actions
          const SizedBox(height: 24),
          _buildQuickActions(context, ref, theme),
        ],
      ),
    );
  }

  Widget _buildThreadView(BuildContext context, WidgetRef ref, ThemeData theme) {
    return ref.watch(emailThreadProvider(email.threadId!)).when(
      data: (thread) => EmailThreadView(thread: thread),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text('Error loading thread: $error'),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, WidgetRef ref, ThemeData theme) {
    return Row(
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.reply),
          label: const Text('Reply'),
          onPressed: () => _reply(ref),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          icon: const Icon(Icons.reply_all),
          label: const Text('Reply All'),
          onPressed: () => _replyAll(ref),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          icon: const Icon(Icons.forward),
          label: const Text('Forward'),
          onPressed: () => _forward(ref),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.archive),
          onPressed: () => _archive(context, ref),
          tooltip: 'Archive',
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _delete(context, ref),
          tooltip: 'Delete',
        ),
      ],
    );
  }

  Color _getPriorityColor(EmailPriority priority) {
    switch (priority) {
      case EmailPriority.low:
        return Colors.green.withOpacity(0.2);
      case EmailPriority.high:
        return Colors.orange.withOpacity(0.2);
      case EmailPriority.urgent:
        return Colors.red.withOpacity(0.2);
      default:
        return Colors.grey.withOpacity(0.2);
    }
  }

  Color _getContrastColor(Color color) {
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  void _toggleStar(WidgetRef ref) {
    final emailActions = ref.read(emailActionsProvider);
    emailActions.markAsStarred(email.id, starred: !email.isStarred);
  }

  void _toggleImportant(WidgetRef ref) {
    final emailActions = ref.read(emailActionsProvider);
    emailActions.markAsImportant(email.id, important: !email.isImportant);
  }

  void _reply(WidgetRef ref) {
    final composeActions = ref.read(composeActionsProvider);
    composeActions.replyToEmail(email);
    ref.read(emailViewModeProvider.notifier).state = EmailViewMode.compose;
  }

  void _replyAll(WidgetRef ref) {
    final composeActions = ref.read(composeActionsProvider);
    composeActions.replyAllToEmail(email);
    ref.read(emailViewModeProvider.notifier).state = EmailViewMode.compose;
  }

  void _forward(WidgetRef ref) {
    final composeActions = ref.read(composeActionsProvider);
    composeActions.forwardEmail(email);
    ref.read(emailViewModeProvider.notifier).state = EmailViewMode.compose;
  }

  void _archive(BuildContext context, WidgetRef ref) {
    final emailActions = ref.read(emailActionsProvider);
    emailActions.moveToFolder(email.id, 'archive');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email archived')),
    );
  }

  void _delete(BuildContext context, WidgetRef ref) {
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
              final emailActions = ref.read(emailActionsProvider);
              emailActions.deleteEmail(email.id);
              Navigator.of(context).pop();
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

  void _handleAction(BuildContext context, WidgetRef ref, String action) {
    final emailActions = ref.read(emailActionsProvider);
    
    switch (action) {
      case 'read':
        emailActions.markAsRead(email.id, read: !email.isRead);
        break;
      case 'reply':
        _reply(ref);
        break;
      case 'reply_all':
        _replyAll(ref);
        break;
      case 'forward':
        _forward(ref);
        break;
      case 'print':
        _print(context);
        break;
      case 'move':
        _showMoveDialog(context, ref);
        break;
      case 'labels':
        _showLabelsDialog(context, ref);
        break;
      case 'archive':
        _archive(context, ref);
        break;
      case 'delete':
        _delete(context, ref);
        break;
      case 'spam':
        _reportSpam(context, ref);
        break;
    }
  }

  void _print(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Print functionality not implemented')),
    );
  }

  void _showMoveDialog(BuildContext context, WidgetRef ref) {
    // TODO: Implement move to folder dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Move to folder not implemented')),
    );
  }

  void _showLabelsDialog(BuildContext context, WidgetRef ref) {
    // TODO: Implement add labels dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add labels not implemented')),
    );
  }

  void _reportSpam(BuildContext context, WidgetRef ref) {
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
              final emailActions = ref.read(emailActionsProvider);
              emailActions.moveToFolder(email.id, 'spam');
              Navigator.of(context).pop();
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

class EmailThreadView extends StatelessWidget {
  final EmailThread thread;

  const EmailThreadView({
    super.key,
    required this.thread,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.forum,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Thread (${thread.messageCount} messages)',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...thread.emails.map((email) => EmailListItem(
            email: email,
            isCompact: true,
            onTap: () {
              // Show email details
            },
          )),
        ],
      ),
    );
  }
}

// Using the main EmailListItem widget from email_list_item.dart