import 'package:flutter/material.dart';
import 'models/dialog_models.dart';
import 'widgets/base_dialog.dart';
import 'widgets/dialog_footer.dart';

/// Dialog for upgrading subscription plan
class UpgradePlanDialog extends StatefulWidget {
  const UpgradePlanDialog({
    super.key,
    this.currentPlan = 'basic',
    this.onUpgrade,
    this.onCancel,
  });

  final String currentPlan;
  final Function(String planId)? onUpgrade;
  final VoidCallback? onCancel;

  @override
  State<UpgradePlanDialog> createState() => _UpgradePlanDialogState();
}

class _UpgradePlanDialogState extends State<UpgradePlanDialog> {
  String? _selectedPlan;
  bool _isLoading = false;

  final Map<String, PricingPlanData> _plans = {
    'basic': const PricingPlanData(
      id: 'basic',
      name: 'Basic',
      description: 'Current plan',
      price: 0,
      features: ['Basic features', 'Email support'],
    ),
    'pro': const PricingPlanData(
      id: 'pro',
      name: 'Pro',
      description: 'Most popular upgrade',
      price: 29,
      features: ['All basic features', 'Priority support', 'Advanced analytics'],
      isPopular: true,
    ),
    'enterprise': const PricingPlanData(
      id: 'enterprise',
      name: 'Enterprise',
      description: 'For large teams',
      price: 99,
      features: ['All pro features', '24/7 support', 'Custom integration'],
    ),
  };

  @override
  Widget build(BuildContext context) {
    final availablePlans = _plans.entries
        .where((entry) => entry.key != widget.currentPlan)
        .map((entry) => entry.value)
        .toList();

    return BaseDialog(
      title: 'Upgrade Your Plan',
      subtitle: 'Unlock more features with a premium plan',
      size: DialogSize.medium,
      child: Column(
        children: availablePlans.map(_buildPlanOption).toList(),
      ),
      actions: [
        DialogActionButton.outlined(
          text: 'Cancel',
          onPressed: _isLoading ? null : widget.onCancel,
        ),
        DialogActionButton.primary(
          text: 'Upgrade Now',
          onPressed: _selectedPlan != null && !_isLoading ? _handleUpgrade : null,
          isLoading: _isLoading,
        ),
      ],
    );
  }

  Widget _buildPlanOption(PricingPlanData plan) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = _selectedPlan == plan.id;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: isSelected ? colorScheme.primaryContainer : colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => setState(() => _selectedPlan = plan.id),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Radio<String>(
                  value: plan.id,
                  groupValue: _selectedPlan,
                  onChanged: (value) => setState(() => _selectedPlan = value),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            plan.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '\$${plan.price}/month',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (plan.isPopular) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Popular',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(plan.description),
                      const SizedBox(height: 8),
                      ...plan.features.map((feature) => Text('• $feature')).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleUpgrade() async {
    if (_selectedPlan == null) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

    widget.onUpgrade?.call(_selectedPlan!);
    if (mounted) Navigator.of(context).pop();
  }
}