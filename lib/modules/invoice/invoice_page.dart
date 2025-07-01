import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/layouts/dashboard_layout.dart';
import '../../core/constants/app_constants.dart';

/// Invoice management module page
class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      header: const InvoiceHeader(),
      children: [
        // Quick stats
        Row(
          children: const [
            Expanded(
              child: _StatCard(
                title: 'Total Invoices',
                value: '1,234',
                icon: Icons.receipt_long,
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                title: 'Paid',
                value: '892',
                icon: Icons.check_circle,
                color: Colors.green,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                title: 'Pending',
                value: '342',
                icon: Icons.pending,
                color: Colors.orange,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                title: 'Total Revenue',
                value: '\$125,430',
                icon: Icons.attach_money,
                color: Colors.purple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        
        // Recent invoices
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
                      'Recent Invoices',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('New Invoice'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Invoice #')),
                      DataColumn(label: Text('Client')),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Amount')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: [
                      _buildInvoiceRow('INV-001', 'Acme Corp', '2024-01-15', '\$5,230', 'Paid', Colors.green),
                      _buildInvoiceRow('INV-002', 'Tech Solutions', '2024-01-18', '\$3,120', 'Pending', Colors.orange),
                      _buildInvoiceRow('INV-003', 'Global Industries', '2024-01-20', '\$8,450', 'Paid', Colors.green),
                      _buildInvoiceRow('INV-004', 'Startup Inc', '2024-01-22', '\$2,890', 'Overdue', Colors.red),
                      _buildInvoiceRow('INV-005', 'Enterprise LLC', '2024-01-25', '\$12,340', 'Pending', Colors.orange),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  DataRow _buildInvoiceRow(String invoice, String client, String date, String amount, String status, Color statusColor) {
    return DataRow(
      cells: [
        DataCell(Text(invoice, style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(client)),
        DataCell(Text(date)),
        DataCell(Text(amount)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.visibility, size: 20),
                onPressed: () {},
                tooltip: 'View',
              ),
              IconButton(
                icon: const Icon(Icons.download, size: 20),
                onPressed: () {},
                tooltip: 'Download PDF',
              ),
              IconButton(
                icon: const Icon(Icons.email, size: 20),
                onPressed: () {},
                tooltip: 'Send Email',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Invoice module header
class InvoiceHeader extends StatelessWidget {
  const InvoiceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardSectionHeader(
      title: 'Invoice Management',
      subtitle: 'Create, manage, and track all your invoices',
      actions: [
        OutlinedButton.icon(
          onPressed: () => context.go('/modules'),
          icon: const Icon(Icons.arrow_back),
          label: const Text('Back to Modules'),
        ),
        const SizedBox(width: 12),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Create Invoice'),
        ),
      ],
    );
  }
}

/// Stat card widget
class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 32),
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
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