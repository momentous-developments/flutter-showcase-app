import 'package:flutter/material.dart';
import '../shared/widgets/testimonial_card.dart';

class TestimonialsPage extends StatelessWidget {
  const TestimonialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Testimonials')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('What Our Customers Say', style: theme.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Text('Real feedback from developers using Flutter Demo', style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
            const SizedBox(height: 32),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 3 : MediaQuery.of(context).size.width > 600 ? 2 : 1,
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
                TestimonialCard(
                  quote: 'Outstanding support team and comprehensive documentation. Everything just works as expected.',
                  author: 'David Wilson',
                  role: 'Senior Developer',
                  company: 'StartupX',
                  rating: 5,
                ),
                TestimonialCard(
                  quote: 'Flutter Demo helped us launch our MVP in record time. Highly recommended for any startup.',
                  author: 'Jessica Liu',
                  role: 'Founder',
                  company: 'AppCo',
                  rating: 5,
                ),
                TestimonialCard(
                  quote: 'The UI components are beautiful and easy to customize. Our designers love the flexibility.',
                  author: 'Mark Thompson',
                  role: 'Design Lead',
                  company: 'CreativeStudio',
                  rating: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}