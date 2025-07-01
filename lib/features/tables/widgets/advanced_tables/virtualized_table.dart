import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/table_models.dart';
import '../../providers/table_providers.dart';
import '../table_cell_renderer.dart';

class VirtualizedTable extends ConsumerStatefulWidget {
  final String tableId;
  
  const VirtualizedTable({
    super.key,
    required this.tableId,
  });

  @override
  ConsumerState<VirtualizedTable> createState() => _VirtualizedTableState();
}

class _VirtualizedTableState extends ConsumerState<VirtualizedTable> {
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();
  
  static const double _rowHeight = 56.0;
  static const double _headerHeight = 64.0;
  static const int _visibleRowsBuffer = 5;
  
  int _firstVisibleRow = 0;
  int _lastVisibleRow = 0;
  
  @override
  void initState() {
    super.initState();
    _verticalController.addListener(_onScroll);
  }
  
  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }
  
  void _onScroll() {
    final scrollOffset = _verticalController.offset;
    final viewportHeight = _verticalController.position.viewportDimension;
    
    setState(() {
      _firstVisibleRow = (scrollOffset / _rowHeight).floor() - _visibleRowsBuffer;
      _firstVisibleRow = _firstVisibleRow.clamp(0, double.infinity).toInt();
      
      _lastVisibleRow = ((scrollOffset + viewportHeight) / _rowHeight).ceil() + _visibleRowsBuffer;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final tableData = ref.watch(tableDataProvider(widget.tableId));
    final tableSettings = ref.watch(tableSettingsProvider(widget.tableId));
    
    if (tableData.rows.isEmpty) {
      return _buildEmptyState(context);
    }
    
    final visibleColumns = tableData.columns.where((col) => col.visible).toList();
    final totalHeight = _headerHeight + (tableData.rows.length * _rowHeight);
    
    // Calculate visible rows
    final visibleRows = <int, TableRowData>{};
    for (int i = _firstVisibleRow; i <= _lastVisibleRow && i < tableData.rows.length; i++) {
      visibleRows[i] = tableData.rows[i];
    }
    
    return Container(
      decoration: BoxDecoration(
        border: tableSettings.bordered
            ? Border.all(color: Theme.of(context).colorScheme.outline)
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Performance indicator
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade100.withOpacity(0.3),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.speed,
                  color: Colors.green.shade800,
                ),
                const SizedBox(width: 8),
                Text(
                  'Virtualized Table - ${tableData.rows.length} total rows',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Rendering ${visibleRows.length} rows',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Table with custom scroll
          Expanded(
            child: Scrollbar(
              controller: _horizontalController,
              child: SingleChildScrollView(
                controller: _horizontalController,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: _calculateTableWidth(visibleColumns),
                  child: Column(
                    children: [
                      // Fixed header
                      _buildHeader(context, visibleColumns, tableSettings),
                      
                      // Virtualized body
                      Expanded(
                        child: Scrollbar(
                          controller: _verticalController,
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            controller: _verticalController,
                            child: SizedBox(
                              height: tableData.rows.length * _rowHeight,
                              child: Stack(
                                children: [
                                  // Render only visible rows
                                  ...visibleRows.entries.map((entry) {
                                    final index = entry.key;
                                    final row = entry.value;
                                    
                                    return Positioned(
                                      top: index * _rowHeight,
                                      left: 0,
                                      right: 0,
                                      height: _rowHeight,
                                      child: _buildRow(
                                        context,
                                        row,
                                        index,
                                        visibleColumns,
                                        tableSettings,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Status bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Showing rows ${_firstVisibleRow + 1} - ${(_lastVisibleRow + 1).clamp(0, tableData.rows.length)} of ${tableData.rows.length}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  'Virtual scrolling enabled for performance',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  double _calculateTableWidth(List<TableColumn> columns) {
    return columns.fold(0.0, (sum, column) {
      return sum + (column.minWidth ?? 150);
    });
  }
  
  Widget _buildHeader(
    BuildContext context,
    List<TableColumn> visibleColumns,
    TableSettings tableSettings,
  ) {
    return Container(
      height: _headerHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        border: tableSettings.bordered
            ? Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  width: 2,
                ),
              )
            : null,
      ),
      child: Row(
        children: visibleColumns.map((column) {
          return Container(
            width: column.minWidth ?? 150,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              column.label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
  
  Widget _buildRow(
    BuildContext context,
    TableRowData row,
    int index,
    List<TableColumn> visibleColumns,
    TableSettings tableSettings,
  ) {
    final isEven = index % 2 == 0;
    
    return Container(
      decoration: BoxDecoration(
        color: tableSettings.striped && !isEven
            ? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3)
            : Theme.of(context).colorScheme.surface,
        border: tableSettings.bordered
            ? Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5),
                ),
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Row click handler
          },
          child: Row(
            children: visibleColumns.map((column) {
              final value = row.data[column.field];
              return Container(
                width: column.minWidth ?? 150,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                child: TableCellRenderer.render(
                  context: context,
                  column: column,
                  value: value,
                  row: row,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
  
  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.view_list,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No data to virtualize',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add large datasets to see virtualization benefits',
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