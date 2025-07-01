import 'package:flutter/material.dart';
import 'models/dialog_models.dart';
import 'widgets/form_dialog.dart';

/// Dialog for managing user permissions
class PermissionDialog extends StatefulWidget {
  const PermissionDialog({
    super.key,
    this.permissions = const [],
    this.onSave,
    this.onCancel,
  });

  final List<PermissionData> permissions;
  final Function(List<PermissionData>)? onSave;
  final VoidCallback? onCancel;

  @override
  State<PermissionDialog> createState() => _PermissionDialogState();
}

class _PermissionDialogState extends State<PermissionDialog> {
  late List<PermissionData> _permissions;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _permissions = List.from(widget.permissions);
    if (_permissions.isEmpty) {
      _permissions = [
        const PermissionData(id: '1', name: 'Read Access', category: 'Data'),
        const PermissionData(id: '2', name: 'Write Access', category: 'Data'),
        const PermissionData(id: '3', name: 'Admin Access', category: 'System'),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormDialog(
      title: 'Manage Permissions',
      subtitle: 'Grant or revoke user permissions',
      submitText: 'Save Permissions',
      cancelText: 'Cancel',
      isLoading: _isLoading,
      canSubmit: true,
      onSubmit: _handleSave,
      onCancel: widget.onCancel,
      child: Column(
        children: _permissions.map((permission) {
          return SwitchListTile(
            title: Text(permission.name),
            subtitle: Text(permission.category),
            value: permission.isGranted,
            onChanged: (value) {
              setState(() {
                final index = _permissions.indexOf(permission);
                _permissions[index] = permission.copyWith(isGranted: value);
              });
            },
          );
        }).toList(),
      ),
    );
  }

  void _handleSave() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    
    widget.onSave?.call(_permissions);
    if (mounted) Navigator.of(context).pop();
  }
}