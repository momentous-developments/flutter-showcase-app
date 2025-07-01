import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/email_models.dart';
import '../providers/email_providers.dart';

class EmailListItem extends ConsumerWidget {
  final Email email;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isCompact;

  const EmailListItem({
    super.key,
    required this.email,
    this.isSelected = false,
    this.onTap,
    this.onLongPress,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selectedEmails = ref.watch(selectedEmailsProvider);
    final emailActions = ref.watch(emailActionsProvider);
    final isCurrentlySelected = selectedEmails.contains(email.id);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      elevation: isCurrentlySelected ? 2 : 0,
      color: isCurrentlySelected 
          ? theme.colorScheme.primaryContainer.withOpacity(0.3)
          : null,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress ?? () => _toggleSelection(emailActions),
        child: Padding(
          padding: EdgeInsets.all(isCompact ? 8 : 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Selection checkbox
              if (selectedEmails.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Checkbox(
                    value: isCurrentlySelected,
                    onChanged: (value) => _toggleSelection(emailActions),
                  ),
                ),
              
              // Sender avatar
              _buildSenderAvatar(theme),
              
              const SizedBox(width: 12),
              
              // Email content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildEmailHeader(theme),
                    if (!isCompact) ...[
                      const SizedBox(height: 4),
                      _buildEmailSubject(theme),
                      const SizedBox(height: 4),
                      _buildEmailPreview(theme),
                    ],
                  ],
                ),
              ),
              
              // Right side actions and indicators
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildTimestamp(theme),
                  const SizedBox(height: 4),
                  _buildIndicators(theme),
                  if (!isCompact) ...[
                    const SizedBox(height: 8),
                    _buildQuickActions(context, ref),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSenderAvatar(ThemeData theme) {
    return CircleAvatar(
      radius: isCompact ? 16 : 20,
      backgroundColor: theme.colorScheme.primaryContainer,
      backgroundImage: email.sender.avatar != null 
          ? NetworkImage(email.sender.avatar!)
          : null,
      child: email.sender.avatar == null
          ? Text(
              email.sender.initials,
              style: TextStyle(
                fontSize: isCompact ? 12 : 14,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            )
          : null,
    );
  }

  Widget _buildEmailHeader(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Text(
            email.sender.displayName,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: email.isRead ? FontWeight.normal : FontWeight.w600,
              color: email.isRead 
                  ? theme.colorScheme.onSurface.withOpacity(0.8)
                  : theme.colorScheme.onSurface,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (email.recipients.length > 1)
          Container(
            margin: const EdgeInsets.only(left: 4),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '+${email.recipients.length - 1}',
              style: theme.textTheme.labelSmall,
            ),
          ),
      ],
    );
  }

  Widget _buildEmailSubject(ThemeData theme) {
    return Text(
      email.displaySubject,
      style: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: email.isRead ? FontWeight.normal : FontWeight.w500,
        color: email.isRead 
            ? theme.colorScheme.onSurface.withOpacity(0.7)
            : theme.colorScheme.onSurface,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _buildEmailPreview(ThemeData theme) {
    return Text(
      email.previewText,
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurface.withOpacity(0.6),
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  Widget _buildTimestamp(ThemeData theme) {
    final now = DateTime.now();
    final difference = now.difference(email.timestamp);
    
    String timeText;
    if (difference.inDays > 0) {
      timeText = DateFormat('MMM d').format(email.timestamp);
    } else if (difference.inHours > 0) {
      timeText = '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      timeText = '${difference.inMinutes}m';
    } else {
      timeText = 'now';
    }

    return Text(
      timeText,
      style: theme.textTheme.labelSmall?.copyWith(
        color: theme.colorScheme.onSurface.withOpacity(0.6),
      ),
    );
  }

  Widget _buildIndicators(ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (email.priority == EmailPriority.high || email.priority == EmailPriority.urgent)
          Icon(
            Icons.priority_high,
            size: 16,
            color: email.priority == EmailPriority.urgent 
                ? Colors.red 
                : Colors.orange,
          ),
        if (email.isImportant)
          Icon(
            Icons.label_important,
            size: 16,
            color: Colors.amber,
          ),
        if (email.isStarred)
          Icon(
            Icons.star,
            size: 16,
            color: Colors.amber,
          ),
        if (email.hasAttachments)
          Icon(
            Icons.attach_file,
            size: 16,
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        if (!email.isRead)
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(left: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            email.isStarred ? Icons.star : Icons.star_border,
            size: 18,
          ),
          onPressed: () => _toggleStar(ref),
          tooltip: email.isStarred ? 'Remove star' : 'Add star',
        ),
        IconButton(
          icon: Icon(
            email.isImportant ? Icons.label_important : Icons.label_important_outline,
            size: 18,
          ),
          onPressed: () => _toggleImportant(ref),
          tooltip: email.isImportant ? 'Mark as not important' : 'Mark as important',
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, size: 18),
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
              value: 'forward',
              child: ListTile(
                leading: Icon(Icons.forward),
                title: Text('Forward'),
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
          ],
        ),
      ],
    );
  }

  void _toggleSelection(EmailActions emailActions) {
    final selectedEmails = emailActions.selectedEmailsNotifier.state;
    if (selectedEmails.contains(email.id)) {
      emailActions.deselectEmail(email.id);
    } else {
      emailActions.selectEmail(email.id);
    }
  }

  void _toggleStar(WidgetRef ref) {
    final emailActions = ref.read(emailActionsProvider);
    emailActions.markAsStarred(email.id, starred: !email.isStarred);
  }

  void _toggleImportant(WidgetRef ref) {
    final emailActions = ref.read(emailActionsProvider);
    emailActions.markAsImportant(email.id, important: !email.isImportant);
  }

  void _handleAction(BuildContext context, WidgetRef ref, String action) {
    final emailActions = ref.read(emailActionsProvider);
    final composeActions = ref.read(composeActionsProvider);
    
    switch (action) {
      case 'read':
        emailActions.markAsRead(email.id, read: !email.isRead);
        break;
      case 'reply':
        composeActions.replyToEmail(email);
        ref.read(emailViewModeProvider.notifier).state = EmailViewMode.compose;
        break;
      case 'forward':
        composeActions.forwardEmail(email);
        ref.read(emailViewModeProvider.notifier).state = EmailViewMode.compose;
        break;
      case 'archive':
        emailActions.moveToFolder(email.id, 'archive');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email archived')),
        );
        break;
      case 'delete':
        _showDeleteConfirmation(context, emailActions);
        break;
    }
  }

  void _showDeleteConfirmation(BuildContext context, EmailActions emailActions) {
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
}