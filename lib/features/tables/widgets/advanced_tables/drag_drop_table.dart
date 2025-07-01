import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/table_models.dart';
import '../../providers/table_providers.dart';
import '../table_cell_renderer.dart';

class DragDropTable extends ConsumerStatefulWidget {
  final String tableId;
  
  const DragDropTable({
    super.key,
    required this.tableId,
  });

  @override
  ConsumerState<DragDropTable> createState() => _DragDropTableState();
}

class _DragDropTableState extends ConsumerState<DragDropTable> {
  int? _draggingIndex;
  
  @override
  Widget build(BuildContext context) {
    final tableData = ref.watch(tableDataProvider(widget.tableId));
    final tableNotifier = ref.read(tableDataProvider(widget.tableId).notifier);
    final tableSettings = ref.watch(tableSettingsProvider(widget.tableId));
    
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
          // Instructions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.drag_indicator,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Drag rows to reorder',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
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
                  child: _buildTable(context, tableData, visibleColumns, tableSettings, tableNotifier),
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
    TableData tableData,
    List<TableColumn> visibleColumns,
    TableSettings tableSettings,
    TableDataNotifier tableNotifier,
  ) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      buildDefaultDragHandles: false,
      header: _buildHeader(context, visibleColumns, tableSettings),
      onReorder: (oldIndex, newIndex) {
        tableNotifier.reorderRows(oldIndex, newIndex);
      },
      itemCount: tableData.rows.length,
      proxyDecorator: (child, index, animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final double animValue = Curves.easeInOut.transform(animation.value);
            final double elevation = lerpDouble(0, 6, animValue)!;
            return Material(
              elevation: elevation,
              borderRadius: BorderRadius.circular(4),
              child: child,
            );
          },
          child: child,
        );
      },
      itemBuilder: (context, index) {
        final row = tableData.rows[index];
        final isEven = index % 2 == 0;
        
        return Container(
          key: ValueKey(row.id),
          decoration: BoxDecoration(
            color: _draggingIndex == index
                ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3)
                : tableSettings.striped && !isEven
                    ? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3)
                    : null,
            border: tableSettings.bordered
                ? Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  )
                : null,
          ),
          child: Row(
            children: [
              // Drag handle
              ReorderableDragStartListener(
                index: index,
                child: Container(
                  width: 48,
                  padding: EdgeInsets.all(tableSettings.dense ? 8 : 16),
                  child: Icon(
                    Icons.drag_indicator,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              // Row number
              Container(
                width: 48,
                padding: EdgeInsets.all(tableSettings.dense ? 8 : 16),
                child: Text(
                  '${index + 1}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              // Data cells
              ...visibleColumns.map((column) {
                final value = row.data[column.field];
                return Container(
                  constraints: BoxConstraints(
                    minWidth: column.minWidth ?? 100,
                    maxWidth: column.maxWidth ?? 300,
                  ),
                  padding: EdgeInsets.all(tableSettings.dense ? 8 : 16),
                  child: TableCellRenderer.render(
                    context: context,
                    column: column,
                    value: value,
                    row: row,
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildHeader(
    BuildContext context,
    List<TableColumn> visibleColumns,
    TableSettings tableSettings,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        border: tableSettings.bordered
            ? Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          // Drag handle column
          Container(
            width: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          // Row number column
          Container(
            width: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              '#',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Data columns
          ...visibleColumns.map((column) {
            return Container(
              constraints: BoxConstraints(
                minWidth: column.minWidth ?? 100,
                maxWidth: column.maxWidth ?? 300,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                column.label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
  
  double? lerpDouble(num? a, num? b, double t) {
    if (a == null && b == null) return null;
    a ??= 0.0;
    b ??= 0.0;
    return a + (b - a) * t;
  }
  
  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.drag_handle,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No data to reorder',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add some data to enable drag and drop',
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