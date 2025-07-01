import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/navigation/navigation_items.dart';

/// Components overview page showing all component categories
class ComponentsPage extends StatelessWidget {
  const ComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final componentCategories = NavigationItems.componentItems.first.children;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar
          SliverAppBar(
            title: const Text('Material 3 Components'),
            pinned: true,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.tertiary,
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () => context.go('/'),
                tooltip: 'Home',
              ),
              const SizedBox(width: 8),
            ],
          ),
          
          // Header description
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Component Library',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Explore the complete Material 3 component collection',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Component categories list
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final category = componentCategories[index];
                  return _ComponentCategoryTile(
                    title: category.label,
                    icon: category.icon,
                    route: category.route,
                    description: _getDescription(category.label),
                    componentCount: _getComponentCount(category.label),
                  );
                },
                childCount: componentCategories.length,
              ),
            ),
          ),
          
          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 40),
          ),
        ],
      ),
    );
  }

  String _getDescription(String categoryName) {
    switch (categoryName) {
      case 'Cards':
        return 'Display content and actions on a single topic';
      case 'Dialogs':
        return 'Overlay content for focused tasks';
      case 'Forms':
        return 'Input components for data collection';
      case 'Tables':
        return 'Organize and display data in rows and columns';
      case 'Charts':
        return 'Visualize data with various chart types';
      case 'Buttons':
        return 'Trigger actions and navigation';
      case 'Navigation':
        return 'Help users move through the app';
      case 'Inputs':
        return 'Text fields and selection controls';
      default:
        return 'Component category';
    }
  }

  int _getComponentCount(String categoryName) {
    switch (categoryName) {
      case 'Cards':
        return 15;
      case 'Dialogs':
        return 12;
      case 'Forms':
        return 20;
      case 'Tables':
        return 8;
      case 'Charts':
        return 10;
      case 'Buttons':
        return 18;
      case 'Navigation':
        return 14;
      case 'Inputs':
        return 16;
      default:
        return 10;
    }
  }
}

/// Simple component category list tile
class _ComponentCategoryTile extends StatelessWidget {
  const _ComponentCategoryTile({
    required this.title,
    required this.icon,
    required this.route,
    required this.description,
    required this.componentCount,
  });

  final String title;
  final IconData icon;
  final String route;
  final String description;
  final int componentCount;

  @override
  Widget build(BuildContext context) {
    final colorIndex = title.hashCode % Colors.primaries.length;
    final color = Colors.primaries[colorIndex];
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 28,
            color: color,
          ),
        ),
        title: Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                componentCount.toString(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => context.go(route),
      ),
    );
  }
}