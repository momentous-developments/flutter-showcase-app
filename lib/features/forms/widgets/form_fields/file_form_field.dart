import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../models/form_models.dart';

class FileFormField extends StatefulWidget {
  final FormFieldModel field;
  final List<FileUploadModel>? value;
  final String? error;
  final Function(List<FileUploadModel>) onChanged;
  
  const FileFormField({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });
  
  @override
  State<FileFormField> createState() => _FileFormFieldState();
}

class _FileFormFieldState extends State<FileFormField> {
  final List<FileUploadModel> _files = [];
  
  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      _files.addAll(widget.value!);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final multiple = widget.field.options?.multiple ?? false;
    final maxFiles = widget.field.options?.maxFiles;
    final acceptedTypes = widget.field.options?.acceptedFileTypes;
    final maxFileSize = widget.field.options?.maxFileSize;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.field.label != null) ...[
          Row(
            children: [
              Text(
                widget.field.label!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (widget.field.required) ...[
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
        ],
        
        // Upload button
        if (!widget.field.disabled && (maxFiles == null || _files.length < maxFiles))
          OutlinedButton.icon(
            onPressed: _pickFiles,
            icon: const Icon(Icons.upload_file),
            label: Text(
              multiple ? 'Choose Files' : 'Choose File',
            ),
          ),
        
        if (widget.field.helperText != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.field.helperText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        
        // File type and size restrictions
        if (acceptedTypes != null || maxFileSize != null) ...[
          const SizedBox(height: 4),
          Text(
            _buildRestrictionsText(acceptedTypes, maxFileSize),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        
        // File list
        if (_files.isNotEmpty) ...[
          const SizedBox(height: 16),
          ..._files.map((file) => _buildFileItem(file)),
        ],
        
        // Error message
        if (widget.error != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.error!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
  
  Widget _buildFileItem(FileUploadModel file) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: _getFileIcon(file.type),
        title: Text(
          file.name,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_formatFileSize(file.size)),
            if (file.status == FileUploadStatus.uploading)
              LinearProgressIndicator(value: file.uploadProgress),
          ],
        ),
        trailing: widget.field.disabled
            ? null
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (file.status == FileUploadStatus.error)
                    Tooltip(
                      message: file.error ?? 'Upload failed',
                      child: Icon(
                        Icons.error,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => _removeFile(file),
                    splashRadius: 20,
                  ),
                ],
              ),
      ),
    );
  }
  
  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: widget.field.options?.multiple ?? false,
        type: _getFileType(),
        allowedExtensions: _getAllowedExtensions(),
      );
      
      if (result != null) {
        final newFiles = result.files.map((file) {
          return FileUploadModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: file.name,
            size: file.size,
            type: file.extension ?? '',
            status: FileUploadStatus.pending,
          );
        }).toList();
        
        // Validate file size
        if (widget.field.options?.maxFileSize != null) {
          for (final file in newFiles) {
            if (file.size > widget.field.options!.maxFileSize!) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${file.name} exceeds maximum file size of ${_formatFileSize(widget.field.options!.maxFileSize!)}',
                  ),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
              return;
            }
          }
        }
        
        setState(() {
          _files.addAll(newFiles);
        });
        
        widget.onChanged(_files);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking files: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }
  
  void _removeFile(FileUploadModel file) {
    setState(() {
      _files.remove(file);
    });
    widget.onChanged(_files);
  }
  
  FileType _getFileType() {
    final types = widget.field.options?.acceptedFileTypes;
    if (types == null || types.isEmpty) {
      return FileType.any;
    }
    
    // Check if all types are images
    final imageTypes = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
    if (types.every((type) => imageTypes.contains(type.toLowerCase()))) {
      return FileType.image;
    }
    
    // Check if all types are videos
    final videoTypes = ['mp4', 'avi', 'mov', 'wmv', 'flv', 'mkv'];
    if (types.every((type) => videoTypes.contains(type.toLowerCase()))) {
      return FileType.video;
    }
    
    // Check if all types are audio
    final audioTypes = ['mp3', 'wav', 'flac', 'aac', 'ogg', 'wma'];
    if (types.every((type) => audioTypes.contains(type.toLowerCase()))) {
      return FileType.audio;
    }
    
    return FileType.custom;
  }
  
  List<String>? _getAllowedExtensions() {
    if (_getFileType() == FileType.custom) {
      return widget.field.options?.acceptedFileTypes;
    }
    return null;
  }
  
  Widget _getFileIcon(String fileType) {
    final type = fileType.toLowerCase();
    
    // Images
    if (['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(type)) {
      return const Icon(Icons.image, size: 40);
    }
    
    // Documents
    if (['pdf'].contains(type)) {
      return const Icon(Icons.picture_as_pdf, size: 40, color: Colors.red);
    }
    if (['doc', 'docx'].contains(type)) {
      return const Icon(Icons.description, size: 40, color: Colors.blue);
    }
    if (['xls', 'xlsx'].contains(type)) {
      return const Icon(Icons.table_chart, size: 40, color: Colors.green);
    }
    
    // Archives
    if (['zip', 'rar', '7z', 'tar', 'gz'].contains(type)) {
      return const Icon(Icons.folder_zip, size: 40);
    }
    
    // Videos
    if (['mp4', 'avi', 'mov', 'wmv', 'flv', 'mkv'].contains(type)) {
      return const Icon(Icons.video_file, size: 40);
    }
    
    // Audio
    if (['mp3', 'wav', 'flac', 'aac', 'ogg', 'wma'].contains(type)) {
      return const Icon(Icons.audio_file, size: 40);
    }
    
    return const Icon(Icons.insert_drive_file, size: 40);
  }
  
  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }
  
  String _buildRestrictionsText(List<String>? acceptedTypes, int? maxFileSize) {
    final restrictions = <String>[];
    
    if (acceptedTypes != null && acceptedTypes.isNotEmpty) {
      restrictions.add('Accepted: ${acceptedTypes.join(', ')}');
    }
    
    if (maxFileSize != null) {
      restrictions.add('Max size: ${_formatFileSize(maxFileSize)}');
    }
    
    return restrictions.join(' • ');
  }
}