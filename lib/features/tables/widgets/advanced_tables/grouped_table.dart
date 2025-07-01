import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/table_models.dart';
import '../../providers/table_providers.dart';
import '../table_cell_renderer.dart';

class GroupedTable extends ConsumerStatefulWidget {
  final String tableId;
  
  const GroupedTable({
    super.key,
    required this.tableId,
  });

  @override
  ConsumerState<GroupedTable> createState() => _GroupedTableState();
}

class _GroupedTableState extends ConsumerState<GroupedTable> {
  final Set<String> _expandedGroups = {};
  
  @override
  Widget build(BuildContext context) {
    final tableData = ref.watch(tableDataProvider(widget.tableId));
    final tableSettings = ref.watch(tableSettingsProvider(widget.tableId));
    
    if (tableData.rows.isEmpty) {
      return _buildEmptyState(context);
    }
    
    final visibleColumns = tableData.columns.where((col) => col.visible).toList();
    final groupConfig = tableData.grouping;
    
    if (groupConfig == null || groupConfig.groupBy.isEmpty) {
      return _buildNoGroupingState(context);
    }
    
    // Group the data
    final groupedData = _groupData(tableData.rows, groupConfig);
    
    return Container(
      decoration: BoxDecoration(
        border: tableSettings.bordered
            ? Border.all(color: Theme.of(context).colorScheme.outline)
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Group info bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.folder_open,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Grouped by: ${groupConfig.groupBy}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  icon: Icon(
                    _expandedGroups.length == groupedData.length
                        ? Icons.unfold_less
                        : Icons.unfold_more,
                  ),
                  label: Text(
                    _expandedGroups.length == groupedData.length
                        ? 'Collapse All'
                        : 'Expand All',
                  ),
                  onPressed: () {
                    setState(() {
                      if (_expandedGroups.length == groupedData.length) {
                        _expandedGroups.clear();
                      } else {
                        _expandedGroups.addAll(groupedData.keys);
                      }
                    });
                  },
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
                  child: _buildTable(
                    context,
                    groupedData,
                    visibleColumns,
                    tableSettings,
                    groupConfig,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Map<String, List<TableRowData>> _groupData(
    List<TableRowData> rows,
    GroupingConfig groupConfig,
  ) {
    final Map<String, List<TableRowData>> grouped = {};
    
    for (final row in rows) {
      final groupValue = row.data[groupConfig.groupBy]?.toString() ?? 'Unknown';
      grouped.putIfAbsent(groupValue, () => []).add(row);
    }
    
    // Sort groups if specified
    if (groupConfig.sortGroups) {
      final sortedKeys = grouped.keys.toList()..sort();
      final sortedMap = <String, List<TableRowData>>{};
      for (final key in sortedKeys) {
        sortedMap[key] = grouped[key]!;
      }
      return sortedMap;
    }
    
    return grouped;
  }
  
  Widget _buildTable(
    BuildContext context,
    Map<String, List<TableRowData>> groupedData,
    List<TableColumn> visibleColumns,
    TableSettings tableSettings,
    GroupingConfig groupConfig,
  ) {
    return Column(
      children: [
        // Header
        Container(
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
              // Group column
              Container(
                width: 300,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  groupConfig.groupBy,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Data columns
              ...visibleColumns.where((col) => col.field != groupConfig.groupBy).map((column) {
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
        ),
        
        // Grouped data
        ...groupedData.entries.map((group) {
          final groupName = group.key;
          final groupRows = group.value;
          final isExpanded = _expandedGroups.contains(groupName);
          
          return Column(
            children: [
              // Group header
              InkWell(
                onTap: () {
                  setState(() {
                    if (isExpanded) {
                      _expandedGroups.remove(groupName);
                    } else {
                      _expandedGroups.add(groupName);
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1),
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
                      Container(
                        width: 300,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Icon(
                              isExpanded ? Icons.expand_less : Icons.expand_more,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.folder,
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                groupName,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${groupRows.length}',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Aggregate values
                      if (groupConfig.showAggregates) ...[
                        ...visibleColumns.where((col) => col.field != groupConfig.groupBy).map((column) {
                          final aggregateValue = _calculateAggregate(
                            groupRows,
                            column,
                            groupConfig.aggregates[column.field],
                          );
                          return Container(
                            constraints: BoxConstraints(
                              minWidth: column.minWidth ?? 100,
                              maxWidth: column.maxWidth ?? 300,
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              aggregateValue,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }),
                      ],
                    ],
                  ),
                ),
              ),
              
              // Group rows
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: isExpanded ? null : 0,
                child: isExpanded
                    ? Column(
                        children: groupRows.asMap().entries.map((entry) {
                          final index = entry.key;
                          final row = entry.value;
                          final isEven = index % 2 == 0;
                          
                          return Container(
                            decoration: BoxDecoration(
                              color: tableSettings.striped && !isEven
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
                                // Indent for group items
                                Container(
                                  width: 300,
                                  padding: EdgeInsets.only(
                                    left: 48,
                                    right: 16,
                                    top: tableSettings.dense ? 8 : 16,
                                    bottom: tableSettings.dense ? 8 : 16,
                                  ),
                                  child: Text(
                                    row.data[groupConfig.groupBy]?.toString() ?? '',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                // Data cells
                                ...visibleColumns.where((col) => col.field != groupConfig.groupBy).map((column) {
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
                        }).toList(),
                      )
                    : null,
              ),
            ],
          );
        }),
      ],
    );
  }
  
  String _calculateAggregate(
    List<TableRowData> rows,
    TableColumn column,
    AggregateType? aggregateType,
  ) {
    if (aggregateType == null) return '';
    
    switch (aggregateType) {
      case AggregateType.sum:
        if (column.type == ColumnType.number ||
            column.type == ColumnType.currency ||
            column.type == ColumnType.percentage) {
          final sum = rows.fold<num>(0, (sum, row) {
            final value = row.data[column.field];
            if (value is num) return sum + value;
            return sum;
          });
          if (column.type == ColumnType.currency) {
            return '\$${sum.toStringAsFixed(2)}';
          } else if (column.type == ColumnType.percentage) {
            return '${sum.toStringAsFixed(1)}%';
          }
          return sum.toString();
        }
        return '';
        
      case AggregateType.average:
        if (column.type == ColumnType.number ||
            column.type == ColumnType.currency ||
            column.type == ColumnType.percentage) {
          final values = rows
              .map((row) => row.data[column.field])
              .where((value) => value is num)
              .cast<num>()
              .toList();
          if (values.isEmpty) return '';
          final avg = values.reduce((a, b) => a + b) / values.length;
          if (column.type == ColumnType.currency) {
            return '\$${avg.toStringAsFixed(2)}';
          } else if (column.type == ColumnType.percentage) {
            return '${avg.toStringAsFixed(1)}%';
          }
          return avg.toStringAsFixed(2);
        }
        return '';
        
      case AggregateType.count:
        final count = rows.where((row) => row.data[column.field] != null).length;
        return count.toString();
        
      case AggregateType.min:
        if (column.type == ColumnType.number ||
            column.type == ColumnType.currency ||
            column.type == ColumnType.percentage) {
          final values = rows
              .map((row) => row.data[column.field])
              .where((value) => value is num)
              .cast<num>()
              .toList();
          if (values.isEmpty) return '';
          final min = values.reduce((a, b) => a < b ? a : b);
          if (column.type == ColumnType.currency) {
            return '\$${min.toStringAsFixed(2)}';
          } else if (column.type == ColumnType.percentage) {
            return '${min.toStringAsFixed(1)}%';
          }
          return min.toString();
        }
        return '';
        
      case AggregateType.max:
        if (column.type == ColumnType.number ||
            column.type == ColumnType.currency ||
            column.type == ColumnType.percentage) {
          final values = rows
              .map((row) => row.data[column.field])
              .where((value) => value is num)
              .cast<num>()
              .toList();
          if (values.isEmpty) return '';
          final max = values.reduce((a, b) => a > b ? a : b);
          if (column.type == ColumnType.currency) {
            return '\$${max.toStringAsFixed(2)}';
          } else if (column.type == ColumnType.percentage) {
            return '${max.toStringAsFixed(1)}%';
          }
          return max.toString();
        }
        return '';
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
              Icons.folder_off,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No data to group',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add some data to see grouping in action',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNoGroupingState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.info_outline,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'No grouping configured',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Configure grouping to organize data by categories',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}