import 'package:flutter/material.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({
    super.key,
    this.facebook,
    this.twitter,
    this.instagram,
    this.linkedIn,
    this.youtube,
    this.github,
    this.iconSize = 24,
    this.spacing = 12,
    this.color,
    this.backgroundColor,
    this.showLabels = false,
  });

  final String? facebook;
  final String? twitter;
  final String? instagram;
  final String? linkedIn;
  final String? youtube;
  final String? github;
  final double iconSize;
  final double spacing;
  final Color? color;
  final Color? backgroundColor;
  final bool showLabels;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final iconColor = color ?? colorScheme.onSurface;

    final links = <Widget>[];

    if (facebook != null) {
      links.add(_buildLink(
        icon: Icons.facebook,
        label: 'Facebook',
        url: facebook!,
        iconColor: iconColor,
        backgroundColor: backgroundColor,
      ));
    }

    if (twitter != null) {
      links.add(_buildLink(
        icon: Icons.chat_bubble_outline,
        label: 'Twitter',
        url: twitter!,
        iconColor: iconColor,
        backgroundColor: backgroundColor,
      ));
    }

    if (instagram != null) {
      links.add(_buildLink(
        icon: Icons.camera_alt_outlined,
        label: 'Instagram',
        url: instagram!,
        iconColor: iconColor,
        backgroundColor: backgroundColor,
      ));
    }

    if (linkedIn != null) {
      links.add(_buildLink(
        icon: Icons.business_center_outlined,
        label: 'LinkedIn',
        url: linkedIn!,
        iconColor: iconColor,
        backgroundColor: backgroundColor,
      ));
    }

    if (youtube != null) {
      links.add(_buildLink(
        icon: Icons.play_circle_outline,
        label: 'YouTube',
        url: youtube!,
        iconColor: iconColor,
        backgroundColor: backgroundColor,
      ));
    }

    if (github != null) {
      links.add(_buildLink(
        icon: Icons.code,
        label: 'GitHub',
        url: github!,
        iconColor: iconColor,
        backgroundColor: backgroundColor,
      ));
    }

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: links,
    );
  }

  Widget _buildLink({
    required IconData icon,
    required String label,
    required String url,
    required Color iconColor,
    Color? backgroundColor,
  }) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: iconSize, color: iconColor),
        if (showLabels) ...[
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(color: iconColor),
          ),
        ],
      ],
    );

    if (backgroundColor != null) {
      return Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(showLabels ? 24 : iconSize),
        child: InkWell(
          onTap: () {
            // Open URL
          },
          borderRadius: BorderRadius.circular(showLabels ? 24 : iconSize),
          child: Padding(
            padding: EdgeInsets.all(showLabels ? 12 : 8),
            child: content,
          ),
        ),
      );
    }

    return IconButton(
      icon: Icon(icon),
      iconSize: iconSize,
      color: iconColor,
      onPressed: () {
        // Open URL
      },
      tooltip: label,
    );
  }
}