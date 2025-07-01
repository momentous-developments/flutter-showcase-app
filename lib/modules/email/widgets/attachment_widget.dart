import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/email_models.dart';
import '../providers/email_providers.dart';

class AttachmentWidget extends ConsumerWidget {
  final Attachment attachment;
  final bool canRemove;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;

  const AttachmentWidget({
    super.key,
    required this.attachment,
    this.canRemove = false,
    this.onRemove,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 1,
      child: InkWell(
        onTap: onTap ?? () => _downloadAttachment(context, ref),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  _buildFileIcon(theme),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          attachment.name,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          attachment.formattedSize,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (canRemove)
                    IconButton(
                      icon: const Icon(Icons.close, size: 16),
                      onPressed: onRemove,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 24,
                        minHeight: 24,
                      ),
                    ),
                ],
              ),
              if (attachment.status == AttachmentStatus.uploading)
                _buildUploadProgress(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFileIcon(ThemeData theme) {
    IconData iconData;
    Color iconColor;

    if (attachment.isImage) {
      iconData = Icons.image;
      iconColor = Colors.blue;
    } else if (attachment.isDocument) {
      iconData = Icons.description;
      iconColor = Colors.red;
    } else if (attachment.isVideo) {
      iconData = Icons.videocam;
      iconColor = Colors.purple;
    } else if (attachment.isAudio) {
      iconData = Icons.audiotrack;
      iconColor = Colors.orange;
    } else if (attachment.mimeType.contains('zip') || 
               attachment.mimeType.contains('rar') ||
               attachment.mimeType.contains('7z')) {
      iconData = Icons.archive;
      iconColor = Colors.green;
    } else if (attachment.mimeType.contains('excel') ||
               attachment.mimeType.contains('spreadsheet')) {
      iconData = Icons.table_chart;
      iconColor = Colors.green;
    } else if (attachment.mimeType.contains('powerpoint') ||
               attachment.mimeType.contains('presentation')) {
      iconData = Icons.slideshow;
      iconColor = Colors.orange;
    } else {
      iconData = Icons.insert_drive_file;
      iconColor = theme.colorScheme.onSurface.withOpacity(0.6);
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 18,
      ),
    );
  }

  Widget _buildUploadProgress() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: attachment.uploadProgress,
          ),
          const SizedBox(height: 4),
          Builder(
            builder: (context) => Text(
              'Uploading... ${((attachment.uploadProgress ?? 0) * 100).toInt()}%',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  void _downloadAttachment(BuildContext context, WidgetRef ref) async {
    try {
      final emailService = ref.read(emailServiceProvider);
      final bytes = await emailService.downloadAttachment(attachment.id);
      
      // Here you would typically save the file or open it
      // For now, just show a success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Downloaded ${attachment.name}'),
            action: SnackBarAction(
              label: 'Open',
              onPressed: () => _openAttachment(context, bytes),
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading ${attachment.name}: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  void _openAttachment(BuildContext context, dynamic bytes) {
    // TODO: Implement file opening logic
    // This would typically use a package like open_file or url_launcher
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('File opening not implemented yet'),
      ),
    );
  }
}

class AttachmentList extends StatelessWidget {
  final List<Attachment> attachments;
  final bool canRemove;
  final Function(Attachment)? onRemove;

  const AttachmentList({
    super.key,
    required this.attachments,
    this.canRemove = false,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attachments (${attachments.length})',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          if (attachments.length <= 3)
            Row(
              children: attachments
                  .map((attachment) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: AttachmentWidget(
                            attachment: attachment,
                            canRemove: canRemove,
                            onRemove: onRemove != null 
                                ? () => onRemove!(attachment)
                                : null,
                          ),
                        ),
                      ))
                  .toList(),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: attachments
                  .map((attachment) => AttachmentWidget(
                        attachment: attachment,
                        canRemove: canRemove,
                        onRemove: onRemove != null 
                            ? () => onRemove!(attachment)
                            : null,
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class AttachmentPreviewDialog extends StatelessWidget {
  final Attachment attachment;

  const AttachmentPreviewDialog({
    super.key,
    required this.attachment,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 600,
          maxHeight: 400,
        ),
        child: Column(
          children: [
            AppBar(
              title: Text(attachment.name),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () {
                    // Download attachment
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Expanded(
              child: _buildPreviewContent(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewContent(BuildContext context) {
    if (attachment.isImage && attachment.url != null) {
      return Image.network(
        attachment.url!,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => _buildErrorContent(),
      );
    } else if (attachment.mimeType.contains('text')) {
      return _buildTextPreview();
    } else {
      return _buildGenericPreview(context);
    }
  }

  Widget _buildTextPreview() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.description, size: 64),
          SizedBox(height: 16),
          Text('Text file preview not available'),
          SizedBox(height: 8),
          Text('Download to view content'),
        ],
      ),
    );
  }

  Widget _buildGenericPreview(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.insert_drive_file,
              size: 32,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            attachment.name,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            attachment.formattedSize,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.download),
            label: const Text('Download'),
            onPressed: () {
              // Download attachment
            },
          ),
        ],
      ),
    );
  }

  Widget _buildErrorContent() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64),
          SizedBox(height: 16),
          Text('Unable to load preview'),
        ],
      ),
    );
  }
}

class AttachmentGridView extends StatelessWidget {
  final List<Attachment> attachments;
  final Function(Attachment)? onTap;

  const AttachmentGridView({
    super.key,
    required this.attachments,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: attachments.length,
      itemBuilder: (context, index) {
        final attachment = attachments[index];
        return GestureDetector(
          onTap: () => onTap?.call(attachment),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  attachment.isImage ? Icons.image : Icons.insert_drive_file,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  attachment.name,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  attachment.formattedSize,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}