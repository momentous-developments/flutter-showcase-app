import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import '../../models/table_models.dart';
import '../../providers/table_providers.dart';
import '../table_cell_renderer.dart';

class PaginatedTable extends ConsumerWidget {
  final String tableId;
  
  const PaginatedTable({
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
    
    final pagination = tableData.pagination;
    if (pagination == null) {
      return _buildNoPaginationState(context);
    }
    
    final visibleColumns = tableData.columns.where((col) => col.visible).toList();
    
    // Calculate paginated rows
    final startIndex = (pagination.currentPage - 1) * pagination.pageSize;
    final endIndex = math.min(startIndex + pagination.pageSize, tableData.rows.length);
    final paginatedRows = tableData.rows.sublist(startIndex, endIndex);
    
    return Container(
      decoration: BoxDecoration(
        border: tableSettings.bordered
            ? Border.all(color: Theme.of(context).colorScheme.outline)
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width - 48,
                ),
                child: SingleChildScrollView(
                  child: _buildTable(context, paginatedRows, visibleColumns, tableSettings, startIndex),
                ),
              ),
            ),
          ),
          
          // Pagination controls
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
            ),
            child: _buildPaginationControls(context, ref, pagination, tableNotifier),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTable(
    BuildContext context,
    List<TableRowData> rows,
    List<TableColumn> visibleColumns,
    TableSettings tableSettings,
    int startIndex,
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
          children: [
            // Row number column
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  '#',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
        ...rows.asMap().entries.map((entry) {
          final index = entry.key;
          final row = entry.value;
          final isEven = index % 2 == 0;
          final rowNumber = startIndex + index + 1;
          
          return TableRow(
            decoration: BoxDecoration(
              color: tableSettings.striped && !isEven
                  ? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3)
                  : null,
            ),
            children: [
              // Row number cell
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                  padding: EdgeInsets.all(tableSettings.dense ? 8 : 16),
                  child: Text(
                    rowNumber.toString(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              // Data cells
              ...visibleColumns.map((column) {
                final value = row.data[column.field];
                return TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    padding: EdgeInsets.all(tableSettings.dense ? 8 : 16),
                    child: TableCellRenderer.render(
                      context: context,
                      column: column,
                      value: value,
                      row: row,
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
  
  Widget _buildPaginationControls(
    BuildContext context,
    WidgetRef ref,
    PaginationConfig pagination,
    TableDataNotifier tableNotifier,
  ) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Page size selector
          if (pagination.showPageSizeSelector) ...[
            Text(
              'Rows per page:',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(width: 8),
            DropdownButton<int>(
              value: pagination.pageSize,
              items: pagination.pageSizeOptions.map((size) {
                return DropdownMenuItem(
                  value: size,
                  child: Text(size.toString()),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  tableNotifier.changePageSize(value);
                }
              },
              isDense: true,
            ),
            const SizedBox(width: 24),
          ],
          
          // Page info
          if (pagination.showPageInfo) ...[
            Text(
              '${_getStartIndex(pagination) + 1}-${_getEndIndex(pagination)} of ${pagination.totalItems}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          
          const Spacer(),
          
          // Page navigation
          _buildPageButtons(context, pagination, tableNotifier),
        ],
      ),
    );
  }
  
  Widget _buildPageButtons(
    BuildContext context,
    PaginationConfig pagination,
    TableDataNotifier tableNotifier,
  ) {
    final theme = Theme.of(context);
    final currentPage = pagination.currentPage;
    final totalPages = pagination.totalPages;
    
    // Calculate visible page numbers
    const maxVisiblePages = 5;
    final startPage = math.max(1, currentPage - 2);
    final endPage = math.min(totalPages, startPage + maxVisiblePages - 1);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // First page
        IconButton(
          icon: const Icon(Icons.first_page),
          onPressed: currentPage > 1
              ? () => tableNotifier.changePage(1)
              : null,
          tooltip: 'First page',
        ),
        
        // Previous page
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: currentPage > 1
              ? () => tableNotifier.changePage(currentPage - 1)
              : null,
          tooltip: 'Previous page',
        ),
        
        const SizedBox(width: 8),
        
        // Page numbers
        if (startPage > 1) ...[
          _buildPageButton(context, 1, currentPage, tableNotifier),
          if (startPage > 2)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                '...',
                style: theme.textTheme.bodyMedium,
              ),
            ),
        ],
        
        for (int page = startPage; page <= endPage; page++)
          _buildPageButton(context, page, currentPage, tableNotifier),
        
        if (endPage < totalPages) ...[
          if (endPage < totalPages - 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                '...',
                style: theme.textTheme.bodyMedium,
              ),
            ),
          _buildPageButton(context, totalPages, currentPage, tableNotifier),
        ],
        
        const SizedBox(width: 8),
        
        // Next page
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: currentPage < totalPages
              ? () => tableNotifier.changePage(currentPage + 1)
              : null,
          tooltip: 'Next page',
        ),
        
        // Last page
        IconButton(
          icon: const Icon(Icons.last_page),
          onPressed: currentPage < totalPages
              ? () => tableNotifier.changePage(totalPages)
              : null,
          tooltip: 'Last page',
        ),
      ],
    );
  }
  
  Widget _buildPageButton(
    BuildContext context,
    int page,
    int currentPage,
    TableDataNotifier tableNotifier,
  ) {
    final isSelected = page == currentPage;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Material(
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: !isSelected
              ? () => tableNotifier.changePage(page)
              : null,
          borderRadius: BorderRadius.circular(4),
          child: Container(
            constraints: const BoxConstraints(minWidth: 32),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Center(
              child: Text(
                page.toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : null,
                  fontWeight: isSelected ? FontWeight.bold : null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  int _getStartIndex(PaginationConfig pagination) {
    return (pagination.currentPage - 1) * pagination.pageSize;
  }
  
  int _getEndIndex(PaginationConfig pagination) {
    return math.min(
      pagination.currentPage * pagination.pageSize,
      pagination.totalItems,
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
              Icons.table_rows,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No data available',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNoPaginationState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Pagination not configured',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}