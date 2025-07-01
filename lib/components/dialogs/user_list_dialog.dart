import 'package:flutter/material.dart';
import 'models/dialog_models.dart';
import 'widgets/base_dialog.dart';
import 'widgets/dialog_footer.dart';

/// Dialog for selecting users from a list
class UserListDialog extends StatefulWidget {
  const UserListDialog({
    super.key,
    this.users = const [],
    this.multiSelect = false,
    this.onSelect,
    this.onCancel,
  });

  final List<UserInfoData> users;
  final bool multiSelect;
  final Function(List<UserInfoData>)? onSelect;
  final VoidCallback? onCancel;

  @override
  State<UserListDialog> createState() => _UserListDialogState();
}

class _UserListDialogState extends State<UserListDialog> {
  final List<UserInfoData> _selectedUsers = [];
  String _searchQuery = '';

  List<UserInfoData> get _users => widget.users.isNotEmpty ? widget.users : [
    const UserInfoData(firstName: 'John', lastName: 'Doe', email: 'john@example.com', role: 'Developer'),
    const UserInfoData(firstName: 'Jane', lastName: 'Smith', email: 'jane@example.com', role: 'Designer'),
  ];

  List<UserInfoData> get _filteredUsers => _users.where((user) {
    return user.firstName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
           user.lastName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
           user.email.toLowerCase().contains(_searchQuery.toLowerCase());
  }).toList();

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Select Users',
      subtitle: widget.multiSelect ? 'Choose multiple users' : 'Choose a user',
      size: DialogSize.medium,
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search users...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredUsers.length,
              itemBuilder: (context, index) {
                final user = _filteredUsers[index];
                final isSelected = _selectedUsers.contains(user);
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(user.firstName[0] + user.lastName[0]),
                  ),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text('${user.email} • ${user.role}'),
                  trailing: widget.multiSelect
                      ? Checkbox(
                          value: isSelected,
                          onChanged: (value) => _toggleUser(user),
                        )
                      : null,
                  onTap: () => widget.multiSelect ? _toggleUser(user) : _selectUser(user),
                );
              },
            ),
          ),
        ],
      ),
      actions: [
        DialogActionButton.outlined(
          text: 'Cancel',
          onPressed: widget.onCancel ?? () => Navigator.of(context).pop(),
        ),
        if (widget.multiSelect)
          DialogActionButton.primary(
            text: 'Select (${_selectedUsers.length})',
            onPressed: _selectedUsers.isNotEmpty
                ? () {
                    widget.onSelect?.call(_selectedUsers);
                    Navigator.of(context).pop();
                  }
                : null,
          ),
      ],
    );
  }

  void _toggleUser(UserInfoData user) {
    setState(() {
      if (_selectedUsers.contains(user)) {
        _selectedUsers.remove(user);
      } else {
        _selectedUsers.add(user);
      }
    });
  }

  void _selectUser(UserInfoData user) {
    widget.onSelect?.call([user]);
    Navigator.of(context).pop();
  }
}