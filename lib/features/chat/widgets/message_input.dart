import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import '../models/chat_models.dart';
import 'voice_recorder.dart';

class MessageInput extends StatefulWidget {
  final Function(String content, {MessageType type, List<File>? attachments}) onSendMessage;
  final VoidCallback? onTypingStart;
  final VoidCallback? onTypingStop;
  final bool enabled;
  final String? placeholder;
  final Message? replyToMessage;
  final VoidCallback? onCancelReply;

  const MessageInput({
    super.key,
    required this.onSendMessage,
    this.onTypingStart,
    this.onTypingStop,
    this.enabled = true,
    this.placeholder,
    this.replyToMessage,
    this.onCancelReply,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput>
    with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();
  final ImagePicker _imagePicker = ImagePicker();
  final AudioRecorder _audioRecorder = AudioRecorder();
  
  bool _isTyping = false;
  bool _showEmojiPicker = false;
  bool _isRecording = false;
  bool _showAttachmentOptions = false;
  List<File> _selectedFiles = [];
  
  late AnimationController _recordingAnimationController;
  late Animation<double> _recordingAnimation;
  late AnimationController _attachmentAnimationController;
  late Animation<double> _attachmentAnimation;

  @override
  void initState() {
    super.initState();
    
    _recordingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _recordingAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _recordingAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _attachmentAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _attachmentAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _attachmentAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _textController.addListener(_onTextChanged);
    _textFocusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _textController.dispose();
    _textFocusNode.dispose();
    _recordingAnimationController.dispose();
    _attachmentAnimationController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _textController.text.trim().isNotEmpty;
    if (hasText && !_isTyping) {
      _isTyping = true;
      widget.onTypingStart?.call();
    } else if (!hasText && _isTyping) {
      _isTyping = false;
      widget.onTypingStop?.call();
    }
    setState(() {});
  }

  void _onFocusChanged() {
    if (_textFocusNode.hasFocus && _showEmojiPicker) {
      setState(() {
        _showEmojiPicker = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.replyToMessage != null) _buildReplyPreview(),
        if (_selectedFiles.isNotEmpty) _buildSelectedFiles(),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              top: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
              ),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                if (_showAttachmentOptions) _buildAttachmentOptions(),
                _buildInputRow(),
                if (_showEmojiPicker) _buildEmojiPicker(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReplyPreview() {
    if (widget.replyToMessage == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        border: Border(
          left: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 4,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Replying to',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.replyToMessage!.content,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: widget.onCancelReply,
            icon: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedFiles() {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _selectedFiles.length,
        itemBuilder: (context, index) {
          final file = _selectedFiles[index];
          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.surfaceVariant,
            ),
            child: Stack(
              children: [
                Center(
                  child: _isImageFile(file)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            file,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getFileIcon(file),
                              size: 32,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _getFileName(file),
                              style: const TextStyle(fontSize: 10),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _removeFile(index),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            onPressed: _toggleAttachmentOptions,
            icon: AnimatedRotation(
              turns: _showAttachmentOptions ? 0.125 : 0,
              duration: const Duration(milliseconds: 300),
              child: const Icon(Icons.add),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      focusNode: _textFocusNode,
                      enabled: widget.enabled,
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: widget.placeholder ?? 'Type a message...',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      textInputAction: TextInputAction.newline,
                      onSubmitted: _hasContent() ? (_) => _sendMessage() : null,
                    ),
                  ),
                  IconButton(
                    onPressed: _toggleEmojiPicker,
                    icon: Icon(
                      _showEmojiPicker ? Icons.keyboard : Icons.emoji_emotions_outlined,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          _buildSendButton(),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    if (_isRecording) {
      return ScaleTransition(
        scale: _recordingAnimation,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: _stopRecording,
            icon: const Icon(Icons.stop, color: Colors.white),
          ),
        ),
      );
    }

    if (_hasContent()) {
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: _sendMessage,
          icon: Icon(
            Icons.send,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      );
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: _startRecording,
        icon: Icon(
          Icons.mic,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }

  Widget _buildAttachmentOptions() {
    return ScaleTransition(
      scale: _attachmentAnimation,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAttachmentOption(
              icon: Icons.photo_camera,
              label: 'Camera',
              onTap: _takePhoto,
            ),
            _buildAttachmentOption(
              icon: Icons.photo_library,
              label: 'Gallery',
              onTap: _pickImages,
            ),
            _buildAttachmentOption(
              icon: Icons.videocam,
              label: 'Video',
              onTap: _takeVideo,
            ),
            _buildAttachmentOption(
              icon: Icons.insert_drive_file,
              label: 'File',
              onTap: _pickFiles,
            ),
            _buildAttachmentOption(
              icon: Icons.location_on,
              label: 'Location',
              onTap: _shareLocation,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmojiPicker() {
    return SizedBox(
      height: 250,
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {
          _textController.text += emoji.emoji;
          _textController.selection = TextSelection.fromPosition(
            TextPosition(offset: _textController.text.length),
          );
        },
        config: Config(
          height: 256,
          checkPlatformCompatibility: true,
          emojiViewConfig: EmojiViewConfig(
            backgroundColor: Theme.of(context).colorScheme.surface,
            emojiSizeMax: 28,
          ),
          skinToneConfig: const SkinToneConfig(),
          categoryViewConfig: CategoryViewConfig(
            backgroundColor: Theme.of(context).colorScheme.surface,
            iconColorSelected: Theme.of(context).colorScheme.primary,
          ),
          bottomActionBarConfig: BottomActionBarConfig(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    );
  }

  bool _hasContent() {
    return _textController.text.trim().isNotEmpty || _selectedFiles.isNotEmpty;
  }

  void _sendMessage() {
    if (!_hasContent()) return;

    final content = _textController.text.trim();
    final files = List<File>.from(_selectedFiles);

    // Determine message type
    MessageType messageType = MessageType.text;
    if (files.isNotEmpty) {
      if (files.every(_isImageFile)) {
        messageType = MessageType.image;
      } else if (files.any(_isVideoFile)) {
        messageType = MessageType.video;
      } else {
        messageType = MessageType.file;
      }
    }

    widget.onSendMessage(
      content,
      type: messageType,
      attachments: files.isNotEmpty ? files : null,
    );

    // Clear input
    _textController.clear();
    _selectedFiles.clear();
    widget.onTypingStop?.call();
    _isTyping = false;
    setState(() {});
  }

  void _toggleAttachmentOptions() {
    setState(() {
      _showAttachmentOptions = !_showAttachmentOptions;
    });

    if (_showAttachmentOptions) {
      _attachmentAnimationController.forward();
    } else {
      _attachmentAnimationController.reverse();
    }
  }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });

    if (_showEmojiPicker) {
      _textFocusNode.unfocus();
    } else {
      _textFocusNode.requestFocus();
    }
  }

  Future<void> _takePhoto() async {
    final image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _selectedFiles.add(File(image.path));
      setState(() {});
    }
    _toggleAttachmentOptions();
  }

  Future<void> _pickImages() async {
    final images = await _imagePicker.pickMultiImage();
    for (final image in images) {
      _selectedFiles.add(File(image.path));
    }
    setState(() {});
    _toggleAttachmentOptions();
  }

  Future<void> _takeVideo() async {
    final video = await _imagePicker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      _selectedFiles.add(File(video.path));
      setState(() {});
    }
    _toggleAttachmentOptions();
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );

    if (result != null) {
      for (final platformFile in result.files) {
        if (platformFile.path != null) {
          _selectedFiles.add(File(platformFile.path!));
        }
      }
      setState(() {});
    }
    _toggleAttachmentOptions();
  }

  void _shareLocation() {
    // TODO: Implement location sharing
    _toggleAttachmentOptions();
  }

  Future<void> _startRecording() async {
    try {
      final permission = await Permission.microphone.request();
      if (permission != PermissionStatus.granted) return;

      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start(const RecordConfig(), path: 'temp_voice_message.m4a');
        setState(() {
          _isRecording = true;
        });
        _recordingAnimationController.repeat(reverse: true);
      }
    } catch (e) {
      debugPrint('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
      });
      _recordingAnimationController.stop();

      if (path != null) {
        _selectedFiles.add(File(path));
        // Send as voice message
        widget.onSendMessage(
          'Voice message',
          type: MessageType.voice,
          attachments: [File(path)],
        );
        _selectedFiles.clear();
      }
    } catch (e) {
      debugPrint('Error stopping recording: $e');
    }
  }

  void _removeFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
  }

  bool _isImageFile(File file) {
    final extension = file.path.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'].contains(extension);
  }

  bool _isVideoFile(File file) {
    final extension = file.path.split('.').last.toLowerCase();
    return ['mp4', 'avi', 'mov', 'wmv', 'flv', 'webm', 'mkv'].contains(extension);
  }

  IconData _getFileIcon(File file) {
    final extension = file.path.split('.').last.toLowerCase();
    
    if (['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'].contains(extension)) {
      return Icons.image;
    }
    if (['mp4', 'avi', 'mov', 'wmv', 'flv', 'webm', 'mkv'].contains(extension)) {
      return Icons.video_file;
    }
    if (['mp3', 'wav', 'flac', 'aac', 'ogg', 'm4a'].contains(extension)) {
      return Icons.audio_file;
    }
    if (['pdf'].contains(extension)) {
      return Icons.picture_as_pdf;
    }
    if (['doc', 'docx'].contains(extension)) {
      return Icons.description;
    }
    if (['xls', 'xlsx'].contains(extension)) {
      return Icons.table_chart;
    }
    if (['ppt', 'pptx'].contains(extension)) {
      return Icons.slideshow;
    }
    
    return Icons.insert_drive_file;
  }

  String _getFileName(File file) {
    return file.path.split('/').last;
  }
}