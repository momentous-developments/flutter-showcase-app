import 'package:flutter/material.dart';

class TestimonialCard extends StatelessWidget {
  const TestimonialCard({
    super.key,
    required this.quote,
    required this.author,
    required this.role,
    this.company,
    this.avatarUrl,
    this.rating,
    this.backgroundColor,
    this.elevation = 1,
  });

  final String quote;
  final String author;
  final String role;
  final String? company;
  final String? avatarUrl;
  final int? rating;
  final Color? backgroundColor;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: elevation,
      color: backgroundColor ?? colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (rating != null) ...[
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < rating! ? Icons.star : Icons.star_border,
                    size: 20,
                    color: Colors.amber,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Container(
              padding: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: colorScheme.primary,
                    width: 3,
                  ),
                ),
              ),
              child: Text(
                '"$quote"',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                if (avatarUrl != null)
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(avatarUrl!),
                  )
                else
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: colorScheme.primaryContainer,
                    child: Text(
                      author.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        author,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        company != null ? '$role at $company' : role,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}