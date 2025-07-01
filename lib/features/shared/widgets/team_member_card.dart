import 'package:flutter/material.dart';

class TeamMemberCard extends StatelessWidget {
  const TeamMemberCard({
    super.key,
    required this.name,
    required this.role,
    this.bio,
    this.imageUrl,
    this.linkedIn,
    this.twitter,
    this.github,
    this.onTap,
    this.elevation = 1,
  });

  final String name;
  final String role;
  final String? bio;
  final String? imageUrl;
  final String? linkedIn;
  final String? twitter;
  final String? github;
  final VoidCallback? onTap;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: elevation,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  image: imageUrl != null
                      ? DecorationImage(
                          image: AssetImage(imageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: imageUrl == null
                    ? Center(
                        child: Text(
                          name.substring(0, 1).toUpperCase(),
                          style: theme.textTheme.displayLarge?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    role,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  if (bio != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      bio!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (linkedIn != null || twitter != null || github != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        if (linkedIn != null)
                          IconButton(
                            icon: const Icon(Icons.link),
                            iconSize: 20,
                            onPressed: () {
                              // Open LinkedIn
                            },
                            tooltip: 'LinkedIn',
                          ),
                        if (twitter != null)
                          IconButton(
                            icon: const Icon(Icons.chat_bubble_outline),
                            iconSize: 20,
                            onPressed: () {
                              // Open Twitter
                            },
                            tooltip: 'Twitter',
                          ),
                        if (github != null)
                          IconButton(
                            icon: const Icon(Icons.code),
                            iconSize: 20,
                            onPressed: () {
                              // Open GitHub
                            },
                            tooltip: 'GitHub',
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}