import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/kanban_providers.dart';
import '../models/simple_models.dart';
import '../widgets/member_avatar.dart';

class TeamView extends ConsumerStatefulWidget {
  final String boardId;
  
  const TeamView({
    super.key,
    required this.boardId,
  });
  
  @override
  ConsumerState<TeamView> createState() => _TeamViewState();
}

class _TeamViewState extends ConsumerState<TeamView> {
  final _emailController = TextEditingController();
  
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final membersAsync = ref.watch(boardMembersProvider(widget.boardId));
    
    return Dialog(
      child: Container(
        width: 600,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Team Members',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Add member section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Team Member',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              hintText: 'Enter email address',
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        FilledButton.icon(
                          onPressed: _addMember,
                          icon: const Icon(Icons.person_add),
                          label: const Text('Add'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Members list
            Expanded(
              child: membersAsync.when(
                data: (members) => ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return _buildMemberTile(member);
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text('Error: $error'),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Stats
            membersAsync.maybeWhen(
              data: (members) => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat(
                      'Total Members',
                      members.length.toString(),
                      Icons.people,
                    ),
                    _buildStat(
                      'Active',
                      members.where((m) => m.isActive).length.toString(),
                      Icons.check_circle,
                    ),
                    _buildStat(
                      'Tasks Assigned',
                      members.fold<int>(0, (sum, m) => sum + m.tasksAssigned).toString(),
                      Icons.assignment,
                    ),
                    _buildStat(
                      'Tasks Completed',
                      members.fold<int>(0, (sum, m) => sum + m.tasksCompleted).toString(),
                      Icons.task_alt,
                    ),
                  ],
                ),
              ),
              orElse: () => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMemberTile(TeamMember member) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: MemberAvatar(
          memberId: member.userId,
          size: 40,
        ),
        title: Row(
          children: [
            Text(member.name),
            const SizedBox(width: 8),
            if (member.role == BoardRole.owner)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Owner',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(member.email),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.assignment,
                  size: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  '${member.tasksAssigned} assigned',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.check_circle,
                  size: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  '${member.tasksCompleted} completed',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        trailing: member.role != BoardRole.owner
            ? PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'change_role':
                      _showChangeRoleDialog(member);
                      break;
                    case 'remove':
                      _confirmRemoveMember(member);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'change_role',
                    child: ListTile(
                      leading: Icon(Icons.swap_horiz),
                      title: Text('Change Role'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'remove',
                    child: ListTile(
                      leading: Icon(
                        Icons.person_remove,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      title: Text(
                        'Remove Member',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }
  
  Widget _buildStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
  
  void _addMember() async {
    final email = _emailController.text.trim();
    if (email.isNotEmpty && email.contains('@')) {
      // In a real app, we'd search for the user by email
      final member = TeamMember(
        id: '',
        userId: 'user${DateTime.now().millisecondsSinceEpoch}',
        boardId: widget.boardId,
        name: email.split('@')[0].replaceAll('.', ' ').split(' ').map((e) => 
          e.isNotEmpty ? '${e[0].toUpperCase()}${e.substring(1)}' : ''
        ).join(' '),
        email: email,
        role: BoardRole.member,
        joinedAt: DateTime.now(),
      );
      
      await ref.read(boardMembersProvider(widget.boardId).notifier).addMember(member);
      _emailController.clear();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added ${member.name} to the board'),
          ),
        );
      }
    }
  }
  
  void _showChangeRoleDialog(TeamMember member) {
    BoardRole selectedRole = member.role;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Change Role for ${member.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: BoardRole.values
              .where((role) => role != BoardRole.owner)
              .map((role) => RadioListTile<BoardRole>(
                    title: Text(_getRoleName(role)),
                    subtitle: Text(_getRoleDescription(role)),
                    value: role,
                    groupValue: selectedRole,
                    onChanged: (value) {
                      if (value != null) {
                        Navigator.of(context).pop();
                        _changeRole(member, value);
                      }
                    },
                  ))
              .toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
  
  void _changeRole(TeamMember member, BoardRole newRole) async {
    await ref
        .read(boardMembersProvider(widget.boardId).notifier)
        .updateMemberRole(member.id, newRole);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Changed ${member.name}\'s role to ${_getRoleName(newRole)}'),
        ),
      );
    }
  }
  
  void _confirmRemoveMember(TeamMember member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Team Member'),
        content: Text('Are you sure you want to remove ${member.name} from this board?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              _removeMember(member);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
  
  void _removeMember(TeamMember member) async {
    await ref
        .read(boardMembersProvider(widget.boardId).notifier)
        .removeMember(member.id);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Removed ${member.name} from the board'),
        ),
      );
    }
  }
  
  String _getRoleName(BoardRole role) {
    switch (role) {
      case BoardRole.owner:
        return 'Owner';
      case BoardRole.admin:
        return 'Admin';
      case BoardRole.member:
        return 'Member';
      case BoardRole.viewer:
        return 'Viewer';
    }
  }
  
  String _getRoleDescription(BoardRole role) {
    switch (role) {
      case BoardRole.owner:
        return 'Full control over the board';
      case BoardRole.admin:
        return 'Can manage board settings and members';
      case BoardRole.member:
        return 'Can create and edit tasks';
      case BoardRole.viewer:
        return 'Can only view the board';
    }
  }
}