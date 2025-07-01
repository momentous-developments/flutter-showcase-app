import 'package:flutter/material.dart';
import 'models/dialog_models.dart';
import 'widgets/form_dialog.dart';

/// Dialog for managing user roles
class RoleManagementDialog extends StatefulWidget {
  const RoleManagementDialog({
    super.key,
    this.currentRole,
    this.availableRoles = const [],
    this.onRoleChanged,
    this.onCancel,
  });

  final String? currentRole;
  final List<RoleData> availableRoles;
  final Function(String roleId)? onRoleChanged;
  final VoidCallback? onCancel;

  @override
  State<RoleManagementDialog> createState() => _RoleManagementDialogState();
}

class _RoleManagementDialogState extends State<RoleManagementDialog> {
  String? _selectedRole;
  bool _isLoading = false;

  List<RoleData> get _roles => widget.availableRoles.isNotEmpty ? widget.availableRoles : [
    const RoleData(id: 'admin', name: 'Administrator', description: 'Full access'),
    const RoleData(id: 'editor', name: 'Editor', description: 'Edit content'),
    const RoleData(id: 'viewer', name: 'Viewer', description: 'View only'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.currentRole;
  }

  @override
  Widget build(BuildContext context) {
    return FormDialog(
      title: 'Assign Role',
      subtitle: 'Select the appropriate role for this user',
      submitText: 'Assign Role',
      cancelText: 'Cancel',
      isLoading: _isLoading,
      canSubmit: _selectedRole != null && _selectedRole != widget.currentRole,
      onSubmit: _handleRoleChange,
      onCancel: widget.onCancel,
      child: Column(
        children: _roles.map((role) {
          final isSelected = _selectedRole == role.id;
          final isCurrent = widget.currentRole == role.id;
          return Card(
            color: isSelected
                ? Theme.of(context).colorScheme.primaryContainer
                : null,
            child: ListTile(
              title: Row(
                children: [
                  Text(role.name),
                  if (isCurrent) ...[
                    const SizedBox(width: 8),
                    Chip(
                      label: const Text('Current'),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ],
                ],
              ),
              subtitle: Text(role.description),
              trailing: Radio<String>(
                value: role.id,
                groupValue: _selectedRole,
                onChanged: (value) => setState(() => _selectedRole = value),
              ),
              onTap: () => setState(() => _selectedRole = role.id),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _handleRoleChange() async {
    if (_selectedRole == null) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

    widget.onRoleChanged?.call(_selectedRole!);
    if (mounted) Navigator.of(context).pop();
  }
}