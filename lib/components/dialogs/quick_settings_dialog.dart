import 'package:flutter/material.dart';
import 'widgets/base_dialog.dart';
import 'widgets/dialog_footer.dart';

/// Dialog for quick access to common settings
class QuickSettingsDialog extends StatefulWidget {
  const QuickSettingsDialog({
    super.key,
    this.onSettingsChanged,
    this.onCancel,
  });

  final Function(Map<String, dynamic>)? onSettingsChanged;
  final VoidCallback? onCancel;

  @override
  State<QuickSettingsDialog> createState() => _QuickSettingsDialogState();
}

class _QuickSettingsDialogState extends State<QuickSettingsDialog> {
  bool _notifications = true;
  bool _darkMode = false;
  bool _soundEnabled = true;
  double _fontSize = 16.0;
  String _language = 'English';

  final List<String> _languages = ['English', 'Spanish', 'French', 'German', 'Japanese'];

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Quick Settings',
      subtitle: 'Adjust common preferences',
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            subtitle: const Text('Enable push notifications'),
            trailing: Switch(
              value: _notifications,
              onChanged: (value) => setState(() => _notifications = value),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            subtitle: const Text('Use dark theme'),
            trailing: Switch(
              value: _darkMode,
              onChanged: (value) => setState(() => _darkMode = value),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.volume_up),
            title: const Text('Sound'),
            subtitle: const Text('Enable sound effects'),
            trailing: Switch(
              value: _soundEnabled,
              onChanged: (value) => setState(() => _soundEnabled = value),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.text_fields),
            title: const Text('Font Size'),
            subtitle: Slider(
              value: _fontSize,
              min: 12.0,
              max: 24.0,
              divisions: 6,
              label: _fontSize.round().toString(),
              onChanged: (value) => setState(() => _fontSize = value),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: DropdownButton<String>(
              value: _language,
              isExpanded: true,
              underline: const SizedBox(),
              items: _languages.map((lang) {
                return DropdownMenuItem(value: lang, child: Text(lang));
              }).toList(),
              onChanged: (value) => setState(() => _language = value!),
            ),
          ),
        ],
      ),
      actions: [
        DialogActionButton.outlined(
          text: 'Cancel',
          onPressed: widget.onCancel ?? () => Navigator.of(context).pop(),
        ),
        DialogActionButton.primary(
          text: 'Apply',
          onPressed: () {
            final settings = <String, dynamic>{
              'notifications': _notifications,
              'darkMode': _darkMode,  
              'soundEnabled': _soundEnabled,
              'fontSize': _fontSize,
              'language': _language,
            };
            widget.onSettingsChanged?.call(settings);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}