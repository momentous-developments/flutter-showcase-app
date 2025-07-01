import 'package:flutter/material.dart';
import 'widgets/base_dialog.dart';
import 'widgets/dialog_footer.dart';

/// Dialog for performing bulk actions on selected items
class BulkActionsDialog extends StatefulWidget {
  const BulkActionsDialog({
    super.key,
    required this.itemCount,
    this.onAction,
    this.onCancel,
  });

  final int itemCount;
  final Function(String action)? onAction;
  final VoidCallback? onCancel;

  @override
  State<BulkActionsDialog> createState() => _BulkActionsDialogState();
}

class _BulkActionsDialogState extends State<BulkActionsDialog> {
  String? _selectedAction;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _actions = [
    {'id': 'delete', 'name': 'Delete', 'icon': Icons.delete, 'color': Colors.red},
    {'id': 'archive', 'name': 'Archive', 'icon': Icons.archive, 'color': Colors.blue},
    {'id': 'export', 'name': 'Export', 'icon': Icons.download, 'color': Colors.green},
    {'id': 'move', 'name': 'Move to Folder', 'icon': Icons.folder, 'color': Colors.orange},
  ];

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Bulk Actions',
      subtitle: 'Choose an action for ${widget.itemCount} selected items',
      child: Column(
        children: _actions.map((action) {
          final isSelected = _selectedAction == action['id'];
          return Card(
            color: isSelected
                ? Theme.of(context).colorScheme.primaryContainer
                : null,
            child: ListTile(
              leading: Icon(
                action['icon'],
                color: action['color'],
              ),
              title: Text(action['name']),
              trailing: Radio<String>(
                value: action['id'],
                groupValue: _selectedAction,
                onChanged: (value) => setState(() => _selectedAction = value),
              ),
              onTap: () => setState(() => _selectedAction = action['id']),
            ),
          );
        }).toList(),
      ),
      actions: [
        DialogActionButton.outlined(
          text: 'Cancel',
          onPressed: _isLoading ? null : widget.onCancel,
        ),
        DialogActionButton.primary(
          text: 'Apply',
          onPressed: _selectedAction != null && !_isLoading ? _handleAction : null,
          isLoading: _isLoading,
        ),
      ],
    );
  }

  void _handleAction() async {
    if (_selectedAction == null) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

    widget.onAction?.call(_selectedAction!);
    if (mounted) Navigator.of(context).pop();
  }
}