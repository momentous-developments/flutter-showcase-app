import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../advanced_tables/advanced_tables.dart';

class AdvancedTablesShowcase extends ConsumerWidget {
  const AdvancedTablesShowcase({super.key});

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
                Tab(text: 'Editable'),
                Tab(text: 'Drag & Drop'),
                Tab(text: 'Grouped'),
                Tab(text: 'Tree'),
                Tab(text: 'Virtualized'),
                Tab(text: 'Exportable'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildTableCard(
                  context,
                  'Editable Table',
                  'Click cells to edit values inline',
                  const EditableTable(tableId: 'editable'),
                ),
                _buildTableCard(
                  context,
                  'Drag & Drop Table',
                  'Reorder rows by dragging them',
                  const DragDropTable(tableId: 'dragdrop'),
                ),
                _buildTableCard(
                  context,
                  'Grouped Table',
                  'Group rows by common values with aggregates',
                  const GroupedTable(tableId: 'grouped'),
                ),
                _buildTableCard(
                  context,
                  'Tree Table',
                  'Hierarchical data with expandable nodes',
                  const TreeTable(tableId: 'tree'),
                ),
                _buildTableCard(
                  context,
                  'Virtualized Table',
                  'Efficiently render large datasets with virtual scrolling',
                  const VirtualizedTable(tableId: 'virtualized'),
                ),
                _buildTableCard(
                  context,
                  'Exportable Table',
                  'Export data in various formats (CSV, JSON, Excel, PDF)',
                  const ExportableTable(tableId: 'exportable'),
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