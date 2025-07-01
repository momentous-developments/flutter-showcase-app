import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart' hide TableRow;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/table_models.dart';
import '../../providers/table_providers.dart';
import '../table_cell_renderer.dart';

class EditableTable extends ConsumerStatefulWidget {
  final String tableId;
  
  const EditableTable({
    super.key,
    required this.tableId,
  });

  @override
  ConsumerState<EditableTable> createState() => _EditableTableState();
}

class _EditableTableState extends ConsumerState<EditableTable> {
  String? _editingCellId;
  final Map<String, TextEditingController> _editControllers = {};
  final Map<String, dynamic> _originalValues = {};
  
  @override
  void dispose() {
    for (final controller in _editControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
  
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
          // Edit mode indicator
          if (_editingCellId != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.edit,
                    size: 16,
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Editing mode - Press Enter to save, Esc to cancel',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
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
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      border: tableSettings.bordered
          ? TableBorder.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            )
          : null,
      children: [
        // Header
        material.TableRow(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
          ),
          children: visibleColumns.map((column) {
            return TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      column.label,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (column.editable) ...[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.edit,
                        size: 14,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ],
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
          
          return material.TableRow(
            decoration: BoxDecoration(
              color: tableSettings.striped && !isEven
                  ? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3)
                  : null,
            ),
            children: visibleColumns.map((column) {
              final value = row.data[column.field];
              final cellId = '${row.id}_${column.field}';
              final isEditing = _editingCellId == cellId;
              
              return TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: InkWell(
                  onTap: column.editable && !row.disabled
                      ? () => _startEditing(cellId, value, row.id, column.field)
                      : null,
                  onDoubleTap: column.editable && !row.disabled
                      ? () => _startEditing(cellId, value, row.id, column.field)
                      : null,
                  child: Container(
                    padding: EdgeInsets.all(tableSettings.dense ? 8 : 16),
                    decoration: isEditing
                        ? BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2,
                            ),
                          )
                        : null,
                    child: isEditing
                        ? _buildEditCell(context, column, value, row, cellId, tableNotifier)
                        : _buildViewCell(context, column, value, row),
                  ),
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }
  
  Widget _buildViewCell(
    BuildContext context,
    TableColumn column,
    dynamic value,
    TableRowData row,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TableCellRenderer.render(
            context: context,
            column: column,
            value: value,
            row: row,
          ),
        ),
        if (column.editable && !row.disabled) ...[
          const SizedBox(width: 8),
          Icon(
            Icons.edit,
            size: 14,
            color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
          ),
        ],
      ],
    );
  }
  
  Widget _buildEditCell(
    BuildContext context,
    TableColumn column,
    dynamic value,
    TableRowData row,
    String cellId,
    TableDataNotifier tableNotifier,
  ) {
    if (column.editRenderer != null) {
      return column.editRenderer!(value, row);
    }
    
    switch (column.type) {
      case ColumnType.text:
      case ColumnType.number:
      case ColumnType.currency:
      case ColumnType.percentage:
        final controller = _editControllers[cellId]!;
        return Focus(
          onFocusChange: (hasFocus) {
            if (!hasFocus) {
              _cancelEditing();
            }
          },
          child: TextField(
            controller: controller,
            autofocus: true,
            keyboardType: column.type == ColumnType.number ||
                    column.type == ColumnType.currency ||
                    column.type == ColumnType.percentage
                ? TextInputType.number
                : TextInputType.text,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              border: OutlineInputBorder(),
            ),
            onSubmitted: (newValue) {
              _saveEdit(tableNotifier, row.id, column, newValue);
            },
            onEditingComplete: () {
              _saveEdit(tableNotifier, row.id, column, controller.text);
            },
          ),
        );
        
      case ColumnType.boolean:
        return Checkbox(
          value: value ?? false,
          onChanged: (newValue) {
            tableNotifier.updateCell(row.id, column.field, newValue);
            _cancelEditing();
          },
        );
        
      case ColumnType.select:
      case ColumnType.status:
        return DropdownButton<String>(
          value: value?.toString(),
          items: _getSelectOptions(column).map((option) {
            return DropdownMenuItem(
              value: option.value.toString(),
              child: Text(option.label),
            );
          }).toList(),
          onChanged: (newValue) {
            tableNotifier.updateCell(row.id, column.field, newValue);
            _cancelEditing();
          },
          isDense: true,
        );
        
      case ColumnType.date:
      case ColumnType.dateTime:
        return InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: value is DateTime ? value : DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              tableNotifier.updateCell(row.id, column.field, date);
              _cancelEditing();
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value is DateTime
                    ? '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}'
                    : 'Select date',
              ),
              const SizedBox(width: 8),
              const Icon(Icons.calendar_today, size: 16),
            ],
          ),
        );
        
      case ColumnType.badge:
      case ColumnType.image:
      case ColumnType.avatar:
      case ColumnType.rating:
      case ColumnType.progress:
      case ColumnType.actions:
      case ColumnType.custom:
        return TableCellRenderer.render(
          context: context,
          column: column,
          value: value,
          row: row,
        );
    }
  }
  
  void _startEditing(String cellId, dynamic value, String rowId, String field) {
    setState(() {
      _editingCellId = cellId;
      _originalValues[cellId] = value;
      
      // Initialize controller
      _editControllers[cellId] = TextEditingController(
        text: value?.toString() ?? '',
      );
    });
  }
  
  void _saveEdit(
    TableDataNotifier tableNotifier,
    String rowId,
    TableColumn column,
    String newValue,
  ) {
    // Parse value based on column type
    dynamic parsedValue = newValue;
    
    switch (column.type) {
      case ColumnType.number:
      case ColumnType.currency:
      case ColumnType.percentage:
        parsedValue = num.tryParse(newValue) ?? 0;
        break;
      case ColumnType.date:
      case ColumnType.dateTime:
        parsedValue = DateTime.tryParse(newValue);
        break;
      case ColumnType.text:
      case ColumnType.boolean:
      case ColumnType.status:
      case ColumnType.badge:
      case ColumnType.image:
      case ColumnType.avatar:
      case ColumnType.rating:
      case ColumnType.progress:
      case ColumnType.actions:
      case ColumnType.custom:
      case ColumnType.select:
        // Keep as string for these types
        break;
    }
    
    // Validate
    if (column.parser != null) {
      try {
        parsedValue = column.parser!(newValue);
      } catch (e) {
        // Show error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid value: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
        return;
      }
    }
    
    // Update cell
    tableNotifier.updateCell(rowId, column.field, parsedValue);
    
    // Clean up
    _cancelEditing();
  }
  
  void _cancelEditing() {
    setState(() {
      if (_editingCellId != null) {
        _editControllers[_editingCellId]?.dispose();
        _editControllers.remove(_editingCellId);
        _originalValues.remove(_editingCellId);
      }
      _editingCellId = null;
    });
  }
  
  List<SelectOption> _getSelectOptions(TableColumn column) {
    // This would normally come from column configuration
    switch (column.field) {
      case 'status':
        return [
          const SelectOption(value: 'pending', label: 'Pending'),
          const SelectOption(value: 'processing', label: 'Processing'),
          const SelectOption(value: 'completed', label: 'Completed'),
          const SelectOption(value: 'cancelled', label: 'Cancelled'),
        ];
      case 'category':
        return [
          const SelectOption(value: 'Electronics', label: 'Electronics'),
          const SelectOption(value: 'Clothing', label: 'Clothing'),
          const SelectOption(value: 'Home', label: 'Home'),
          const SelectOption(value: 'Books', label: 'Books'),
        ];
      default:
        return [];
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
              Icons.edit_note,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No editable data',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add some data to start editing',
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