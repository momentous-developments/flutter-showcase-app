import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/table_providers.dart';

class TableFeaturesShowcase extends ConsumerWidget {
  const TableFeaturesShowcase({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Table Features',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Explore various table features and configurations',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          
          // Feature sections
          _buildFeatureSection(
            context,
            'Column Features',
            'Customize column behavior and appearance',
            [
              _FeatureCard(
                title: 'Column Types',
                description: 'Text, Number, Currency, Date, Boolean, Status, Badge, Image, Avatar, Rating, Progress, Actions',
                icon: Icons.view_column,
                color: Colors.blue,
              ),
              _FeatureCard(
                title: 'Column Formatting',
                description: 'Custom formatters, date formats, currency symbols, decimal places',
                icon: Icons.format_paint,
                color: Colors.green,
              ),
              _FeatureCard(
                title: 'Column Operations',
                description: 'Sortable, Filterable, Resizable, Reorderable, Pinnable, Hideable',
                icon: Icons.settings,
                color: Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          _buildFeatureSection(
            context,
            'Row Features',
            'Row-level interactions and styling',
            [
              _FeatureCard(
                title: 'Row Selection',
                description: 'Single, Multiple, Checkbox, Click-to-select, Keyboard navigation',
                icon: Icons.check_box,
                color: Colors.purple,
              ),
              _FeatureCard(
                title: 'Row Actions',
                description: 'Edit, Delete, Duplicate, Custom actions, Bulk operations',
                icon: Icons.touch_app,
                color: Colors.red,
              ),
              _FeatureCard(
                title: 'Row Styling',
                description: 'Striped rows, Hover effects, Selected state, Disabled state',
                icon: Icons.palette,
                color: Colors.teal,
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          _buildFeatureSection(
            context,
            'Data Features',
            'Data manipulation and export',
            [
              _FeatureCard(
                title: 'Filtering',
                description: 'Text search, Number ranges, Date ranges, Multi-select, Custom filters',
                icon: Icons.filter_list,
                color: Colors.indigo,
              ),
              _FeatureCard(
                title: 'Sorting',
                description: 'Single column, Multi-column, Custom comparators, Stable sort',
                icon: Icons.sort,
                color: Colors.amber,
              ),
              _FeatureCard(
                title: 'Export',
                description: 'CSV, JSON, Excel, PDF, Print, Custom formats',
                icon: Icons.download,
                color: Colors.cyan,
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          _buildFeatureSection(
            context,
            'Advanced Features',
            'Performance and specialized functionality',
            [
              _FeatureCard(
                title: 'Virtual Scrolling',
                description: 'Render only visible rows for large datasets',
                icon: Icons.speed,
                color: Colors.deepOrange,
              ),
              _FeatureCard(
                title: 'Grouping',
                description: 'Group by columns, Collapsible groups, Aggregate functions',
                icon: Icons.folder,
                color: Colors.brown,
              ),
              _FeatureCard(
                title: 'Tree View',
                description: 'Hierarchical data, Parent-child relationships, Expand/collapse',
                icon: Icons.account_tree,
                color: Colors.pink,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureSection(
    BuildContext context,
    String title,
    String description,
    List<_FeatureCard> features,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 1200
                ? 3
                : constraints.maxWidth > 800
                    ? 2
                    : 1;
            
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: features.map((feature) => _buildFeatureCard(
                context,
                feature.title,
                feature.description,
                feature.icon,
                feature.color,
              )).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _FeatureCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}