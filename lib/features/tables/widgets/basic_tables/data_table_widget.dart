import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/table_models.dart';
import '../../providers/table_providers.dart';

class DataTableWidget extends ConsumerWidget {
  final String tableId;
  
  const DataTableWidget({
    super.key,
    required this.tableId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableData = ref.watch(tableDataProvider(tableId));
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width - 48,
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Theme.of(context).colorScheme.outlineVariant,
            ),
            child: DataTable(
              columnSpacing: tableSettings.dense ? 24 : 56,
              horizontalMargin: tableSettings.dense ? 12 : 24,
              dataRowHeight: tableSettings.rowHeight,
              headingRowHeight: tableSettings.headerHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              headingRowColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
              ),
              columns: visibleColumns.map((column) {
                return DataColumn(
                  label: _buildColumnHeader(context, column),
                  numeric: column.type == ColumnType.number ||
                           column.type == ColumnType.currency ||
                           column.type == ColumnType.percentage,
                );
              }).toList(),
              rows: _buildDataRows(context, tableData, visibleColumns, tableSettings),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildColumnHeader(BuildContext context, TableColumn column) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        column.label,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  
  List<DataRow> _buildDataRows(
    BuildContext context,
    TableData tableData,
    List<TableColumn> visibleColumns,
    TableSettings tableSettings,
  ) {
    return tableData.rows.asMap().entries.map((entry) {
      final index = entry.key;
      final row = entry.value;
      final isEven = index % 2 == 0;
      
      return DataRow(
        color: tableSettings.striped && !isEven
            ? MaterialStateProperty.all(
                Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              )
            : null,
        cells: visibleColumns.map((column) {
          final value = row.data[column.field];
          return DataCell(
            _buildCellContent(context, column, value, row),
          );
        }).toList(),
      );
    }).toList();
  }
  
  Widget _buildCellContent(
    BuildContext context,
    TableColumn column,
    dynamic value,
    TableRowData row,
  ) {
    if (column.customRenderer != null) {
      return column.customRenderer!(value, row);
    }
    
    switch (column.type) {
      case ColumnType.text:
        return Text(
          column.formatter?.call(value) ?? value?.toString() ?? '',
          style: Theme.of(context).textTheme.bodyMedium,
        );
        
      case ColumnType.number:
        final format = column.format;
        String formattedValue = value?.toString() ?? '';
        if (format != null && value != null) {
          if (format.decimalPlaces != null) {
            formattedValue = (value as num).toStringAsFixed(format.decimalPlaces!);
          }
          if (format.prefix != null) formattedValue = '${format.prefix}$formattedValue';
          if (format.suffix != null) formattedValue = '$formattedValue${format.suffix}';
        }
        return Text(
          formattedValue,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.right,
        );
        
      case ColumnType.currency:
        final format = column.format;
        String formattedValue = '';
        if (value != null) {
          final numValue = value as num;
          formattedValue = numValue.toStringAsFixed(format?.decimalPlaces ?? 2);
          formattedValue = '${format?.currencySymbol ?? '\$'}$formattedValue';
        }
        return Text(
          formattedValue,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.right,
        );
        
      case ColumnType.percentage:
        final format = column.format;
        String formattedValue = '';
        if (value != null) {
          final numValue = value as num;
          formattedValue = numValue.toStringAsFixed(format?.decimalPlaces ?? 0);
          formattedValue = '$formattedValue%';
        }
        return Text(
          formattedValue,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.right,
        );
        
      case ColumnType.date:
      case ColumnType.dateTime:
        if (value == null) return const Text('');
        final date = value as DateTime;
        return Text(
          column.formatter?.call(date) ?? date.toLocal().toString(),
          style: Theme.of(context).textTheme.bodyMedium,
        );
        
      case ColumnType.boolean:
        return Icon(
          value == true ? Icons.check_circle : Icons.cancel,
          color: value == true
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.error,
          size: 20,
        );
        
      case ColumnType.status:
        if (value == null) return const Text('');
        final statusConfig = column.format?.statusConfig?[value.toString()];
        if (statusConfig == null) {
          return Text(value.toString());
        }
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (statusConfig.icon != null)
              Icon(statusConfig.icon, size: 16, color: statusConfig.color),
            const SizedBox(width: 4),
            Text(
              statusConfig.label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: statusConfig.color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
        
      case ColumnType.badge:
        if (value == null) return const Text('');
        final badgeConfig = column.format?.badgeConfig?[value.toString()];
        if (badgeConfig == null) {
          return Text(value.toString());
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: badgeConfig.backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            badgeConfig.label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: badgeConfig.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
        
      case ColumnType.image:
        if (value == null) return const SizedBox.shrink();
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            value.toString(),
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 60,
                height: 60,
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Icon(
                  Icons.broken_image,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              );
            },
          ),
        );
        
      case ColumnType.avatar:
        if (value == null) return const SizedBox.shrink();
        return CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(value.toString()),
          onBackgroundImageError: (exception, stackTrace) {},
          child: value.toString().isEmpty
              ? const Icon(Icons.person)
              : null,
        );
        
      case ColumnType.rating:
        if (value == null) return const SizedBox.shrink();
        final rating = (value as num).toDouble();
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(5, (index) {
              if (index < rating.floor()) {
                return const Icon(Icons.star, size: 16, color: Colors.amber);
              } else if (index < rating) {
                return const Icon(Icons.star_half, size: 16, color: Colors.amber);
              } else {
                return const Icon(Icons.star_border, size: 16, color: Colors.amber);
              }
            }),
            const SizedBox(width: 4),
            Text(
              rating.toStringAsFixed(1),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
        
      case ColumnType.progress:
        if (value == null) return const SizedBox.shrink();
        final progress = (value as num) / 100;
        return Container(
          width: 100,
          height: 8,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        );
        
      case ColumnType.actions:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              iconSize: 20,
              onPressed: () {},
              tooltip: 'Edit',
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              iconSize: 20,
              onPressed: () {},
              tooltip: 'Delete',
            ),
          ],
        );
        
      case ColumnType.custom:
      default:
        return Text(
          value?.toString() ?? '',
          style: Theme.of(context).textTheme.bodyMedium,
        );
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
            const SizedBox(height: 8),
            Text(
              'There are no rows to display',
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