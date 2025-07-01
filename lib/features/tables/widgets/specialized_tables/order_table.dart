import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/table_models.dart';
import '../../providers/table_providers.dart';

class OrderTable extends ConsumerStatefulWidget {
  final String tableId;
  
  const OrderTable({
    super.key,
    required this.tableId,
  });

  @override
  ConsumerState<OrderTable> createState() => _OrderTableState();
}

class _OrderTableState extends ConsumerState<OrderTable> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final tableData = ref.watch(tableDataProvider(widget.tableId));
    final tableSettings = ref.watch(tableSettingsProvider(widget.tableId));
    
    if (tableData.rows.isEmpty) {
      return _buildEmptyState(context);
    }
    
    // Group orders by status
    final ordersByStatus = _groupOrdersByStatus(tableData.rows);
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Order dashboard header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      size: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Management',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Track and manage customer orders',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    FilledButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('New Order'),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildOrderMetrics(context, tableData.rows),
              ],
            ),
          ),
          
          // Status tabs
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: [
                _buildTab('All Orders', tableData.rows.length),
                _buildTab('Pending', ordersByStatus['pending']?.length ?? 0, Colors.orange),
                _buildTab('Processing', ordersByStatus['processing']?.length ?? 0, Colors.blue),
                _buildTab('Shipped', ordersByStatus['shipped']?.length ?? 0, Colors.purple),
                _buildTab('Delivered', ordersByStatus['delivered']?.length ?? 0, Colors.green),
                _buildTab('Cancelled', ordersByStatus['cancelled']?.length ?? 0, Colors.red),
              ],
            ),
          ),
          
          // Order content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrderList(context, tableData.rows),
                _buildOrderList(context, ordersByStatus['pending'] ?? []),
                _buildOrderList(context, ordersByStatus['processing'] ?? []),
                _buildOrderList(context, ordersByStatus['shipped'] ?? []),
                _buildOrderList(context, ordersByStatus['delivered'] ?? []),
                _buildOrderList(context, ordersByStatus['cancelled'] ?? []),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Map<String, List<TableRowData>> _groupOrdersByStatus(List<TableRowData> orders) {
    final Map<String, List<TableRowData>> grouped = {};
    for (final order in orders) {
      final status = order.data['status'] ?? 'pending';
      grouped.putIfAbsent(status, () => []).add(order);
    }
    return grouped;
  }
  
  Widget _buildTab(String label, int count, [Color? color]) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: (color ?? Theme.of(context).colorScheme.primary).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color ?? Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildOrderMetrics(BuildContext context, List<TableRowData> orders) {
    final todayOrders = orders.where((o) {
      final date = o.data['orderDate'] as DateTime?;
      return date != null && _isToday(date);
    }).length;
    
    final totalRevenue = orders.fold<double>(
      0,
      (sum, order) => sum + (order.data['total'] ?? 0),
    );
    
    final averageOrderValue = orders.isNotEmpty ? totalRevenue / orders.length : 0;
    
    final pendingOrders = orders.where((o) => o.data['status'] == 'pending').length;
    
    return Row(
      children: [
        _buildMetricCard(
          context,
          'Today\'s Orders',
          todayOrders.toString(),
          Icons.today,
          Theme.of(context).colorScheme.primary,
          '↑ 12% from yesterday',
        ),
        const SizedBox(width: 16),
        _buildMetricCard(
          context,
          'Total Revenue',
          '\$${totalRevenue.toStringAsFixed(2)}',
          Icons.attach_money,
          Colors.green,
          'This month',
        ),
        const SizedBox(width: 16),
        _buildMetricCard(
          context,
          'Average Order',
          '\$${averageOrderValue.toStringAsFixed(2)}',
          Icons.analytics,
          Theme.of(context).colorScheme.secondary,
          'Per transaction',
        ),
        const SizedBox(width: 16),
        _buildMetricCard(
          context,
          'Pending Orders',
          pendingOrders.toString(),
          Icons.pending_actions,
          Colors.orange,
          'Awaiting processing',
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
    String subtitle,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const Spacer(),
                Icon(
                  Icons.trending_up,
                  color: color,
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOrderList(BuildContext context, List<TableRowData> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inbox,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No orders in this category',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return _buildOrderCard(context, orders[index]);
      },
    );
  }
  
  Widget _buildOrderCard(BuildContext context, TableRowData order) {
    final status = order.data['status'] ?? 'pending';
    final statusInfo = _getStatusInfo(status);
    final orderDate = order.data['orderDate'] as DateTime?;
    final total = order.data['total'] ?? 0;
    final items = order.data['items'] ?? [];
    final customer = order.data['customer'] ?? {};
    final shippingMethod = order.data['shippingMethod'] ?? 'Standard';
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            // Order header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  // Order info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Order #${order.data['orderNumber'] ?? order.id}',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusInfo.color.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    statusInfo.icon,
                                    size: 14,
                                    color: statusInfo.color,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    status.toUpperCase(),
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: statusInfo.color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          orderDate != null
                              ? 'Placed on ${_formatDate(orderDate)}'
                              : 'Date unknown',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Total
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${total.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        '${items.length} items',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Order details
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Customer info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        child: Text(
                          _getInitials(customer['name'] ?? ''),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              customer['name'] ?? 'Unknown Customer',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              customer['email'] ?? '',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Shipping info
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.local_shipping,
                                size: 16,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                shippingMethod,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          if (order.data['trackingNumber'] != null)
                            Text(
                              'Tracking: ${order.data['trackingNumber']}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  
                  // Order timeline
                  if (status != 'cancelled') ...[
                    const SizedBox(height: 20),
                    _buildOrderTimeline(context, status),
                  ],
                  
                  // Actions
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('View Details'),
                      ),
                      const SizedBox(width: 8),
                      if (status == 'pending')
                        FilledButton(
                          onPressed: () {},
                          child: const Text('Process Order'),
                        )
                      else if (status == 'processing')
                        FilledButton(
                          onPressed: () {},
                          child: const Text('Mark as Shipped'),
                        )
                      else if (status == 'shipped')
                        FilledButton(
                          onPressed: () {},
                          child: const Text('Mark as Delivered'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOrderTimeline(BuildContext context, String currentStatus) {
    final statuses = ['pending', 'processing', 'shipped', 'delivered'];
    final currentIndex = statuses.indexOf(currentStatus);
    
    return Row(
      children: [
        for (int i = 0; i < statuses.length; i++) ...[
          _buildTimelineStep(
            context,
            statuses[i],
            i <= currentIndex,
            i == currentIndex,
          ),
          if (i < statuses.length - 1)
            Expanded(
              child: Container(
                height: 2,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                color: i < currentIndex
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
        ],
      ],
    );
  }
  
  Widget _buildTimelineStep(
    BuildContext context,
    String status,
    bool isCompleted,
    bool isCurrent,
  ) {
    final statusInfo = _getStatusInfo(status);
    
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isCompleted
                ? statusInfo.color
                : Theme.of(context).colorScheme.surfaceVariant,
            shape: BoxShape.circle,
            border: isCurrent
                ? Border.all(
                    color: statusInfo.color,
                    width: 3,
                  )
                : null,
          ),
          child: Icon(
            isCompleted ? Icons.check : statusInfo.icon,
            size: 16,
            color: isCompleted
                ? Colors.white
                : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _formatStatus(status),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: isCompleted
                ? statusInfo.color
                : Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: isCurrent ? FontWeight.bold : null,
          ),
        ),
      ],
    );
  }
  
  ({Color color, IconData icon}) _getStatusInfo(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return (color: Colors.orange, icon: Icons.pending_actions);
      case 'processing':
        return (color: Colors.blue, icon: Icons.settings);
      case 'shipped':
        return (color: Colors.purple, icon: Icons.local_shipping);
      case 'delivered':
        return (color: Colors.green, icon: Icons.check_circle);
      case 'cancelled':
        return (color: Colors.red, icon: Icons.cancel);
      default:
        return (color: Colors.grey, icon: Icons.help);
    }
  }
  
  String _formatStatus(String status) {
    return status[0].toUpperCase() + status.substring(1);
  }
  
  String _getInitials(String name) {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '';
  }
  
  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
           date.month == now.month &&
           date.day == now.day;
  }
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
  
  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No orders yet',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Orders will appear here once customers start purchasing',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Create Test Order'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}