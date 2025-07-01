import 'package:flutter/material.dart';
import 'models/dialog_models.dart';
import 'widgets/form_dialog.dart';

/// Dialog for adding or editing address information
class AddressDialog extends StatefulWidget {
  const AddressDialog({
    super.key,
    this.addressData,
    this.onSave,
    this.onCancel,
  });

  final AddressData? addressData;
  final Function(AddressData)? onSave;
  final VoidCallback? onCancel;

  @override
  State<AddressDialog> createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {
  late AddressData _addressData;
  bool _isLoading = false;
  String _selectedAddressType = 'home';

  final List<String> _countries = [
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'Germany',
    'France',
    'Japan',
    'Brazil',
    'India',
    'China',
  ];

  final List<AddressTypeOption> _addressTypes = [
    AddressTypeOption(
      value: 'home',
      title: 'Home',
      subtitle: 'Delivery Time (7am - 9pm)',
      icon: Icons.home_outlined,
    ),
    AddressTypeOption(
      value: 'office',
      title: 'Office',
      subtitle: 'Delivery Time (10am - 6pm)',
      icon: Icons.business_outlined,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _addressData = widget.addressData ?? const AddressData();
    _selectedAddressType = _addressData.addressType;
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.addressData != null;

    return FormDialog(
      title: isEditing ? 'Edit Address' : 'Add New Address',
      subtitle: isEditing
          ? 'Edit address for future billing'
          : 'Add address for billing address',
      submitText: isEditing ? 'Update' : 'Submit',
      cancelText: 'Cancel',
      isLoading: _isLoading,
      canSubmit: _canSubmit(),
      onSubmit: _handleSubmit,
      onCancel: widget.onCancel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAddressTypeSelector(),
          const SizedBox(height: 24),
          _buildNameFields(),
          const SizedBox(height: 16),
          _buildCountryField(),
          const SizedBox(height: 16),
          _buildAddressFields(),
          const SizedBox(height: 16),
          _buildLocationFields(),
          const SizedBox(height: 16),
          _buildDefaultSwitch(),
        ],
      ),
    );
  }

  Widget _buildAddressTypeSelector() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Address Type',
          style: theme.textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: _addressTypes.map((option) {
            final isSelected = _selectedAddressType == option.value;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Material(
                  color: isSelected
                      ? colorScheme.primaryContainer
                      : colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedAddressType = option.value;
                        _addressData = _addressData.copyWith(
                          addressType: option.value,
                        );
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Icon(
                            option.icon,
                            size: 32,
                            color: isSelected
                                ? colorScheme.onPrimaryContainer
                                : colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            option.title,
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: isSelected
                                  ? colorScheme.onPrimaryContainer
                                  : colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            option.subtitle,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isSelected
                                  ? colorScheme.onPrimaryContainer
                                  : colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNameFields() {
    return Row(
      children: [
        Expanded(
          child: DialogFormField(
            label: 'First Name',
            hint: 'John',
            value: _addressData.firstName,
            required: true,
            onChanged: (value) {
              _addressData = _addressData.copyWith(firstName: value);
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'First name is required';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DialogFormField(
            label: 'Last Name',
            hint: 'Doe',
            value: _addressData.lastName,
            required: true,
            onChanged: (value) {
              _addressData = _addressData.copyWith(lastName: value);
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

  Widget _buildCountryField() {
    return DialogDropdownField<String>(
      label: 'Country',
      value: _addressData.country.isEmpty ? null : _addressData.country,
      required: true,
      items: _countries.map((country) {
        return DropdownMenuItem<String>(
          value: country,
          child: Text(country),
        );
      }).toList(),
      onChanged: (value) {
        _addressData = _addressData.copyWith(country: value ?? '');
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Country is required';
        }
        return null;
      },
    );
  }

  Widget _buildAddressFields() {
    return Column(
      children: [
        DialogFormField(
          label: 'Address Line 1',
          hint: '12, Business Park',
          value: _addressData.address1,
          required: true,
          onChanged: (value) {
            _addressData = _addressData.copyWith(address1: value);
          },
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Address is required';
            }
            return null;
          },
        ),
        DialogFormField(
          label: 'Address Line 2',
          hint: 'Mall Road (Optional)',
          value: _addressData.address2,
          onChanged: (value) {
            _addressData = _addressData.copyWith(address2: value);
          },
        ),
      ],
    );
  }

  Widget _buildLocationFields() {
    return Column(
      children: [
        DialogFormField(
          label: 'Landmark',
          hint: 'Nr. Hard Rock Cafe',
          value: _addressData.landmark,
          onChanged: (value) {
            _addressData = _addressData.copyWith(landmark: value);
          },
        ),
        Row(
          children: [
            Expanded(
              child: DialogFormField(
                label: 'City',
                hint: 'Los Angeles',
                value: _addressData.city,
                required: true,
                onChanged: (value) {
                  _addressData = _addressData.copyWith(city: value);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'City is required';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DialogFormField(
                label: 'State',
                hint: 'California',
                value: _addressData.state,
                required: true,
                onChanged: (value) {
                  _addressData = _addressData.copyWith(state: value);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'State is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        DialogFormField(
          label: 'Zip Code',
          hint: '99950',
          value: _addressData.zipCode,
          required: true,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            _addressData = _addressData.copyWith(zipCode: value);
          },
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Zip code is required';
            }
            if (value.length < 5) {
              return 'Invalid zip code';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDefaultSwitch() {
    final theme = Theme.of(context);

    return SwitchListTile(
      title: Text(
        'Make this default shipping address',
        style: theme.textTheme.bodyMedium,
      ),
      value: _addressData.isDefault,
      onChanged: (value) {
        setState(() {
          _addressData = _addressData.copyWith(isDefault: value);
        });
      },
      contentPadding: EdgeInsets.zero,
    );
  }

  bool _canSubmit() {
    return _addressData.firstName.isNotEmpty &&
        _addressData.lastName.isNotEmpty &&
        _addressData.country.isNotEmpty &&
        _addressData.address1.isNotEmpty &&
        _addressData.city.isNotEmpty &&
        _addressData.state.isNotEmpty &&
        _addressData.zipCode.isNotEmpty;
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
      widget.onSave!(_addressData);
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}

class AddressTypeOption {
  final String value;
  final String title;
  final String subtitle;
  final IconData icon;

  const AddressTypeOption({
    required this.value,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}