import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/layouts/dashboard_layout.dart';
import '../../core/constants/app_constants.dart';

/// Logistics management module page
class LogisticsPage extends StatelessWidget {
  const LogisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      header: const LogisticsHeader(),
      children: [
        // Overview cards
        Row(
          children: const [
            Expanded(
              child: _OverviewCard(
                title: 'Active Shipments',
                value: '234',
                icon: Icons.local_shipping,
                color: Colors.blue,
                trend: '+12%',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _OverviewCard(
                title: 'In Transit',
                value: '156',
                icon: Icons.flight,
                color: Colors.orange,
                trend: '+8%',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _OverviewCard(
                title: 'Delivered Today',
                value: '42',
                icon: Icons.check_circle,
                color: Colors.green,
                trend: '+23%',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _OverviewCard(
                title: 'Warehouses',
                value: '8',
                icon: Icons.warehouse,
                color: Colors.purple,
                trend: '0%',
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Map view placeholder
        Card(
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    size: 64,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Live Tracking Map',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Real-time shipment tracking across all routes',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Shipments table
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Shipments',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('New Shipment'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Tracking #')),
                      DataColumn(label: Text('Origin')),
                      DataColumn(label: Text('Destination')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('ETA')),
                      DataColumn(label: Text('Carrier')),
                    ],
                    rows: [
                      _buildShipmentRow('TRK-001234', 'New York', 'Los Angeles', 'In Transit', '2 days', 'FedEx'),
                      _buildShipmentRow('TRK-001235', 'Chicago', 'Miami', 'Delivered', 'Completed', 'UPS'),
                      _buildShipmentRow('TRK-001236', 'Seattle', 'Boston', 'Processing', '4 days', 'DHL'),
                      _buildShipmentRow('TRK-001237', 'Dallas', 'Denver', 'In Transit', '1 day', 'USPS'),
                      _buildShipmentRow('TRK-001238', 'Phoenix', 'Portland', 'Delayed', '3 days', 'FedEx'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Warehouse inventory
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Warehouse Inventory',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      _buildInventoryItem('Los Angeles Warehouse', 85),
                      _buildInventoryItem('New York Warehouse', 72),
                      _buildInventoryItem('Chicago Warehouse', 93),
                      _buildInventoryItem('Miami Warehouse', 67),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Actions',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      _buildQuickAction(context, Icons.qr_code_scanner, 'Scan Package'),
                      _buildQuickAction(context, Icons.inventory, 'Update Inventory'),
                      _buildQuickAction(context, Icons.route, 'Plan Route'),
                      _buildQuickAction(context, Icons.analytics, 'View Reports'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  DataRow _buildShipmentRow(String tracking, String origin, String destination, String status, String eta, String carrier) {
    Color statusColor = Colors.grey;
    IconData statusIcon = Icons.info;
    
    switch (status) {
      case 'In Transit':
        statusColor = Colors.blue;
        statusIcon = Icons.local_shipping;
        break;
      case 'Delivered':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'Processing':
        statusColor = Colors.orange;
        statusIcon = Icons.access_time;
        break;
      case 'Delayed':
        statusColor = Colors.red;
        statusIcon = Icons.warning;
        break;
    }

    return DataRow(
      cells: [
        DataCell(Text(tracking, style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(origin)),
        DataCell(Text(destination)),
        DataCell(
          Row(
            children: [
              Icon(statusIcon, size: 16, color: statusColor),
              const SizedBox(width: 4),
              Text(status, style: TextStyle(color: statusColor)),
            ],
          ),
        ),
        DataCell(Text(eta)),
        DataCell(Text(carrier)),
      ],
    );
  }

  Widget _buildInventoryItem(String warehouse, int percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(warehouse),
              Text('$percentage%', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
              percentage > 80 ? Colors.green : percentage > 60 ? Colors.orange : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        onTap: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        ),
        tileColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
      ),
    );
  }
}

/// Logistics module header
class LogisticsHeader extends StatelessWidget {
  const LogisticsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardSectionHeader(
      title: 'Logistics Management',
      subtitle: 'Track shipments, manage inventory, and optimize routes',
      actions: [
        OutlinedButton.icon(
          onPressed: () => context.go('/modules'),
          icon: const Icon(Icons.arrow_back),
          label: const Text('Back to Modules'),
        ),
        const SizedBox(width: 12),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.qr_code_scanner),
          label: const Text('Scan Package'),
        ),
      ],
    );
  }
}

/// Overview card widget
class _OverviewCard extends StatelessWidget {
  const _OverviewCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.trend,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String trend;

  @override
  Widget build(BuildContext context) {
    final isPositive = trend.startsWith('+');
    final trendColor = isPositive ? Colors.green : trend == '0%' ? Colors.grey : Colors.red;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: trendColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    trend,
                    style: TextStyle(
                      color: trendColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}