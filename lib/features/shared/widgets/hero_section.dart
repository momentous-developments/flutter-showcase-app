import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.title,
    required this.subtitle,
    this.primaryAction,
    this.secondaryAction,
    this.backgroundImage,
    this.backgroundColor,
    this.height = 500,
    this.textAlign = TextAlign.center,
    this.children = const [],
  });

  final String title;
  final String subtitle;
  final VoidCallback? primaryAction;
  final VoidCallback? secondaryAction;
  final String? backgroundImage;
  final Color? backgroundColor;
  final double height;
  final TextAlign textAlign;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.primaryContainer,
        image: backgroundImage != null
            ? DecorationImage(
                image: AssetImage(backgroundImage!),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
              )
            : null,
      ),
      child: Stack(
        children: [
          // Gradient overlay
          if (backgroundImage == null)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorScheme.primaryContainer,
                      colorScheme.primaryContainer.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
          // Content
          Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: textAlign == TextAlign.center
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.displayLarge?.copyWith(
                      color: backgroundImage != null
                          ? Colors.white
                          : colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: textAlign,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    subtitle,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: backgroundImage != null
                          ? Colors.white.withOpacity(0.9)
                          : colorScheme.onPrimaryContainer.withOpacity(0.8),
                    ),
                    textAlign: textAlign,
                  ),
                  if (primaryAction != null || secondaryAction != null) ...[
                    const SizedBox(height: 32),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        if (primaryAction != null)
                          FilledButton.icon(
                            onPressed: primaryAction,
                            icon: const Icon(Icons.arrow_forward),
                            label: const Text('Get Started'),
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                            ),
                          ),
                        if (secondaryAction != null)
                          OutlinedButton.icon(
                            onPressed: secondaryAction,
                            icon: const Icon(Icons.play_circle_outline),
                            label: const Text('Watch Demo'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              foregroundColor: backgroundImage != null
                                  ? Colors.white
                                  : colorScheme.onPrimaryContainer,
                              side: BorderSide(
                                color: backgroundImage != null
                                    ? Colors.white
                                    : colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                  ...children,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}