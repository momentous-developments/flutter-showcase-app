import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/chart_models.dart';

/// Data table widget for displaying chart data
class ChartDataTable extends StatefulWidget {
  final List<ChartSeries> series;
  final bool showSearch;
  final bool showExport;
  final bool sortable;
  final int? rowsPerPage;
  final Function(ChartSeries series, ChartPoint point)? onRowTap;

  const ChartDataTable({
    super.key,
    required this.series,
    this.showSearch = true,
    this.showExport = true,
    this.sortable = true,
    this.rowsPerPage,
    this.onRowTap,
  });

  @override
  State<ChartDataTable> createState() => _ChartDataTableState();
}

class _ChartDataTableState extends State<ChartDataTable> {
  String _searchQuery = '';
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  int _currentPage = 0;
  late int _rowsPerPage;

  @override
  void initState() {
    super.initState();
    _rowsPerPage = widget.rowsPerPage ?? 10;
  }

  List<_TableRow> _getFilteredAndSortedData() {
    final rows = <_TableRow>[];
    
    for (final series in widget.series) {
      for (final point in series.data) {
        rows.add(_TableRow(series: series, point: point));
      }
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      rows.retainWhere((row) {
        final searchLower = _searchQuery.toLowerCase();
        return row.series.name.toLowerCase().contains(searchLower) ||
               (row.point.label?.toLowerCase().contains(searchLower) ?? false) ||
               row.point.x.toString().contains(searchLower) ||
               row.point.y.toString().contains(searchLower);
      });
    }

    // Sort data
    if (widget.sortable) {
      rows.sort((a, b) {
        int result;
        switch (_sortColumnIndex) {
          case 0: // Series
            result = a.series.name.compareTo(b.series.name);
            break;
          case 1: // Label
            result = (a.point.label ?? '').compareTo(b.point.label ?? '');
            break;
          case 2: // X Value
            result = a.point.x.compareTo(b.point.x);
            break;
          case 3: // Y Value
            result = a.point.y.compareTo(b.point.y);
            break;
          default:
            result = 0;
        }
        return _sortAscending ? result : -result;
      });
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final filteredData = _getFilteredAndSortedData();
    final totalPages = (filteredData.length / _rowsPerPage).ceil();

    return Column(
      children: [
        // Toolbar
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                color: colorScheme.outlineVariant,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              if (widget.showSearch) ...[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search data...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                        _currentPage = 0;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
              ],
              if (widget.showExport) ...[
                PopupMenuButton<String>(
                  icon: const Icon(Icons.download),
                  tooltip: 'Export data',
                  onSelected: (format) {
                    _exportData(format, filteredData);
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'csv',
                      child: Row(
                        children: [
                          Icon(Icons.table_chart, size: 20),
                          SizedBox(width: 8),
                          Text('Export as CSV'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'json',
                      child: Row(
                        children: [
                          Icon(Icons.code, size: 20),
                          SizedBox(width: 8),
                          Text('Export as JSON'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'clipboard',
                      child: Row(
                        children: [
                          Icon(Icons.content_copy, size: 20),
                          SizedBox(width: 8),
                          Text('Copy to clipboard'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        // Data table
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                sortColumnIndex: widget.sortable ? _sortColumnIndex : null,
                sortAscending: _sortAscending,
                columns: [
                  DataColumn(
                    label: const Text('Series'),
                    onSort: widget.sortable ? (index, ascending) {
                      setState(() {
                        _sortColumnIndex = index;
                        _sortAscending = ascending;
                      });
                    } : null,
                  ),
                  DataColumn(
                    label: const Text('Label'),
                    onSort: widget.sortable ? (index, ascending) {
                      setState(() {
                        _sortColumnIndex = index;
                        _sortAscending = ascending;
                      });
                    } : null,
                  ),
                  DataColumn(
                    label: const Text('X Value'),
                    numeric: true,
                    onSort: widget.sortable ? (index, ascending) {
                      setState(() {
                        _sortColumnIndex = index;
                        _sortAscending = ascending;
                      });
                    } : null,
                  ),
                  DataColumn(
                    label: const Text('Y Value'),
                    numeric: true,
                    onSort: widget.sortable ? (index, ascending) {
                      setState(() {
                        _sortColumnIndex = index;
                        _sortAscending = ascending;
                      });
                    } : null,
                  ),
                ],
                rows: _buildDataRows(filteredData),
              ),
            ),
          ),
        ),
        // Pagination
        if (filteredData.length > _rowsPerPage)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Rows per page:'),
                    const SizedBox(width: 8),
                    DropdownButton<int>(
                      value: _rowsPerPage,
                      items: [10, 25, 50, 100].map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _rowsPerPage = value!;
                          _currentPage = 0;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${_currentPage * _rowsPerPage + 1}-'
                      '${((_currentPage + 1) * _rowsPerPage).clamp(0, filteredData.length)} '
                      'of ${filteredData.length}',
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: _currentPage > 0
                          ? () {
                              setState(() {
                                _currentPage--;
                              });
                            }
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: _currentPage < totalPages - 1
                          ? () {
                              setState(() {
                                _currentPage++;
                              });
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

  List<DataRow> _buildDataRows(List<_TableRow> data) {
    final startIndex = _currentPage * _rowsPerPage;
    final endIndex = (startIndex + _rowsPerPage).clamp(0, data.length);
    final pageData = data.sublist(startIndex, endIndex);

    return pageData.map((row) {
      final defaultColors = Theme.of(context).colorScheme;
      final seriesColors = ChartTheme.fromColorScheme(defaultColors).colors;
      final seriesIndex = widget.series.indexOf(row.series);
      final color = row.series.color ?? 
          seriesColors[seriesIndex % seriesColors.length];

      return DataRow(
        cells: [
          DataCell(
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(row.series.name),
              ],
            ),
          ),
          DataCell(Text(row.point.label ?? '-')),
          DataCell(Text(row.point.x.toStringAsFixed(2))),
          DataCell(Text(row.point.y.toStringAsFixed(2))),
        ],
        onSelectChanged: widget.onRowTap != null
            ? (_) => widget.onRowTap!(row.series, row.point)
            : null,
      );
    }).toList();
  }

  void _exportData(String format, List<_TableRow> data) {
    String content;
    
    switch (format) {
      case 'csv':
        content = _generateCSV(data);
        break;
      case 'json':
        content = _generateJSON(data);
        break;
      case 'clipboard':
        content = _generateCSV(data);
        Clipboard.setData(ClipboardData(text: content));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data copied to clipboard')),
        );
        return;
      default:
        return;
    }
    
    // In a real app, you would save the file or trigger a download
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Export to $format completed')),
    );
  }

  String _generateCSV(List<_TableRow> data) {
    final buffer = StringBuffer();
    buffer.writeln('Series,Label,X Value,Y Value');
    
    for (final row in data) {
      buffer.writeln(
        '${row.series.name},'
        '${row.point.label ?? ""},'
        '${row.point.x},'
        '${row.point.y}',
      );
    }
    
    return buffer.toString();
  }

  String _generateJSON(List<_TableRow> data) {
    final jsonData = data.map((row) => {
      'series': row.series.name,
      'label': row.point.label,
      'x': row.point.x,
      'y': row.point.y,
    }).toList();
    
    // In a real app, you would use json.encode
    return jsonData.toString();
  }
}

/// Helper class for table rows
class _TableRow {
  final ChartSeries series;
  final ChartPoint point;

  const _TableRow({
    required this.series,
    required this.point,
  });
}