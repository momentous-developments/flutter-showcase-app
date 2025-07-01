import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../shared/widgets/hero_section.dart';
import '../shared/widgets/feature_card.dart';
import '../shared/widgets/testimonial_card.dart';
import '../shared/widgets/pricing_card.dart';
import '../shared/widgets/newsletter.dart';
import '../shared/widgets/social_links.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.rocket_launch, color: colorScheme.primary),
            const SizedBox(width: 8),
            const Text('Flutter Demo'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.go('/pages/marketing/features'),
            child: const Text('Features'),
          ),
          TextButton(
            onPressed: () => context.go('/pages/marketing/pricing'),
            child: const Text('Pricing'),
          ),
          TextButton(
            onPressed: () => context.go('/pages/marketing/about'),
            child: const Text('About'),
          ),
          const SizedBox(width: 8),
          FilledButton(
            onPressed: () => context.go('/pages/auth/login'),
            child: const Text('Sign In'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            HeroSection(
              title: 'Build Amazing Apps with Flutter',
              subtitle: 'The fastest way to create beautiful, native apps for mobile, web, and desktop from a single codebase.',
              primaryAction: () => context.go('/pages/auth/register'),
              secondaryAction: () {
                // Play demo video
              },
              height: 600,
            ),
            
            // Features Section
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Text(
                    'Why Choose Flutter Demo?',
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Discover the powerful features that make Flutter Demo the best choice for modern app development',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth > 1200 ? 3 : 
                                            constraints.maxWidth > 800 ? 2 : 1;
                      final childAspectRatio = constraints.maxWidth > 800 ? 1.2 : 1.5;
                      
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: childAspectRatio,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: const [
                          FeatureCard(
                            icon: Icons.speed,
                            title: 'Lightning Fast',
                            description: 'Hot reload for instant development. Build once, run everywhere with native performance.',
                          ),
                          FeatureCard(
                            icon: Icons.palette,
                            title: 'Beautiful UI',
                            description: 'Rich widgets and Material Design 3 support for stunning user interfaces.',
                          ),
                          FeatureCard(
                            icon: Icons.devices,
                            title: 'Cross Platform',
                            description: 'One codebase for mobile, web, and desktop applications.',
                          ),
                          FeatureCard(
                            icon: Icons.code,
                            title: 'Developer Friendly',
                            description: 'Excellent tooling, comprehensive documentation, and active community.',
                          ),
                          FeatureCard(
                            icon: Icons.security,
                            title: 'Secure & Reliable',
                            description: 'Built-in security features and robust architecture for enterprise apps.',
                          ),
                          FeatureCard(
                            icon: Icons.trending_up,
                            title: 'Scalable',
                            description: 'Grows with your business from MVP to enterprise-scale applications.',
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            // Statistics Section
            Container(
              width: double.infinity,
              color: colorScheme.surfaceContainerHighest,
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Text(
                    'Trusted by Developers Worldwide',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth > 800;
                      return Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        spacing: 32,
                        runSpacing: 24,
                        children: [
                          _StatCard(
                            number: '1M+',
                            label: 'Developers',
                            icon: Icons.people,
                            isWide: isWide,
                          ),
                          _StatCard(
                            number: '500K+',
                            label: 'Apps Built',
                            icon: Icons.apps,
                            isWide: isWide,
                          ),
                          _StatCard(
                            number: '99.9%',
                            label: 'Uptime',
                            icon: Icons.check_circle,
                            isWide: isWide,
                          ),
                          _StatCard(
                            number: '24/7',
                            label: 'Support',
                            icon: Icons.support_agent,
                            isWide: isWide,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            // Testimonials Section
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Text(
                    'What Developers Are Saying',
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth > 1200 ? 3 : 
                                            constraints.maxWidth > 600 ? 2 : 1;
                      
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: const [
                          TestimonialCard(
                            quote: 'Flutter Demo has revolutionized our development process. We can now ship features 3x faster than before.',
                            author: 'Sarah Chen',
                            role: 'Lead Developer',
                            company: 'TechStart Inc',
                            rating: 5,
                          ),
                          TestimonialCard(
                            quote: 'The cross-platform capabilities are amazing. One codebase for all our platforms saved us months of development.',
                            author: 'Mike Johnson',
                            role: 'CTO',
                            company: 'InnovateLab',
                            rating: 5,
                          ),
                          TestimonialCard(
                            quote: 'Best development experience I\'ve had. The hot reload feature alone makes it worth switching to Flutter.',
                            author: 'Emily Rodriguez',
                            role: 'Mobile Developer',
                            company: 'Digital Solutions',
                            rating: 5,
                          ),
                        ],
                      );
                    },
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
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimaryContainer,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Join thousands of developers building amazing apps with Flutter',
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
                        onPressed: () => context.go('/pages/marketing/pricing'),
                        icon: const Icon(Icons.visibility),
                        label: const Text('View Pricing'),
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

            // Newsletter Section
            const Padding(
              padding: EdgeInsets.all(32),
              child: Newsletter(),
            ),

            // Footer
            Container(
              width: double.infinity,
              color: colorScheme.surfaceContainerHighest,
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.rocket_launch, color: colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Flutter Demo',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const SocialLinks(
                    facebook: 'https://facebook.com/flutterdemo',
                    twitter: 'https://twitter.com/flutterdemo',
                    github: 'https://github.com/flutterdemo',
                    linkedIn: 'https://linkedin.com/company/flutterdemo',
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 24,
                    runSpacing: 8,
                    children: [
                      TextButton(
                        onPressed: () => context.go('/pages/misc/privacy-policy'),
                        child: const Text('Privacy Policy'),
                      ),
                      TextButton(
                        onPressed: () => context.go('/pages/misc/terms-of-service'),
                        child: const Text('Terms of Service'),
                      ),
                      TextButton(
                        onPressed: () => context.go('/pages/marketing/contact'),
                        child: const Text('Contact'),
                      ),
                      TextButton(
                        onPressed: () => context.go('/pages/misc/help-center'),
                        child: const Text('Help'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '© 2024 Flutter Demo. All rights reserved.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.number,
    required this.label,
    required this.icon,
    required this.isWide,
  });

  final String number;
  final String label;
  final IconData icon;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: isWide ? 200 : 150,
      child: Column(
        children: [
          Icon(
            icon,
            size: 48,
            color: colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            number,
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}