import 'package:flutter/material.dart';
import 'widgets/base_dialog.dart';
import 'widgets/dialog_footer.dart';

/// Dialog for selecting payment providers
class PaymentProvidersDialog extends StatefulWidget {
  const PaymentProvidersDialog({
    super.key,
    this.onSelect,
    this.onCancel,
  });

  final Function(String provider)? onSelect;
  final VoidCallback? onCancel;

  @override
  State<PaymentProvidersDialog> createState() => _PaymentProvidersDialogState();
}

class _PaymentProvidersDialogState extends State<PaymentProvidersDialog> {
  String? _selectedProvider;
  final List<Map<String, dynamic>> _providers = [
    {'id': 'stripe', 'name': 'Stripe', 'icon': Icons.credit_card},
    {'id': 'paypal', 'name': 'PayPal', 'icon': Icons.account_balance_wallet},
    {'id': 'square', 'name': 'Square', 'icon': Icons.payment},
  ];

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Select Payment Provider',
      subtitle: 'Choose your preferred payment processor',
      child: Column(
        children: _providers.map((provider) {
          final isSelected = _selectedProvider == provider['id'];
          return ListTile(
            leading: Icon(provider['icon']),
            title: Text(provider['name']),
            trailing: Radio<String>(
              value: provider['id'],
              groupValue: _selectedProvider,
              onChanged: (value) => setState(() => _selectedProvider = value),
            ),
            onTap: () => setState(() => _selectedProvider = provider['id']),
          );
        }).toList(),
      ),
      actions: [
        DialogActionButton.outlined(
          text: 'Cancel',
          onPressed: widget.onCancel ?? () => Navigator.of(context).pop(),
        ),
        DialogActionButton.primary(
          text: 'Select',
          onPressed: _selectedProvider != null
              ? () {
                  widget.onSelect?.call(_selectedProvider!);
                  Navigator.of(context).pop();
                }
              : null,
        ),
      ],
    );
  }
}