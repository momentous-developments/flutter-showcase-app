import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/table_models.dart';
import '../../providers/table_providers.dart';
import '../table_cell_renderer.dart';

class ReportTable extends ConsumerStatefulWidget {
  final String tableId;
  
  const ReportTable({
    super.key,
    required this.tableId,
  });

  @override
  ConsumerState<ReportTable> createState() => _ReportTableState();
}

class _ReportTableState extends ConsumerState<ReportTable> {
  String _selectedPeriod = 'month';
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();
  
  @override
  Widget build(BuildContext context) {
    final tableData = ref.watch(tableDataProvider(widget.tableId));
    final tableSettings = ref.watch(tableSettingsProvider(widget.tableId));
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Report header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.secondaryContainer,
                ],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.analytics,
                      size: 32,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Analytics Report',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Comprehensive business insights',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    PopupMenuButton<String>(
                      icon: Icon(
                        Icons.download,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      onSelected: (format) => _exportReport(format),
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'pdf', child: Text('Export as PDF')),
                        const PopupMenuItem(value: 'excel', child: Text('Export as Excel')),
                        const PopupMenuItem(value: 'csv', child: Text('Export as CSV')),
                      ],
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(
                        Icons.print,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      onPressed: () => _printReport(),
                      tooltip: 'Print Report',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Period selector
                Row(
                  children: [
                    Text(
                      'Period:',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(value: 'week', label: Text('Week')),
                        ButtonSegment(value: 'month', label: Text('Month')),
                        ButtonSegment(value: 'quarter', label: Text('Quarter')),
                        ButtonSegment(value: 'year', label: Text('Year')),
                        ButtonSegment(value: 'custom', label: Text('Custom')),
                      ],
                      selected: {_selectedPeriod},
                      onSelectionChanged: (value) {
                        setState(() {
                          _selectedPeriod = value.first;
                          _updateDateRange();
                        });
                      },
                    ),
                    if (_selectedPeriod == 'custom') ...[
                      const SizedBox(width: 16),
                      TextButton.icon(
                        icon: const Icon(Icons.calendar_today),
                        label: Text(
                          '${_formatDate(_startDate)} - ${_formatDate(_endDate)}',
                        ),
                        onPressed: () => _selectDateRange(context),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          
          // Key metrics
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
            ),
            child: _buildKeyMetrics(context, tableData),
          ),
          
          // Report content
          Expanded(
            child: tableData.rows.isEmpty 
                ? _buildEmptyState(context)
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Summary section
                        _buildSummarySection(context, tableData),
                        const SizedBox(height: 32),
                        
                        // Charts section
                        _buildChartsSection(context, tableData),
                        const SizedBox(height: 32),
                        
                        // Detailed table
                        Text(
                          'Detailed Breakdown',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildDetailedTable(context, tableData, tableSettings),
                      ],
                    ),
                  ),
          ),
          
          // Report footer
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  'Report generated on ${_formatDate(DateTime.now())} at ${_formatTime(DateTime.now())}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text('Refresh Data'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildKeyMetrics(BuildContext context, TableData tableData) {
    // Calculate metrics from table data
    final totalRevenue = tableData.rows.fold<double>(
      0,
      (sum, row) => sum + (row.data['revenue'] ?? 0),
    );
    final totalOrders = tableData.rows.fold<int>(
      0,
      (sum, row) => sum + ((row.data['orders'] ?? 0) as int),
    );
    final conversionRate = tableData.rows.isNotEmpty
        ? tableData.rows.map((r) => r.data['conversionRate'] ?? 0).reduce((a, b) => a + b) / tableData.rows.length
        : 0.0;
    final growth = 15.3; // Mock growth percentage
    
    return Row(
      children: [
        _buildMetricCard(
          context,
          'Total Revenue',
          '\$${_formatNumber(totalRevenue)}',
          Icons.attach_money,
          Colors.green,
          growth,
        ),
        const SizedBox(width: 16),
        _buildMetricCard(
          context,
          'Total Orders',
          _formatNumber(totalOrders.toDouble()),
          Icons.shopping_cart,
          Theme.of(context).colorScheme.primary,
          8.7,
        ),
        const SizedBox(width: 16),
        _buildMetricCard(
          context,
          'Conversion Rate',
          '${conversionRate.toStringAsFixed(1)}%',
          Icons.trending_up,
          Theme.of(context).colorScheme.secondary,
          -2.1,
        ),
        const SizedBox(width: 16),
        _buildMetricCard(
          context,
          'Avg Order Value',
          '\$${(totalRevenue / (totalOrders == 0 ? 1 : totalOrders)).toStringAsFixed(2)}',
          Icons.analytics,
          Theme.of(context).colorScheme.tertiary,
          5.4,
        ),
      ],
    );
  }
  
  Widget _buildMetricCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
    double change,
  ) {
    final isPositive = change >= 0;
    
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isPositive
                        ? Colors.green.withOpacity(0.1)
                        : Theme.of(context).colorScheme.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                        size: 12,
                        color: isPositive
                            ? Colors.green
                            : Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${change.abs()}%',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: isPositive
                              ? Colors.green
                              : Theme.of(context).colorScheme.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSummarySection(BuildContext context, TableData tableData) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Executive Summary',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Performance during the selected period shows strong growth across key metrics. '
              'Revenue increased by 15.3% compared to the previous period, driven primarily by '
              'improved conversion rates and higher average order values. Customer acquisition '
              'costs decreased by 8%, while customer lifetime value increased by 12%.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildSummaryChip(context, 'Strong Growth', Colors.green),
                const SizedBox(width: 8),
                _buildSummaryChip(context, 'Improved Efficiency', Colors.blue),
                const SizedBox(width: 8),
                _buildSummaryChip(context, 'Higher Retention', Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSummaryChip(BuildContext context, String label, Color color) {
    return Chip(
      label: Text(label),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(color: color.withOpacity(0.3)),
      labelStyle: TextStyle(color: color),
    );
  }
  
  Widget _buildChartsSection(BuildContext context, TableData tableData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visual Analytics',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Revenue chart placeholder
            Expanded(
              child: _buildChartCard(
                context,
                'Revenue Trend',
                Icons.show_chart,
                'Line chart showing revenue over time',
              ),
            ),
            const SizedBox(width: 16),
            // Category breakdown placeholder
            Expanded(
              child: _buildChartCard(
                context,
                'Category Breakdown',
                Icons.pie_chart,
                'Pie chart showing sales by category',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer segments placeholder
            Expanded(
              child: _buildChartCard(
                context,
                'Customer Segments',
                Icons.donut_large,
                'Donut chart showing customer distribution',
              ),
            ),
            const SizedBox(width: 16),
            // Geographic distribution placeholder
            Expanded(
              child: _buildChartCard(
                context,
                'Geographic Distribution',
                Icons.map,
                'Heat map showing sales by region',
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildChartCard(
    BuildContext context,
    String title,
    IconData icon,
    String placeholder,
  ) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Container(
        height: 250,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    placeholder,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDetailedTable(
    BuildContext context,
    TableData tableData,
    TableSettings tableSettings,
  ) {
    final visibleColumns = tableData.columns.where((col) => col.visible).toList();
    
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width - 48,
          ),
          child: Table(
            defaultColumnWidth: const IntrinsicColumnWidth(),
            border: TableBorder(
              horizontalInside: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5),
              ),
            ),
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
              
              // Data rows with alternating colors
              ...tableData.rows.asMap().entries.map((entry) {
                final index = entry.key;
                final row = entry.value;
                final isEven = index % 2 == 0;
                
                return TableRow(
                  decoration: BoxDecoration(
                    color: isEven
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                  ),
                  children: visibleColumns.map((column) {
                    final value = row.data[column.field];
                    return TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        padding: const EdgeInsets.all(16),
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
              
              // Footer totals
              TableRow(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                  border: Border(
                    top: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                children: visibleColumns.map((column) {
                  // Calculate totals for numeric columns
                  dynamic total;
                  if (column.type == ColumnType.number ||
                      column.type == ColumnType.currency ||
                      column.type == ColumnType.percentage) {
                    total = tableData.rows.fold<double>(
                      0,
                      (sum, row) => sum + (row.data[column.field] ?? 0),
                    );
                  }
                  
                  return TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        column == visibleColumns.first
                            ? 'Total'
                            : total != null
                                ? column.type == ColumnType.currency
                                    ? '\$${total.toStringAsFixed(2)}'
                                    : total.toStringAsFixed(2)
                                : '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _updateDateRange() {
    final now = DateTime.now();
    switch (_selectedPeriod) {
      case 'week':
        _startDate = now.subtract(const Duration(days: 7));
        _endDate = now;
        break;
      case 'month':
        _startDate = DateTime(now.year, now.month - 1, now.day);
        _endDate = now;
        break;
      case 'quarter':
        _startDate = DateTime(now.year, now.month - 3, now.day);
        _endDate = now;
        break;
      case 'year':
        _startDate = DateTime(now.year - 1, now.month, now.day);
        _endDate = now;
        break;
    }
  }
  
  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
    );
    
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }
  
  void _exportReport(String format) {
    // Implement export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exporting report as $format...'),
      ),
    );
  }
  
  void _printReport() {
    // Implement print functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Preparing report for printing...'),
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
  
  String _formatTime(DateTime date) {
    return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
  
  String _formatNumber(double number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toStringAsFixed(0);
  }
  
  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.analytics_outlined,
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
              'Reports will be generated once data is available',
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