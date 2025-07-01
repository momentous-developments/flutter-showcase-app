import 'package:flutter/material.dart';
import 'responsive_layout.dart';
import '../constants/app_constants.dart';

/// Layout for individual modules with consistent structure
class ModuleLayout extends StatelessWidget {
  const ModuleLayout({
    super.key,
    required this.title,
    required this.body,
    this.subtitle,
    this.actions,
    this.tabs,
    this.tabViews,
    this.floatingActionButton,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
    this.showBackButton = true,
    this.padding,
  });

  final String title;
  final String? subtitle;
  final Widget body;
  final List<Widget>? actions;
  final List<Tab>? tabs;
  final List<Widget>? tabViews;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;
  final bool showBackButton;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final hasTabNavigation = tabs != null && tabViews != null;

    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      appBar: AppBar(
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
        bottom: hasTabNavigation
            ? TabBar(
                tabs: tabs!,
                isScrollable: tabs!.length > 4,
              )
            : null,
      ),
      body: hasTabNavigation
          ? TabBarView(children: tabViews!)
          : _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (padding != null) {
      return Padding(
        padding: padding!,
        child: body,
      );
    }

    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.all(16),
      tabletPadding: const EdgeInsets.all(20),
      desktopPadding: const EdgeInsets.all(24),
      child: body,
    );
  }
}

/// Module section header
class ModuleSectionHeader extends StatelessWidget {
  const ModuleSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.showDivider = true,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
  });

  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final bool showDivider;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (actions != null) ...actions!,
            ],
          ),
        ),
        if (showDivider) const Divider(),
      ],
    );
  }
}

/// Module content card
class ModuleContentCard extends StatelessWidget {
  const ModuleContentCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.margin = const EdgeInsets.only(bottom: 16),
    this.elevation,
    this.color,
  });

  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double? elevation;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      elevation: elevation,
      color: color,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

/// Module list item
class ModuleListItem extends StatelessWidget {
  const ModuleListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.selected = false,
    this.dense = false,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool selected;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      leading: leading,
      trailing: trailing,
      onTap: onTap,
      selected: selected,
      dense: dense,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

/// Module grid layout
class ModuleGrid extends StatelessWidget {
  const ModuleGrid({
    super.key,
    required this.children,
    this.crossAxisCount,
    this.childAspectRatio = 1.0,
    this.crossAxisSpacing = 16.0,
    this.mainAxisSpacing = 16.0,
    this.padding = const EdgeInsets.all(16),
  });

  final List<Widget> children;
  final int? crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    int columns = crossAxisCount ?? _getDefaultColumns(context);
    
    return Padding(
      padding: padding,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
        ),
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      ),
    );
  }

  int _getDefaultColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= AppConstants.tabletBreakpoint) {
      return 4;
    } else if (width >= AppConstants.mobileBreakpoint) {
      return 2;
    } else {
      return 1;
    }
  }
}

/// Module toolbar with common actions
class ModuleToolbar extends StatelessWidget {
  const ModuleToolbar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.backgroundColor,
    this.elevation = 1,
    this.height = 56,
  });

  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double elevation;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: backgroundColor ?? Theme.of(context).colorScheme.surface,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 16),
            ],
            if (title != null) ...[
              Expanded(child: title!),
            ],
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }
}

/// Module filter bar
class ModuleFilterBar extends StatelessWidget {
  const ModuleFilterBar({
    super.key,
    this.filters = const [],
    this.onFilterChanged,
    this.searchController,
    this.onSearchChanged,
    this.showSearch = true,
    this.padding = const EdgeInsets.all(16),
  });

  final List<FilterChip> filters;
  final ValueChanged<int>? onFilterChanged;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;
  final bool showSearch;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        children: [
          if (showSearch) ...[
            SearchBar(
              controller: searchController,
              onChanged: onSearchChanged,
              hintText: 'Search...',
              leading: const Icon(Icons.search),
            ),
            if (filters.isNotEmpty) const SizedBox(height: 16),
          ],
          if (filters.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: filters,
            ),
          ],
        ],
      ),
    );
  }
}

/// Module empty state
class ModuleEmptyState extends StatelessWidget {
  const ModuleEmptyState({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.action,
    this.illustration,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget? action;
  final Widget? illustration;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            illustration ??
                Icon(
                  icon,
                  size: 64,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            const SizedBox(height: 24),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: 24),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}