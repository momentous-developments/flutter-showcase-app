import 'package:flutter/material.dart';
import '../shared/widgets/contact_form.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Contact Us')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: size.width > 800
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildContactInfo(context)),
                    const SizedBox(width: 32),
                    Expanded(child: _buildContactForm(context)),
                  ],
                )
              : Column(
                  children: [
                    _buildContactInfo(context),
                    const SizedBox(height: 32),
                    _buildContactForm(context),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Get in Touch', style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Text('We\'d love to hear from you. Send us a message and we\'ll respond as soon as possible.',
          style: theme.textTheme.bodyLarge),
        const SizedBox(height: 32),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.email, color: colorScheme.primary),
                  title: const Text('Email'),
                  subtitle: const Text('hello@flutterdemo.com'),
                ),
                ListTile(
                  leading: Icon(Icons.phone, color: colorScheme.primary),
                  title: const Text('Phone'),
                  subtitle: const Text('+1 (555) 123-4567'),
                ),
                ListTile(
                  leading: Icon(Icons.location_on, color: colorScheme.primary),
                  title: const Text('Address'),
                  subtitle: const Text('123 Flutter Street\nSan Francisco, CA 94105'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Send us a Message', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ContactForm(
              onSubmit: (data) async {
                // Handle form submission
              },
            ),
          ],
        ),
      ),
    );
  }
}