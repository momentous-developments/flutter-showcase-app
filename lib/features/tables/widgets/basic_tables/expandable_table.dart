import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/table_models.dart';
import '../../providers/table_providers.dart';
import '../table_cell_renderer.dart';

class ExpandableTable extends ConsumerWidget {
  final String tableId;
  
  const ExpandableTable({
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
          child: SingleChildScrollView(
            child: _buildTable(context, ref, tableData, visibleColumns, tableSettings),
          ),
        ),
      ),
    );
  }
  
  Widget _buildTable(
    BuildContext context,
    WidgetRef ref,
    TableData tableData,
    List<TableColumn> visibleColumns,
    TableSettings tableSettings,
  ) {
    final tableNotifier = ref.read(tableDataProvider(tableId).notifier);
    
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
              // Expand column
              Container(
                width: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
        ),
        
        // Data rows with expandable content
        ...tableData.rows.asMap().entries.map((entry) {
          final index = entry.key;
          final row = entry.value;
          final isEven = index % 2 == 0;
          final isExpanded = row.expanded;
          
          return Column(
            children: [
              // Main row
              InkWell(
                onTap: () => tableNotifier.toggleRowExpansion(row.id),
                child: Container(
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
                      // Expand icon
                      Container(
                        width: 48,
                        padding: EdgeInsets.all(tableSettings.dense ? 8 : 16),
                        child: Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          size: 20,
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
                ),
              ),
              
              // Expanded content
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: isExpanded ? null : 0,
                child: isExpanded
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
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
                        child: _buildExpandedContent(context, row),
                      )
                    : null,
              ),
            ],
          );
        }),
      ],
    );
  }
  
  Widget _buildExpandedContent(BuildContext context, TableRowData row) {
    // This would normally be customized based on the table type
    // For now, showing generic additional information
    
    switch (tableId) {
      case 'orders':
        return _buildOrderDetails(context, row);
      case 'users':
        return _buildUserDetails(context, row);
      case 'products':
        return _buildProductDetails(context, row);
      default:
        return _buildGenericDetails(context, row);
    }
  }
  
  Widget _buildOrderDetails(BuildContext context, TableRowData row) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Details',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order items
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Items',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDetailItem('Product A', 'Quantity: 2 × \$50.00'),
                  _buildDetailItem('Product B', 'Quantity: 1 × \$75.00'),
                  _buildDetailItem('Product C', 'Quantity: 3 × \$25.00'),
                  const Divider(),
                  _buildDetailItem('Subtotal', '\$250.00', isHighlighted: true),
                  _buildDetailItem('Tax', '\$20.00'),
                  _buildDetailItem('Shipping', '\$10.00'),
                  const Divider(),
                  _buildDetailItem('Total', '\$280.00', isHighlighted: true),
                ],
              ),
            ),
            const SizedBox(width: 32),
            // Shipping info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shipping Information',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDetailItem('Address', '123 Main St, City, State 12345'),
                  _buildDetailItem('Method', row.data['shippingMethod'] ?? 'Standard'),
                  _buildDetailItem('Tracking', 'ABC123456789'),
                  const SizedBox(height: 16),
                  Text(
                    'Customer Notes',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please deliver to the back door. Ring the doorbell twice.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildUserDetails(BuildContext context, TableRowData row) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile Information',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildDetailItem('Member Since', 'January 15, 2023'),
              _buildDetailItem('Last Login', '2 hours ago'),
              _buildDetailItem('Total Orders', '47'),
              _buildDetailItem('Total Spent', '\$3,842.50'),
            ],
          ),
        ),
        const SizedBox(width: 32),
        // Activity section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Activity',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildActivityItem('Placed order #12345', '2 days ago'),
              _buildActivityItem('Updated profile', '1 week ago'),
              _buildActivityItem('Changed password', '2 weeks ago'),
              _buildActivityItem('Added payment method', '1 month ago'),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildProductDetails(BuildContext context, TableRowData row) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Information',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDetailItem('SKU', row.data['sku'] ?? 'N/A'),
                  _buildDetailItem('Category', row.data['category'] ?? 'Uncategorized'),
                  _buildDetailItem('Weight', '2.5 lbs'),
                  _buildDetailItem('Dimensions', '10" × 8" × 6"'),
                ],
              ),
            ),
            const SizedBox(width: 32),
            // Inventory info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Inventory',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDetailItem('In Stock', row.data['stock']?.toString() ?? '0'),
                  _buildDetailItem('Reserved', '5'),
                  _buildDetailItem('Available', '${(row.data['stock'] ?? 0) - 5}'),
                  _buildDetailItem('Reorder Level', '10'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Description',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This is a high-quality product that meets all industry standards. '
          'It features durable construction and comes with a 1-year warranty. '
          'Perfect for both personal and professional use.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
  
  Widget _buildGenericDetails(BuildContext context, TableRowData row) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Information',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...row.data.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    '${entry.key}:',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    entry.value?.toString() ?? 'N/A',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
  
  Widget _buildDetailItem(String label, String value, {bool isHighlighted = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActivityItem(String activity, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8),
          const SizedBox(width: 8),
          Expanded(
            child: Text(activity),
          ),
          Text(
            time,
            style: const TextStyle(fontSize: 12),
          ),
        ],
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
              Icons.unfold_more,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No expandable data',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add some data to see expandable rows',
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