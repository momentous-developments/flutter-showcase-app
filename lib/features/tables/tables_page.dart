import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/base_scaffold.dart';
import 'widgets/basic_tables/data_table_widget.dart';
import 'widgets/basic_tables/sortable_table.dart';
import 'widgets/basic_tables/filterable_table.dart';
import 'widgets/basic_tables/paginated_table.dart';
import 'widgets/basic_tables/selectable_table.dart';
import 'widgets/basic_tables/expandable_table.dart';
import 'widgets/advanced_tables/editable_table.dart';
import 'widgets/advanced_tables/drag_drop_table.dart';
import 'widgets/advanced_tables/grouped_table.dart';
import 'widgets/advanced_tables/tree_table.dart';
import 'widgets/advanced_tables/virtualized_table.dart';
import 'widgets/advanced_tables/exportable_table.dart';
import 'widgets/specialized_tables/invoice_table.dart';
import 'widgets/specialized_tables/product_table.dart';
import 'widgets/specialized_tables/user_table.dart';
import 'widgets/specialized_tables/order_table.dart';
import 'widgets/specialized_tables/report_table.dart';

class TablesPage extends ConsumerStatefulWidget {
  const TablesPage({super.key});

  @override
  ConsumerState<TablesPage> createState() => _TablesPageState();
}

class _TablesPageState extends ConsumerState<TablesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tables'),
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: const [
                Tab(text: 'Basic Tables'),
                Tab(text: 'Advanced Tables'),
                Tab(text: 'Specialized Tables'),
                Tab(text: 'Features'),
              ],
            ),
          ),
          
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Basic Tables Tab
                _buildBasicTablesTab(),
                
                // Advanced Tables Tab
                _buildAdvancedTablesTab(),
                
                // Specialized Tables Tab
                _buildSpecializedTablesTab(),
                
                // Features Tab
                _buildFeaturesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBasicTablesTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSectionTitle('Basic Table Types'),
        const SizedBox(height: 16),
        
        // Data Table
        _buildTableCard(
          title: 'Basic Data Table',
          description: 'Simple table for displaying structured data',
          child: const DataTableWidget(tableId: 'basic'),
        ),
        
        const SizedBox(height: 24),
        
        // Sortable Table
        _buildTableCard(
          title: 'Sortable Table',
          description: 'Table with column sorting capabilities',
          child: const SortableTable(tableId: 'basic'),
        ),
        
        const SizedBox(height: 24),
        
        // Filterable Table
        _buildTableCard(
          title: 'Filterable Table',
          description: 'Table with advanced filtering options',
          child: const FilterableTable(tableId: 'products'),
        ),
        
        const SizedBox(height: 24),
        
        // Paginated Table
        _buildTableCard(
          title: 'Paginated Table',
          description: 'Table with pagination for large datasets',
          child: const PaginatedTable(tableId: 'users'),
        ),
        
        const SizedBox(height: 24),
        
        // Selectable Table
        _buildTableCard(
          title: 'Selectable Table',
          description: 'Table with row selection and bulk actions',
          child: const SelectableTable(tableId: 'users'),
        ),
        
        const SizedBox(height: 24),
        
        // Expandable Table
        _buildTableCard(
          title: 'Expandable Table',
          description: 'Table with expandable rows for additional details',
          child: const ExpandableTable(tableId: 'orders'),
        ),
      ],
    );
  }
  
  Widget _buildAdvancedTablesTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSectionTitle('Advanced Table Types'),
        const SizedBox(height: 16),
        
        // Editable Table
        _buildTableCard(
          title: 'Editable Table',
          description: 'Table with inline editing capabilities',
          child: const EditableTable(tableId: 'invoices'),
        ),
        
        const SizedBox(height: 24),
        
        // Drag & Drop Table
        _buildTableCard(
          title: 'Drag & Drop Table',
          description: 'Table with row reordering via drag and drop',
          child: const DragDropTable(tableId: 'basic'),
        ),
        
        const SizedBox(height: 24),
        
        // Grouped Table
        _buildTableCard(
          title: 'Grouped Table',
          description: 'Table with row grouping by column values',
          child: const GroupedTable(tableId: 'products'),
        ),
        
        const SizedBox(height: 24),
        
        // Tree Table
        _buildTableCard(
          title: 'Tree Table',
          description: 'Hierarchical table with parent-child relationships',
          child: const TreeTable(tableId: 'tree'),
        ),
        
        const SizedBox(height: 24),
        
        // Virtualized Table
        _buildTableCard(
          title: 'Virtualized Table',
          description: 'Performance-optimized table for massive datasets',
          child: const VirtualizedTable(tableId: 'virtualized'),
        ),
        
        const SizedBox(height: 24),
        
        // Exportable Table
        _buildTableCard(
          title: 'Exportable Table',
          description: 'Table with export to CSV, Excel, and PDF',
          child: const ExportableTable(tableId: 'orders'),
        ),
      ],
    );
  }
  
  Widget _buildSpecializedTablesTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSectionTitle('Specialized Table Types'),
        const SizedBox(height: 16),
        
        // Invoice Table
        _buildTableCard(
          title: 'Invoice Table',
          description: 'Specialized table for invoice line items with calculations',
          child: const InvoiceTable(tableId: 'invoices'),
        ),
        
        const SizedBox(height: 24),
        
        // Product Table
        _buildTableCard(
          title: 'Product Table',
          description: 'E-commerce product catalog with images and status',
          child: const ProductTable(tableId: 'products'),
        ),
        
        const SizedBox(height: 24),
        
        // User Table
        _buildTableCard(
          title: 'User Table',
          description: 'User management table with avatars and roles',
          child: const UserTable(tableId: 'users'),
        ),
        
        const SizedBox(height: 24),
        
        // Order Table
        _buildTableCard(
          title: 'Order Table',
          description: 'Order management with status tracking',
          child: const OrderTable(tableId: 'orders'),
        ),
        
        const SizedBox(height: 24),
        
        // Report Table
        _buildTableCard(
          title: 'Report Table',
          description: 'Analytics report table with metrics and dimensions',
          child: const ReportTable(tableId: 'reports'),
        ),
      ],
    );
  }
  
  Widget _buildFeaturesTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSectionTitle('Table Features'),
        const SizedBox(height: 16),
        
        _buildFeatureSection(
          title: 'Column Features',
          features: [
            _buildFeatureItem('Column Resizing', Icons.swap_horiz),
            _buildFeatureItem('Column Visibility Toggle', Icons.visibility),
            _buildFeatureItem('Column Reordering', Icons.reorder),
            _buildFeatureItem('Fixed Columns', Icons.push_pin),
            _buildFeatureItem('Custom Cell Renderers', Icons.widgets),
          ],
        ),
        
        const SizedBox(height: 24),
        
        _buildFeatureSection(
          title: 'Data Features',
          features: [
            _buildFeatureItem('Advanced Filtering', Icons.filter_list),
            _buildFeatureItem('Multi-column Sorting', Icons.sort),
            _buildFeatureItem('Search Functionality', Icons.search),
            _buildFeatureItem('Data Validation', Icons.check_circle),
            _buildFeatureItem('Real-time Updates', Icons.update),
          ],
        ),
        
        const SizedBox(height: 24),
        
        _buildFeatureSection(
          title: 'Interaction Features',
          features: [
            _buildFeatureItem('Row Selection', Icons.check_box),
            _buildFeatureItem('Bulk Actions', Icons.checklist),
            _buildFeatureItem('Inline Editing', Icons.edit),
            _buildFeatureItem('Context Menus', Icons.more_vert),
            _buildFeatureItem('Keyboard Navigation', Icons.keyboard),
          ],
        ),
        
        const SizedBox(height: 24),
        
        _buildFeatureSection(
          title: 'Export & Import',
          features: [
            _buildFeatureItem('Export to CSV', Icons.file_download),
            _buildFeatureItem('Export to Excel', Icons.table_chart),
            _buildFeatureItem('Export to PDF', Icons.picture_as_pdf),
            _buildFeatureItem('Import from CSV', Icons.file_upload),
            _buildFeatureItem('Print Functionality', Icons.print),
          ],
        ),
        
        const SizedBox(height: 24),
        
        _buildFeatureSection(
          title: 'Performance',
          features: [
            _buildFeatureItem('Virtual Scrolling', Icons.speed),
            _buildFeatureItem('Lazy Loading', Icons.hourglass_empty),
            _buildFeatureItem('Data Caching', Icons.cached),
            _buildFeatureItem('Optimized Rendering', Icons.flash_on),
            _buildFeatureItem('Progressive Loading', Icons.pending),
          ],
        ),
      ],
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
  
  Widget _buildTableCard({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          child,
        ],
      ),
    );
  }
  
  Widget _buildFeatureSection({
    required String title,
    required List<Widget> features,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: features,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFeatureItem(String label, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
      ),
    );
  }
}