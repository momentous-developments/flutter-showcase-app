// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TableColumnImpl _$$TableColumnImplFromJson(Map<String, dynamic> json) =>
    _$TableColumnImpl(
      id: json['id'] as String,
      field: json['field'] as String,
      label: json['label'] as String,
      type: $enumDecode(_$ColumnTypeEnumMap, json['type']),
      visible: json['visible'] as bool? ?? true,
      sortable: json['sortable'] as bool? ?? true,
      filterable: json['filterable'] as bool? ?? true,
      editable: json['editable'] as bool? ?? false,
      resizable: json['resizable'] as bool? ?? false,
      fixed: json['fixed'] as bool? ?? false,
      width: (json['width'] as num?)?.toDouble(),
      minWidth: (json['minWidth'] as num?)?.toDouble(),
      maxWidth: (json['maxWidth'] as num?)?.toDouble(),
      align: $enumDecodeNullable(_$TextAlignEnumMap, json['align']),
      format: json['format'] == null
          ? null
          : ColumnFormat.fromJson(json['format'] as Map<String, dynamic>),
      filterConfig: json['filterConfig'] == null
          ? null
          : FilterConfig.fromJson(json['filterConfig'] as Map<String, dynamic>),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$TableColumnImplToJson(_$TableColumnImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'field': instance.field,
      'label': instance.label,
      'type': _$ColumnTypeEnumMap[instance.type]!,
      'visible': instance.visible,
      'sortable': instance.sortable,
      'filterable': instance.filterable,
      'editable': instance.editable,
      'resizable': instance.resizable,
      'fixed': instance.fixed,
      'width': instance.width,
      'minWidth': instance.minWidth,
      'maxWidth': instance.maxWidth,
      'align': _$TextAlignEnumMap[instance.align],
      'format': instance.format,
      'filterConfig': instance.filterConfig,
      'metadata': instance.metadata,
    };

const _$ColumnTypeEnumMap = {
  ColumnType.text: 'text',
  ColumnType.number: 'number',
  ColumnType.currency: 'currency',
  ColumnType.percentage: 'percentage',
  ColumnType.date: 'date',
  ColumnType.dateTime: 'dateTime',
  ColumnType.boolean: 'boolean',
  ColumnType.select: 'select',
  ColumnType.status: 'status',
  ColumnType.badge: 'badge',
  ColumnType.image: 'image',
  ColumnType.avatar: 'avatar',
  ColumnType.rating: 'rating',
  ColumnType.progress: 'progress',
  ColumnType.actions: 'actions',
  ColumnType.custom: 'custom',
};

const _$TextAlignEnumMap = {
  TextAlign.left: 'left',
  TextAlign.right: 'right',
  TextAlign.center: 'center',
  TextAlign.justify: 'justify',
  TextAlign.start: 'start',
  TextAlign.end: 'end',
};

_$ColumnFormatImpl _$$ColumnFormatImplFromJson(Map<String, dynamic> json) =>
    _$ColumnFormatImpl(
      decimalPlaces: (json['decimalPlaces'] as num?)?.toInt(),
      thousandSeparator: json['thousandSeparator'] as String?,
      decimalSeparator: json['decimalSeparator'] as String?,
      prefix: json['prefix'] as String?,
      suffix: json['suffix'] as String?,
      dateFormat: json['dateFormat'] as String?,
      currencySymbol: json['currencySymbol'] as String?,
      currencyCode: json['currencyCode'] as String?,
      statusConfig: (json['statusConfig'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, StatusConfig.fromJson(e as Map<String, dynamic>)),
      ),
      badgeConfig: (json['badgeConfig'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, BadgeConfig.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$ColumnFormatImplToJson(_$ColumnFormatImpl instance) =>
    <String, dynamic>{
      'decimalPlaces': instance.decimalPlaces,
      'thousandSeparator': instance.thousandSeparator,
      'decimalSeparator': instance.decimalSeparator,
      'prefix': instance.prefix,
      'suffix': instance.suffix,
      'dateFormat': instance.dateFormat,
      'currencySymbol': instance.currencySymbol,
      'currencyCode': instance.currencyCode,
      'statusConfig': instance.statusConfig,
      'badgeConfig': instance.badgeConfig,
    };

_$StatusConfigImpl _$$StatusConfigImplFromJson(Map<String, dynamic> json) =>
    _$StatusConfigImpl(
      label: json['label'] as String,
    );

Map<String, dynamic> _$$StatusConfigImplToJson(_$StatusConfigImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
    };

_$BadgeConfigImpl _$$BadgeConfigImplFromJson(Map<String, dynamic> json) =>
    _$BadgeConfigImpl(
      label: json['label'] as String,
    );

Map<String, dynamic> _$$BadgeConfigImplToJson(_$BadgeConfigImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
    };

_$TableRowDataImpl _$$TableRowDataImplFromJson(Map<String, dynamic> json) =>
    _$TableRowDataImpl(
      id: json['id'] as String,
      data: json['data'] as Map<String, dynamic>,
      selected: json['selected'] as bool? ?? false,
      expanded: json['expanded'] as bool? ?? false,
      disabled: json['disabled'] as bool? ?? false,
      editing: json['editing'] as bool? ?? false,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => TableRowData.fromJson(e as Map<String, dynamic>))
          .toList(),
      parentId: json['parentId'] as String?,
      level: (json['level'] as num?)?.toInt(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$TableRowDataImplToJson(_$TableRowDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'selected': instance.selected,
      'expanded': instance.expanded,
      'disabled': instance.disabled,
      'editing': instance.editing,
      'children': instance.children,
      'parentId': instance.parentId,
      'level': instance.level,
      'metadata': instance.metadata,
    };

_$TableDataImpl _$$TableDataImplFromJson(Map<String, dynamic> json) =>
    _$TableDataImpl(
      columns: (json['columns'] as List<dynamic>)
          .map((e) => TableColumn.fromJson(e as Map<String, dynamic>))
          .toList(),
      rows: (json['rows'] as List<dynamic>)
          .map((e) => TableRowData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalRows: (json['totalRows'] as num?)?.toInt() ?? 0,
      filteredRows: (json['filteredRows'] as num?)?.toInt() ?? 0,
      pagination: json['pagination'] == null
          ? null
          : PaginationConfig.fromJson(
              json['pagination'] as Map<String, dynamic>),
      sortConfig: json['sortConfig'] == null
          ? null
          : SortConfig.fromJson(json['sortConfig'] as Map<String, dynamic>),
      filters: (json['filters'] as List<dynamic>?)
          ?.map((e) => FilterConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
      selection: json['selection'] == null
          ? null
          : SelectionConfig.fromJson(json['selection'] as Map<String, dynamic>),
      groupConfig: json['groupConfig'] == null
          ? null
          : GroupConfig.fromJson(json['groupConfig'] as Map<String, dynamic>),
      grouping: json['grouping'] == null
          ? null
          : GroupingConfig.fromJson(json['grouping'] as Map<String, dynamic>),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$TableDataImplToJson(_$TableDataImpl instance) =>
    <String, dynamic>{
      'columns': instance.columns,
      'rows': instance.rows,
      'totalRows': instance.totalRows,
      'filteredRows': instance.filteredRows,
      'pagination': instance.pagination,
      'sortConfig': instance.sortConfig,
      'filters': instance.filters,
      'selection': instance.selection,
      'groupConfig': instance.groupConfig,
      'grouping': instance.grouping,
      'metadata': instance.metadata,
    };

_$PaginationConfigImpl _$$PaginationConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$PaginationConfigImpl(
      currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
      pageSizeOptions: (json['pageSizeOptions'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [10, 25, 50, 100],
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
      totalItems: (json['totalItems'] as num?)?.toInt() ?? 0,
      showPageSizeSelector: json['showPageSizeSelector'] as bool? ?? true,
      showPageInfo: json['showPageInfo'] as bool? ?? true,
    );

Map<String, dynamic> _$$PaginationConfigImplToJson(
        _$PaginationConfigImpl instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'pageSize': instance.pageSize,
      'pageSizeOptions': instance.pageSizeOptions,
      'totalPages': instance.totalPages,
      'totalItems': instance.totalItems,
      'showPageSizeSelector': instance.showPageSizeSelector,
      'showPageInfo': instance.showPageInfo,
    };

_$SortConfigImpl _$$SortConfigImplFromJson(Map<String, dynamic> json) =>
    _$SortConfigImpl(
      field: json['field'] as String?,
      direction: $enumDecodeNullable(_$SortDirectionEnumMap, json['direction']),
      multiSort: json['multiSort'] as bool? ?? false,
      sortItems: (json['sortItems'] as List<dynamic>?)
          ?.map((e) => SortItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SortConfigImplToJson(_$SortConfigImpl instance) =>
    <String, dynamic>{
      'field': instance.field,
      'direction': _$SortDirectionEnumMap[instance.direction],
      'multiSort': instance.multiSort,
      'sortItems': instance.sortItems,
    };

const _$SortDirectionEnumMap = {
  SortDirection.ascending: 'ascending',
  SortDirection.descending: 'descending',
};

_$SortItemImpl _$$SortItemImplFromJson(Map<String, dynamic> json) =>
    _$SortItemImpl(
      field: json['field'] as String,
      direction: $enumDecode(_$SortDirectionEnumMap, json['direction']),
      priority: (json['priority'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$SortItemImplToJson(_$SortItemImpl instance) =>
    <String, dynamic>{
      'field': instance.field,
      'direction': _$SortDirectionEnumMap[instance.direction]!,
      'priority': instance.priority,
    };

_$FilterConfigImpl _$$FilterConfigImplFromJson(Map<String, dynamic> json) =>
    _$FilterConfigImpl(
      field: json['field'] as String,
      type: $enumDecode(_$FilterTypeEnumMap, json['type']),
      value: json['value'],
      operator: json['operator'] as String?,
      label: json['label'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => SelectOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      min: json['min'],
      max: json['max'],
    );

Map<String, dynamic> _$$FilterConfigImplToJson(_$FilterConfigImpl instance) =>
    <String, dynamic>{
      'field': instance.field,
      'type': _$FilterTypeEnumMap[instance.type]!,
      'value': instance.value,
      'operator': instance.operator,
      'label': instance.label,
      'options': instance.options,
      'min': instance.min,
      'max': instance.max,
    };

const _$FilterTypeEnumMap = {
  FilterType.text: 'text',
  FilterType.number: 'number',
  FilterType.date: 'date',
  FilterType.dateRange: 'dateRange',
  FilterType.select: 'select',
  FilterType.multiSelect: 'multiSelect',
  FilterType.boolean: 'boolean',
  FilterType.custom: 'custom',
};

_$SelectOptionImpl _$$SelectOptionImplFromJson(Map<String, dynamic> json) =>
    _$SelectOptionImpl(
      value: json['value'],
      label: json['label'] as String,
      disabled: json['disabled'] as bool? ?? false,
    );

Map<String, dynamic> _$$SelectOptionImplToJson(_$SelectOptionImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
      'disabled': instance.disabled,
    };

_$SelectionConfigImpl _$$SelectionConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$SelectionConfigImpl(
      mode: $enumDecodeNullable(_$SelectionModeEnumMap, json['mode']) ??
          SelectionMode.none,
      selectedIds: (json['selectedIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      showCheckboxes: json['showCheckboxes'] as bool? ?? true,
    );

Map<String, dynamic> _$$SelectionConfigImplToJson(
        _$SelectionConfigImpl instance) =>
    <String, dynamic>{
      'mode': _$SelectionModeEnumMap[instance.mode]!,
      'selectedIds': instance.selectedIds,
      'showCheckboxes': instance.showCheckboxes,
    };

const _$SelectionModeEnumMap = {
  SelectionMode.none: 'none',
  SelectionMode.single: 'single',
  SelectionMode.multiple: 'multiple',
};

_$GroupConfigImpl _$$GroupConfigImplFromJson(Map<String, dynamic> json) =>
    _$GroupConfigImpl(
      field: json['field'] as String,
      collapsible: json['collapsible'] as bool? ?? true,
      expandedGroups: (json['expandedGroups'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const {},
    );

Map<String, dynamic> _$$GroupConfigImplToJson(_$GroupConfigImpl instance) =>
    <String, dynamic>{
      'field': instance.field,
      'collapsible': instance.collapsible,
      'expandedGroups': instance.expandedGroups,
    };

_$GroupingConfigImpl _$$GroupingConfigImplFromJson(Map<String, dynamic> json) =>
    _$GroupingConfigImpl(
      groupBy: json['groupBy'] as String,
      sortGroups: json['sortGroups'] as bool? ?? true,
      showAggregates: json['showAggregates'] as bool? ?? true,
      aggregates: (json['aggregates'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, $enumDecode(_$AggregateTypeEnumMap, e)),
          ) ??
          const {},
      expandedGroups: (json['expandedGroups'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const {},
    );

Map<String, dynamic> _$$GroupingConfigImplToJson(
        _$GroupingConfigImpl instance) =>
    <String, dynamic>{
      'groupBy': instance.groupBy,
      'sortGroups': instance.sortGroups,
      'showAggregates': instance.showAggregates,
      'aggregates': instance.aggregates
          .map((k, e) => MapEntry(k, _$AggregateTypeEnumMap[e]!)),
      'expandedGroups': instance.expandedGroups,
    };

const _$AggregateTypeEnumMap = {
  AggregateType.sum: 'sum',
  AggregateType.average: 'average',
  AggregateType.count: 'count',
  AggregateType.min: 'min',
  AggregateType.max: 'max',
};

_$TableSettingsImpl _$$TableSettingsImplFromJson(Map<String, dynamic> json) =>
    _$TableSettingsImpl(
      striped: json['striped'] as bool? ?? true,
      bordered: json['bordered'] as bool? ?? true,
      hoverable: json['hoverable'] as bool? ?? true,
      dense: json['dense'] as bool? ?? false,
      showHeader: json['showHeader'] as bool? ?? true,
      stickyHeader: json['stickyHeader'] as bool? ?? false,
      stickyFirstColumn: json['stickyFirstColumn'] as bool? ?? false,
      virtualScroll: json['virtualScroll'] as bool? ?? false,
      rowHeight: (json['rowHeight'] as num?)?.toDouble() ?? 50,
      headerHeight: (json['headerHeight'] as num?)?.toDouble() ?? 50,
      responsive: json['responsive'] as bool? ?? true,
      showColumnToggle: json['showColumnToggle'] as bool? ?? true,
      showExport: json['showExport'] as bool? ?? true,
      showPrint: json['showPrint'] as bool? ?? true,
      showSearch: json['showSearch'] as bool? ?? true,
      showFilters: json['showFilters'] as bool? ?? true,
      showRefresh: json['showRefresh'] as bool? ?? true,
      bulkActions: (json['bulkActions'] as List<dynamic>?)
          ?.map((e) => BulkAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$TableSettingsImplToJson(_$TableSettingsImpl instance) =>
    <String, dynamic>{
      'striped': instance.striped,
      'bordered': instance.bordered,
      'hoverable': instance.hoverable,
      'dense': instance.dense,
      'showHeader': instance.showHeader,
      'stickyHeader': instance.stickyHeader,
      'stickyFirstColumn': instance.stickyFirstColumn,
      'virtualScroll': instance.virtualScroll,
      'rowHeight': instance.rowHeight,
      'headerHeight': instance.headerHeight,
      'responsive': instance.responsive,
      'showColumnToggle': instance.showColumnToggle,
      'showExport': instance.showExport,
      'showPrint': instance.showPrint,
      'showSearch': instance.showSearch,
      'showFilters': instance.showFilters,
      'showRefresh': instance.showRefresh,
      'bulkActions': instance.bulkActions,
      'metadata': instance.metadata,
    };

_$BulkActionImpl _$$BulkActionImplFromJson(Map<String, dynamic> json) =>
    _$BulkActionImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      requireConfirmation: json['requireConfirmation'] as bool? ?? false,
      confirmationMessage: json['confirmationMessage'] as String?,
      disabled: json['disabled'] as bool? ?? false,
    );

Map<String, dynamic> _$$BulkActionImplToJson(_$BulkActionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'requireConfirmation': instance.requireConfirmation,
      'confirmationMessage': instance.confirmationMessage,
      'disabled': instance.disabled,
    };

_$InvoiceTableRowImpl _$$InvoiceTableRowImplFromJson(
        Map<String, dynamic> json) =>
    _$InvoiceTableRowImpl(
      id: json['id'] as String,
      description: json['description'] as String,
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      notes: json['notes'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$InvoiceTableRowImplToJson(
        _$InvoiceTableRowImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'discount': instance.discount,
      'tax': instance.tax,
      'total': instance.total,
      'notes': instance.notes,
      'metadata': instance.metadata,
    };

_$ProductTableRowImpl _$$ProductTableRowImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductTableRowImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      sku: json['sku'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      stock: (json['stock'] as num).toInt(),
      status: json['status'] as String,
      image: json['image'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ProductTableRowImplToJson(
        _$ProductTableRowImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sku': instance.sku,
      'category': instance.category,
      'price': instance.price,
      'stock': instance.stock,
      'status': instance.status,
      'image': instance.image,
      'rating': instance.rating,
      'metadata': instance.metadata,
    };

_$UserTableRowImpl _$$UserTableRowImplFromJson(Map<String, dynamic> json) =>
    _$UserTableRowImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLogin: json['lastLogin'] == null
          ? null
          : DateTime.parse(json['lastLogin'] as String),
      avatar: json['avatar'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$UserTableRowImplToJson(_$UserTableRowImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastLogin': instance.lastLogin?.toIso8601String(),
      'avatar': instance.avatar,
      'metadata': instance.metadata,
    };

_$OrderTableRowImpl _$$OrderTableRowImplFromJson(Map<String, dynamic> json) =>
    _$OrderTableRowImpl(
      id: json['id'] as String,
      orderNumber: json['orderNumber'] as String,
      customer: json['customer'] as String,
      orderDate: DateTime.parse(json['orderDate'] as String),
      total: (json['total'] as num).toDouble(),
      status: json['status'] as String,
      paymentStatus: json['paymentStatus'] as String,
      shippingMethod: json['shippingMethod'] as String?,
      deliveryDate: json['deliveryDate'] == null
          ? null
          : DateTime.parse(json['deliveryDate'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$OrderTableRowImplToJson(_$OrderTableRowImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNumber': instance.orderNumber,
      'customer': instance.customer,
      'orderDate': instance.orderDate.toIso8601String(),
      'total': instance.total,
      'status': instance.status,
      'paymentStatus': instance.paymentStatus,
      'shippingMethod': instance.shippingMethod,
      'deliveryDate': instance.deliveryDate?.toIso8601String(),
      'metadata': instance.metadata,
    };

_$ReportTableRowImpl _$$ReportTableRowImplFromJson(Map<String, dynamic> json) =>
    _$ReportTableRowImpl(
      id: json['id'] as String,
      metrics: json['metrics'] as Map<String, dynamic>,
      period: DateTime.parse(json['period'] as String),
      dimensions: json['dimensions'] as Map<String, dynamic>?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ReportTableRowImplToJson(
        _$ReportTableRowImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'metrics': instance.metrics,
      'period': instance.period.toIso8601String(),
      'dimensions': instance.dimensions,
      'metadata': instance.metadata,
    };

_$ExportConfigImpl _$$ExportConfigImplFromJson(Map<String, dynamic> json) =>
    _$ExportConfigImpl(
      format: $enumDecode(_$ExportFormatEnumMap, json['format']),
      filename: json['filename'] as String,
      includeHeaders: json['includeHeaders'] as bool? ?? true,
      includeFilters: json['includeFilters'] as bool? ?? false,
      includeSummary: json['includeSummary'] as bool? ?? false,
      selectedColumns: (json['selectedColumns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      columnMapping: (json['columnMapping'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ExportConfigImplToJson(_$ExportConfigImpl instance) =>
    <String, dynamic>{
      'format': _$ExportFormatEnumMap[instance.format]!,
      'filename': instance.filename,
      'includeHeaders': instance.includeHeaders,
      'includeFilters': instance.includeFilters,
      'includeSummary': instance.includeSummary,
      'selectedColumns': instance.selectedColumns,
      'columnMapping': instance.columnMapping,
      'metadata': instance.metadata,
    };

const _$ExportFormatEnumMap = {
  ExportFormat.csv: 'csv',
  ExportFormat.excel: 'excel',
  ExportFormat.pdf: 'pdf',
  ExportFormat.json: 'json',
};

_$CellEditConfigImpl _$$CellEditConfigImplFromJson(Map<String, dynamic> json) =>
    _$CellEditConfigImpl(
      columnId: json['columnId'] as String,
      value: json['value'],
      newValue: json['newValue'],
      rowId: json['rowId'] as String,
      isValid: json['isValid'] as bool? ?? false,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$$CellEditConfigImplToJson(
        _$CellEditConfigImpl instance) =>
    <String, dynamic>{
      'columnId': instance.columnId,
      'value': instance.value,
      'newValue': instance.newValue,
      'rowId': instance.rowId,
      'isValid': instance.isValid,
      'errorMessage': instance.errorMessage,
    };
