import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/theme_provider.dart';
import '../../core/constants/app_constants.dart';

/// Settings page for the application
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSection(
            title: 'Appearance',
            children: [
              ListTile(
                leading: const Icon(Icons.palette),
                title: const Text('Theme Color'),
                subtitle: Text('Current: ${_getCurrentColorName(themeState.colorSeed)}'),
                trailing: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: themeState.colorSeed,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: 2,
                    ),
                  ),
                ),
                onTap: () => _showColorPicker(context, ref),
              ),
              ListTile(
                leading: Icon(_getThemeModeIcon(themeState.themeMode)),
                title: const Text('Theme Mode'),
                subtitle: Text(_getThemeModeLabel(themeState.themeMode)),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showThemeModeDialog(context, ref, themeState.themeMode),
              ),
            ],
          ),
          _buildSection(
            title: 'Navigation',
            children: [
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () => context.go('/'),
              ),
              ListTile(
                leading: const Icon(Icons.widgets),
                title: const Text('Components'),
                onTap: () => context.go('/components'),
              ),
              ListTile(
                leading: const Icon(Icons.apps),
                title: const Text('Modules'),
                onTap: () => context.go('/modules'),
              ),
            ],
          ),
          _buildSection(
            title: 'About',
            children: [
              const ListTile(
                leading: Icon(Icons.info),
                title: Text('Flutter Material 3 Demo'),
                subtitle: Text('Version 1.0.0'),
              ),
              ListTile(
                leading: const Icon(Icons.code),
                title: const Text('View on GitHub'),
                subtitle: const Text('Source code and documentation'),
                trailing: const Icon(Icons.open_in_new),
                onTap: () {
                  // Open GitHub repository
                },
              ),
              const ListTile(
                leading: Icon(Icons.build),
                title: Text('Built with Flutter'),
                subtitle: Text('Material Design 3'),
              ),
            ],
          ),
          _buildSection(
            title: 'Advanced',
            children: [
              ListTile(
                leading: const Icon(Icons.restore),
                title: const Text('Reset Theme'),
                subtitle: const Text('Restore default theme settings'),
                onTap: () async {
                  await ref.read(themeProvider.notifier).resetTheme();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Theme reset to defaults')),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
        ...children,
        const Divider(height: 1),
      ],
    );
  }

  String _getCurrentColorName(Color color) {
    for (final seed in AppConstants.colorSeeds) {
      if (seed.color.value == color.value) {
        return seed.label;
      }
    }
    return 'Custom';
  }

  IconData _getThemeModeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  String _getThemeModeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light mode';
      case ThemeMode.dark:
        return 'Dark mode';
      case ThemeMode.system:
        return 'System default';
    }
  }

  void _showColorPicker(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme Color'),
        content: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: AppConstants.colorSeeds.asMap().entries.map((entry) {
            final index = entry.key;
            final seed = entry.value;
            final isSelected = ref.read(themeProvider).colorSeed.value == seed.color.value;
            
            return GestureDetector(
              onTap: () {
                ref.read(themeProvider.notifier).updateColorSeedByIndex(index);
                Navigator.of(context).pop();
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: seed.color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected 
                        ? Theme.of(context).colorScheme.onSurface 
                        : Theme.of(context).colorScheme.outline,
                    width: isSelected ? 3 : 2,
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        color: seed.color.computeLuminance() > 0.5
                            ? Colors.black
                            : Colors.white,
                      )
                    : null,
              ),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showThemeModeDialog(BuildContext context, WidgetRef ref, ThemeMode currentMode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Theme Mode'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ThemeMode.values.map((mode) {
            return RadioListTile<ThemeMode>(
              title: Text(_getThemeModeLabel(mode)),
              value: mode,
              groupValue: currentMode,
              onChanged: (value) {
                if (value != null) {
                  ref.read(themeProvider.notifier).updateThemeMode(value);
                  Navigator.of(context).pop();
                }
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}