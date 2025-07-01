import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/kanban_providers.dart';
import '../models/simple_models.dart';

class BoardSettingsView extends ConsumerStatefulWidget {
  final String boardId;
  
  const BoardSettingsView({
    super.key,
    required this.boardId,
  });
  
  @override
  ConsumerState<BoardSettingsView> createState() => _BoardSettingsViewState();
}

class _BoardSettingsViewState extends ConsumerState<BoardSettingsView> {
  late BoardSettings _settings;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    final board = ref.read(currentBoardProvider).value;
    if (board != null) {
      _titleController.text = board.title;
      _descriptionController.text = board.description ?? '';
      _settings = board.settings != null
          ? BoardSettings.fromJson(board.settings!)
          : const BoardSettings();
    }
  }
  
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Board Settings',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // General Settings
            Text(
              'General',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Board Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            
            // Feature Settings
            Text(
              'Features',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Show Task Numbers'),
              subtitle: const Text('Display task count on columns'),
              value: _settings.showTaskNumbers,
              onChanged: (value) {
                setState(() {
                  _settings = _settings.copyWith(showTaskNumbers: value);
                });
              },
            ),
            SwitchListTile(
              title: const Text('Allow Comments'),
              subtitle: const Text('Enable commenting on tasks'),
              value: _settings.allowComments,
              onChanged: (value) {
                setState(() {
                  _settings = _settings.copyWith(allowComments: value);
                });
              },
            ),
            SwitchListTile(
              title: const Text('Allow Attachments'),
              subtitle: const Text('Enable file attachments on tasks'),
              value: _settings.allowAttachments,
              onChanged: (value) {
                setState(() {
                  _settings = _settings.copyWith(allowAttachments: value);
                });
              },
            ),
            SwitchListTile(
              title: const Text('Allow Subtasks'),
              subtitle: const Text('Enable subtasks and checklists'),
              value: _settings.allowSubtasks,
              onChanged: (value) {
                setState(() {
                  _settings = _settings.copyWith(allowSubtasks: value);
                });
              },
            ),
            SwitchListTile(
              title: const Text('Allow Time Tracking'),
              subtitle: const Text('Track time spent on tasks'),
              value: _settings.allowTimeTracking,
              onChanged: (value) {
                setState(() {
                  _settings = _settings.copyWith(allowTimeTracking: value);
                });
              },
            ),
            SwitchListTile(
              title: const Text('Allow Labels'),
              subtitle: const Text('Use labels to categorize tasks'),
              value: _settings.allowLabels,
              onChanged: (value) {
                setState(() {
                  _settings = _settings.copyWith(allowLabels: value);
                });
              },
            ),
            SwitchListTile(
              title: const Text('Allow Due Dates'),
              subtitle: const Text('Set due dates on tasks'),
              value: _settings.allowDueDates,
              onChanged: (value) {
                setState(() {
                  _settings = _settings.copyWith(allowDueDates: value);
                });
              },
            ),
            SwitchListTile(
              title: const Text('Show Progress'),
              subtitle: const Text('Display progress indicators'),
              value: _settings.showProgress,
              onChanged: (value) {
                setState(() {
                  _settings = _settings.copyWith(showProgress: value);
                });
              },
            ),
            const SizedBox(height: 24),
            
            // Default View
            Text(
              'Default View',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _settings.defaultView,
              decoration: const InputDecoration(
                labelText: 'Default View',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'board', child: Text('Board View')),
                DropdownMenuItem(value: 'list', child: Text('List View')),
                DropdownMenuItem(value: 'calendar', child: Text('Calendar View')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _settings = _settings.copyWith(defaultView: value);
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            
            // Primary Color
            Text(
              'Primary Color',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                '#3F51B5', '#E91E63', '#9C27B0', '#673AB7',
                '#2196F3', '#009688', '#4CAF50', '#FF9800',
              ].map((color) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _settings = _settings.copyWith(primaryColor: color);
                    });
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(int.parse(color.replaceFirst('#', '0xFF'))),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _settings.primaryColor == color
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outline,
                        width: _settings.primaryColor == color ? 3 : 1,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            
            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _saveSettings,
                  child: const Text('Save Settings'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  void _saveSettings() async {
    final board = ref.read(currentBoardProvider).value;
    if (board != null) {
      final updatedBoard = board.copyWith(
        title: _titleController.text,
        description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
        settings: _settings.toJson(),
      );
      
      await ref.read(boardListProvider.notifier).updateBoard(widget.boardId, updatedBoard);
      ref.read(currentBoardProvider.notifier).updateBoard(updatedBoard);
      
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Board settings updated'),
          ),
        );
      }
    }
  }
}