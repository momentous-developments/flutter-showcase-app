import 'package:flutter/material.dart';
import 'models/dialog_models.dart';
import 'widgets/form_dialog.dart';

/// Dialog for selecting and configuring payment methods
class PaymentMethodDialog extends StatefulWidget {
  const PaymentMethodDialog({
    super.key,
    this.paymentData,
    this.onSave,
    this.onCancel,
  });

  final PaymentMethodData? paymentData;
  final Function(PaymentMethodData)? onSave;
  final VoidCallback? onCancel;

  @override
  State<PaymentMethodDialog> createState() => _PaymentMethodDialogState();
}

class _PaymentMethodDialogState extends State<PaymentMethodDialog> {
  late PaymentMethodData _paymentData;
  bool _isLoading = false;

  final List<PaymentMethodOption> _paymentMethods = [
    PaymentMethodOption(
      type: 'card',
      name: 'Credit/Debit Card',
      description: 'Visa, Mastercard, American Express',
      icon: Icons.credit_card,
      color: Colors.blue,
      isPopular: true,
    ),
    PaymentMethodOption(
      type: 'paypal',
      name: 'PayPal',
      description: 'Pay with your PayPal account',
      icon: Icons.account_balance_wallet,
      color: Colors.indigo,
    ),
    PaymentMethodOption(
      type: 'apple_pay',
      name: 'Apple Pay',
      description: 'Quick and secure payments',
      icon: Icons.phone_iphone,
      color: Colors.black,
    ),
    PaymentMethodOption(
      type: 'google_pay',
      name: 'Google Pay',
      description: 'Pay with Google',
      icon: Icons.account_balance_wallet,
      color: Colors.green,
    ),
    PaymentMethodOption(
      type: 'bank_transfer',
      name: 'Bank Transfer',
      description: 'Direct bank account transfer',
      icon: Icons.account_balance,
      color: Colors.teal,
    ),
    PaymentMethodOption(
      type: 'crypto',
      name: 'Cryptocurrency',
      description: 'Bitcoin, Ethereum, and more',
      icon: Icons.currency_bitcoin,
      color: Colors.orange,
    ),
  ];

  final Map<String, List<String>> _providers = {
    'card': ['Visa', 'Mastercard', 'American Express', 'Discover'],
    'paypal': ['PayPal'],
    'apple_pay': ['Apple Pay'],
    'google_pay': ['Google Pay'],
    'bank_transfer': ['Chase', 'Bank of America', 'Wells Fargo', 'Other'],
    'crypto': ['Bitcoin', 'Ethereum', 'Litecoin', 'Other'],
  };

  @override
  void initState() {
    super.initState();
    _paymentData = widget.paymentData ?? const PaymentMethodData();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.paymentData != null;

    return FormDialog(
      title: isEditing ? 'Edit Payment Method' : 'Add Payment Method',
      subtitle: isEditing
          ? 'Update your payment method information'
          : 'Choose your preferred payment method',
      submitText: isEditing ? 'Update Method' : 'Add Method',
      cancelText: 'Cancel',
      isLoading: _isLoading,
      canSubmit: _canSubmit(),
      onSubmit: _handleSubmit,
      onCancel: widget.onCancel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMethodSelector(),
          const SizedBox(height: 24),
          if (_paymentData.type.isNotEmpty) ...[
            _buildProviderSelector(),
            const SizedBox(height: 16),
            _buildAccountFields(),
            const SizedBox(height: 16),
            _buildDefaultSwitch(),
          ],
        ],
      ),
    );
  }

  Widget _buildMethodSelector() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: theme.textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _paymentMethods.length,
          itemBuilder: (context, index) {
            final method = _paymentMethods[index];
            final isSelected = _paymentData.type == method.type;

            return Material(
              color: isSelected
                  ? colorScheme.primaryContainer
                  : colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _paymentData = _paymentData.copyWith(
                      type: method.type,
                      provider: '', // Reset provider when type changes
                      accountNumber: '',
                      accountName: '',
                    );
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: method.color.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              method.icon,
                              color: method.color,
                              size: 20,
                            ),
                          ),
                          const Spacer(),
                          if (method.isPopular)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Popular',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        method.name,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: isSelected
                              ? colorScheme.onPrimaryContainer
                              : colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        method.description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isSelected
                              ? colorScheme.onPrimaryContainer
                              : colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProviderSelector() {
    final providers = _providers[_paymentData.type] ?? [];
    if (providers.isEmpty) return const SizedBox.shrink();

    return DialogDropdownField<String>(
      label: '${_getMethodDisplayName()} Provider',
      value: _paymentData.provider.isEmpty ? null : _paymentData.provider,
      required: true,
      items: providers.map((provider) {
        return DropdownMenuItem<String>(
          value: provider,
          child: Text(provider),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _paymentData = _paymentData.copyWith(provider: value ?? '');
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Provider is required';
        }
        return null;
      },
    );
  }

  Widget _buildAccountFields() {
    switch (_paymentData.type) {
      case 'card':
        return _buildCardFields();
      case 'paypal':
        return _buildPayPalFields();
      case 'apple_pay':
      case 'google_pay':
        return _buildDigitalWalletFields();
      case 'bank_transfer':
        return _buildBankFields();
      case 'crypto':
        return _buildCryptoFields();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildCardFields() {
    return Column(
      children: [
        DialogFormField(
          label: 'Card Number',
          hint: '**** **** **** 1234',
          value: _paymentData.accountNumber,
          required: true,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              _paymentData = _paymentData.copyWith(accountNumber: value);
            });
          },
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Card number is required';
            }
            return null;
          },
          prefixIcon: const Icon(Icons.credit_card),
        ),
        DialogFormField(
          label: 'Cardholder Name',
          hint: 'John Doe',
          value: _paymentData.accountName,
          required: true,
          onChanged: (value) {
            setState(() {
              _paymentData = _paymentData.copyWith(accountName: value);
            });
          },
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Cardholder name is required';
            }
            return null;
          },
          prefixIcon: const Icon(Icons.person),
        ),
      ],
    );
  }

  Widget _buildPayPalFields() {
    return DialogFormField(
      label: 'PayPal Email',
      hint: 'your.email@paypal.com',
      value: _paymentData.accountNumber,
      required: true,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        setState(() {
          _paymentData = _paymentData.copyWith(
            accountNumber: value,
            accountName: value, // Use email as account name for PayPal
          );
        });
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'PayPal email is required';
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      prefixIcon: const Icon(Icons.email),
    );
  }

  Widget _buildDigitalWalletFields() {
    final isApplePay = _paymentData.type == 'apple_pay';
    final walletName = isApplePay ? 'Apple Pay' : 'Google Pay';

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                isApplePay ? Icons.phone_iphone : Icons.android,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '$walletName will be automatically configured when you confirm this payment method.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        DialogFormField(
          label: 'Display Name',
          hint: 'My $walletName',
          value: _paymentData.accountName,
          required: true,
          onChanged: (value) {
            setState(() {
              _paymentData = _paymentData.copyWith(
                accountName: value,
                accountNumber: walletName, // Set account number to wallet type
              );
            });
          },
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Display name is required';
            }
            return null;
          },
          prefixIcon: const Icon(Icons.label),
        ),
      ],
    );
  }

  Widget _buildBankFields() {
    return Column(
      children: [
        DialogFormField(
          label: 'Account Number',
          hint: '****1234',
          value: _paymentData.accountNumber,
          required: true,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              _paymentData = _paymentData.copyWith(accountNumber: value);
            });
          },
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Account number is required';
            }
            return null;
          },
          prefixIcon: const Icon(Icons.account_balance),
        ),
        DialogFormField(
          label: 'Account Holder Name',
          hint: 'John Doe',
          value: _paymentData.accountName,
          required: true,
          onChanged: (value) {
            setState(() {
              _paymentData = _paymentData.copyWith(accountName: value);
            });
          },
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Account holder name is required';
            }
            return null;
          },
          prefixIcon: const Icon(Icons.person),
        ),
      ],
    );
  }

  Widget _buildCryptoFields() {
    return Column(
      children: [
        DialogFormField(
          label: 'Wallet Address',
          hint: '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa',
          value: _paymentData.accountNumber,
          required: true,
          onChanged: (value) {
            setState(() {
              _paymentData = _paymentData.copyWith(accountNumber: value);
            });
          },
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Wallet address is required';
            }
            return null;
          },
          prefixIcon: const Icon(Icons.account_balance_wallet),
        ),
        DialogFormField(
          label: 'Wallet Name',
          hint: 'My Bitcoin Wallet',
          value: _paymentData.accountName,
          required: true,
          onChanged: (value) {
            setState(() {
              _paymentData = _paymentData.copyWith(accountName: value);
            });
          },
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Wallet name is required';
            }
            return null;
          },
          prefixIcon: const Icon(Icons.label),
        ),
      ],
    );
  }

  Widget _buildDefaultSwitch() {
    final theme = Theme.of(context);

    return SwitchListTile(
      title: Text(
        'Set as default payment method',
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        'This payment method will be used by default for new purchases',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      value: _paymentData.isDefault,
      onChanged: (value) {
        setState(() {
          _paymentData = _paymentData.copyWith(isDefault: value);
        });
      },
      contentPadding: EdgeInsets.zero,
    );
  }

  String _getMethodDisplayName() {
    switch (_paymentData.type) {
      case 'card':
        return 'Card';
      case 'paypal':
        return 'PayPal';
      case 'apple_pay':
        return 'Apple Pay';
      case 'google_pay':
        return 'Google Pay';
      case 'bank_transfer':
        return 'Bank';
      case 'crypto':
        return 'Cryptocurrency';
      default:
        return 'Payment';
    }
  }

  bool _canSubmit() {
    if (_paymentData.type.isEmpty || _paymentData.provider.isEmpty) {
      return false;
    }

    switch (_paymentData.type) {
      case 'card':
        return _paymentData.accountNumber.isNotEmpty &&
            _paymentData.accountName.isNotEmpty;
      case 'paypal':
        return _paymentData.accountNumber.isNotEmpty &&
            RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_paymentData.accountNumber);
      case 'apple_pay':
      case 'google_pay':
        return _paymentData.accountName.isNotEmpty;
      case 'bank_transfer':
        return _paymentData.accountNumber.isNotEmpty &&
            _paymentData.accountName.isNotEmpty;
      case 'crypto':
        return _paymentData.accountNumber.isNotEmpty &&
            _paymentData.accountName.isNotEmpty;
      default:
        return false;
    }
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
      widget.onSave!(_paymentData);
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}

class PaymentMethodOption {
  final String type;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final bool isPopular;

  const PaymentMethodOption({
    required this.type,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    this.isPopular = false,
  });
}