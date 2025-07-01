import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import '../models/table_models.dart';
import 'package:csv/csv.dart';
import 'dart:convert';

// Table data provider
final tableDataProvider = StateNotifierProvider.family<TableDataNotifier, TableData, String>(
  (ref, tableId) => TableDataNotifier(tableId),
);

class TableDataNotifier extends StateNotifier<TableData> {
  TableDataNotifier(String tableId) : super(_getInitialTableData(tableId));
  
  // Sort table
  void sort(String field, {bool multiSort = false}) {
    SortConfig newSortConfig;
    
    if (multiSort && state.sortConfig?.multiSort == true) {
      // Multi-sort logic
      final sortItems = List<SortItem>.from(state.sortConfig?.sortItems ?? []);
      final existingIndex = sortItems.indexWhere((item) => item.field == field);
      
      if (existingIndex >= 0) {
        // Toggle direction or remove
        final existing = sortItems[existingIndex];
        if (existing.direction == SortDirection.ascending) {
          sortItems[existingIndex] = existing.copyWith(direction: SortDirection.descending);
        } else {
          sortItems.removeAt(existingIndex);
        }
      } else {
        // Add new sort item
        sortItems.add(SortItem(
          field: field,
          direction: SortDirection.ascending,
          priority: sortItems.length,
        ));
      }
      
      newSortConfig = SortConfig(
        field: sortItems.isNotEmpty ? sortItems.first.field : null,
        direction: sortItems.isNotEmpty ? sortItems.first.direction : null,
        multiSort: true,
        sortItems: sortItems,
      );
    } else {
      // Single sort logic
      SortDirection? newDirection;
      
      if (state.sortConfig?.field == field) {
        // Toggle direction
        newDirection = state.sortConfig?.direction == SortDirection.ascending
            ? SortDirection.descending
            : null;
      } else {
        // New field
        newDirection = SortDirection.ascending;
      }
      
      newSortConfig = SortConfig(
        field: newDirection != null ? field : null,
        direction: newDirection,
        multiSort: false,
      );
    }
    
    // Apply sorting
    final sortedRows = _sortRows(List<TableRowData>.from(state.rows), newSortConfig);
    
    state = state.copyWith(
      rows: sortedRows,
      sortConfig: newSortConfig,
    );
  }
  
  // Filter table
  void filter(List<FilterConfig> filters) {
    // Apply filters to original data
    final filteredRows = _filterRows(_getOriginalRows(), filters);
    
    // Re-apply sorting if active
    final sortedRows = state.sortConfig != null
        ? _sortRows(filteredRows, state.sortConfig!)
        : filteredRows;
    
    // Update pagination
    final totalFiltered = sortedRows.length;
    final pagination = state.pagination?.copyWith(
      totalItems: totalFiltered,
      totalPages: (totalFiltered / (state.pagination?.pageSize ?? 10)).ceil(),
      currentPage: 1, // Reset to first page
    );
    
    state = state.copyWith(
      rows: sortedRows,
      filters: filters,
      filteredRows: totalFiltered,
      pagination: pagination,
    );
  }
  
  // Change page
  void changePage(int page) {
    if (state.pagination == null) return;
    
    final pagination = state.pagination!.copyWith(currentPage: page);
    state = state.copyWith(pagination: pagination);
  }
  
  // Change page size
  void changePageSize(int pageSize) {
    if (state.pagination == null) return;
    
    final totalPages = (state.filteredRows / pageSize).ceil();
    final currentPage = math.min(state.pagination!.currentPage, totalPages);
    
    final pagination = state.pagination!.copyWith(
      pageSize: pageSize,
      totalPages: totalPages,
      currentPage: currentPage,
    );
    
    state = state.copyWith(pagination: pagination);
  }
  
  // Select rows
  void selectRows(List<String> rowIds, {SelectionMode? mode}) {
    final selectionMode = mode ?? state.selection?.mode ?? SelectionMode.multiple;
    
    List<String> newSelectedIds;
    
    switch (selectionMode) {
      case SelectionMode.none:
        newSelectedIds = [];
        break;
      case SelectionMode.single:
        newSelectedIds = rowIds.take(1).toList();
        break;
      case SelectionMode.multiple:
        newSelectedIds = rowIds;
        break;
    }
    
    // Update row selection state
    final updatedRows = state.rows.map((row) {
      final isSelected = newSelectedIds.contains(row.id);
      return row.copyWith(selected: isSelected);
    }).toList();
    
    final selection = (state.selection ?? const SelectionConfig()).copyWith(
      selectedIds: newSelectedIds,
    );
    
    state = state.copyWith(
      rows: updatedRows,
      selection: selection,
    );
    
    // Trigger callback
    selection.onSelectionChanged?.call(newSelectedIds);
  }
  
  // Toggle row selection
  void toggleRowSelection(String rowId) {
    final currentSelection = state.selection?.selectedIds ?? [];
    final isSelected = currentSelection.contains(rowId);
    
    List<String> newSelection;
    
    if (state.selection?.mode == SelectionMode.single) {
      newSelection = isSelected ? [] : [rowId];
    } else {
      newSelection = isSelected
          ? currentSelection.where((id) => id != rowId).toList()
          : [...currentSelection, rowId];
    }
    
    selectRows(newSelection);
  }
  
  // Select all rows
  void selectAll() {
    if (state.selection?.mode == SelectionMode.none) return;
    
    final allIds = state.rows.map((row) => row.id).toList();
    selectRows(allIds);
  }
  
  // Clear selection
  void clearSelection() {
    selectRows([]);
  }
  
  // Update cell value
  void updateCell(String rowId, String field, dynamic value) {
    final updatedRows = state.rows.map((row) {
      if (row.id == rowId) {
        final newData = Map<String, dynamic>.from(row.data);
        newData[field] = value;
        return row.copyWith(data: newData, editing: false);
      }
      return row;
    }).toList();
    
    state = state.copyWith(rows: updatedRows);
  }
  
  // Start editing cell
  void startEditingCell(String rowId, String field) {
    final updatedRows = state.rows.map((row) {
      return row.copyWith(editing: row.id == rowId);
    }).toList();
    
    state = state.copyWith(rows: updatedRows);
  }
  
  // Cancel editing
  void cancelEditing() {
    final updatedRows = state.rows.map((row) {
      return row.copyWith(editing: false);
    }).toList();
    
    state = state.copyWith(rows: updatedRows);
  }
  
  // Toggle column visibility
  void toggleColumnVisibility(String columnId) {
    final updatedColumns = state.columns.map((col) {
      if (col.id == columnId) {
        return col.copyWith(visible: !col.visible);
      }
      return col;
    }).toList();
    
    state = state.copyWith(columns: updatedColumns);
  }
  
  // Reorder rows (drag and drop)
  void reorderRows(int oldIndex, int newIndex) {
    final rows = List<TableRowData>.from(state.rows);
    
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    
    final row = rows.removeAt(oldIndex);
    rows.insert(newIndex, row);
    
    state = state.copyWith(rows: rows);
  }
  
  // Expand/collapse row
  void toggleRowExpansion(String rowId) {
    final updatedRows = state.rows.map((row) {
      if (row.id == rowId) {
        return row.copyWith(expanded: !row.expanded);
      }
      return row;
    }).toList();
    
    state = state.copyWith(rows: updatedRows);
  }
  
  // Group by field
  void groupBy(String? field) {
    if (field == null) {
      state = state.copyWith(groupConfig: null);
      return;
    }
    
    final groupConfig = GroupConfig(
      field: field,
      collapsible: true,
      expandedGroups: {},
    );
    
    state = state.copyWith(groupConfig: groupConfig);
  }
  
  // Toggle group expansion
  void toggleGroupExpansion(String groupKey) {
    if (state.groupConfig == null) return;
    
    final expandedGroups = Map<String, bool>.from(state.groupConfig!.expandedGroups);
    expandedGroups[groupKey] = !(expandedGroups[groupKey] ?? true);
    
    final groupConfig = state.groupConfig!.copyWith(expandedGroups: expandedGroups);
    state = state.copyWith(groupConfig: groupConfig);
  }
  
  // Export table data
  String exportData(ExportConfig config) {
    final visibleColumns = state.columns.where((col) => col.visible).toList();
    final columnsToExport = config.selectedColumns != null
        ? visibleColumns.where((col) => config.selectedColumns!.contains(col.id)).toList()
        : visibleColumns;
    
    switch (config.format) {
      case ExportFormat.csv:
        return _exportToCsv(columnsToExport, config);
      case ExportFormat.json:
        return _exportToJson(columnsToExport, config);
      default:
        throw UnimplementedError('Export format ${config.format} not implemented');
    }
  }
  
  // Helper methods
  List<TableRowData> _sortRows(List<TableRowData> rows, SortConfig sortConfig) {
    if (sortConfig.field == null) return rows;
    
    final sortedRows = List<TableRowData>.from(rows);
    
    if (sortConfig.multiSort && sortConfig.sortItems != null) {
      // Multi-column sort
      sortedRows.sort((a, b) {
        for (final sortItem in sortConfig.sortItems!) {
          final aValue = a.data[sortItem.field];
          final bValue = b.data[sortItem.field];
          final comparison = _compareValues(aValue, bValue);
          
          if (comparison != 0) {
            return sortItem.direction == SortDirection.ascending
                ? comparison
                : -comparison;
          }
        }
        return 0;
      });
    } else {
      // Single column sort
      sortedRows.sort((a, b) {
        final aValue = a.data[sortConfig.field!];
        final bValue = b.data[sortConfig.field!];
        final comparison = _compareValues(aValue, bValue);
        
        return sortConfig.direction == SortDirection.ascending
            ? comparison
            : -comparison;
      });
    }
    
    return sortedRows;
  }
  
  int _compareValues(dynamic a, dynamic b) {
    // Handle null values
    if (a == null && b == null) return 0;
    if (a == null) return -1;
    if (b == null) return 1;
    
    // Compare by type
    if (a is num && b is num) {
      return a.compareTo(b);
    } else if (a is DateTime && b is DateTime) {
      return a.compareTo(b);
    } else if (a is bool && b is bool) {
      return a == b ? 0 : (a ? 1 : -1);
    } else {
      // Convert to string and compare
      return a.toString().compareTo(b.toString());
    }
  }
  
  List<TableRowData> _filterRows(List<TableRowData> rows, List<FilterConfig> filters) {
    if (filters.isEmpty) return rows;
    
    return rows.where((row) {
      for (final filter in filters) {
        if (!_matchesFilter(row.data[filter.field], filter)) {
          return false;
        }
      }
      return true;
    }).toList();
  }
  
  bool _matchesFilter(dynamic value, FilterConfig filter) {
    switch (filter.type) {
      case FilterType.text:
        final searchTerm = filter.value?.toString().toLowerCase() ?? '';
        final fieldValue = value?.toString().toLowerCase() ?? '';
        return fieldValue.contains(searchTerm);
        
      case FilterType.number:
        if (value is! num) return false;
        final filterValue = filter.value as num?;
        final min = filter.min as num?;
        final max = filter.max as num?;
        
        if (filterValue != null) {
          switch (filter.operator) {
            case '=':
              return value == filterValue;
            case '!=':
              return value != filterValue;
            case '>':
              return value > filterValue;
            case '>=':
              return value >= filterValue;
            case '<':
              return value < filterValue;
            case '<=':
              return value <= filterValue;
            default:
              return value == filterValue;
          }
        }
        
        if (min != null && value < min) return false;
        if (max != null && value > max) return false;
        return true;
        
      case FilterType.date:
      case FilterType.dateRange:
        if (value is! DateTime) return false;
        final min = filter.min as DateTime?;
        final max = filter.max as DateTime?;
        
        if (min != null && value.isBefore(min)) return false;
        if (max != null && value.isAfter(max)) return false;
        return true;
        
      case FilterType.select:
      case FilterType.multiSelect:
        final selectedValues = filter.value is List
            ? filter.value as List
            : [filter.value];
        return selectedValues.isEmpty || selectedValues.contains(value);
        
      case FilterType.boolean:
        return filter.value == null || value == filter.value;
        
      case FilterType.custom:
        // Custom filter logic would be implemented here
        return true;
    }
  }
  
  List<TableRowData> _getOriginalRows() {
    // This would normally fetch from a data source
    // For now, return the current rows
    return state.rows;
  }
  
  String _exportToCsv(List<TableColumn> columns, ExportConfig config) {
    final rows = <List<dynamic>>[];
    
    // Add headers
    if (config.includeHeaders) {
      rows.add(columns.map((col) => col.label).toList());
    }
    
    // Add data rows
    for (final row in state.rows) {
      final rowData = columns.map((col) {
        final value = row.data[col.field];
        if (col.formatter != null) {
          return col.formatter!(value);
        }
        return value?.toString() ?? '';
      }).toList();
      rows.add(rowData);
    }
    
    return const ListToCsvConverter().convert(rows);
  }
  
  String _exportToJson(List<TableColumn> columns, ExportConfig config) {
    final data = state.rows.map((row) {
      final rowData = <String, dynamic>{};
      for (final col in columns) {
        final fieldName = config.columnMapping?[col.id] ?? col.field;
        rowData[fieldName] = row.data[col.field];
      }
      return rowData;
    }).toList();
    
    final exportData = <String, dynamic>{
      'data': data,
    };
    
    if (config.includeFilters && state.filters != null) {
      exportData['filters'] = state.filters!.map((f) => {
        'field': f.field,
        'type': f.type.toString(),
        'value': f.value,
      }).toList();
    }
    
    if (config.includeSummary) {
      exportData['summary'] = {
        'totalRows': state.totalRows,
        'filteredRows': state.filteredRows,
        'exportDate': DateTime.now().toIso8601String(),
      };
    }
    
    return const JsonEncoder.withIndent('  ').convert(exportData);
  }
  
  static TableData _getInitialTableData(String tableId) {
    // This would normally fetch from a data source
    // For now, return mock data based on tableId
    switch (tableId) {
      case 'users':
        return _createUserTableData();
      case 'products':
        return _createProductTableData();
      case 'orders':
        return _createOrderTableData();
      case 'invoices':
        return _createInvoiceTableData();
      default:
        return _createBasicTableData();
    }
  }
  
  static TableData _createUserTableData() {
    final columns = [
      const TableColumn(
        id: 'avatar',
        field: 'avatar',
        label: '',
        type: ColumnType.avatar,
        sortable: false,
        filterable: false,
        width: 50,
      ),
      const TableColumn(
        id: 'name',
        field: 'name',
        label: 'Name',
        type: ColumnType.text,
      ),
      const TableColumn(
        id: 'email',
        field: 'email',
        label: 'Email',
        type: ColumnType.text,
      ),
      const TableColumn(
        id: 'role',
        field: 'role',
        label: 'Role',
        type: ColumnType.badge,
        format: ColumnFormat(
          badgeConfig: {
            'admin': BadgeConfig(
              backgroundColor: Colors.purple,
              textColor: Colors.white,
              label: 'Admin',
            ),
            'user': BadgeConfig(
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              label: 'User',
            ),
            'guest': BadgeConfig(
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              label: 'Guest',
            ),
          },
        ),
      ),
      const TableColumn(
        id: 'status',
        field: 'status',
        label: 'Status',
        type: ColumnType.status,
        format: ColumnFormat(
          statusConfig: {
            'active': StatusConfig(
              color: Colors.green,
              label: 'Active',
              icon: Icons.check_circle,
            ),
            'inactive': StatusConfig(
              color: Colors.orange,
              label: 'Inactive',
              icon: Icons.pause_circle,
            ),
            'banned': StatusConfig(
              color: Colors.red,
              label: 'Banned',
              icon: Icons.block,
            ),
          },
        ),
      ),
      const TableColumn(
        id: 'createdAt',
        field: 'createdAt',
        label: 'Created',
        type: ColumnType.date,
        format: ColumnFormat(dateFormat: 'MMM dd, yyyy'),
      ),
      const TableColumn(
        id: 'actions',
        field: 'actions',
        label: 'Actions',
        type: ColumnType.actions,
        sortable: false,
        filterable: false,
        width: 100,
      ),
    ];
    
    final rows = List.generate(50, (index) {
      final roles = ['admin', 'user', 'guest'];
      final statuses = ['active', 'inactive', 'banned'];
      
      return TableRowData(
        id: 'user_$index',
        data: {
          'avatar': 'https://i.pravatar.cc/150?img=$index',
          'name': 'User ${index + 1}',
          'email': 'user${index + 1}@example.com',
          'role': roles[index % roles.length],
          'status': statuses[index % statuses.length],
          'createdAt': DateTime.now().subtract(Duration(days: index * 7)),
        },
      );
    });
    
    return TableData(
      columns: columns,
      rows: rows,
      totalRows: rows.length,
      filteredRows: rows.length,
      pagination: PaginationConfig(
        currentPage: 1,
        pageSize: 10,
        totalPages: (rows.length / 10).ceil(),
        totalItems: rows.length,
      ),
      selection: const SelectionConfig(
        mode: SelectionMode.multiple,
        showCheckboxes: true,
      ),
    );
  }
  
  static TableData _createProductTableData() {
    final columns = [
      const TableColumn(
        id: 'image',
        field: 'image',
        label: 'Image',
        type: ColumnType.image,
        sortable: false,
        filterable: false,
        width: 80,
      ),
      const TableColumn(
        id: 'name',
        field: 'name',
        label: 'Product Name',
        type: ColumnType.text,
      ),
      const TableColumn(
        id: 'sku',
        field: 'sku',
        label: 'SKU',
        type: ColumnType.text,
      ),
      const TableColumn(
        id: 'category',
        field: 'category',
        label: 'Category',
        type: ColumnType.text,
      ),
      const TableColumn(
        id: 'price',
        field: 'price',
        label: 'Price',
        type: ColumnType.currency,
        format: ColumnFormat(
          currencySymbol: r'$',
          decimalPlaces: 2,
        ),
      ),
      const TableColumn(
        id: 'stock',
        field: 'stock',
        label: 'Stock',
        type: ColumnType.number,
      ),
      const TableColumn(
        id: 'rating',
        field: 'rating',
        label: 'Rating',
        type: ColumnType.rating,
      ),
      const TableColumn(
        id: 'status',
        field: 'status',
        label: 'Status',
        type: ColumnType.badge,
        format: ColumnFormat(
          badgeConfig: {
            'available': BadgeConfig(
              backgroundColor: Colors.green,
              textColor: Colors.white,
              label: 'Available',
            ),
            'low_stock': BadgeConfig(
              backgroundColor: Colors.orange,
              textColor: Colors.white,
              label: 'Low Stock',
            ),
            'out_of_stock': BadgeConfig(
              backgroundColor: Colors.red,
              textColor: Colors.white,
              label: 'Out of Stock',
            ),
          },
        ),
      ),
    ];
    
    final categories = ['Electronics', 'Clothing', 'Home', 'Books', 'Toys'];
    final random = math.Random();
    
    final rows = List.generate(100, (index) {
      final stock = random.nextInt(100);
      String status;
      if (stock == 0) {
        status = 'out_of_stock';
      } else if (stock < 10) {
        status = 'low_stock';
      } else {
        status = 'available';
      }
      
      return TableRowData(
        id: 'product_$index',
        data: {
          'image': 'https://picsum.photos/80/80?random=$index',
          'name': 'Product ${index + 1}',
          'sku': 'SKU-${(index + 1000).toString().padLeft(4, '0')}',
          'category': categories[index % categories.length],
          'price': 19.99 + (index * 10),
          'stock': stock,
          'rating': 3.5 + (random.nextDouble() * 1.5),
          'status': status,
        },
      );
    });
    
    return TableData(
      columns: columns,
      rows: rows,
      totalRows: rows.length,
      filteredRows: rows.length,
      pagination: PaginationConfig(
        currentPage: 1,
        pageSize: 25,
        totalPages: (rows.length / 25).ceil(),
        totalItems: rows.length,
      ),
    );
  }
  
  static TableData _createOrderTableData() {
    final columns = [
      const TableColumn(
        id: 'orderNumber',
        field: 'orderNumber',
        label: 'Order #',
        type: ColumnType.text,
      ),
      const TableColumn(
        id: 'customer',
        field: 'customer',
        label: 'Customer',
        type: ColumnType.text,
      ),
      const TableColumn(
        id: 'orderDate',
        field: 'orderDate',
        label: 'Order Date',
        type: ColumnType.dateTime,
        format: ColumnFormat(dateFormat: 'MMM dd, yyyy HH:mm'),
      ),
      const TableColumn(
        id: 'total',
        field: 'total',
        label: 'Total',
        type: ColumnType.currency,
        format: ColumnFormat(
          currencySymbol: r'$',
          decimalPlaces: 2,
        ),
      ),
      const TableColumn(
        id: 'status',
        field: 'status',
        label: 'Status',
        type: ColumnType.status,
        format: ColumnFormat(
          statusConfig: {
            'pending': StatusConfig(
              color: Colors.orange,
              label: 'Pending',
              icon: Icons.access_time,
            ),
            'processing': StatusConfig(
              color: Colors.blue,
              label: 'Processing',
              icon: Icons.sync,
            ),
            'shipped': StatusConfig(
              color: Colors.purple,
              label: 'Shipped',
              icon: Icons.local_shipping,
            ),
            'delivered': StatusConfig(
              color: Colors.green,
              label: 'Delivered',
              icon: Icons.check_circle,
            ),
            'cancelled': StatusConfig(
              color: Colors.red,
              label: 'Cancelled',
              icon: Icons.cancel,
            ),
          },
        ),
      ),
      const TableColumn(
        id: 'paymentStatus',
        field: 'paymentStatus',
        label: 'Payment',
        type: ColumnType.badge,
        format: ColumnFormat(
          badgeConfig: {
            'paid': BadgeConfig(
              backgroundColor: Colors.green,
              textColor: Colors.white,
              label: 'Paid',
            ),
            'pending': BadgeConfig(
              backgroundColor: Colors.orange,
              textColor: Colors.white,
              label: 'Pending',
            ),
            'failed': BadgeConfig(
              backgroundColor: Colors.red,
              textColor: Colors.white,
              label: 'Failed',
            ),
          },
        ),
      ),
      const TableColumn(
        id: 'shippingMethod',
        field: 'shippingMethod',
        label: 'Shipping',
        type: ColumnType.text,
      ),
    ];
    
    final statuses = ['pending', 'processing', 'shipped', 'delivered', 'cancelled'];
    final paymentStatuses = ['paid', 'pending', 'failed'];
    final shippingMethods = ['Standard', 'Express', 'Overnight'];
    final random = math.Random();
    
    final rows = List.generate(200, (index) {
      return TableRowData(
        id: 'order_$index',
        data: {
          'orderNumber': 'ORD-${(index + 10000).toString()}',
          'customer': 'Customer ${index + 1}',
          'orderDate': DateTime.now().subtract(Duration(days: index)),
          'total': 50.0 + (random.nextDouble() * 450),
          'status': statuses[random.nextInt(statuses.length)],
          'paymentStatus': paymentStatuses[random.nextInt(paymentStatuses.length)],
          'shippingMethod': shippingMethods[random.nextInt(shippingMethods.length)],
        },
      );
    });
    
    return TableData(
      columns: columns,
      rows: rows,
      totalRows: rows.length,
      filteredRows: rows.length,
      pagination: PaginationConfig(
        currentPage: 1,
        pageSize: 50,
        totalPages: (rows.length / 50).ceil(),
        totalItems: rows.length,
      ),
    );
  }
  
  static TableData _createInvoiceTableData() {
    final columns = [
      const TableColumn(
        id: 'description',
        field: 'description',
        label: 'Description',
        type: ColumnType.text,
        editable: true,
      ),
      const TableColumn(
        id: 'quantity',
        field: 'quantity',
        label: 'Qty',
        type: ColumnType.number,
        editable: true,
        width: 80,
      ),
      const TableColumn(
        id: 'unitPrice',
        field: 'unitPrice',
        label: 'Unit Price',
        type: ColumnType.currency,
        editable: true,
        format: ColumnFormat(
          currencySymbol: r'$',
          decimalPlaces: 2,
        ),
        width: 120,
      ),
      const TableColumn(
        id: 'discount',
        field: 'discount',
        label: 'Discount',
        type: ColumnType.percentage,
        editable: true,
        format: ColumnFormat(
          suffix: '%',
        ),
        width: 100,
      ),
      const TableColumn(
        id: 'tax',
        field: 'tax',
        label: 'Tax',
        type: ColumnType.percentage,
        editable: true,
        format: ColumnFormat(
          suffix: '%',
        ),
        width: 80,
      ),
      const TableColumn(
        id: 'total',
        field: 'total',
        label: 'Total',
        type: ColumnType.currency,
        format: ColumnFormat(
          currencySymbol: r'$',
          decimalPlaces: 2,
        ),
        width: 120,
      ),
      const TableColumn(
        id: 'actions',
        field: 'actions',
        label: '',
        type: ColumnType.actions,
        sortable: false,
        filterable: false,
        width: 50,
      ),
    ];
    
    final rows = [
      TableRowData(
        id: 'invoice_1',
        data: {
          'description': 'Web Development Services',
          'quantity': 40,
          'unitPrice': 75.00,
          'discount': 10,
          'tax': 8.25,
          'total': 2929.50,
        },
      ),
      TableRowData(
        id: 'invoice_2',
        data: {
          'description': 'Mobile App Development',
          'quantity': 80,
          'unitPrice': 100.00,
          'discount': 15,
          'tax': 8.25,
          'total': 7361.00,
        },
      ),
      TableRowData(
        id: 'invoice_3',
        data: {
          'description': 'UI/UX Design',
          'quantity': 20,
          'unitPrice': 50.00,
          'discount': 0,
          'tax': 8.25,
          'total': 1082.50,
        },
      ),
    ];
    
    return TableData(
      columns: columns,
      rows: rows,
      totalRows: rows.length,
      filteredRows: rows.length,
    );
  }
  
  static TableData _createBasicTableData() {
    final columns = [
      const TableColumn(
        id: 'id',
        field: 'id',
        label: 'ID',
        type: ColumnType.text,
        width: 80,
      ),
      const TableColumn(
        id: 'name',
        field: 'name',
        label: 'Name',
        type: ColumnType.text,
      ),
      const TableColumn(
        id: 'value',
        field: 'value',
        label: 'Value',
        type: ColumnType.number,
      ),
      const TableColumn(
        id: 'progress',
        field: 'progress',
        label: 'Progress',
        type: ColumnType.progress,
      ),
      const TableColumn(
        id: 'status',
        field: 'status',
        label: 'Status',
        type: ColumnType.boolean,
      ),
    ];
    
    final rows = List.generate(20, (index) {
      return TableRowData(
        id: 'row_$index',
        data: {
          'id': index + 1,
          'name': 'Item ${index + 1}',
          'value': (index + 1) * 10,
          'progress': (index + 1) * 5,
          'status': index % 2 == 0,
        },
      );
    });
    
    return TableData(
      columns: columns,
      rows: rows,
      totalRows: rows.length,
      filteredRows: rows.length,
    );
  }
}

// Table settings provider
final tableSettingsProvider = StateProvider.family<TableSettings, String>(
  (ref, tableId) => const TableSettings(),
);

// Bulk actions provider
final bulkActionsProvider = Provider.family<List<BulkAction>, String>(
  (ref, tableId) {
    switch (tableId) {
      case 'users':
        return [
          BulkAction(
            id: 'activate',
            label: 'Activate',
            icon: Icons.check_circle,
            onAction: (selectedIds) {
              // Handle activation
              debugPrint('Activating users: $selectedIds');
            },
          ),
          BulkAction(
            id: 'deactivate',
            label: 'Deactivate',
            icon: Icons.pause_circle,
            onAction: (selectedIds) {
              // Handle deactivation
              debugPrint('Deactivating users: $selectedIds');
            },
          ),
          BulkAction(
            id: 'delete',
            label: 'Delete',
            icon: Icons.delete,
            onAction: (selectedIds) {
              // Handle deletion
              debugPrint('Deleting users: $selectedIds');
            },
            requireConfirmation: true,
            confirmationMessage: 'Are you sure you want to delete the selected users?',
          ),
        ];
        
      case 'products':
        return [
          BulkAction(
            id: 'publish',
            label: 'Publish',
            icon: Icons.publish,
            onAction: (selectedIds) {
              debugPrint('Publishing products: $selectedIds');
            },
          ),
          BulkAction(
            id: 'unpublish',
            label: 'Unpublish',
            icon: Icons.unpublished,
            onAction: (selectedIds) {
              debugPrint('Unpublishing products: $selectedIds');
            },
          ),
          BulkAction(
            id: 'duplicate',
            label: 'Duplicate',
            icon: Icons.copy,
            onAction: (selectedIds) {
              debugPrint('Duplicating products: $selectedIds');
            },
          ),
        ];
        
      case 'orders':
        return [
          BulkAction(
            id: 'mark_shipped',
            label: 'Mark as Shipped',
            icon: Icons.local_shipping,
            onAction: (selectedIds) {
              debugPrint('Marking orders as shipped: $selectedIds');
            },
          ),
          BulkAction(
            id: 'cancel',
            label: 'Cancel Orders',
            icon: Icons.cancel,
            onAction: (selectedIds) {
              debugPrint('Cancelling orders: $selectedIds');
            },
            requireConfirmation: true,
          ),
          BulkAction(
            id: 'export',
            label: 'Export',
            icon: Icons.download,
            onAction: (selectedIds) {
              debugPrint('Exporting orders: $selectedIds');
            },
          ),
        ];
        
      default:
        return [];
    }
  },
);