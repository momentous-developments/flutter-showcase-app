import 'package:flutter/material.dart';
import '../shared/widgets/feature_card.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Features')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Powerful Features', style: theme.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Text('Everything you need to build amazing applications', style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
            const SizedBox(height: 32),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 1,
              childAspectRatio: 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: const [
                FeatureCard(icon: Icons.speed, title: 'Lightning Fast', description: 'Optimized performance for the best user experience'),
                FeatureCard(icon: Icons.security, title: 'Secure by Default', description: 'Built-in security features to protect your data'),
                FeatureCard(icon: Icons.devices, title: 'Cross Platform', description: 'Works seamlessly across all devices and platforms'),
                FeatureCard(icon: Icons.palette, title: 'Beautiful Design', description: 'Modern Material Design 3 components'),
                FeatureCard(icon: Icons.code, title: 'Developer Friendly', description: 'Clean APIs and comprehensive documentation'),
                FeatureCard(icon: Icons.trending_up, title: 'Scalable', description: 'Grows with your business needs'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}