import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/dialog_models.dart';
import 'widgets/form_dialog.dart';

/// Dialog for adding or editing billing card information
class BillingCardDialog extends StatefulWidget {
  const BillingCardDialog({
    super.key,
    this.cardData,
    this.onSave,
    this.onCancel,
  });

  final BillingCardData? cardData;
  final Function(BillingCardData)? onSave;
  final VoidCallback? onCancel;

  @override
  State<BillingCardDialog> createState() => _BillingCardDialogState();
}

class _BillingCardDialogState extends State<BillingCardDialog> {
  late BillingCardData _cardData;
  bool _isLoading = false;
  bool _showCvv = false;

  final List<CardTypeOption> _cardTypes = [
    CardTypeOption(
      value: 'visa',
      name: 'Visa',
      icon: Icons.credit_card,
      color: Colors.blue,
    ),
    CardTypeOption(
      value: 'mastercard',
      name: 'Mastercard',
      icon: Icons.credit_card,
      color: Colors.red,
    ),
    CardTypeOption(
      value: 'amex',
      name: 'American Express',
      icon: Icons.credit_card,
      color: Colors.green,
    ),
    CardTypeOption(
      value: 'discover',
      name: 'Discover',
      icon: Icons.credit_card,
      color: Colors.orange,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _cardData = widget.cardData ?? const BillingCardData();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.cardData != null;

    return FormDialog(
      title: isEditing ? 'Edit Payment Card' : 'Add Payment Card',
      subtitle: isEditing
          ? 'Update your payment card information'
          : 'Add a new payment card for billing',
      submitText: isEditing ? 'Update Card' : 'Add Card',
      cancelText: 'Cancel',
      isLoading: _isLoading,
      canSubmit: _canSubmit(),
      onSubmit: _handleSubmit,
      onCancel: widget.onCancel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardPreview(),
          const SizedBox(height: 24),
          _buildCardTypeSelector(),
          const SizedBox(height: 24),
          _buildCardNumberField(),
          const SizedBox(height: 16),
          _buildExpiryAndCvvFields(),
          const SizedBox(height: 16),
          _buildCardholderNameField(),
          const SizedBox(height: 16),
          _buildDefaultSwitch(),
        ],
      ),
    );
  }

  Widget _buildCardPreview() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final selectedCardType = _cardTypes.firstWhere(
      (type) => type.value == _cardData.cardType,
      orElse: () => _cardTypes.first,
    );

    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            selectedCardType.color.shade700,
            selectedCardType.color.shade900,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                selectedCardType.icon,
                color: Colors.white,
                size: 32,
              ),
              Text(
                selectedCardType.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            _formatCardNumber(_cardData.cardNumber),
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontFamily: 'monospace',
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CARDHOLDER',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    _cardData.cardholderName.isEmpty
                        ? 'FULL NAME'
                        : _cardData.cardholderName.toUpperCase(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'EXPIRES',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    _cardData.expiryDate.isEmpty ? 'MM/YY' : _cardData.expiryDate,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardTypeSelector() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Card Type',
          style: theme.textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _cardTypes.map((type) {
            final isSelected = _cardData.cardType == type.value;
            return FilterChip(
              label: Text(type.name),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _cardData = _cardData.copyWith(cardType: type.value);
                  });
                }
              },
              avatar: Icon(
                type.icon,
                size: 16,
                color: isSelected ? colorScheme.onSecondaryContainer : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCardNumberField() {
    return DialogFormField(
      label: 'Card Number',
      hint: '1234 5678 9012 3456',
      value: _cardData.cardNumber,
      required: true,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        final formatted = _formatCardNumberInput(value);
        setState(() {
          _cardData = _cardData.copyWith(cardNumber: formatted);
        });
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Card number is required';
        }
        final cleanNumber = value.replaceAll(' ', '');
        if (cleanNumber.length < 16) {
          return 'Card number must be 16 digits';
        }
        return null;
      },
    );
  }

  Widget _buildExpiryAndCvvFields() {
    return Row(
      children: [
        Expanded(
          child: DialogFormField(
            label: 'Expiry Date',
            hint: 'MM/YY',
            value: _cardData.expiryDate,
            required: true,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final formatted = _formatExpiryDate(value);
              setState(() {
                _cardData = _cardData.copyWith(expiryDate: formatted);
              });
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Expiry date is required';
              }
              if (value.length != 5) {
                return 'Invalid expiry date';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DialogFormField(
            label: 'CVV',
            hint: '123',
            value: _cardData.cvv,
            required: true,
            keyboardType: TextInputType.number,
            obscureText: !_showCvv,
            onChanged: (value) {
              if (value.length <= 4) {
                setState(() {
                  _cardData = _cardData.copyWith(cvv: value);
                });
              }
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'CVV is required';
              }
              if (value.length < 3) {
                return 'Invalid CVV';
              }
              return null;
            },
            suffixIcon: IconButton(
              icon: Icon(_showCvv ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _showCvv = !_showCvv;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardholderNameField() {
    return DialogFormField(
      label: 'Cardholder Name',
      hint: 'John Doe',
      value: _cardData.cardholderName,
      required: true,
      onChanged: (value) {
        setState(() {
          _cardData = _cardData.copyWith(cardholderName: value);
        });
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Cardholder name is required';
        }
        return null;
      },
    );
  }

  Widget _buildDefaultSwitch() {
    final theme = Theme.of(context);

    return SwitchListTile(
      title: Text(
        'Make this the default payment method',
        style: theme.textTheme.bodyMedium,
      ),
      value: _cardData.isDefault,
      onChanged: (value) {
        setState(() {
          _cardData = _cardData.copyWith(isDefault: value);
        });
      },
      contentPadding: EdgeInsets.zero,
    );
  }

  String _formatCardNumber(String cardNumber) {
    if (cardNumber.isEmpty) return '•••• •••• •••• ••••';
    final cleanNumber = cardNumber.replaceAll(' ', '');
    if (cleanNumber.length < 16) {
      return cleanNumber.padRight(16, '•').replaceAllMapped(
            RegExp(r'.{4}'),
            (match) => '${match.group(0)} ',
          ).trim();
    }
    return cleanNumber.replaceAllMapped(
      RegExp(r'.{4}'),
      (match) => '${match.group(0)} ',
    ).trim();
  }

  String _formatCardNumberInput(String input) {
    final cleanInput = input.replaceAll(' ', '');
    if (cleanInput.length > 16) {
      return _cardData.cardNumber; // Don't allow more than 16 digits
    }
    return cleanInput.replaceAllMapped(
      RegExp(r'.{4}'),
      (match) => '${match.group(0)} ',
    ).trim();
  }

  String _formatExpiryDate(String input) {
    final cleanInput = input.replaceAll('/', '');
    if (cleanInput.length > 4) {
      return _cardData.expiryDate; // Don't allow more than 4 digits
    }
    if (cleanInput.length >= 2) {
      return '${cleanInput.substring(0, 2)}/${cleanInput.substring(2)}';
    }
    return cleanInput;
  }

  bool _canSubmit() {
    return _cardData.cardNumber.replaceAll(' ', '').length == 16 &&
        _cardData.expiryDate.length == 5 &&
        _cardData.cvv.length >= 3 &&
        _cardData.cardholderName.isNotEmpty;
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
      widget.onSave!(_cardData);
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}

class CardTypeOption {
  final String value;
  final String name;
  final IconData icon;
  final MaterialColor color;

  const CardTypeOption({
    required this.value,
    required this.name,
    required this.icon,
    required this.color,
  });
}