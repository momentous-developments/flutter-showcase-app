import 'package:flutter/material.dart';
import '../shared/widgets/newsletter.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.rocket_launch, size: 120, color: colorScheme.primary),
              const SizedBox(height: 32),
              Text('Coming Soon', style: theme.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              Text('We\'re working hard to bring you something amazing. Stay tuned!',
                style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
              const SizedBox(height: 48),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: const Newsletter(
                  title: 'Get Notified',
                  subtitle: 'Be the first to know when we launch',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}