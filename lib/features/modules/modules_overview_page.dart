import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';

/// Overview page for all application modules
class ModulesOverviewPage extends StatelessWidget {
  const ModulesOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar
          SliverAppBar(
            title: const Text('Application Modules'),
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
                      Theme.of(context).colorScheme.secondary,
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
                    'Explore Our Modules',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Comprehensive business applications built with Material 3',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Business Applications Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Business Applications',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _ModuleListTile(
                  title: 'Academy',
                  subtitle: 'Learning Management System',
                  description: 'Complete e-learning platform with courses and progress tracking',
                  icon: Icons.school,
                  color: Colors.blue,
                  route: '/modules/academy',
                ),
                _ModuleListTile(
                  title: 'E-commerce',
                  subtitle: 'Online Shopping Platform',
                  description: 'Full-featured online store with product catalog and cart',
                  icon: Icons.shopping_cart,
                  color: Colors.green,
                  route: '/modules/ecommerce',
                ),
                _ModuleListTile(
                  title: 'Email Client',
                  subtitle: 'Email Management System',
                  description: 'Modern email client with inbox management and composer',
                  icon: Icons.email,
                  color: Colors.red,
                  route: '/modules/email',
                ),
                _ModuleListTile(
                  title: 'Chat Application',
                  subtitle: 'Real-time Messaging',
                  description: 'Instant messaging platform with channels and file sharing',
                  icon: Icons.chat,
                  color: Colors.purple,
                  route: '/modules/chat',
                ),
              ]),
            ),
          ),
          
          // Productivity Tools Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Productivity Tools',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _ModuleListTile(
                  title: 'Calendar',
                  subtitle: 'Event Management',
                  description: 'Advanced calendar with scheduling and reminders',
                  icon: Icons.calendar_today,
                  color: Colors.orange,
                  route: '/modules/calendar',
                ),
                _ModuleListTile(
                  title: 'Kanban Board',
                  subtitle: 'Project Management',
                  description: 'Visual project tool with drag-and-drop tasks',
                  icon: Icons.view_kanban,
                  color: Colors.teal,
                  route: '/modules/kanban',
                ),
                _ModuleListTile(
                  title: 'Invoice System',
                  subtitle: 'Billing Management',
                  description: 'Professional invoicing with templates and tracking',
                  icon: Icons.receipt_long,
                  color: Colors.indigo,
                  route: '/modules/invoice',
                ),
                _ModuleListTile(
                  title: 'Logistics',
                  subtitle: 'Supply Chain Management',
                  description: 'Shipment tracking and inventory management',
                  icon: Icons.local_shipping,
                  color: Colors.brown,
                  route: '/modules/logistics',
                ),
              ]),
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
}

/// Simple module list tile widget
class _ModuleListTile extends StatelessWidget {
  const _ModuleListTile({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    required this.route,
  });

  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  final String route;

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => context.go(route),
      ),
    );
  }
}

