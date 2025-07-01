import 'package:flutter/material.dart';
import '../shared/widgets/team_member_card.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Our Team')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Meet Our Team', style: theme.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Text('The passionate people behind Flutter Demo', style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
            const SizedBox(height: 32),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 4 : MediaQuery.of(context).size.width > 800 ? 3 : MediaQuery.of(context).size.width > 400 ? 2 : 1,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: const [
                TeamMemberCard(name: 'Sarah Johnson', role: 'CEO & Founder', bio: 'Former Google engineer with 10+ years of experience.'),
                TeamMemberCard(name: 'Mike Chen', role: 'CTO', bio: 'Flutter expert and open source contributor.'),
                TeamMemberCard(name: 'Emily Rodriguez', role: 'Head of Design', bio: 'UX designer focused on beautiful experiences.'),
                TeamMemberCard(name: 'David Kim', role: 'Lead Developer', bio: 'Full-stack developer passionate about clean code.'),
                TeamMemberCard(name: 'Lisa Wang', role: 'Product Manager', bio: 'Product strategist with startup experience.'),
                TeamMemberCard(name: 'Alex Thompson', role: 'DevOps Engineer', bio: 'Infrastructure expert ensuring reliability.'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}