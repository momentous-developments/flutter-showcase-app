import 'package:flutter/material.dart';
import '../shared/widgets/team_member_card.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text('About Flutter Demo', style: theme.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Text('We\'re passionate about building amazing developer tools that help create beautiful applications.',
                    style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Text('Our Mission', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('To democratize app development by providing powerful, easy-to-use tools that enable anyone to build beautiful, fast applications.',
              style: theme.textTheme.bodyLarge),
            const SizedBox(height: 32),
            Text('Our Team', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 1,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: const [
                TeamMemberCard(
                  name: 'Sarah Johnson',
                  role: 'CEO & Founder',
                  bio: 'Former Google engineer with 10+ years of experience in mobile development.',
                ),
                TeamMemberCard(
                  name: 'Mike Chen',
                  role: 'CTO',
                  bio: 'Flutter expert and open source contributor passionate about developer tools.',
                ),
                TeamMemberCard(
                  name: 'Emily Rodriguez',
                  role: 'Head of Design',
                  bio: 'UX designer focused on creating beautiful and intuitive user experiences.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}