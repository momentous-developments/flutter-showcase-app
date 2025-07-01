import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/table_models.dart';
import '../../providers/table_providers.dart';
import '../table_cell_renderer.dart';

class SortableTable extends ConsumerWidget {
  final String tableId;
  
  const SortableTable({
    super.key,
    required this.tableId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableData = ref.watch(tableDataProvider(tableId));
    final tableNotifier = ref.read(tableDataProvider(tableId).notifier);
    final tableSettings = ref.watch(tableSettingsProvider(tableId));
    
    if (tableData.rows.isEmpty) {
      return _buildEmptyState(context);
    }
    
    final visibleColumns = tableData.columns.where((col) => col.visible).toList();
    
    return Container(
      decoration: BoxDecoration(
        border: tableSettings.bordered
            ? Border.all(color: Theme.of(context).colorScheme.outline)
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Sort info bar
          if (tableData.sortConfig?.field != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.sort,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Sorted by: ${_getColumnLabel(tableData.columns, tableData.sortConfig!.field!)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    tableData.sortConfig!.direction == SortDirection.ascending
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () => tableNotifier.sort(''),
                    icon: const Icon(Icons.clear, size: 16),
                    label: const Text('Clear'),
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    ),
                  ),
                ],
              ),
            ),
          
          // Table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width - 48,
                ),
                child: SingleChildScrollView(
                  child: _buildTable(context, ref, tableData, visibleColumns, tableSettings),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTable(
    BuildContext context,
    WidgetRef ref,
    TableData tableData,
    List<TableColumn> visibleColumns,
    TableSettings tableSettings,
  ) {
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      border: tableSettings.bordered
          ? TableBorder.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            )
          : null,
      children: [
        // Header
        TableRow(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
          ),
          children: visibleColumns.map((column) {
            return _buildHeaderCell(context, ref, column, tableData);
          }).toList(),
        ),
        
        // Data rows
        ...tableData.rows.asMap().entries.map((entry) {
          final index = entry.key;
          final row = entry.value;
          final isEven = index % 2 == 0;
          
          return TableRow(
            decoration: BoxDecoration(
              color: tableSettings.striped && !isEven
                  ? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3)
                  : null,
            ),
            children: visibleColumns.map((column) {
              final value = row.data[column.field];
              return TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: InkWell(
                  onTap: tableSettings.hoverable ? () {} : null,
                  child: Container(
                    padding: EdgeInsets.all(tableSettings.dense ? 8 : 16),
                    child: TableCellRenderer.render(
                      context: context,
                      column: column,
                      value: value,
                      row: row,
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }
  
  Widget _buildHeaderCell(
    BuildContext context,
    WidgetRef ref,
    TableColumn column,
    TableData tableData,
  ) {
    final tableNotifier = ref.read(tableDataProvider(tableId).notifier);
    final isSorted = tableData.sortConfig?.field == column.field;
    final isAscending = tableData.sortConfig?.direction == SortDirection.ascending;
    
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: InkWell(
        onTap: column.sortable
            ? () => tableNotifier.sort(column.field)
            : null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                column.label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSorted ? Theme.of(context).colorScheme.primary : null,
                ),
              ),
              if (column.sortable) ...[
                const SizedBox(width: 4),
                if (isSorted)
                  Icon(
                    isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  )
                else
                  Icon(
                    Icons.unfold_more,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
  
  String _getColumnLabel(List<TableColumn> columns, String field) {
    return columns.firstWhere((col) => col.field == field).label;
  }
  
  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sort,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No data to sort',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add some data to see sorting in action',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}