import 'package:flutter/material.dart';
import 'widgets/form_dialog.dart';

/// Dialog for sharing project with team members
class ShareProjectDialog extends StatefulWidget {
  const ShareProjectDialog({
    super.key,
    this.projectName,
    this.onShare,
    this.onCancel,
  });

  final String? projectName;
  final Function(List<String> emails, String permission)? onShare;
  final VoidCallback? onCancel;

  @override
  State<ShareProjectDialog> createState() => _ShareProjectDialogState();
}

class _ShareProjectDialogState extends State<ShareProjectDialog> {
  final List<String> _emails = [];
  String _permission = 'view';
  String _currentEmail = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FormDialog(
      title: 'Share Project',
      subtitle: widget.projectName != null 
          ? 'Share "${widget.projectName}" with your team'
          : 'Share project with your team',
      submitText: 'Send Invitations',
      cancelText: 'Cancel',
      isLoading: _isLoading,
      canSubmit: _emails.isNotEmpty,
      onSubmit: _handleShare,
      onCancel: widget.onCancel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DialogFormField(
            label: 'Email Address',
            hint: 'colleague@company.com',
            value: _currentEmail,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => _currentEmail = value,
            suffixIcon: IconButton(
              onPressed: _addEmail,
              icon: const Icon(Icons.add),
            ),
          ),
          if (_emails.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: _emails.map((email) => Chip(
                label: Text(email),
                onDeleted: () => setState(() => _emails.remove(email)),
              )).toList(),
            ),
          ],
          const SizedBox(height: 16),
          DialogDropdownField<String>(
            label: 'Permission Level',
            value: _permission,
            items: const [
              DropdownMenuItem(value: 'view', child: Text('View Only')),
              DropdownMenuItem(value: 'edit', child: Text('Can Edit')),
              DropdownMenuItem(value: 'admin', child: Text('Admin')),
            ],
            onChanged: (value) => setState(() => _permission = value ?? 'view'),
          ),
        ],
      ),
    );
  }

  void _addEmail() {
    if (_currentEmail.isNotEmpty && 
        RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_currentEmail) &&
        !_emails.contains(_currentEmail)) {
      setState(() {
        _emails.add(_currentEmail);
        _currentEmail = '';
      });
    }
  }

  void _handleShare() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    
    widget.onShare?.call(_emails, _permission);
    if (mounted) Navigator.of(context).pop();
  }
}