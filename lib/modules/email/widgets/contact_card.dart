import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/email_models.dart';
import '../providers/email_providers.dart';

class ContactCard extends ConsumerWidget {
  final Contact contact;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool showActions;

  const ContactCard({
    super.key,
    required this.contact,
    this.isSelected = false,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: isSelected ? 4 : 1,
      color: isSelected 
          ? theme.colorScheme.primaryContainer.withOpacity(0.3)
          : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildAvatar(theme),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contact.displayName,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          contact.email,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (showActions) _buildActions(context, ref),
                ],
              ),
              if (contact.company != null || contact.title != null) ...[
                const SizedBox(height: 8),
                _buildJobInfo(theme),
              ],
              if (contact.phone != null) ...[
                const SizedBox(height: 8),
                _buildContactInfo(theme),
              ],
              if (contact.tags?.isNotEmpty == true) ...[
                const SizedBox(height: 8),
                _buildTags(theme),
              ],
              if (contact.lastContact != null) ...[
                const SizedBox(height: 8),
                _buildLastContact(theme),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(ThemeData theme) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.primaryContainer,
        image: contact.avatar != null
            ? DecorationImage(
                image: NetworkImage(contact.avatar!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: contact.avatar == null
          ? Text(
              contact.initials,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            )
          : null,
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.email),
          onPressed: () => _composeEmail(ref),
          tooltip: 'Send email',
        ),
        if (contact.phone != null)
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () => _makeCall(context),
            tooltip: 'Call',
          ),
        PopupMenuButton<String>(
          onSelected: (action) => _handleAction(context, ref, action),
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
              value: 'export',
              child: ListTile(
                leading: Icon(Icons.download),
                title: Text('Export'),
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              value: 'block',
              child: ListTile(
                leading: const Icon(Icons.block),
                title: Text(contact.isBlocked == true ? 'Unblock' : 'Block'),
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
    );
  }

  Widget _buildJobInfo(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (contact.title != null)
          Text(
            contact.title!,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        if (contact.company != null)
          Text(
            contact.company!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
      ],
    );
  }

  Widget _buildContactInfo(ThemeData theme) {
    return Row(
      children: [
        Icon(
          Icons.phone,
          size: 16,
          color: theme.colorScheme.onSurface.withOpacity(0.6),
        ),
        const SizedBox(width: 4),
        Text(
          contact.phone!,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildTags(ThemeData theme) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: contact.tags!.take(3).map((tag) => Chip(
        label: Text(
          tag,
          style: theme.textTheme.labelSmall,
        ),
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      )).toList(),
    );
  }

  Widget _buildLastContact(ThemeData theme) {
    final now = DateTime.now();
    final difference = now.difference(contact.lastContact!);
    
    String timeText;
    if (difference.inDays > 0) {
      timeText = '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      timeText = '${difference.inHours}h ago';
    } else {
      timeText = 'Recently';
    }

    return Row(
      children: [
        Icon(
          Icons.access_time,
          size: 16,
          color: theme.colorScheme.onSurface.withOpacity(0.6),
        ),
        const SizedBox(width: 4),
        Text(
          'Last contact: $timeText',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  void _composeEmail(WidgetRef ref) {
    final composeActions = ref.read(composeActionsProvider);
    composeActions.newEmail();
    
    // Update compose state with recipient
    final currentState = ref.read(composeStateProvider);
    final newState = (currentState ?? const ComposeState()).copyWith(
      to: contact.email,
    );
    ref.read(composeStateProvider.notifier).state = newState;
    ref.read(emailViewModeProvider.notifier).state = EmailViewMode.compose;
  }

  void _makeCall(BuildContext context) {
    // TODO: Implement phone call functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling ${contact.phone}')),
    );
  }

  void _handleAction(BuildContext context, WidgetRef ref, String action) {
    switch (action) {
      case 'edit':
        onEdit?.call();
        break;
      case 'duplicate':
        _duplicateContact(context, ref);
        break;
      case 'export':
        _exportContact(context);
        break;
      case 'block':
        _toggleBlock(context, ref);
        break;
      case 'delete':
        _confirmDelete(context, ref);
        break;
    }
  }

  void _duplicateContact(BuildContext context, WidgetRef ref) {
    // TODO: Implement contact duplication
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contact duplication not implemented')),
    );
  }

  void _exportContact(BuildContext context) {
    // TODO: Implement contact export (vCard)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contact export not implemented')),
    );
  }

  void _toggleBlock(BuildContext context, WidgetRef ref) {
    final isBlocked = contact.isBlocked == true;
    // TODO: Implement contact blocking
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isBlocked ? 'Contact unblocked' : 'Contact blocked',
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Contact'),
        content: Text(
          'Are you sure you want to delete ${contact.displayName}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDelete?.call();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Contact deleted')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class ContactListItem extends ConsumerWidget {
  final Contact contact;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ContactListItem({
    super.key,
    required this.contact,
    this.isSelected = false,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return ListTile(
      selected: isSelected,
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primaryContainer,
        backgroundImage: contact.avatar != null
            ? NetworkImage(contact.avatar!)
            : null,
        child: contact.avatar == null
            ? Text(
                contact.initials,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              )
            : null,
      ),
      title: Text(
        contact.displayName,
        style: theme.textTheme.titleMedium,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(contact.email),
          if (contact.company != null || contact.title != null)
            Text(
              [contact.title, contact.company]
                  .where((e) => e != null)
                  .join(' at '),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.email),
            onPressed: () => _composeEmail(ref),
            tooltip: 'Send email',
          ),
          PopupMenuButton<String>(
            onSelected: (action) => _handleAction(context, ref, action),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  void _composeEmail(WidgetRef ref) {
    final composeActions = ref.read(composeActionsProvider);
    composeActions.newEmail();
    
    // Update compose state with recipient
    final currentState = ref.read(composeStateProvider);
    final newState = (currentState ?? const ComposeState()).copyWith(
      to: contact.email,
    );
    ref.read(composeStateProvider.notifier).state = newState;
    ref.read(emailViewModeProvider.notifier).state = EmailViewMode.compose;
  }

  void _handleAction(BuildContext context, WidgetRef ref, String action) {
    switch (action) {
      case 'edit':
        onEdit?.call();
        break;
      case 'delete':
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Contact'),
            content: Text(
              'Are you sure you want to delete ${contact.displayName}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onDelete?.call();
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        );
        break;
    }
  }
}

class ContactDetailView extends ConsumerWidget {
  final Contact contact;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ContactDetailView({
    super.key,
    required this.contact,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.displayName),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEdit,
          ),
          PopupMenuButton<String>(
            onSelected: (action) => _handleAction(context, action),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'share',
                child: ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Share'),
                ),
              ),
              const PopupMenuItem(
                value: 'export',
                child: ListTile(
                  leading: Icon(Icons.download),
                  title: Text('Export'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile section
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.primaryContainer,
                      image: contact.avatar != null
                          ? DecorationImage(
                              image: NetworkImage(contact.avatar!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: contact.avatar == null
                        ? Text(
                            contact.initials,
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    contact.displayName,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (contact.title != null || contact.company != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      [contact.title, contact.company]
                          .where((e) => e != null)
                          .join(' at '),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Quick actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildQuickAction(
                  context,
                  ref,
                  Icons.email,
                  'Email',
                  () => _composeEmail(ref),
                ),
                if (contact.phone != null)
                  _buildQuickAction(
                    context,
                    ref,
                    Icons.phone,
                    'Call',
                    () => _makeCall(context),
                  ),
                _buildQuickAction(
                  context,
                  ref,
                  Icons.message,
                  'Message',
                  () => _sendMessage(context),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Contact information
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Information',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(context, Icons.email, 'Email', contact.email),
                    if (contact.phone != null)
                      _buildInfoRow(context, Icons.phone, 'Phone', contact.phone!),
                    if (contact.company != null)
                      _buildInfoRow(context, Icons.business, 'Company', contact.company!),
                    if (contact.title != null)
                      _buildInfoRow(context, Icons.work, 'Title', contact.title!),
                  ],
                ),
              ),
            ),
            
            // Custom fields
            if (contact.customFields?.isNotEmpty == true) ...[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Additional Information',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...contact.customFields!.entries.map(
                        (entry) => _buildInfoRow(
                          context,
                          Icons.info,
                          entry.key,
                          entry.value.toString(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            
            // Tags
            if (contact.tags?.isNotEmpty == true) ...[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tags',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: contact.tags!.map((tag) => Chip(
                          label: Text(tag),
                          backgroundColor: theme.colorScheme.surfaceContainerHighest,
                        )).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context,
    WidgetRef ref,
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return Column(
      children: [
        FloatingActionButton(
          heroTag: label,
          onPressed: onPressed,
          child: Icon(icon),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _composeEmail(WidgetRef ref) {
    final composeActions = ref.read(composeActionsProvider);
    composeActions.newEmail();
    
    final currentState = ref.read(composeStateProvider);
    final newState = (currentState ?? const ComposeState()).copyWith(
      to: contact.email,
    );
    ref.read(composeStateProvider.notifier).state = newState;
    ref.read(emailViewModeProvider.notifier).state = EmailViewMode.compose;
  }

  void _makeCall(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling ${contact.phone}')),
    );
  }

  void _sendMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Messaging not implemented')),
    );
  }

  void _handleAction(BuildContext context, String action) {
    switch (action) {
      case 'share':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Share not implemented')),
        );
        break;
      case 'export':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Export not implemented')),
        );
        break;
      case 'delete':
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Contact'),
            content: Text(
              'Are you sure you want to delete ${contact.displayName}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onDelete?.call();
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        );
        break;
    }
  }
}