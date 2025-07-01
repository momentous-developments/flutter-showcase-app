import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'table_models.freezed.dart';
part 'table_models.g.dart';

// Table Types
enum TableType {
  basic,
  sortable,
  filterable,
  paginated,
  selectable,
  expandable,
  editable,
  dragDrop,
  grouped,
  tree,
  virtualized,
  exportable,
}

// Column Types
enum ColumnType {
  text,
  number,
  currency,
  percentage,
  date,
  dateTime,
  boolean,
  select,
  status,
  badge,
  image,
  avatar,
  rating,
  progress,
  actions,
  custom,
}

// Sort Direction
enum SortDirection {
  ascending,
  descending,
}

// Filter Types
enum FilterType {
  text,
  number,
  date,
  dateRange,
  select,
  multiSelect,
  boolean,
  custom,
}

// Export Formats
enum ExportFormat {
  csv,
  excel,
  pdf,
  json,
}

@freezed
class TableColumn with _$TableColumn {
  const factory TableColumn({
    required String id,
    required String field,
    required String label,
    required ColumnType type,
    @Default(true) bool visible,
    @Default(true) bool sortable,
    @Default(true) bool filterable,
    @Default(false) bool editable,
    @Default(false) bool resizable,
    @Default(false) bool fixed,
    double? width,
    double? minWidth,
    double? maxWidth,
    TextAlign? align,
    ColumnFormat? format,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Widget Function(dynamic value, TableRowData row)? customRenderer,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Widget Function(dynamic value, TableRowData row)? editRenderer,
    @JsonKey(includeFromJson: false, includeToJson: false)
    dynamic Function(String text)? parser,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String Function(dynamic value)? formatter,
    FilterConfig? filterConfig,
    Map<String, dynamic>? metadata,
  }) = _TableColumn;

  factory TableColumn.fromJson(Map<String, dynamic> json) =>
      _$TableColumnFromJson(json);
}

@freezed
class ColumnFormat with _$ColumnFormat {
  const factory ColumnFormat({
    // Number formatting
    int? decimalPlaces,
    String? thousandSeparator,
    String? decimalSeparator,
    String? prefix,
    String? suffix,
    
    // Date formatting
    String? dateFormat,
    
    // Currency formatting
    String? currencySymbol,
    String? currencyCode,
    
    // Status formatting
    Map<String, StatusConfig>? statusConfig,
    
    // Badge formatting
    Map<String, BadgeConfig>? badgeConfig,
  }) = _ColumnFormat;

  factory ColumnFormat.fromJson(Map<String, dynamic> json) =>
      _$ColumnFormatFromJson(json);
}

@freezed
class StatusConfig with _$StatusConfig {
  const factory StatusConfig({
    @JsonKey(includeFromJson: false, includeToJson: false)
    Color? color,
    required String label,
    @JsonKey(includeFromJson: false, includeToJson: false)
    IconData? icon,
  }) = _StatusConfig;

  factory StatusConfig.fromJson(Map<String, dynamic> json) =>
      _$StatusConfigFromJson(json);
}

@freezed
class BadgeConfig with _$BadgeConfig {
  const factory BadgeConfig({
    @JsonKey(includeFromJson: false, includeToJson: false)
    Color? backgroundColor,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Color? textColor,
    required String label,
    @JsonKey(includeFromJson: false, includeToJson: false)
    IconData? icon,
  }) = _BadgeConfig;

  factory BadgeConfig.fromJson(Map<String, dynamic> json) =>
      _$BadgeConfigFromJson(json);
}

@freezed
class TableRowData with _$TableRowData {
  const factory TableRowData({
    required String id,
    required Map<String, dynamic> data,
    @Default(false) bool selected,
    @Default(false) bool expanded,
    @Default(false) bool disabled,
    @Default(false) bool editing,
    List<TableRowData>? children, // For tree tables
    String? parentId, // For tree tables
    int? level, // For tree tables
    Map<String, dynamic>? metadata,
  }) = _TableRowData;

  factory TableRowData.fromJson(Map<String, dynamic> json) =>
      _$TableRowDataFromJson(json);
}

@freezed
class TableData with _$TableData {
  const factory TableData({
    required List<TableColumn> columns,
    required List<TableRowData> rows,
    @Default(0) int totalRows,
    @Default(0) int filteredRows,
    PaginationConfig? pagination,
    SortConfig? sortConfig,
    List<FilterConfig>? filters,
    SelectionConfig? selection,
    GroupConfig? groupConfig,
    GroupingConfig? grouping,
    Map<String, dynamic>? metadata,
  }) = _TableData;

  factory TableData.fromJson(Map<String, dynamic> json) =>
      _$TableDataFromJson(json);
}

@freezed
class PaginationConfig with _$PaginationConfig {
  const factory PaginationConfig({
    @Default(1) int currentPage,
    @Default(10) int pageSize,
    @Default([10, 25, 50, 100]) List<int> pageSizeOptions,
    @Default(0) int totalPages,
    @Default(0) int totalItems,
    @Default(true) bool showPageSizeSelector,
    @Default(true) bool showPageInfo,
  }) = _PaginationConfig;

  factory PaginationConfig.fromJson(Map<String, dynamic> json) =>
      _$PaginationConfigFromJson(json);
}

@freezed
class SortConfig with _$SortConfig {
  const factory SortConfig({
    String? field,
    SortDirection? direction,
    @Default(false) bool multiSort,
    List<SortItem>? sortItems,
  }) = _SortConfig;

  factory SortConfig.fromJson(Map<String, dynamic> json) =>
      _$SortConfigFromJson(json);
}

@freezed
class SortItem with _$SortItem {
  const factory SortItem({
    required String field,
    required SortDirection direction,
    @Default(0) int priority,
  }) = _SortItem;

  factory SortItem.fromJson(Map<String, dynamic> json) =>
      _$SortItemFromJson(json);
}

@freezed
class FilterConfig with _$FilterConfig {
  const factory FilterConfig({
    required String field,
    required FilterType type,
    dynamic value,
    String? operator,
    String? label,
    List<SelectOption>? options, // For select filters
    dynamic min, // For range filters
    dynamic max, // For range filters
    @JsonKey(includeFromJson: false, includeToJson: false)
    Widget Function(FilterConfig config, Function(dynamic) onChanged)? customFilter,
  }) = _FilterConfig;

  factory FilterConfig.fromJson(Map<String, dynamic> json) =>
      _$FilterConfigFromJson(json);
}

@freezed
class SelectOption with _$SelectOption {
  const factory SelectOption({
    required dynamic value,
    required String label,
    @Default(false) bool disabled,
  }) = _SelectOption;

  factory SelectOption.fromJson(Map<String, dynamic> json) =>
      _$SelectOptionFromJson(json);
}

@freezed
class SelectionConfig with _$SelectionConfig {
  const factory SelectionConfig({
    @Default(SelectionMode.none) SelectionMode mode,
    @Default([]) List<String> selectedIds,
    @Default(true) bool showCheckboxes,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Function(List<String> selectedIds)? onSelectionChanged,
  }) = _SelectionConfig;

  factory SelectionConfig.fromJson(Map<String, dynamic> json) =>
      _$SelectionConfigFromJson(json);
}

enum SelectionMode {
  none,
  single,
  multiple,
}

@freezed
class GroupConfig with _$GroupConfig {
  const factory GroupConfig({
    required String field,
    @Default(true) bool collapsible,
    @Default({}) Map<String, bool> expandedGroups,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String Function(dynamic value)? groupLabelFormatter,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Widget Function(String groupKey, List<TableRowData> rows)? groupHeaderRenderer,
  }) = _GroupConfig;

  factory GroupConfig.fromJson(Map<String, dynamic> json) =>
      _$GroupConfigFromJson(json);
}

@freezed
class GroupingConfig with _$GroupingConfig {
  const factory GroupingConfig({
    required String groupBy,
    @Default(true) bool sortGroups,
    @Default(true) bool showAggregates,
    @Default({}) Map<String, AggregateType> aggregates,
    @Default({}) Map<String, bool> expandedGroups,
  }) = _GroupingConfig;

  factory GroupingConfig.fromJson(Map<String, dynamic> json) =>
      _$GroupingConfigFromJson(json);
}

enum AggregateType {
  sum,
  average,
  count,
  min,
  max,
}

@freezed
class TableSettings with _$TableSettings {
  const factory TableSettings({
    @Default(true) bool striped,
    @Default(true) bool bordered,
    @Default(true) bool hoverable,
    @Default(false) bool dense,
    @Default(true) bool showHeader,
    @Default(false) bool stickyHeader,
    @Default(false) bool stickyFirstColumn,
    @Default(false) bool virtualScroll,
    @Default(50) double rowHeight,
    @Default(50) double headerHeight,
    @Default(true) bool responsive,
    @Default(true) bool showColumnToggle,
    @Default(true) bool showExport,
    @Default(true) bool showPrint,
    @Default(true) bool showSearch,
    @Default(true) bool showFilters,
    @Default(true) bool showRefresh,
    List<BulkAction>? bulkActions,
    Map<String, dynamic>? metadata,
  }) = _TableSettings;

  factory TableSettings.fromJson(Map<String, dynamic> json) =>
      _$TableSettingsFromJson(json);
}

@freezed
class BulkAction with _$BulkAction {
  const factory BulkAction({
    required String id,
    required String label,
    @JsonKey(includeFromJson: false, includeToJson: false)
    IconData? icon,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Function(List<String> selectedIds)? onAction,
    @Default(false) bool requireConfirmation,
    String? confirmationMessage,
    @Default(false) bool disabled,
  }) = _BulkAction;

  factory BulkAction.fromJson(Map<String, dynamic> json) =>
      _$BulkActionFromJson(json);
}

// Specialized Table Models

@freezed
class InvoiceTableRow with _$InvoiceTableRow {
  const factory InvoiceTableRow({
    required String id,
    required String description,
    required int quantity,
    required double unitPrice,
    required double discount,
    required double tax,
    required double total,
    String? notes,
    Map<String, dynamic>? metadata,
  }) = _InvoiceTableRow;

  factory InvoiceTableRow.fromJson(Map<String, dynamic> json) =>
      _$InvoiceTableRowFromJson(json);
}

@freezed
class ProductTableRow with _$ProductTableRow {
  const factory ProductTableRow({
    required String id,
    required String name,
    required String sku,
    required String category,
    required double price,
    required int stock,
    required String status,
    String? image,
    double? rating,
    Map<String, dynamic>? metadata,
  }) = _ProductTableRow;

  factory ProductTableRow.fromJson(Map<String, dynamic> json) =>
      _$ProductTableRowFromJson(json);
}

@freezed
class UserTableRow with _$UserTableRow {
  const factory UserTableRow({
    required String id,
    required String name,
    required String email,
    required String role,
    required String status,
    required DateTime createdAt,
    DateTime? lastLogin,
    String? avatar,
    Map<String, dynamic>? metadata,
  }) = _UserTableRow;

  factory UserTableRow.fromJson(Map<String, dynamic> json) =>
      _$UserTableRowFromJson(json);
}

@freezed
class OrderTableRow with _$OrderTableRow {
  const factory OrderTableRow({
    required String id,
    required String orderNumber,
    required String customer,
    required DateTime orderDate,
    required double total,
    required String status,
    required String paymentStatus,
    String? shippingMethod,
    DateTime? deliveryDate,
    Map<String, dynamic>? metadata,
  }) = _OrderTableRow;

  factory OrderTableRow.fromJson(Map<String, dynamic> json) =>
      _$OrderTableRowFromJson(json);
}

@freezed
class ReportTableRow with _$ReportTableRow {
  const factory ReportTableRow({
    required String id,
    required Map<String, dynamic> metrics,
    required DateTime period,
    Map<String, dynamic>? dimensions,
    Map<String, dynamic>? metadata,
  }) = _ReportTableRow;

  factory ReportTableRow.fromJson(Map<String, dynamic> json) =>
      _$ReportTableRowFromJson(json);
}

// Export Configuration
@freezed
class ExportConfig with _$ExportConfig {
  const factory ExportConfig({
    required ExportFormat format,
    required String filename,
    @Default(true) bool includeHeaders,
    @Default(false) bool includeFilters,
    @Default(false) bool includeSummary,
    List<String>? selectedColumns,
    Map<String, String>? columnMapping,
    Map<String, dynamic>? metadata,
  }) = _ExportConfig;

  factory ExportConfig.fromJson(Map<String, dynamic> json) =>
      _$ExportConfigFromJson(json);
}

// Cell Edit Models
@freezed
class CellEditConfig with _$CellEditConfig {
  const factory CellEditConfig({
    required String columnId,
    required dynamic value,
    required dynamic newValue,
    required String rowId,
    @Default(false) bool isValid,
    String? errorMessage,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Function(dynamic newValue)? onSave,
    @JsonKey(includeFromJson: false, includeToJson: false)
    VoidCallback? onCancel,
  }) = _CellEditConfig;

  factory CellEditConfig.fromJson(Map<String, dynamic> json) =>
      _$CellEditConfigFromJson(json);
}