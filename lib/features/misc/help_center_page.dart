import 'package:flutter/material.dart';
import '../shared/widgets/faq_item.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Help Center')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('How can we help you?', style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search for help articles...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 32),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 1,
              childAspectRatio: 1.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _HelpCard(
                  icon: Icons.rocket_launch,
                  title: 'Getting Started',
                  description: 'Learn the basics of Flutter Demo',
                  colorScheme: colorScheme,
                ),
                _HelpCard(
                  icon: Icons.account_circle,
                  title: 'Account & Billing',
                  description: 'Manage your account and subscription',
                  colorScheme: colorScheme,
                ),
                _HelpCard(
                  icon: Icons.build,
                  title: 'Development Guide',
                  description: 'Build amazing apps with our tools',
                  colorScheme: colorScheme,
                ),
                _HelpCard(
                  icon: Icons.security,
                  title: 'Security',
                  description: 'Keep your account and data secure',
                  colorScheme: colorScheme,
                ),
                _HelpCard(
                  icon: Icons.api,
                  title: 'API Documentation',
                  description: 'Integrate with our powerful APIs',
                  colorScheme: colorScheme,
                ),
                _HelpCard(
                  icon: Icons.support_agent,
                  title: 'Contact Support',
                  description: 'Get help from our support team',
                  colorScheme: colorScheme,
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text('Popular Questions', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Column(
              children: [
                FAQItem(
                  question: 'How do I get started with Flutter Demo?',
                  answer: 'You can get started by signing up for a free account and following our quick start guide.',
                ),
                FAQItem(
                  question: 'Can I upgrade or downgrade my plan?',
                  answer: 'Yes, you can change your plan at any time from your account settings.',
                ),
                FAQItem(
                  question: 'Is there a mobile app?',
                  answer: 'Yes, we have mobile apps for both iOS and Android available in the app stores.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HelpCard extends StatelessWidget {
  const _HelpCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.colorScheme,
  });

  final IconData icon;
  final String title;
  final String description;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: colorScheme.primary),
              const SizedBox(height: 16),
              Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(description, style: theme.textTheme.bodySmall, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}