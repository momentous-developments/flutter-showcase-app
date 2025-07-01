import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/kanban_providers.dart';

class MemberAvatar extends ConsumerWidget {
  final String memberId;
  final double size;
  final bool showBorder;
  
  const MemberAvatar({
    super.key,
    required this.memberId,
    this.size = 32,
    this.showBorder = true,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardId = ref.watch(selectedBoardIdProvider);
    if (boardId == null) return const SizedBox.shrink();
    
    final membersAsync = ref.watch(boardMembersProvider(boardId));
    
    return membersAsync.when(
      data: (members) {
        final member = members.firstWhere(
          (m) => m.userId == memberId,
          orElse: () => members.first, // Fallback
        );
        
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: showBorder
                ? Border.all(
                    color: Theme.of(context).colorScheme.surface,
                    width: 2,
                  )
                : null,
          ),
          child: ClipOval(
            child: member.avatarUrl != null
                ? Image.network(
                    member.avatarUrl!,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => _buildFallback(context, member.name),
                  )
                : _buildFallback(context, member.name),
          ),
        );
      },
      loading: () => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
      ),
      error: (_, __) => _buildFallback(context, 'U'),
    );
  }
  
  Widget _buildFallback(BuildContext context, String name) {
    final initials = name
        .split(' ')
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() : '')
        .take(2)
        .join();
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getColorFromString(name),
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  
  Color _getColorFromString(String input) {
    final colors = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
    ];
    
    final hash = input.hashCode;
    return colors[hash % colors.length];
  }
}