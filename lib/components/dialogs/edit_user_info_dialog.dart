import 'package:flutter/material.dart';
import 'models/dialog_models.dart';
import 'widgets/form_dialog.dart';

/// Dialog for editing user profile information
class EditUserInfoDialog extends StatefulWidget {
  const EditUserInfoDialog({
    super.key,
    this.userData,
    this.onSave,
    this.onCancel,
  });

  final UserInfoData? userData;
  final Function(UserInfoData)? onSave;
  final VoidCallback? onCancel;

  @override
  State<EditUserInfoDialog> createState() => _EditUserInfoDialogState();
}

class _EditUserInfoDialogState extends State<EditUserInfoDialog> {
  late UserInfoData _userData;
  bool _isLoading = false;

  final List<String> _roles = [
    'Administrator',
    'Manager',
    'Developer',
    'Designer',
    'Analyst',
    'Support',
    'User',
  ];

  final List<String> _departments = [
    'Engineering',
    'Design',
    'Product',
    'Marketing',
    'Sales',
    'Support',
    'Human Resources',
    'Finance',
  ];

  @override
  void initState() {
    super.initState();
    _userData = widget.userData ?? const UserInfoData();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.userData != null;

    return FormDialog(
      title: isEditing ? 'Edit User Information' : 'Add New User',
      subtitle: isEditing
          ? 'Update user profile information'
          : 'Create a new user account',
      submitText: isEditing ? 'Update User' : 'Create User',
      cancelText: 'Cancel',
      isLoading: _isLoading,
      canSubmit: _canSubmit(),
      onSubmit: _handleSubmit,
      onCancel: widget.onCancel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatarSection(),
          const SizedBox(height: 24),
          _buildNameFields(),
          const SizedBox(height: 16),
          _buildContactFields(),
          const SizedBox(height: 16),
          _buildRoleAndDepartmentFields(),
          const SizedBox(height: 16),
          _buildBioField(),
        ],
      ),
    );
  }

  Widget _buildAvatarSection() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: colorScheme.primaryContainer,
                backgroundImage: _userData.avatarUrl.isNotEmpty
                    ? NetworkImage(_userData.avatarUrl)
                    : null,
                child: _userData.avatarUrl.isEmpty
                    ? Icon(
                        Icons.person,
                        size: 50,
                        color: colorScheme.onPrimaryContainer,
                      )
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Material(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: _selectAvatar,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Profile Picture',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameFields() {
    return Row(
      children: [
        Expanded(
          child: DialogFormField(
            label: 'First Name',
            hint: 'John',
            value: _userData.firstName,
            required: true,
            onChanged: (value) {
              setState(() {
                _userData = _userData.copyWith(firstName: value);
              });
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'First name is required';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.person_outline),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DialogFormField(
            label: 'Last Name',
            hint: 'Doe',
            value: _userData.lastName,
            required: true,
            onChanged: (value) {
              setState(() {
                _userData = _userData.copyWith(lastName: value);
              });
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Last name is required';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContactFields() {
    return Column(
      children: [
        DialogFormField(
          label: 'Email Address',
          hint: 'john.doe@company.com',
          value: _userData.email,
          required: true,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            setState(() {
              _userData = _userData.copyWith(email: value);
            });
          },
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Email is required';
            }
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        DialogFormField(
          label: 'Phone Number',
          hint: '+1 (555) 123-4567',
          value: _userData.phone,
          keyboardType: TextInputType.phone,
          onChanged: (value) {
            setState(() {
              _userData = _userData.copyWith(phone: value);
            });
          },
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              if (value.length < 10) {
                return 'Please enter a valid phone number';
              }
            }
            return null;
          },
          prefixIcon: const Icon(Icons.phone_outlined),
        ),
      ],
    );
  }

  Widget _buildRoleAndDepartmentFields() {
    return Row(
      children: [
        Expanded(
          child: DialogDropdownField<String>(
            label: 'Role',
            value: _userData.role.isEmpty ? null : _userData.role,
            required: true,
            items: _roles.map((role) {
              return DropdownMenuItem<String>(
                value: role,
                child: Text(role),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _userData = _userData.copyWith(role: value ?? '');
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Role is required';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DialogDropdownField<String>(
            label: 'Department',
            value: _userData.department.isEmpty ? null : _userData.department,
            required: true,
            items: _departments.map((department) {
              return DropdownMenuItem<String>(
                value: department,
                child: Text(department),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _userData = _userData.copyWith(department: value ?? '');
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Department is required';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBioField() {
    return DialogFormField(
      label: 'Bio',
      hint: 'Tell us about yourself...',
      value: _userData.bio,
      maxLines: 4,
      onChanged: (value) {
        setState(() {
          _userData = _userData.copyWith(bio: value);
        });
      },
      validator: (value) {
        if (value != null && value.length > 500) {
          return 'Bio cannot exceed 500 characters';
        }
        return null;
      },
      prefixIcon: const Icon(Icons.notes_outlined),
    );
  }

  void _selectAvatar() {
    // In a real app, this would open an image picker
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Avatar'),
        content: const Text('Avatar selection would be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _userData = _userData.copyWith(
                  avatarUrl: 'https://via.placeholder.com/150',
                );
              });
              Navigator.of(context).pop();
            },
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }

  bool _canSubmit() {
    return _userData.firstName.isNotEmpty &&
        _userData.lastName.isNotEmpty &&
        _userData.email.isNotEmpty &&
        _userData.role.isNotEmpty &&
        _userData.department.isNotEmpty &&
        RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_userData.email);
  }

  void _handleSubmit() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });

    if (widget.onSave != null) {
      widget.onSave!(_userData);
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}