import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/table_models.dart';
import '../../providers/table_providers.dart';
import '../table_cell_renderer.dart';

class FilterableTable extends ConsumerStatefulWidget {
  final String tableId;
  
  const FilterableTable({
    super.key,
    required this.tableId,
  });

  @override
  ConsumerState<FilterableTable> createState() => _FilterableTableState();
}

class _FilterableTableState extends ConsumerState<FilterableTable> {
  final Map<String, TextEditingController> _filterControllers = {};
  final Map<String, dynamic> _filterValues = {};
  bool _showFilters = true;
  
  @override
  void dispose() {
    for (final controller in _filterControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final tableData = ref.watch(tableDataProvider(widget.tableId));
    final tableNotifier = ref.read(tableDataProvider(widget.tableId).notifier);
    final tableSettings = ref.watch(tableSettingsProvider(widget.tableId));
    
    if (tableData.rows.isEmpty && (tableData.filters?.isEmpty ?? true)) {
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
          // Filter toolbar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.filter_list,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Filters',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    if (tableData.filters?.isNotEmpty ?? false)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${tableData.filters!.length} active',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        _clearFilters();
                        tableNotifier.filter([]);
                      },
                      icon: const Icon(Icons.clear, size: 16),
                      label: const Text('Clear All'),
                    ),
                    IconButton(
                      icon: Icon(_showFilters ? Icons.expand_less : Icons.expand_more),
                      onPressed: () {
                        setState(() {
                          _showFilters = !_showFilters;
                        });
                      },
                    ),
                  ],
                ),
                if (_showFilters) ...[
                  const SizedBox(height: 16),
                  _buildFilterRow(visibleColumns, tableNotifier),
                ],
              ],
            ),
          ),
          
          // Results info
          if (tableData.filters?.isNotEmpty ?? false)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3),
              ),
              child: Row(
                children: [
                  Text(
                    'Showing ${tableData.filteredRows} of ${tableData.totalRows} rows',
                    style: Theme.of(context).textTheme.bodySmall,
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
                  child: _buildTable(context, tableData, visibleColumns, tableSettings),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFilterRow(
    List<TableColumn> columns,
    TableDataNotifier tableNotifier,
  ) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: columns.where((col) => col.filterable).map((column) {
        return SizedBox(
          width: 200,
          child: _buildFilterField(column, tableNotifier),
        );
      }).toList(),
    );
  }
  
  Widget _buildFilterField(
    TableColumn column,
    TableDataNotifier tableNotifier,
  ) {
    switch (column.type) {
      case ColumnType.text:
      case ColumnType.number:
      case ColumnType.currency:
      case ColumnType.percentage:
        _filterControllers.putIfAbsent(
          column.field,
          () => TextEditingController(),
        );
        
        return TextField(
          controller: _filterControllers[column.field],
          decoration: InputDecoration(
            labelText: column.label,
            border: const OutlineInputBorder(),
            isDense: true,
            suffixIcon: _filterControllers[column.field]!.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, size: 16),
                    onPressed: () {
                      _filterControllers[column.field]!.clear();
                      _applyFilters(tableNotifier);
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            _filterValues[column.field] = value;
            _applyFilters(tableNotifier);
          },
        );
        
      case ColumnType.select:
      case ColumnType.status:
      case ColumnType.badge:
        return DropdownButtonFormField<String>(
          value: _filterValues[column.field],
          decoration: InputDecoration(
            labelText: column.label,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
          items: [
            const DropdownMenuItem(
              value: null,
              child: Text('All'),
            ),
            ..._getSelectOptions(column).map((option) {
              return DropdownMenuItem(
                value: option.value.toString(),
                child: Text(option.label),
              );
            }),
          ],
          onChanged: (value) {
            _filterValues[column.field] = value;
            _applyFilters(tableNotifier);
          },
        );
        
      case ColumnType.boolean:
        return DropdownButtonFormField<bool?>(
          value: _filterValues[column.field],
          decoration: InputDecoration(
            labelText: column.label,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
          items: const [
            DropdownMenuItem(value: null, child: Text('All')),
            DropdownMenuItem(value: true, child: Text('Yes')),
            DropdownMenuItem(value: false, child: Text('No')),
          ],
          onChanged: (value) {
            _filterValues[column.field] = value;
            _applyFilters(tableNotifier);
          },
        );
        
      case ColumnType.date:
      case ColumnType.dateTime:
        return Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: '${column.label} From',
                  border: const OutlineInputBorder(),
                  isDense: true,
                  suffixIcon: const Icon(Icons.calendar_today, size: 16),
                ),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    _filterValues['${column.field}_from'] = date;
                    _applyFilters(tableNotifier);
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: '${column.label} To',
                  border: const OutlineInputBorder(),
                  isDense: true,
                  suffixIcon: const Icon(Icons.calendar_today, size: 16),
                ),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    _filterValues['${column.field}_to'] = date;
                    _applyFilters(tableNotifier);
                  }
                },
              ),
            ),
          ],
        );
        
      default:
        return const SizedBox.shrink();
    }
  }
  
  List<SelectOption> _getSelectOptions(TableColumn column) {
    // This would normally be populated from the actual data or column configuration
    switch (column.field) {
      case 'status':
        return [
          const SelectOption(value: 'active', label: 'Active'),
          const SelectOption(value: 'inactive', label: 'Inactive'),
          const SelectOption(value: 'banned', label: 'Banned'),
        ];
      case 'role':
        return [
          const SelectOption(value: 'admin', label: 'Admin'),
          const SelectOption(value: 'user', label: 'User'),
          const SelectOption(value: 'guest', label: 'Guest'),
        ];
      case 'category':
        return [
          const SelectOption(value: 'Electronics', label: 'Electronics'),
          const SelectOption(value: 'Clothing', label: 'Clothing'),
          const SelectOption(value: 'Home', label: 'Home'),
          const SelectOption(value: 'Books', label: 'Books'),
          const SelectOption(value: 'Toys', label: 'Toys'),
        ];
      default:
        return [];
    }
  }
  
  void _applyFilters(TableDataNotifier tableNotifier) {
    final filters = <FilterConfig>[];
    
    _filterValues.forEach((field, value) {
      if (value != null && value.toString().isNotEmpty) {
        filters.add(FilterConfig(
          field: field,
          type: _getFilterType(field),
          value: value,
        ));
      }
    });
    
    tableNotifier.filter(filters);
  }
  
  FilterType _getFilterType(String field) {
    // This would normally be determined by the column type
    if (field.contains('date')) return FilterType.date;
    if (field == 'status' || field == 'role' || field == 'category') return FilterType.select;
    return FilterType.text;
  }
  
  void _clearFilters() {
    _filterControllers.forEach((key, controller) {
      controller.clear();
    });
    _filterValues.clear();
    setState(() {});
  }
  
  Widget _buildTable(
    BuildContext context,
    TableData tableData,
    List<TableColumn> visibleColumns,
    TableSettings tableSettings,
  ) {
    if (tableData.rows.isEmpty) {
      return _buildNoResultsState(context);
    }
    
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
            }).toList(),
          );
        }),
      ],
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
              Icons.filter_list_off,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No data to filter',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add some data to see filtering in action',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNoResultsState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your filters',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: () {
                _clearFilters();
                ref.read(tableDataProvider(widget.tableId).notifier).filter([]);
              },
              child: const Text('Clear Filters'),
            ),
          ],
        ),
      ),
    );
  }
}