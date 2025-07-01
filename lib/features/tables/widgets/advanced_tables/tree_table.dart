import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/table_models.dart';
import '../../providers/table_providers.dart';
import '../table_cell_renderer.dart';

class TreeTable extends ConsumerStatefulWidget {
  final String tableId;
  
  const TreeTable({
    super.key,
    required this.tableId,
  });

  @override
  ConsumerState<TreeTable> createState() => _TreeTableState();
}

class _TreeTableState extends ConsumerState<TreeTable> {
  final Set<String> _expandedNodes = {};
  
  @override
  Widget build(BuildContext context) {
    final tableData = ref.watch(tableDataProvider(widget.tableId));
    final tableSettings = ref.watch(tableSettingsProvider(widget.tableId));
    
    if (tableData.rows.isEmpty) {
      return _buildEmptyState(context);
    }
    
    final visibleColumns = tableData.columns.where((col) => col.visible).toList();
    
    // Build tree structure
    final treeNodes = _buildTreeStructure(tableData.rows);
    
    return Container(
      decoration: BoxDecoration(
        border: tableSettings.bordered
            ? Border.all(color: Theme.of(context).colorScheme.outline)
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Tree controls
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.account_tree,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Tree View',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  icon: Icon(
                    _expandedNodes.isEmpty ? Icons.unfold_more : Icons.unfold_less,
                  ),
                  label: Text(
                    _expandedNodes.isEmpty ? 'Expand All' : 'Collapse All',
                  ),
                  onPressed: () {
                    setState(() {
                      if (_expandedNodes.isEmpty) {
                        _expandedNodes.addAll(_getAllNodeIds(treeNodes));
                      } else {
                        _expandedNodes.clear();
                      }
                    });
                  },
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
                  child: _buildTable(context, treeNodes, visibleColumns, tableSettings),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  List<TreeNode> _buildTreeStructure(List<TableRowData> rows) {
    final Map<String, TreeNode> nodeMap = {};
    final List<TreeNode> rootNodes = [];
    
    // First pass: create all nodes
    for (final row in rows) {
      final node = TreeNode(
        id: row.id,
        row: row,
        children: [],
        level: 0,
      );
      nodeMap[row.id] = node;
    }
    
    // Second pass: build hierarchy
    for (final row in rows) {
      final parentId = row.data['parentId'] as String?;
      final node = nodeMap[row.id]!;
      
      if (parentId == null || !nodeMap.containsKey(parentId)) {
        rootNodes.add(node);
      } else {
        final parent = nodeMap[parentId]!;
        parent.children.add(node);
        node.level = parent.level + 1;
      }
    }
    
    return rootNodes;
  }
  
  Set<String> _getAllNodeIds(List<TreeNode> nodes) {
    final Set<String> ids = {};
    for (final node in nodes) {
      if (node.children.isNotEmpty) {
        ids.add(node.id);
        ids.addAll(_getAllNodeIds(node.children));
      }
    }
    return ids;
  }
  
  Widget _buildTable(
    BuildContext context,
    List<TreeNode> treeNodes,
    List<TableColumn> visibleColumns,
    TableSettings tableSettings,
  ) {
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
            children: visibleColumns.map((column) {
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
            }).toList(),
          ),
        ),
        
        // Tree rows
        ..._buildTreeRows(context, treeNodes, visibleColumns, tableSettings),
      ],
    );
  }
  
  List<Widget> _buildTreeRows(
    BuildContext context,
    List<TreeNode> nodes,
    List<TableColumn> visibleColumns,
    TableSettings tableSettings, {
    int level = 0,
  }) {
    final List<Widget> rows = [];
    
    for (int i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      final isExpanded = _expandedNodes.contains(node.id);
      final hasChildren = node.children.isNotEmpty;
      final isEven = rows.length % 2 == 0;
      
      // Main row
      rows.add(
        InkWell(
          onTap: hasChildren ? () {
            setState(() {
              if (isExpanded) {
                _expandedNodes.remove(node.id);
              } else {
                _expandedNodes.add(node.id);
              }
            });
          } : null,
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
              children: visibleColumns.asMap().entries.map((entry) {
                final columnIndex = entry.key;
                final column = entry.value;
                final value = node.row.data[column.field];
                
                return Container(
                  constraints: BoxConstraints(
                    minWidth: column.minWidth ?? 100,
                    maxWidth: column.maxWidth ?? 300,
                  ),
                  padding: EdgeInsets.all(tableSettings.dense ? 8 : 16),
                  child: columnIndex == 0
                      ? Row(
                          children: [
                            // Indentation
                            SizedBox(width: level * 24.0),
                            // Expand/collapse icon
                            if (hasChildren)
                              Icon(
                                isExpanded ? Icons.expand_less : Icons.expand_more,
                                size: 20,
                              )
                            else
                              const SizedBox(width: 20),
                            const SizedBox(width: 8),
                            // Node icon
                            Icon(
                              hasChildren ? Icons.folder : Icons.description,
                              size: 16,
                              color: hasChildren
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 8),
                            // Cell value
                            Expanded(
                              child: TableCellRenderer.render(
                                context: context,
                                column: column,
                                value: value,
                                row: node.row,
                              ),
                            ),
                          ],
                        )
                      : TableCellRenderer.render(
                          context: context,
                          column: column,
                          value: value,
                          row: node.row,
                        ),
                );
              }).toList(),
            ),
          ),
        ),
      );
      
      // Child rows (if expanded)
      if (hasChildren && isExpanded) {
        rows.addAll(
          _buildTreeRows(
            context,
            node.children,
            visibleColumns,
            tableSettings,
            level: level + 1,
          ),
        );
      }
    }
    
    return rows;
  }
  
  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.account_tree,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No tree data',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add hierarchical data to see tree view',
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

class TreeNode {
  final String id;
  final TableRowData row;
  final List<TreeNode> children;
  int level;
  
  TreeNode({
    required this.id,
    required this.row,
    required this.children,
    required this.level,
  });
}