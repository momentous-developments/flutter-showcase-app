import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import '../../models/table_models.dart';
import '../../providers/table_providers.dart';
import '../table_cell_renderer.dart';

class ExportableTable extends ConsumerStatefulWidget {
  final String tableId;
  
  const ExportableTable({
    super.key,
    required this.tableId,
  });

  @override
  ConsumerState<ExportableTable> createState() => _ExportableTableState();
}

class _ExportableTableState extends ConsumerState<ExportableTable> {
  bool _isExporting = false;
  String? _lastExport;
  
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
          // Export toolbar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.file_download,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Export Options',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    // Export buttons
                    _ExportButton(
                      icon: Icons.file_copy,
                      label: 'CSV',
                      onPressed: _isExporting ? null : () => _exportData('csv'),
                    ),
                    const SizedBox(width: 8),
                    _ExportButton(
                      icon: Icons.code,
                      label: 'JSON',
                      onPressed: _isExporting ? null : () => _exportData('json'),
                    ),
                    const SizedBox(width: 8),
                    _ExportButton(
                      icon: Icons.table_chart,
                      label: 'Excel',
                      onPressed: _isExporting ? null : () => _exportData('excel'),
                    ),
                    const SizedBox(width: 8),
                    _ExportButton(
                      icon: Icons.picture_as_pdf,
                      label: 'PDF',
                      onPressed: _isExporting ? null : () => _exportData('pdf'),
                    ),
                    const SizedBox(width: 8),
                    _ExportButton(
                      icon: Icons.print,
                      label: 'Print',
                      onPressed: _isExporting ? null : () => _printTable(),
                    ),
                  ],
                ),
                if (_lastExport != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _lastExport!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
  
  Widget _buildTable(
    BuildContext context,
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
  
  Future<void> _exportData(String format) async {
    setState(() {
      _isExporting = true;
      _lastExport = null;
    });
    
    try {
      // Simulate export delay
      await Future.delayed(const Duration(seconds: 1));
      
      final tableData = ref.read(tableDataProvider(widget.tableId));
      final visibleColumns = tableData.columns.where((col) => col.visible).toList();
      
      switch (format) {
        case 'csv':
          final csv = _generateCSV(tableData, visibleColumns);
          // In a real app, save to file or download
          setState(() {
            _lastExport = 'Exported ${tableData.rows.length} rows to CSV';
          });
          break;
          
        case 'json':
          final json = _generateJSON(tableData, visibleColumns);
          // In a real app, save to file or download
          setState(() {
            _lastExport = 'Exported ${tableData.rows.length} rows to JSON';
          });
          break;
          
        case 'excel':
          // In a real app, use a package like excel or syncfusion_flutter_xlsio
          setState(() {
            _lastExport = 'Exported ${tableData.rows.length} rows to Excel';
          });
          break;
          
        case 'pdf':
          // In a real app, use pdf package to generate PDF
          setState(() {
            _lastExport = 'Exported ${tableData.rows.length} rows to PDF';
          });
          break;
      }
      
      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully exported as $format'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      setState(() {
        _isExporting = false;
      });
    }
  }
  
  String _generateCSV(TableData tableData, List<TableColumn> columns) {
    final buffer = StringBuffer();
    
    // Headers
    buffer.writeln(columns.map((col) => '"${col.label}"').join(','));
    
    // Data
    for (final row in tableData.rows) {
      final values = columns.map((col) {
        final value = row.data[col.field];
        if (value == null) return '""';
        if (value is String) return '"${value.replaceAll('"', '""')}"';
        return value.toString();
      });
      buffer.writeln(values.join(','));
    }
    
    return buffer.toString();
  }
  
  String _generateJSON(TableData tableData, List<TableColumn> columns) {
    final data = tableData.rows.map((row) {
      final Map<String, dynamic> rowData = {};
      for (final col in columns) {
        rowData[col.field] = row.data[col.field];
      }
      return rowData;
    }).toList();
    
    return const JsonEncoder.withIndent('  ').convert(data);
  }
  
  Future<void> _printTable() async {
    setState(() {
      _isExporting = true;
      _lastExport = null;
    });
    
    try {
      // Simulate print preparation
      await Future.delayed(const Duration(milliseconds: 500));
      
      // In a real app, use printing package
      setState(() {
        _lastExport = 'Sent to printer';
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Table sent to printer'),
          ),
        );
      }
    } finally {
      setState(() {
        _isExporting = false;
      });
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
              Icons.download,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No data to export',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add some data to enable export functionality',
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

class _ExportButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  
  const _ExportButton({
    required this.icon,
    required this.label,
    this.onPressed,
  });
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: onPressed != null
          ? Theme.of(context).colorScheme.secondary.withOpacity(0.1)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: onPressed != null
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: onPressed != null
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}