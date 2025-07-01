import 'package:flutter/material.dart';
import '../shared/widgets/faq_item.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('FAQ')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Frequently Asked Questions', style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Text('Find answers to common questions about Flutter Demo', style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
            const SizedBox(height: 32),
            const Column(
              children: [
                FAQItem(
                  question: 'What is Flutter Demo?',
                  answer: 'Flutter Demo is a comprehensive development platform that helps you build beautiful, fast applications for mobile, web, and desktop.',
                ),
                FAQItem(
                  question: 'How much does it cost?',
                  answer: 'We offer flexible pricing plans starting from \$10/month. Check our pricing page for detailed information.',
                ),
                FAQItem(
                  question: 'Is there a free trial?',
                  answer: 'Yes! We offer a 14-day free trial for all our plans. No credit card required to get started.',
                ),
                FAQItem(
                  question: 'Can I cancel anytime?',
                  answer: 'Absolutely. You can cancel your subscription at any time from your account settings.',
                ),
                FAQItem(
                  question: 'Do you offer technical support?',
                  answer: 'Yes, we provide comprehensive technical support including documentation, tutorials, and direct support channels.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}