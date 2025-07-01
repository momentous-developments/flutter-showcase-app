import 'package:flutter/material.dart';
import 'models/dialog_models.dart';
import 'widgets/base_dialog.dart';
import 'widgets/dialog_footer.dart';

/// Dialog for displaying and selecting pricing plans
class PricingDialog extends StatefulWidget {
  const PricingDialog({
    super.key,
    this.currentPlan,
    this.onPlanSelected,
    this.onCancel,
  });

  final String? currentPlan;
  final Function(PricingPlanData)? onPlanSelected;
  final VoidCallback? onCancel;

  @override
  State<PricingDialog> createState() => _PricingDialogState();
}

class _PricingDialogState extends State<PricingDialog> {
  String? _selectedPlan;
  bool _isLoading = false;

  final List<PricingPlanData> _plans = [
    PricingPlanData(
      id: 'basic',
      name: 'Basic',
      description: 'Perfect for getting started',
      price: 0,
      interval: 'month',
      features: [
        'Up to 3 projects',
        '1GB storage',
        'Email support',
        'Basic analytics',
        'Community access',
      ],
    ),
    PricingPlanData(
      id: 'pro',
      name: 'Pro',
      description: 'Most popular for growing teams',
      price: 29,
      interval: 'month',
      features: [
        'Unlimited projects',
        '100GB storage',
        'Priority support',
        'Advanced analytics',
        'Custom integrations',
        'Team collaboration',
        'API access',
      ],
      isPopular: true,
    ),
    PricingPlanData(
      id: 'enterprise',
      name: 'Enterprise',
      description: 'For large organizations',
      price: 99,
      interval: 'month',
      features: [
        'Everything in Pro',
        'Unlimited storage',
        '24/7 dedicated support',
        'Advanced security',
        'SSO integration',
        'Custom reporting',
        'On-premise deployment',
        'SLA guarantee',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedPlan = widget.currentPlan;
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Choose Your Plan',
      subtitle: 'Select the plan that best fits your needs',
      size: DialogSize.large,
      child: Column(
        children: [
          _buildPlansGrid(),
          const SizedBox(height: 24),
          _buildFeatureComparison(),
        ],
      ),
      actions: [
        DialogActionButton.outlined(
          text: 'Cancel',
          onPressed: _isLoading ? null : widget.onCancel,
        ),
        DialogActionButton.primary(
          text: _selectedPlan == widget.currentPlan ? 'Current Plan' : 'Select Plan',
          onPressed: _selectedPlan != null && 
                     _selectedPlan != widget.currentPlan && 
                     !_isLoading
              ? _handlePlanSelection
              : null,
          isLoading: _isLoading,
        ),
      ],
    );
  }

  Widget _buildPlansGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 800 ? 3 : 1;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: crossAxisCount == 3 ? 0.8 : 2.5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: _plans.length,
          itemBuilder: (context, index) => _buildPlanCard(_plans[index]),
        );
      },
    );
  }

  Widget _buildPlanCard(PricingPlanData plan) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = _selectedPlan == plan.id;
    final isCurrent = widget.currentPlan == plan.id;

    return Material(
      color: isSelected
          ? colorScheme.primaryContainer
          : colorScheme.surfaceVariant,
      borderRadius: BorderRadius.circular(16),
      elevation: isSelected ? 4 : 0,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedPlan = plan.id;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: isSelected
                ? Border.all(color: colorScheme.primary, width: 2)
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      plan.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: isSelected
                            ? colorScheme.onPrimaryContainer
                            : colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (plan.isPopular)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Most Popular',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  if (isCurrent)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.secondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Current',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                plan.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '\$${plan.price.toStringAsFixed(0)}',
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: isSelected
                          ? colorScheme.onPrimaryContainer
                          : colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '/${plan.interval}',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isSelected
                          ? colorScheme.onPrimaryContainer
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: plan.features.map((feature) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 16,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              feature,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: isSelected
                                    ? colorScheme.onPrimaryContainer
                                    : colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureComparison() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All plans include:',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _buildIncludedFeature('SSL certificates'),
              _buildIncludedFeature('99.9% uptime'),
              _buildIncludedFeature('Mobile app'),
              _buildIncludedFeature('Data backup'),
              _buildIncludedFeature('30-day money back'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIncludedFeature(String feature) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check,
          size: 16,
          color: colorScheme.primary,
        ),
        const SizedBox(width: 4),
        Text(
          feature,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  void _handlePlanSelection() async {
    if (_selectedPlan == null) return;

    final selectedPlanData = _plans.firstWhere(
      (plan) => plan.id == _selectedPlan,
    );

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });

    if (widget.onPlanSelected != null) {
      widget.onPlanSelected!(selectedPlanData);
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}