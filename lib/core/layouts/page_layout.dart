import 'package:flutter/material.dart';
import 'responsive_layout.dart';

/// Layout for static pages with consistent structure
class PageLayout extends StatelessWidget {
  const PageLayout({
    super.key,
    required this.title,
    required this.body,
    this.subtitle,
    this.actions,
    this.showAppBar = true,
    this.showBackButton = true,
    this.backgroundColor,
    this.padding,
    this.scrollable = true,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  final String title;
  final String? subtitle;
  final Widget body;
  final List<Widget>? actions;
  final bool showAppBar;
  final bool showBackButton;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final bool scrollable;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    Widget content = _buildBody(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: showAppBar ? _buildAppBar(context) : null,
      body: content,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          if (subtitle != null) ...[
            Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
      actions: actions,
      automaticallyImplyLeading: showBackButton,
      elevation: 0,
      scrolledUnderElevation: 1,
    );
  }

  Widget _buildBody(BuildContext context) {
    Widget content = body;

    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    } else {
      content = ResponsiveContainer(
        mobilePadding: const EdgeInsets.all(16),
        tabletPadding: const EdgeInsets.all(20),
        desktopPadding: const EdgeInsets.all(24),
        child: content,
      );
    }

    if (scrollable) {
      content = SingleChildScrollView(child: content);
    }

    return content;
  }
}

/// Centered page layout for focused content
class CenteredPageLayout extends StatelessWidget {
  const CenteredPageLayout({
    super.key,
    required this.child,
    this.maxWidth = 600,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(24),
  });

  final Widget child;
  final double maxWidth;
  final Color? backgroundColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Split page layout with sidebar
class SplitPageLayout extends StatelessWidget {
  const SplitPageLayout({
    super.key,
    required this.sidebar,
    required this.content,
    this.sidebarWidth = 300,
    this.showSidebarOnMobile = false,
    this.sidebarBreakpoint = 768,
  });

  final Widget sidebar;
  final Widget content;
  final double sidebarWidth;
  final bool showSidebarOnMobile;
  final double sidebarBreakpoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final showSidebar = constraints.maxWidth >= sidebarBreakpoint || showSidebarOnMobile;

        if (showSidebar) {
          return Row(
            children: [
              SizedBox(
                width: sidebarWidth,
                child: sidebar,
              ),
              const VerticalDivider(width: 1),
              Expanded(child: content),
            ],
          );
        } else {
          return content;
        }
      },
    );
  }
}

/// Page with hero section
class HeroPageLayout extends StatelessWidget {
  const HeroPageLayout({
    super.key,
    required this.hero,
    required this.content,
    this.heroHeight = 300,
    this.backgroundColor,
    this.scrollable = true,
  });

  final Widget hero;
  final Widget content;
  final double heroHeight;
  final Color? backgroundColor;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    Widget body = Column(
      children: [
        SizedBox(
          height: heroHeight,
          child: hero,
        ),
        Expanded(child: content),
      ],
    );

    if (scrollable) {
      body = SingleChildScrollView(child: body);
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: body,
    );
  }
}

/// Form page layout with consistent styling
class FormPageLayout extends StatelessWidget {
  const FormPageLayout({
    super.key,
    required this.title,
    required this.form,
    this.subtitle,
    this.actions,
    this.maxWidth = 600,
    this.showAppBar = true,
    this.showBackButton = true,
    this.padding,
  });

  final String title;
  final String? subtitle;
  final Widget form;
  final List<Widget>? actions;
  final double maxWidth;
  final bool showAppBar;
  final bool showBackButton;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: title,
      subtitle: subtitle,
      actions: actions,
      showAppBar: showAppBar,
      showBackButton: showBackButton,
      padding: padding,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: form,
        ),
      ),
    );
  }
}

/// Article page layout for content-heavy pages
class ArticlePageLayout extends StatelessWidget {
  const ArticlePageLayout({
    super.key,
    required this.title,
    required this.content,
    this.subtitle,
    this.author,
    this.publishDate,
    this.tags,
    this.coverImage,
    this.actions,
    this.maxWidth = 800,
  });

  final String title;
  final String? subtitle;
  final Widget content;
  final String? author;
  final DateTime? publishDate;
  final List<String>? tags;
  final Widget? coverImage;
  final List<Widget>? actions;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: title,
      subtitle: subtitle,
      actions: actions,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (coverImage != null) ...[
                coverImage!,
                const SizedBox(height: 24),
              ],
              
              // Article header
              Text(
                title,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              if (subtitle != null) ...[
                const SizedBox(height: 8),
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              
              // Article meta
              if (author != null || publishDate != null) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    if (author != null) ...[
                      Text(
                        'By $author',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (author != null && publishDate != null) ...[
                      Text(
                        ' • ',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (publishDate != null) ...[
                      Text(
                        _formatDate(publishDate!),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
              
              const SizedBox(height: 32),
              
              // Article content
              content,
              
              // Tags
              if (tags != null && tags!.isNotEmpty) ...[
                const SizedBox(height: 32),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags!.map((tag) => Chip(
                    label: Text(tag),
                    backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  )).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Simple date formatting - you might want to use intl package
    return '${date.day}/${date.month}/${date.year}';
  }
}

/// Error page layout
class ErrorPageLayout extends StatelessWidget {
  const ErrorPageLayout({
    super.key,
    required this.title,
    required this.message,
    this.errorCode,
    this.actions,
    this.icon = Icons.error_outline,
    this.illustration,
  });

  final String title;
  final String message;
  final String? errorCode;
  final List<Widget>? actions;
  final IconData icon;
  final Widget? illustration;

  @override
  Widget build(BuildContext context) {
    return CenteredPageLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          illustration ??
              Icon(
                icon,
                size: 80,
                color: Theme.of(context).colorScheme.error,
              ),
          const SizedBox(height: 32),
          
          if (errorCode != null) ...[
            Text(
              errorCode!,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
          ],
          
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          
          if (actions != null) ...[
            const SizedBox(height: 32),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: actions!,
            ),
          ],
        ],
      ),
    );
  }
}