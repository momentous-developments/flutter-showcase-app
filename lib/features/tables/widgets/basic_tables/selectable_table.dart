import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/table_models.dart';
import '../../providers/table_providers.dart';
import '../table_cell_renderer.dart';

class SelectableTable extends ConsumerWidget {
  final String tableId;
  
  const SelectableTable({
    super.key,
    required this.tableId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableData = ref.watch(tableDataProvider(tableId));
    final tableNotifier = ref.read(tableDataProvider(tableId).notifier);
    final tableSettings = ref.watch(tableSettingsProvider(tableId));
    final bulkActions = ref.watch(bulkActionsProvider(tableId));
    
    if (tableData.rows.isEmpty) {
      return _buildEmptyState(context);
    }
    
    final visibleColumns = tableData.columns.where((col) => col.visible).toList();
    final selectedCount = tableData.selection?.selectedIds.length ?? 0;
    final hasSelection = selectedCount > 0;
    
    return Container(
      decoration: BoxDecoration(
        border: tableSettings.bordered
            ? Border.all(color: Theme.of(context).colorScheme.outline)
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Selection toolbar
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: hasSelection ? 64 : 0,
            child: hasSelection
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '$selectedCount item${selectedCount > 1 ? 's' : ''} selected',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        // Bulk actions
                        ...bulkActions.map((action) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: IconButton(
                              icon: Icon(action.icon),
                              tooltip: action.label,
                              onPressed: action.disabled
                                  ? null
                                  : () => _handleBulkAction(
                                      context,
                                      action,
                                      tableData.selection?.selectedIds ?? [],
                                    ),
                            ),
                          );
                        }),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () => tableNotifier.clearSelection(),
                          child: const Text('Clear'),
                        ),
                      ],
                    ),
                  )
                : null,
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
    final tableNotifier = ref.read(tableDataProvider(tableId).notifier);
    final selectionMode = tableData.selection?.mode ?? SelectionMode.none;
    final showCheckboxes = tableData.selection?.showCheckboxes ?? true;
    final selectedIds = tableData.selection?.selectedIds ?? [];
    final allSelected = tableData.rows.isNotEmpty &&
        selectedIds.length == tableData.rows.length;
    final someSelected = selectedIds.isNotEmpty && !allSelected;
    
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
          children: [
            // Select all checkbox
            if (selectionMode != SelectionMode.none && showCheckboxes)
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: selectionMode == SelectionMode.multiple
                      ? Checkbox(
                          value: allSelected,
                          tristate: true,
                          onChanged: (value) {
                            if (value == true) {
                              tableNotifier.selectAll();
                            } else {
                              tableNotifier.clearSelection();
                            }
                          },
                        )
                      : const SizedBox(width: 24),
                ),
              ),
            // Data columns
            ...visibleColumns.map((column) {
              return TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    column.label,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
        
        // Data rows
        ...tableData.rows.asMap().entries.map((entry) {
          final index = entry.key;
          final row = entry.value;
          final isEven = index % 2 == 0;
          final isSelected = selectedIds.contains(row.id);
          
          return TableRow(
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3)
                  : tableSettings.striped && !isEven
                      ? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3)
                      : null,
            ),
            children: [
              // Selection checkbox
              if (selectionMode != SelectionMode.none && showCheckboxes)
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    padding: EdgeInsets.all(tableSettings.dense ? 8 : 16),
                    child: selectionMode == SelectionMode.multiple
                        ? Checkbox(
                            value: isSelected,
                            onChanged: row.disabled
                                ? null
                                : (value) => tableNotifier.toggleRowSelection(row.id),
                          )
                        : Radio<String>(
                            value: row.id,
                            groupValue: selectedIds.isNotEmpty ? selectedIds.first : null,
                            onChanged: row.disabled
                                ? null
                                : (value) => tableNotifier.selectRows([row.id]),
                          ),
                  ),
                ),
              // Data cells
              ...visibleColumns.map((column) {
                final value = row.data[column.field];
                return TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: InkWell(
                    onTap: selectionMode != SelectionMode.none && !showCheckboxes && !row.disabled
                        ? () => tableNotifier.toggleRowSelection(row.id)
                        : null,
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
              }),
            ],
          );
        }),
      ],
    );
  }
  
  void _handleBulkAction(
    BuildContext context,
    BulkAction action,
    List<String> selectedIds,
  ) {
    if (action.requireConfirmation) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirm ${action.label}'),
          content: Text(
            action.confirmationMessage ??
            'Are you sure you want to ${action.label.toLowerCase()} ${selectedIds.length} item${selectedIds.length > 1 ? 's' : ''}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                action.onAction?.call(selectedIds);
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      );
    } else {
      action.onAction?.call(selectedIds);
    }
  }
  
  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.checklist,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No data to select',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add some data to see selection in action',
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