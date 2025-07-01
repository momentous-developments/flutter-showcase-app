import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Terms of Service')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Terms of Service', style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text('Last updated: December 15, 2023', style: theme.textTheme.bodySmall),
              const SizedBox(height: 32),
              _buildSection(theme, 'Acceptance of Terms', 
                'By accessing and using Flutter Demo, you accept and agree to be bound by the terms and provision of this agreement.'),
              _buildSection(theme, 'Use License',
                'Permission is granted to temporarily download one copy of Flutter Demo for personal, non-commercial transitory viewing only.'),
              _buildSection(theme, 'Disclaimer',
                'The materials on Flutter Demo are provided on an \'as is\' basis. Flutter Demo makes no warranties, expressed or implied.'),
              _buildSection(theme, 'Limitations',
                'In no event shall Flutter Demo or its suppliers be liable for any damages arising out of the use or inability to use the materials.'),
              _buildSection(theme, 'Accuracy of Materials',
                'The materials appearing on Flutter Demo could include technical, typographical, or photographic errors.'),
              _buildSection(theme, 'Contact Information',
                'If you have questions about these Terms of Service, please contact us at legal@flutterdemo.com.'),
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