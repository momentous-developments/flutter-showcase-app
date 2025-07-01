import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../models/chat_models.dart';

class UserListItem extends StatelessWidget {
  final User user;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final int unreadCount;
  final bool isOnline;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool showStatus;
  final bool showLastMessage;

  const UserListItem({
    super.key,
    required this.user,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadCount = 0,
    this.isOnline = false,
    this.isSelected = false,
    this.onTap,
    this.onLongPress,
    this.showStatus = true,
    this.showLastMessage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primaryContainer
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        leading: _buildAvatar(context),
        title: _buildTitle(context),
        subtitle: showLastMessage ? _buildSubtitle(context) : null,
        trailing: _buildTrailing(context),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: user.avatar != null
              ? ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: user.avatar!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => _buildAvatarFallback(context),
                    errorWidget: (context, url, error) => _buildAvatarFallback(context),
                  ),
                )
              : _buildAvatarFallback(context),
        ),
        if (showStatus)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: _getStatusColor(),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.surface,
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAvatarFallback(BuildContext context) {
    return Center(
      child: Text(
        user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            user.name,
            style: TextStyle(
              fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? Theme.of(context).colorScheme.onPrimaryContainer
                  : Theme.of(context).colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (showStatus) _buildStatusIndicator(context),
      ],
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    if (lastMessage == null) return const SizedBox.shrink();

    return Text(
      lastMessage!,
      style: TextStyle(
        color: isSelected
            ? Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7)
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        fontWeight: unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTrailing(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (lastMessageTime != null)
          Text(
            _formatTime(lastMessageTime!),
            style: TextStyle(
              fontSize: 12,
              color: isSelected
                  ? Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7)
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        const SizedBox(height: 4),
        if (unreadCount > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
            child: Text(
              unreadCount > 99 ? '99+' : unreadCount.toString(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onError,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }

  Widget _buildStatusIndicator(BuildContext context) {
    if (!showStatus) return const SizedBox.shrink();

    String statusText = '';
    Color statusColor = Colors.grey;

    switch (user.userStatus) {
      case UserStatus.online:
        statusText = 'Online';
        statusColor = Colors.green;
        break;
      case UserStatus.away:
        statusText = 'Away';
        statusColor = Colors.orange;
        break;
      case UserStatus.busy:
        statusText = 'Busy';
        statusColor = Colors.red;
        break;
      case UserStatus.offline:
        statusText = _getLastSeenText();
        statusColor = Colors.grey;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: statusColor,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (user.userStatus) {
      case UserStatus.online:
        return Colors.green;
      case UserStatus.away:
        return Colors.orange;
      case UserStatus.busy:
        return Colors.red;
      case UserStatus.offline:
        return Colors.grey;
    }
  }

  String _getLastSeenText() {
    if (user.lastSeen == null) return 'Offline';

    final now = DateTime.now();
    final difference = now.difference(user.lastSeen!);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d').format(user.lastSeen!);
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays == 0) {
      return DateFormat('HH:mm').format(time);
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return DateFormat('EEE').format(time);
    } else {
      return DateFormat('MMM d').format(time);
    }
  }
}