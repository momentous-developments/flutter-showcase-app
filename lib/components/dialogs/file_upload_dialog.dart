import 'package:flutter/material.dart';
import 'widgets/base_dialog.dart';
import 'widgets/dialog_footer.dart';

/// Dialog for file upload with progress indication
class FileUploadDialog extends StatefulWidget {
  const FileUploadDialog({
    super.key,
    this.onUpload,
    this.onCancel,
  });

  final Function(List<String> filePaths)? onUpload;
  final VoidCallback? onCancel;

  @override
  State<FileUploadDialog> createState() => _FileUploadDialogState();
}

class _FileUploadDialogState extends State<FileUploadDialog> {
  final List<UploadFile> _files = [];
  bool _isUploading = false;
  double _uploadProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Upload Files',
      subtitle: 'Select files to upload',
      size: DialogSize.medium,
      child: Column(
        children: [
          if (_files.isEmpty)
            _buildDropZone()
          else
            _buildFileList(),
          if (_isUploading) ...[
            const SizedBox(height: 16),
            LinearProgressIndicator(value: _uploadProgress),
            const SizedBox(height: 8),
            Text('Uploading... ${(_uploadProgress * 100).toInt()}%'),
          ],
        ],
      ),
      actions: [
        if (!_isUploading)
          DialogActionButton.text(
            text: 'Add Files',
            onPressed: _selectFiles,
            icon: const Icon(Icons.add),
          ),
        DialogActionButton.outlined(
          text: 'Cancel',
          onPressed: _isUploading ? null : widget.onCancel,
        ),
        DialogActionButton.primary(
          text: 'Upload',
          onPressed: _files.isNotEmpty && !_isUploading ? _handleUpload : null,
          isLoading: _isUploading,
        ),
      ],
    );
  }

  Widget _buildDropZone() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: colorScheme.outline,
          style: BorderStyle.solid,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
        color: colorScheme.surfaceVariant.withOpacity(0.3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_upload,
            size: 48,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Drop files here or click to select',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Supports: PDF, DOC, JPG, PNG (Max 10MB)',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _selectFiles,
            icon: const Icon(Icons.folder_open),
            label: const Text('Browse Files'),
          ),
        ],
      ),
    );
  }

  Widget _buildFileList() {
    return Column(
      children: [
        Container(
          height: 200,
          child: ListView.builder(
            itemCount: _files.length,
            itemBuilder: (context, index) {
              final file = _files[index];
              return ListTile(
                leading: Icon(_getFileIcon(file.name)),
                title: Text(file.name),
                subtitle: Text('${(file.size / 1024 / 1024).toStringAsFixed(1)} MB'),
                trailing: IconButton(
                  onPressed: _isUploading ? null : () => _removeFile(index),
                  icon: const Icon(Icons.remove_circle),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text('${_files.length} file(s) selected'),
            const Spacer(),
            TextButton.icon(
              onPressed: _isUploading ? null : _selectFiles,
              icon: const Icon(Icons.add),
              label: const Text('Add More'),
            ),
          ],
        ),
      ],
    );
  }

  IconData _getFileIcon(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }

  void _selectFiles() {
    // In a real app, this would open a file picker
    setState(() {
      _files.addAll([
        UploadFile(name: 'document.pdf', size: 2048000),
        UploadFile(name: 'image.jpg', size: 1024000),
      ]);
    });
  }

  void _removeFile(int index) {
    setState(() {
      _files.removeAt(index);
    });
  }

  void _handleUpload() async {
    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
    });

    // Simulate upload progress
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) {
        setState(() {
          _uploadProgress = i / 100;
        });
      }
    }

    setState(() {
      _isUploading = false;
    });

    widget.onUpload?.call(_files.map((f) => f.name).toList());
    if (mounted) Navigator.of(context).pop();
  }
}

class UploadFile {
  final String name;
  final int size;

  const UploadFile({
    required this.name,
    required this.size,
  });
}