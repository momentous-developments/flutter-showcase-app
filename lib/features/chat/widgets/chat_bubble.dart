import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:intl/intl.dart';
import '../models/chat_models.dart';
import 'message_reactions.dart';
import 'voice_message_player.dart';

class ChatBubble extends StatefulWidget {
  final Message message;
  final User? sender;
  final bool isCurrentUser;
  final bool showAvatar;
  final bool showTimestamp;
  final ChatBubbleStyle style;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Function(String emoji)? onReaction;
  final VoidCallback? onReply;
  final Color? bubbleColor;
  final Color? textColor;

  const ChatBubble({
    super.key,
    required this.message,
    this.sender,
    required this.isCurrentUser,
    this.showAvatar = true,
    this.showTimestamp = true,
    this.style = ChatBubbleStyle.modern,
    this.onTap,
    this.onLongPress,
    this.onReaction,
    this.onReply,
    this.bubbleColor,
    this.textColor,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  VideoPlayerController? _videoController;
  AudioPlayer? _audioPlayer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _animationController.forward();

    _initializeMediaController();
  }

  void _initializeMediaController() {
    if (widget.message.type == MessageType.video && widget.message.attachments.isNotEmpty) {
      final videoAttachment = widget.message.attachments.first;
      _videoController = VideoPlayerController.networkUrl(Uri.parse(videoAttachment.url))
        ..initialize().then((_) {
          if (mounted) setState(() {});
        });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _videoController?.dispose();
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: widget.isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!widget.isCurrentUser && widget.showAvatar) _buildAvatar(),
            const SizedBox(width: 8.0),
            Flexible(
              child: Column(
                crossAxisAlignment: widget.isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  _buildMessageBubble(),
                  if (widget.showTimestamp) _buildTimestamp(),
                  if (widget.message.reactions.isNotEmpty) _buildReactions(),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            if (widget.isCurrentUser && widget.showAvatar) _buildAvatar(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final avatar = widget.sender?.avatar;
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: avatar != null
          ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: avatar,
                fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => _buildAvatarFallback(),
              ),
            )
          : _buildAvatarFallback(),
    );
  }

  Widget _buildAvatarFallback() {
    final name = widget.sender?.name ?? 'User';
    return Center(
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : 'U',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMessageBubble() {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: _getBubbleDecoration(),
        padding: _getBubblePadding(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.message.replyToId != null) _buildReplyPreview(),
            if (!widget.isCurrentUser && widget.sender != null) _buildSenderName(),
            _buildMessageContent(),
            _buildMessageStatus(),
          ],
        ),
      ),
    );
  }

  BoxDecoration _getBubbleDecoration() {
    final theme = Theme.of(context);
    final isCurrentUser = widget.isCurrentUser;
    
    Color bubbleColor;
    if (widget.bubbleColor != null) {
      bubbleColor = widget.bubbleColor!;
    } else if (isCurrentUser) {
      bubbleColor = theme.colorScheme.primary;
    } else {
      bubbleColor = theme.colorScheme.surfaceContainerHighest;
    }

    switch (widget.style) {
      case ChatBubbleStyle.modern:
        return BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isCurrentUser ? 16 : 4),
            bottomRight: Radius.circular(isCurrentUser ? 4 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        );
      case ChatBubbleStyle.classic:
        return BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(12),
        );
      case ChatBubbleStyle.minimal:
        return BoxDecoration(
          color: bubbleColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: bubbleColor.withOpacity(0.3)),
        );
      case ChatBubbleStyle.rounded:
        return BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(24),
        );
      case ChatBubbleStyle.square:
        return BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(4),
        );
    }
  }

  EdgeInsetsGeometry _getBubblePadding() {
    switch (widget.message.type) {
      case MessageType.image:
      case MessageType.video:
        return const EdgeInsets.all(4);
      default:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
    }
  }

  Widget _buildReplyPreview() {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border(
          left: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 3,
          ),
        ),
      ),
      child: const Text(
        'Replying to message...', // TODO: Show actual replied message
        style: TextStyle(
          fontSize: 12,
          fontStyle: FontStyle.italic,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildSenderName() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        widget.sender?.name ?? 'Unknown',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }

  Widget _buildMessageContent() {
    switch (widget.message.type) {
      case MessageType.text:
        return _buildTextMessage();
      case MessageType.image:
        return _buildImageMessage();
      case MessageType.video:
        return _buildVideoMessage();
      case MessageType.audio:
      case MessageType.voice:
        return _buildVoiceMessage();
      case MessageType.file:
        return _buildFileMessage();
      case MessageType.location:
        return _buildLocationMessage();
      case MessageType.contact:
        return _buildContactMessage();
      case MessageType.system:
        return _buildSystemMessage();
      default:
        return _buildTextMessage();
    }
  }

  Widget _buildTextMessage() {
    return SelectableText(
      widget.message.content,
      style: TextStyle(
        color: widget.textColor ?? 
            (widget.isCurrentUser 
                ? Theme.of(context).colorScheme.onPrimary 
                : Theme.of(context).colorScheme.onSurface),
        fontSize: 16,
      ),
    );
  }

  Widget _buildImageMessage() {
    if (widget.message.attachments.isEmpty) return const SizedBox.shrink();
    
    final imageAttachment = widget.message.attachments.first;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: imageAttachment.url,
        width: 200,
        height: 200,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: 200,
          height: 200,
          color: Colors.grey[300],
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => Container(
          width: 200,
          height: 200,
          color: Colors.grey[300],
          child: const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildVideoMessage() {
    if (widget.message.attachments.isEmpty || _videoController == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black,
      ),
      child: _videoController!.value.isInitialized
          ? Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AspectRatio(
                    aspectRatio: _videoController!.value.aspectRatio,
                    child: VideoPlayer(_videoController!),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _videoController!.value.isPlaying
                          ? _videoController!.pause()
                          : _videoController!.play();
                    });
                  },
                  icon: Icon(
                    _videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildVoiceMessage() {
    if (widget.message.attachments.isEmpty) return const SizedBox.shrink();
    
    final voiceAttachment = widget.message.attachments.first;
    return VoiceMessagePlayer(
      url: voiceAttachment.url,
      duration: voiceAttachment.duration ?? 0,
    );
  }

  Widget _buildFileMessage() {
    if (widget.message.attachments.isEmpty) return const SizedBox.shrink();
    
    final fileAttachment = widget.message.attachments.first;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getFileIcon(fileAttachment.mimeType),
            size: 32,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileAttachment.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (fileAttachment.size != null)
                  Text(
                    _formatFileSize(fileAttachment.size!),
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_on, color: Colors.red),
          SizedBox(width: 8),
          Text('Location shared'),
        ],
      ),
    );
  }

  Widget _buildContactMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.contact_phone),
          SizedBox(width: 8),
          Text('Contact shared'),
        ],
      ),
    );
  }

  Widget _buildSystemMessage() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        widget.message.content,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontSize: 12,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _buildMessageStatus() {
    if (!widget.isCurrentUser) return const SizedBox.shrink();

    IconData statusIcon;
    Color statusColor = Theme.of(context).colorScheme.onPrimary.withOpacity(0.6);

    switch (widget.message.status) {
      case MessageStatus.sending:
        statusIcon = Icons.schedule;
        break;
      case MessageStatus.sent:
        statusIcon = Icons.check;
        break;
      case MessageStatus.delivered:
        statusIcon = Icons.done_all;
        break;
      case MessageStatus.read:
        statusIcon = Icons.done_all;
        statusColor = Colors.blue;
        break;
      case MessageStatus.failed:
        statusIcon = Icons.error;
        statusColor = Colors.red;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.message.isEdited)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                'edited',
                style: TextStyle(
                  fontSize: 10,
                  color: statusColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          Icon(
            statusIcon,
            size: 12,
            color: statusColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTimestamp() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        DateFormat('HH:mm').format(widget.message.timestamp ?? DateTime.now()),
        style: TextStyle(
          fontSize: 10,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
      ),
    );
  }

  Widget _buildReactions() {
    return MessageReactions(
      reactions: widget.message.reactions,
      onReactionTap: widget.onReaction,
    );
  }

  IconData _getFileIcon(String? mimeType) {
    if (mimeType == null) return Icons.insert_drive_file;
    
    if (mimeType.startsWith('image/')) return Icons.image;
    if (mimeType.startsWith('video/')) return Icons.video_file;
    if (mimeType.startsWith('audio/')) return Icons.audio_file;
    if (mimeType.contains('pdf')) return Icons.picture_as_pdf;
    if (mimeType.contains('document') || mimeType.contains('word')) return Icons.description;
    if (mimeType.contains('spreadsheet') || mimeType.contains('excel')) return Icons.table_chart;
    if (mimeType.contains('presentation') || mimeType.contains('powerpoint')) return Icons.slideshow;
    
    return Icons.insert_drive_file;
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}