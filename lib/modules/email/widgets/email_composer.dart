import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:file_picker/file_picker.dart';
import '../models/email_models.dart';
import '../providers/email_providers.dart';
import 'attachment_widget.dart';

class EmailComposer extends ConsumerStatefulWidget {
  final ComposeState? initialState;
  final VoidCallback? onClose;

  const EmailComposer({
    super.key,
    this.initialState,
    this.onClose,
  });

  @override
  ConsumerState<EmailComposer> createState() => _EmailComposerState();
}

class _EmailComposerState extends ConsumerState<EmailComposer> {
  late final TextEditingController _toController;
  late final TextEditingController _ccController;
  late final TextEditingController _bccController;
  late final TextEditingController _subjectController;
  late final QuillController _bodyController;
  
  bool _showCc = false;
  bool _showBcc = false;
  bool _isLoading = false;
  bool _isDraft = false;
  EmailPriority _priority = EmailPriority.normal;
  bool _requestReadReceipt = false;
  DateTime? _scheduledAt;
  List<Attachment> _attachments = [];

  @override
  void initState() {
    super.initState();
    
    final initialState = widget.initialState ?? ref.read(composeStateProvider);
    
    _toController = TextEditingController(text: initialState?.to ?? '');
    _ccController = TextEditingController(text: initialState?.cc ?? '');
    _bccController = TextEditingController(text: initialState?.bcc ?? '');
    _subjectController = TextEditingController(text: initialState?.subject ?? '');
    
    _bodyController = QuillController.basic();
    if (initialState?.body != null) {
      // Parse HTML content if available
      _bodyController.document.insert(0, initialState!.body!);
    }
    
    _attachments = initialState?.attachments ?? [];
    _priority = initialState?.priority ?? EmailPriority.normal;
    _requestReadReceipt = initialState?.requestReadReceipt ?? false;
    _scheduledAt = initialState?.scheduledAt;
    
    _showCc = _ccController.text.isNotEmpty;
    _showBcc = _bccController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _toController.dispose();
    _ccController.dispose();
    _bccController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 8,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 400,
          maxHeight: 600,
        ),
        child: Column(
          children: [
            _buildHeader(theme),
            const Divider(height: 1),
            Expanded(
              child: Column(
                children: [
                  _buildRecipientFields(),
                  _buildSubjectField(),
                  const Divider(height: 1),
                  _buildToolbar(),
                  const Divider(height: 1),
                  Expanded(child: _buildBodyEditor()),
                  if (_attachments.isNotEmpty) _buildAttachments(),
                ],
              ),
            ),
            const Divider(height: 1),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            Icons.edit,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text(
            _getHeaderTitle(),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          if (_isDraft)
            Chip(
              label: const Text('Draft'),
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
            ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.minimize),
            onPressed: () {
              // Minimize composer (not implemented)
            },
            tooltip: 'Minimize',
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: widget.onClose,
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientFields() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildRecipientField(
            controller: _toController,
            label: 'To',
            isRequired: true,
          ),
          if (_showCc)
            _buildRecipientField(
              controller: _ccController,
              label: 'Cc',
            ),
          if (_showBcc)
            _buildRecipientField(
              controller: _bccController,
              label: 'Bcc',
            ),
          if (!_showCc || !_showBcc)
            Row(
              children: [
                const SizedBox(width: 32),
                if (!_showCc)
                  TextButton(
                    onPressed: () => setState(() => _showCc = true),
                    child: const Text('Cc'),
                  ),
                if (!_showBcc)
                  TextButton(
                    onPressed: () => setState(() => _showBcc = true),
                    child: const Text('Bcc'),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildRecipientField({
    required TextEditingController controller,
    required String label,
    bool isRequired = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Enter email addresses',
                border: InputBorder.none,
                isDense: true,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.contacts),
                  onPressed: _showContactPicker,
                ),
              ),
              validator: isRequired
                  ? (value) => value?.isEmpty == true ? 'Required' : null
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 32),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: _subjectController,
              decoration: const InputDecoration(
                hintText: 'Subject',
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          PopupMenuButton<EmailPriority>(
            icon: Icon(
              _getPriorityIcon(),
              color: _getPriorityColor(),
            ),
            onSelected: (priority) => setState(() => _priority = priority),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: EmailPriority.low,
                child: Row(
                  children: [
                    Icon(Icons.keyboard_arrow_down, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Low Priority'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: EmailPriority.normal,
                child: Row(
                  children: [
                    Icon(Icons.remove, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('Normal Priority'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: EmailPriority.high,
                child: Row(
                  children: [
                    Icon(Icons.keyboard_arrow_up, color: Colors.orange),
                    SizedBox(width: 8),
                    Text('High Priority'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: EmailPriority.urgent,
                child: Row(
                  children: [
                    Icon(Icons.priority_high, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Urgent'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),  
      child: Row(
        children: [
          Expanded(
            child: QuillSimpleToolbar(
              controller: _bodyController,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: _pickFiles,
            tooltip: 'Attach files',
          ),
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: _pickImages,
            tooltip: 'Insert image',
          ),
        ],
      ),
    );
  }

  Widget _buildBodyEditor() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: QuillEditor.basic(
        controller: _bodyController,
      ),
    );
  }

  Widget _buildAttachments() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attachments (${_attachments.length})',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _attachments.map((attachment) => AttachmentWidget(
              attachment: attachment,
              canRemove: true,
              onRemove: () => _removeAttachment(attachment),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ElevatedButton.icon(
            icon: _isLoading 
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.send),
            label: const Text('Send'),
            onPressed: _isLoading ? null : _sendEmail,
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: _saveDraft,
            child: const Text('Save Draft'),
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: _showScheduleDialog,
            child: const Text('Schedule'),
          ),
          const Spacer(),
          Tooltip(
            message: 'More options',
            child: PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                CheckedPopupMenuItem(
                  value: 'read_receipt',
                  checked: _requestReadReceipt,
                  child: const Text('Request read receipt'),
                ),
                const PopupMenuItem(
                  value: 'template',
                  child: ListTile(
                    leading: Icon(Icons.save),
                    title: Text('Save as template'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'discard',
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Discard'),
                  ),
                ),
              ],
              onSelected: _handleMenuAction,
            ),
          ),
        ],
      ),
    );
  }

  String _getHeaderTitle() {
    final composeState = ref.read(composeStateProvider);
    switch (composeState?.mode) {
      case ComposeMode.reply:
        return 'Reply';
      case ComposeMode.replyAll:
        return 'Reply All';
      case ComposeMode.forward:
        return 'Forward';
      case ComposeMode.draft:
        return 'Edit Draft';
      default:
        return 'New Message';
    }
  }

  IconData _getPriorityIcon() {
    switch (_priority) {
      case EmailPriority.low:
        return Icons.keyboard_arrow_down;
      case EmailPriority.high:
        return Icons.keyboard_arrow_up;
      case EmailPriority.urgent:
        return Icons.priority_high;
      default:
        return Icons.remove;
    }
  }

  Color _getPriorityColor() {
    switch (_priority) {
      case EmailPriority.low:
        return Colors.green;
      case EmailPriority.high:
        return Colors.orange;
      case EmailPriority.urgent:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showContactPicker() {
    // TODO: Implement contact picker
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contact picker not implemented yet')),
    );
  }

  void _pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null) {
        for (final file in result.files) {
          if (file.bytes != null) {
            final attachment = await _uploadAttachment(
              file.name,
              file.extension ?? 'unknown',
              file.bytes!,
            );
            setState(() {
              _attachments.add(attachment);
            });
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking files: $e')),
      );
    }
  }

  void _pickImages() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );

      if (result != null) {
        for (final file in result.files) {
          if (file.bytes != null) {
            final attachment = await _uploadAttachment(
              file.name,
              file.extension ?? 'jpg',
              file.bytes!,
            );
            setState(() {
              _attachments.add(attachment);
            });
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking images: $e')),
      );
    }
  }

  Future<Attachment> _uploadAttachment(
    String fileName,
    String extension,
    Uint8List bytes,
  ) async {
    final emailService = ref.read(emailServiceProvider);
    
    return await emailService.uploadAttachment(
      fileName,
      'application/$extension',
      bytes,
      onProgress: (progress) {
        // TODO: Show upload progress
      },
    );
  }

  void _removeAttachment(Attachment attachment) {
    setState(() {
      _attachments.remove(attachment);
    });
  }

  void _sendEmail() async {
    if (_toController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter at least one recipient')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final composeActions = ref.read(composeActionsProvider);
      final composeState = _buildComposeState();
      
      composeActions.updateCompose(composeState);
      await composeActions.sendEmail();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email sent successfully')),
        );
        widget.onClose?.call();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending email: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _saveDraft() async {
    try {
      final composeActions = ref.read(composeActionsProvider);
      final composeState = _buildComposeState().copyWith(isDraft: true);
      
      composeActions.updateCompose(composeState);
      await composeActions.saveDraft();
      
      setState(() => _isDraft = true);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Draft saved')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving draft: $e')),
        );
      }
    }
  }

  void _showScheduleDialog() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(hours: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((date) {
      if (date != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((time) {
          if (time != null) {
            final scheduledAt = DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            );
            _scheduleEmail(scheduledAt);
          }
        });
      }
    });
  }

  void _scheduleEmail(DateTime scheduledAt) async {
    try {
      final composeActions = ref.read(composeActionsProvider);
      final composeState = _buildComposeState().copyWith(scheduledAt: scheduledAt);
      
      composeActions.updateCompose(composeState);
      await composeActions.scheduleEmail(scheduledAt);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email scheduled for ${scheduledAt.toString()}'),
          ),
        );
        widget.onClose?.call();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error scheduling email: $e')),
        );
      }
    }
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'read_receipt':
        setState(() => _requestReadReceipt = !_requestReadReceipt);
        break;
      case 'template':
        _saveAsTemplate();
        break;
      case 'discard':
        _discardEmail();
        break;
    }
  }

  void _saveAsTemplate() {
    // TODO: Implement save as template
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Save as template not implemented yet')),
    );
  }

  void _discardEmail() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard Email'),
        content: const Text('Are you sure you want to discard this email?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.onClose?.call();
            },
            child: const Text('Discard'),
          ),
        ],
      ),
    );
  }

  ComposeState _buildComposeState() {
    return ComposeState(
      to: _toController.text,
      cc: _ccController.text.isEmpty ? null : _ccController.text,
      bcc: _bccController.text.isEmpty ? null : _bccController.text,
      subject: _subjectController.text,
      body: _bodyController.document.toPlainText(),
      attachments: _attachments,
      priority: _priority,
      requestReadReceipt: _requestReadReceipt,
      scheduledAt: _scheduledAt,
      isDraft: _isDraft,
      lastSaved: DateTime.now(),
    );
  }
}