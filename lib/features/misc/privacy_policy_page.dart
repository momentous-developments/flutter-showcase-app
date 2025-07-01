import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Privacy Policy', style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text('Last updated: December 15, 2023', style: theme.textTheme.bodySmall),
              const SizedBox(height: 32),
              _buildSection(theme, 'Information We Collect', 
                'We collect information you provide directly to us, such as when you create an account, make a purchase, or contact us for support.'),
              _buildSection(theme, 'How We Use Your Information',
                'We use the information we collect to provide, maintain, and improve our services, process transactions, and communicate with you.'),
              _buildSection(theme, 'Information Sharing',
                'We do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except as described in this policy.'),
              _buildSection(theme, 'Data Security',
                'We implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.'),
              _buildSection(theme, 'Contact Us',
                'If you have questions about this Privacy Policy, please contact us at privacy@flutterdemo.com.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(ThemeData theme, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(content, style: theme.textTheme.bodyLarge),
        const SizedBox(height: 24),
      ],
    );
  }
}