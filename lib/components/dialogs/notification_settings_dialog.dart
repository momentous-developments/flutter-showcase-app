import 'package:flutter/material.dart';
import 'widgets/form_dialog.dart';

/// Dialog for managing notification preferences
class NotificationSettingsDialog extends StatefulWidget {
  const NotificationSettingsDialog({
    super.key,
    this.onSave,
    this.onCancel,
  });

  final Function(Map<String, bool>)? onSave;
  final VoidCallback? onCancel;

  @override
  State<NotificationSettingsDialog> createState() => _NotificationSettingsDialogState();
}

class _NotificationSettingsDialogState extends State<NotificationSettingsDialog> {
  final Map<String, bool> _settings = {
    'email_notifications': true,
    'push_notifications': true,
    'sms_notifications': false,
    'marketing_emails': false,
  };
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FormDialog(
      title: 'Notification Settings',
      subtitle: 'Manage your notification preferences',
      submitText: 'Save Settings',
      cancelText: 'Cancel',
      isLoading: _isLoading,
      canSubmit: true,
      onSubmit: _handleSave,
      onCancel: widget.onCancel,
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Email Notifications'),
            subtitle: const Text('Receive updates via email'),
            value: _settings['email_notifications']!,
            onChanged: (value) => setState(() => _settings['email_notifications'] = value),
          ),
          SwitchListTile(
            title: const Text('Push Notifications'),
            subtitle: const Text('Get real-time alerts'),
            value: _settings['push_notifications']!,
            onChanged: (value) => setState(() => _settings['push_notifications'] = value),
          ),
          SwitchListTile(
            title: const Text('SMS Notifications'),
            subtitle: const Text('Important alerts via SMS'),
            value: _settings['sms_notifications']!,
            onChanged: (value) => setState(() => _settings['sms_notifications'] = value),
          ),
          SwitchListTile(
            title: const Text('Marketing Emails'),
            subtitle: const Text('Product updates and offers'),
            value: _settings['marketing_emails']!,
            onChanged: (value) => setState(() => _settings['marketing_emails'] = value),
          ),
        ],
      ),
    );
  }

  void _handleSave() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    
    widget.onSave?.call(_settings);
    if (mounted) Navigator.of(context).pop();
  }
}