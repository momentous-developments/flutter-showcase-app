import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../specialized_tables/specialized_tables.dart';

class SpecializedTablesShowcase extends ConsumerWidget {
  const SpecializedTablesShowcase({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 5,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
            child: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Invoice'),
                Tab(text: 'Product'),
                Tab(text: 'User'),
                Tab(text: 'Order'),
                Tab(text: 'Report'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildTableSection(
                  context,
                  'Invoice Table',
                  'Specialized table for managing invoices with custom styling',
                  const InvoiceTable(tableId: 'invoices'),
                ),
                _buildTableSection(
                  context,
                  'Product Table',
                  'Product inventory with grid/list view toggle',
                  const ProductTable(tableId: 'products'),
                ),
                _buildTableSection(
                  context,
                  'User Table',
                  'User management with avatars and card view',
                  const UserTable(tableId: 'users'),
                ),
                _buildTableSection(
                  context,
                  'Order Table',
                  'Order tracking with status tabs and timeline',
                  const OrderTable(tableId: 'orders'),
                ),
                _buildTableSection(
                  context,
                  'Report Table',
                  'Analytics dashboard with charts and metrics',
                  const ReportTable(tableId: 'reports'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableSection(
    BuildContext context,
    String title,
    String description,
    Widget table,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 700,
            child: table,
          ),
        ],
      ),
    );
  }
}