import 'package:flutter/material.dart';
import 'widgets/form_dialog.dart';

/// Dialog for customizing app theme
class ThemeCustomizationDialog extends StatefulWidget {
  const ThemeCustomizationDialog({
    super.key,
    this.onThemeChanged,
    this.onCancel,
  });

  final Function(ThemeSettings)? onThemeChanged;
  final VoidCallback? onCancel;

  @override
  State<ThemeCustomizationDialog> createState() => _ThemeCustomizationDialogState();
}

class _ThemeCustomizationDialogState extends State<ThemeCustomizationDialog> {
  ThemeMode _themeMode = ThemeMode.system;
  Color _primaryColor = Colors.blue;
  bool _isLoading = false;

  final List<Color> _colorOptions = [
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.red,
    Colors.teal,
  ];

  @override
  Widget build(BuildContext context) {
    return FormDialog(
      title: 'Theme Settings',
      subtitle: 'Customize the app appearance',
      submitText: 'Apply Theme',
      cancelText: 'Cancel',
      isLoading: _isLoading,
      canSubmit: true,
      onSubmit: _handleApply,
      onCancel: widget.onCancel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Theme Mode', style: Theme.of(context).textTheme.titleMedium),
          RadioListTile<ThemeMode>(
            title: const Text('System'),
            value: ThemeMode.system,
            groupValue: _themeMode,
            onChanged: (value) => setState(() => _themeMode = value!),
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Light'),
            value: ThemeMode.light,
            groupValue: _themeMode,
            onChanged: (value) => setState(() => _themeMode = value!),
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Dark'),
            value: ThemeMode.dark,
            groupValue: _themeMode,
            onChanged: (value) => setState(() => _themeMode = value!),
          ),
          const SizedBox(height: 16),
          Text('Primary Color', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: _colorOptions.map((color) {
              return GestureDetector(
                onTap: () => setState(() => _primaryColor = color),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: _primaryColor == color
                        ? Border.all(color: Colors.black, width: 2)
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _handleApply() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _isLoading = false);
    
    widget.onThemeChanged?.call(ThemeSettings(
      themeMode: _themeMode,
      primaryColor: _primaryColor,
    ));
    if (mounted) Navigator.of(context).pop();
  }
}

class ThemeSettings {
  final ThemeMode themeMode;
  final Color primaryColor;

  const ThemeSettings({
    required this.themeMode,
    required this.primaryColor,
  });
}