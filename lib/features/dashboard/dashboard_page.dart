import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/layouts/dashboard_layout.dart';
import '../../core/widgets/navigation/breadcrumbs.dart';
import '../../core/navigation/navigation_items.dart';
import 'widgets/dashboard_cards.dart';
import 'widgets/quick_stats.dart';

/// Main dashboard page showing overview of the demo app
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      header: const DashboardHeader(),
      children: const [
        // Quick stats row
        QuickStatsCard(),
        ComponentsOverviewCard(),
        ModulesOverviewCard(),
        RecentActivityCard(),
        
        // Feature highlights
        ComponentShowcaseCard(),
        ThemeCustomizationCard(),
        ResponsiveDesignCard(),
        DeveloperToolsCard(),
      ],
    );
  }
}

/// Dashboard header with welcome message and quick actions
class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardSectionHeader(
      title: 'Welcome to Flutter Material 3 Demo',
      subtitle: 'Explore 286 components across 10 modules with Material Design 3',
      actions: [
        OutlinedButton.icon(
          onPressed: () => context.go('/components'),
          icon: const Icon(Icons.widgets),
          label: const Text('Browse Components'),
        ),
        const SizedBox(width: 12),
        FilledButton.icon(
          onPressed: () => context.go('/modules'),
          icon: const Icon(Icons.apps),
          label: const Text('Explore Modules'),
        ),
      ],
    );
  }
}

/// Quick stats card showing app overview
class QuickStatsCard extends StatelessWidget {
  const QuickStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'App Overview',
      child: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: const [
                QuickStatItem(
                  title: 'Components',
                  value: '286',
                  icon: Icons.widgets,
                  color: Colors.blue,
                ),
                QuickStatItem(
                  title: 'Modules',
                  value: '10',
                  icon: Icons.apps,
                  color: Colors.green,
                ),
                QuickStatItem(
                  title: 'Layouts',
                  value: '25+',
                  icon: Icons.view_quilt,
                  color: Colors.orange,
                ),
                QuickStatItem(
                  title: 'Themes',
                  value: 'Dynamic',
                  icon: Icons.palette,
                  color: Colors.purple,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Components overview card
class ComponentsOverviewCard extends StatelessWidget {
  const ComponentsOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'Component Categories',
      subtitle: 'Explore organized UI components',
      actions: [
        TextButton(
          onPressed: () => context.go('/components'),
          child: const Text('View All'),
        ),
      ],
      child: ListView(
        children: const [
          ComponentCategoryItem(
            title: 'Cards',
            subtitle: '15+ card variants',
            icon: Icons.credit_card,
            route: '/components/cards',
          ),
          ComponentCategoryItem(
            title: 'Forms',
            subtitle: '20+ input components',
            icon: Icons.edit,
            route: '/components/forms',
          ),
          ComponentCategoryItem(
            title: 'Tables',
            subtitle: 'Data display solutions',
            icon: Icons.table_chart,
            route: '/components/tables',
          ),
          ComponentCategoryItem(
            title: 'Charts',
            subtitle: 'Visualization components',
            icon: Icons.analytics,
            route: '/components/charts',
          ),
        ],
      ),
    );
  }
}

/// Modules overview card
class ModulesOverviewCard extends StatelessWidget {
  const ModulesOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'Application Modules',
      subtitle: 'Complete feature modules',
      actions: [
        TextButton(
          onPressed: () => context.go('/modules'),
          child: const Text('View All'),
        ),
      ],
      child: ListView(
        children: const [
          ModuleItem(
            title: 'E-commerce',
            subtitle: 'Shopping & product management',
            icon: Icons.shopping_cart,
            route: '/modules/ecommerce',
          ),
          ModuleItem(
            title: 'Academy',
            subtitle: 'Learning management system',
            icon: Icons.school,
            route: '/modules/academy',
          ),
          ModuleItem(
            title: 'Chat',
            subtitle: 'Real-time messaging',
            icon: Icons.chat,
            route: '/modules/chat',
          ),
          ModuleItem(
            title: 'Calendar',
            subtitle: 'Event management',
            icon: Icons.calendar_today,
            route: '/modules/calendar',
          ),
        ],
      ),
    );
  }
}

/// Recent activity card
class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'Recent Activity',
      subtitle: 'Latest updates and changes',
      child: ListView(
        children: [
          ActivityItem(
            title: 'Material 3 components updated',
            subtitle: '2 hours ago',
            icon: Icons.update,
            color: Colors.green,
          ),
          ActivityItem(
            title: 'New chart types added',
            subtitle: '5 hours ago',
            icon: Icons.analytics,
            color: Colors.blue,
          ),
          ActivityItem(
            title: 'Theme system enhanced',
            subtitle: '1 day ago',
            icon: Icons.palette,
            color: Colors.purple,
          ),
          ActivityItem(
            title: 'Navigation improved',
            subtitle: '2 days ago',
            icon: Icons.navigation,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}

/// Component showcase card
class ComponentShowcaseCard extends StatelessWidget {
  const ComponentShowcaseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'Component Showcase',
      subtitle: 'Featured Material 3 components',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Sample Material 3 components
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {},
                    child: const Text('Filled Button'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Outlined'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const LinearProgressIndicator(value: 0.7),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: const Text('Material 3 List Tile'),
                subtitle: const Text('With updated styling'),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Theme customization card
class ThemeCustomizationCard extends StatelessWidget {
  const ThemeCustomizationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'Theme Customization',
      subtitle: 'Dynamic theming with Material 3',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.palette,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Try different color schemes and themes using the controls in the app bar.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => context.go('/settings'),
            child: const Text('Theme Settings'),
          ),
        ],
      ),
    );
  }
}

/// Responsive design card
class ResponsiveDesignCard extends StatelessWidget {
  const ResponsiveDesignCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'Responsive Design',
      subtitle: 'Adaptive layouts for all screen sizes',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.devices,
            size: 48,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 16),
          Text(
            'Resize your window to see adaptive navigation and responsive layouts in action.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// Developer tools card
class DeveloperToolsCard extends StatelessWidget {
  const DeveloperToolsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'Developer Tools',
      subtitle: 'Code examples and documentation',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.code,
            size: 48,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          const SizedBox(height: 16),
          Text(
            'Each component includes code examples and implementation details for developers.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => context.go('/components'),
            child: const Text('View Examples'),
          ),
        ],
      ),
    );
  }
}