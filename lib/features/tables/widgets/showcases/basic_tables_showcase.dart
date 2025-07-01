import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../basic_tables/basic_tables.dart';

class BasicTablesShowcase extends ConsumerWidget {
  const BasicTablesShowcase({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 6,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
            child: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Data Table'),
                Tab(text: 'Sortable'),
                Tab(text: 'Filterable'),
                Tab(text: 'Paginated'),
                Tab(text: 'Selectable'),
                Tab(text: 'Expandable'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildTableCard(
                  context,
                  'Basic Data Table',
                  'Simple table for displaying data in rows and columns',
                  const DataTableWidget(tableId: 'basic'),
                ),
                _buildTableCard(
                  context,
                  'Sortable Table',
                  'Click column headers to sort data',
                  const SortableTable(tableId: 'sortable'),
                ),
                _buildTableCard(
                  context,
                  'Filterable Table',
                  'Advanced filtering options for each column',
                  const FilterableTable(tableId: 'filterable'),
                ),
                _buildTableCard(
                  context,
                  'Paginated Table',
                  'Navigate through large datasets with pagination',
                  const PaginatedTable(tableId: 'paginated'),
                ),
                _buildTableCard(
                  context,
                  'Selectable Table',
                  'Select single or multiple rows with bulk actions',
                  const SelectableTable(tableId: 'selectable'),
                ),
                _buildTableCard(
                  context,
                  'Expandable Table',
                  'Click rows to reveal additional details',
                  const ExpandableTable(tableId: 'expandable'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableCard(
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
            height: 600,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              child: table,
            ),
          ),
        ],
      ),
    );
  }
}