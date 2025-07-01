import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../shared/widgets/pricing_card.dart';
import '../shared/widgets/faq_item.dart';

class PricingPage extends StatefulWidget {
  const PricingPage({super.key});

  @override
  State<PricingPage> createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage> {
  bool _isYearly = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pricing'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Text(
                    'Simple, Transparent Pricing',
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Choose the plan that works best for you and your team',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  // Billing toggle
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _BillingToggleButton(
                          text: 'Monthly',
                          isSelected: !_isYearly,
                          onTap: () {
                            setState(() {
                              _isYearly = false;
                            });
                          },
                        ),
                        _BillingToggleButton(
                          text: 'Yearly',
                          isSelected: _isYearly,
                          onTap: () {
                            setState(() {
                              _isYearly = true;
                            });
                          },
                          badge: 'Save 20%',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Pricing Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 800;
                  
                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: PricingCard(
                            title: 'Starter',
                            price: _isYearly ? '\$8' : '\$10',
                            period: _isYearly ? 'month' : 'month',
                            description: 'Perfect for individuals and small projects',
                            features: const [
                              'Up to 3 projects',
                              '5GB storage',
                              'Basic support',
                              'Community access',
                              'Standard templates',
                            ],
                            onTap: () => _selectPlan('starter'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: PricingCard(
                            title: 'Professional',
                            price: _isYearly ? '\$24' : '\$30',
                            period: _isYearly ? 'month' : 'month',
                            description: 'Best for growing teams and businesses',
                            isPopular: true,
                            features: const [
                              'Up to 10 projects',
                              '50GB storage',
                              'Priority support',
                              'Advanced analytics',
                              'Premium templates',
                              'Team collaboration',
                              'API access',
                            ],
                            onTap: () => _selectPlan('professional'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: PricingCard(
                            title: 'Enterprise',
                            price: _isYearly ? '\$80' : '\$100',
                            period: _isYearly ? 'month' : 'month',
                            description: 'For large organizations with custom needs',
                            features: const [
                              'Unlimited projects',
                              '500GB storage',
                              '24/7 dedicated support',
                              'Custom integrations',
                              'White-label options',
                              'Advanced security',
                              'Custom contracts',
                              'Training & onboarding',
                            ],
                            onTap: () => _selectPlan('enterprise'),
                          ),
                        ),
                      ],
                    );
                  }
                  
                  return Column(
                    children: [
                      PricingCard(
                        title: 'Starter',
                        price: _isYearly ? '\$8' : '\$10',
                        period: _isYearly ? 'month' : 'month',
                        description: 'Perfect for individuals and small projects',
                        features: const [
                          'Up to 3 projects',
                          '5GB storage',
                          'Basic support',
                          'Community access',
                          'Standard templates',
                        ],
                        onTap: () => _selectPlan('starter'),
                      ),
                      const SizedBox(height: 16),
                      PricingCard(
                        title: 'Professional',
                        price: _isYearly ? '\$24' : '\$30',
                        period: _isYearly ? 'month' : 'month',
                        description: 'Best for growing teams and businesses',
                        isPopular: true,
                        features: const [
                          'Up to 10 projects',
                          '50GB storage',
                          'Priority support',
                          'Advanced analytics',
                          'Premium templates',
                          'Team collaboration',
                          'API access',
                        ],
                        onTap: () => _selectPlan('professional'),
                      ),
                      const SizedBox(height: 16),
                      PricingCard(
                        title: 'Enterprise',
                        price: _isYearly ? '\$80' : '\$100',
                        period: _isYearly ? 'month' : 'month',
                        description: 'For large organizations with custom needs',
                        features: const [
                          'Unlimited projects',
                          '500GB storage',
                          '24/7 dedicated support',
                          'Custom integrations',
                          'White-label options',
                          'Advanced security',
                          'Custom contracts',
                          'Training & onboarding',
                        ],
                        onTap: () => _selectPlan('enterprise'),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Features Comparison
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Text(
                    'Compare Features',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: colorScheme.outline),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Feature')),
                          DataColumn(label: Text('Starter')),
                          DataColumn(label: Text('Professional')),
                          DataColumn(label: Text('Enterprise')),
                        ],
                        rows: [
                          _buildFeatureRow('Projects', '3', '10', 'Unlimited'),
                          _buildFeatureRow('Storage', '5GB', '50GB', '500GB'),
                          _buildFeatureRow('Support', 'Basic', 'Priority', '24/7 Dedicated'),
                          _buildFeatureRow('Analytics', '✗', '✓', '✓'),
                          _buildFeatureRow('API Access', '✗', '✓', '✓'),
                          _buildFeatureRow('Team Collaboration', '✗', '✓', '✓'),
                          _buildFeatureRow('Custom Integrations', '✗', '✗', '✓'),
                          _buildFeatureRow('White-label', '✗', '✗', '✓'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // FAQ Section
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Text(
                    'Frequently Asked Questions',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Column(
                    children: [
                      FAQItem(
                        question: 'Can I change my plan anytime?',
                        answer: 'Yes, you can upgrade or downgrade your plan at any time. Changes will be reflected in your next billing cycle.',
                      ),
                      FAQItem(
                        question: 'Is there a free trial?',
                        answer: 'Yes, all plans come with a 14-day free trial. No credit card required to start.',
                      ),
                      FAQItem(
                        question: 'What payment methods do you accept?',
                        answer: 'We accept all major credit cards, PayPal, and bank transfers for enterprise customers.',
                      ),
                      FAQItem(
                        question: 'Can I cancel anytime?',
                        answer: 'Yes, you can cancel your subscription at any time. You\'ll continue to have access until the end of your billing period.',
                      ),
                      FAQItem(
                        question: 'Do you offer discounts for non-profits?',
                        answer: 'Yes, we offer special pricing for educational institutions and non-profit organizations. Contact us for details.',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // CTA Section
            Container(
              width: double.infinity,
              color: colorScheme.primaryContainer,
              padding: const EdgeInsets.all(48),
              child: Column(
                children: [
                  Text(
                    'Ready to Get Started?',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimaryContainer,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Start your free 14-day trial today. No credit card required.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      FilledButton.icon(
                        onPressed: () => context.go('/pages/auth/register'),
                        icon: const Icon(Icons.rocket_launch),
                        label: const Text('Start Free Trial'),
                        style: FilledButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => context.go('/pages/marketing/contact'),
                        icon: const Icon(Icons.phone),
                        label: const Text('Talk to Sales'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colorScheme.onPrimaryContainer,
                          side: BorderSide(color: colorScheme.onPrimaryContainer),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildFeatureRow(String feature, String starter, String pro, String enterprise) {
    return DataRow(
      cells: [
        DataCell(Text(feature, style: const TextStyle(fontWeight: FontWeight.w500))),
        DataCell(Text(starter)),
        DataCell(Text(pro)),
        DataCell(Text(enterprise)),
      ],
    );
  }

  void _selectPlan(String plan) {
    context.go('/pages/auth/register?plan=$plan');
  }
}

class _BillingToggleButton extends StatelessWidget {
  const _BillingToggleButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.badge,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: theme.textTheme.titleSmall?.copyWith(
                color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            if (badge != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge!,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}