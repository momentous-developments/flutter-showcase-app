// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TableColumn _$TableColumnFromJson(Map<String, dynamic> json) {
  return _TableColumn.fromJson(json);
}

/// @nodoc
mixin _$TableColumn {
  String get id => throw _privateConstructorUsedError;
  String get field => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  ColumnType get type => throw _privateConstructorUsedError;
  bool get visible => throw _privateConstructorUsedError;
  bool get sortable => throw _privateConstructorUsedError;
  bool get filterable => throw _privateConstructorUsedError;
  bool get editable => throw _privateConstructorUsedError;
  bool get resizable => throw _privateConstructorUsedError;
  bool get fixed => throw _privateConstructorUsedError;
  double? get width => throw _privateConstructorUsedError;
  double? get minWidth => throw _privateConstructorUsedError;
  double? get maxWidth => throw _privateConstructorUsedError;
  TextAlign? get align => throw _privateConstructorUsedError;
  ColumnFormat? get format => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Widget Function(dynamic, TableRowData)? get customRenderer =>
      throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Widget Function(dynamic, TableRowData)? get editRenderer =>
      throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  dynamic Function(String)? get parser => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String Function(dynamic)? get formatter => throw _privateConstructorUsedError;
  FilterConfig? get filterConfig => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this TableColumn to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TableColumn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TableColumnCopyWith<TableColumn> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableColumnCopyWith<$Res> {
  factory $TableColumnCopyWith(
          TableColumn value, $Res Function(TableColumn) then) =
      _$TableColumnCopyWithImpl<$Res, TableColumn>;
  @useResult
  $Res call(
      {String id,
      String field,
      String label,
      ColumnType type,
      bool visible,
      bool sortable,
      bool filterable,
      bool editable,
      bool resizable,
      bool fixed,
      double? width,
      double? minWidth,
      double? maxWidth,
      TextAlign? align,
      ColumnFormat? format,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Widget Function(dynamic, TableRowData)? customRenderer,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Widget Function(dynamic, TableRowData)? editRenderer,
      @JsonKey(includeFromJson: false, includeToJson: false)
      dynamic Function(String)? parser,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String Function(dynamic)? formatter,
      FilterConfig? filterConfig,
      Map<String, dynamic>? metadata});

  $ColumnFormatCopyWith<$Res>? get format;
  $FilterConfigCopyWith<$Res>? get filterConfig;
}

/// @nodoc
class _$TableColumnCopyWithImpl<$Res, $Val extends TableColumn>
    implements $TableColumnCopyWith<$Res> {
  _$TableColumnCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TableColumn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? field = null,
    Object? label = null,
    Object? type = null,
    Object? visible = null,
    Object? sortable = null,
    Object? filterable = null,
    Object? editable = null,
    Object? resizable = null,
    Object? fixed = null,
    Object? width = freezed,
    Object? minWidth = freezed,
    Object? maxWidth = freezed,
    Object? align = freezed,
    Object? format = freezed,
    Object? customRenderer = freezed,
    Object? editRenderer = freezed,
    Object? parser = freezed,
    Object? formatter = freezed,
    Object? filterConfig = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ColumnType,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      sortable: null == sortable
          ? _value.sortable
          : sortable // ignore: cast_nullable_to_non_nullable
              as bool,
      filterable: null == filterable
          ? _value.filterable
          : filterable // ignore: cast_nullable_to_non_nullable
              as bool,
      editable: null == editable
          ? _value.editable
          : editable // ignore: cast_nullable_to_non_nullable
              as bool,
      resizable: null == resizable
          ? _value.resizable
          : resizable // ignore: cast_nullable_to_non_nullable
              as bool,
      fixed: null == fixed
          ? _value.fixed
          : fixed // ignore: cast_nullable_to_non_nullable
              as bool,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double?,
      minWidth: freezed == minWidth
          ? _value.minWidth
          : minWidth // ignore: cast_nullable_to_non_nullable
              as double?,
      maxWidth: freezed == maxWidth
          ? _value.maxWidth
          : maxWidth // ignore: cast_nullable_to_non_nullable
              as double?,
      align: freezed == align
          ? _value.align
          : align // ignore: cast_nullable_to_non_nullable
              as TextAlign?,
      format: freezed == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as ColumnFormat?,
      customRenderer: freezed == customRenderer
          ? _value.customRenderer
          : customRenderer // ignore: cast_nullable_to_non_nullable
              as Widget Function(dynamic, TableRowData)?,
      editRenderer: freezed == editRenderer
          ? _value.editRenderer
          : editRenderer // ignore: cast_nullable_to_non_nullable
              as Widget Function(dynamic, TableRowData)?,
      parser: freezed == parser
          ? _value.parser
          : parser // ignore: cast_nullable_to_non_nullable
              as dynamic Function(String)?,
      formatter: freezed == formatter
          ? _value.formatter
          : formatter // ignore: cast_nullable_to_non_nullable
              as String Function(dynamic)?,
      filterConfig: freezed == filterConfig
          ? _value.filterConfig
          : filterConfig // ignore: cast_nullable_to_non_nullable
              as FilterConfig?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of TableColumn
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ColumnFormatCopyWith<$Res>? get format {
    if (_value.format == null) {
      return null;
    }

    return $ColumnFormatCopyWith<$Res>(_value.format!, (value) {
      return _then(_value.copyWith(format: value) as $Val);
    });
  }

  /// Create a copy of TableColumn
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FilterConfigCopyWith<$Res>? get filterConfig {
    if (_value.filterConfig == null) {
      return null;
    }

    return $FilterConfigCopyWith<$Res>(_value.filterConfig!, (value) {
      return _then(_value.copyWith(filterConfig: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TableColumnImplCopyWith<$Res>
    implements $TableColumnCopyWith<$Res> {
  factory _$$TableColumnImplCopyWith(
          _$TableColumnImpl value, $Res Function(_$TableColumnImpl) then) =
      __$$TableColumnImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String field,
      String label,
      ColumnType type,
      bool visible,
      bool sortable,
      bool filterable,
      bool editable,
      bool resizable,
      bool fixed,
      double? width,
      double? minWidth,
      double? maxWidth,
      TextAlign? align,
      ColumnFormat? format,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Widget Function(dynamic, TableRowData)? customRenderer,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Widget Function(dynamic, TableRowData)? editRenderer,
      @JsonKey(includeFromJson: false, includeToJson: false)
      dynamic Function(String)? parser,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String Function(dynamic)? formatter,
      FilterConfig? filterConfig,
      Map<String, dynamic>? metadata});

  @override
  $ColumnFormatCopyWith<$Res>? get format;
  @override
  $FilterConfigCopyWith<$Res>? get filterConfig;
}

/// @nodoc
class __$$TableColumnImplCopyWithImpl<$Res>
    extends _$TableColumnCopyWithImpl<$Res, _$TableColumnImpl>
    implements _$$TableColumnImplCopyWith<$Res> {
  __$$TableColumnImplCopyWithImpl(
      _$TableColumnImpl _value, $Res Function(_$TableColumnImpl) _then)
      : super(_value, _then);

  /// Create a copy of TableColumn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? field = null,
    Object? label = null,
    Object? type = null,
    Object? visible = null,
    Object? sortable = null,
    Object? filterable = null,
    Object? editable = null,
    Object? resizable = null,
    Object? fixed = null,
    Object? width = freezed,
    Object? minWidth = freezed,
    Object? maxWidth = freezed,
    Object? align = freezed,
    Object? format = freezed,
    Object? customRenderer = freezed,
    Object? editRenderer = freezed,
    Object? parser = freezed,
    Object? formatter = freezed,
    Object? filterConfig = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$TableColumnImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ColumnType,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      sortable: null == sortable
          ? _value.sortable
          : sortable // ignore: cast_nullable_to_non_nullable
              as bool,
      filterable: null == filterable
          ? _value.filterable
          : filterable // ignore: cast_nullable_to_non_nullable
              as bool,
      editable: null == editable
          ? _value.editable
          : editable // ignore: cast_nullable_to_non_nullable
              as bool,
      resizable: null == resizable
          ? _value.resizable
          : resizable // ignore: cast_nullable_to_non_nullable
              as bool,
      fixed: null == fixed
          ? _value.fixed
          : fixed // ignore: cast_nullable_to_non_nullable
              as bool,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double?,
      minWidth: freezed == minWidth
          ? _value.minWidth
          : minWidth // ignore: cast_nullable_to_non_nullable
              as double?,
      maxWidth: freezed == maxWidth
          ? _value.maxWidth
          : maxWidth // ignore: cast_nullable_to_non_nullable
              as double?,
      align: freezed == align
          ? _value.align
          : align // ignore: cast_nullable_to_non_nullable
              as TextAlign?,
      format: freezed == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as ColumnFormat?,
      customRenderer: freezed == customRenderer
          ? _value.customRenderer
          : customRenderer // ignore: cast_nullable_to_non_nullable
              as Widget Function(dynamic, TableRowData)?,
      editRenderer: freezed == editRenderer
          ? _value.editRenderer
          : editRenderer // ignore: cast_nullable_to_non_nullable
              as Widget Function(dynamic, TableRowData)?,
      parser: freezed == parser
          ? _value.parser
          : parser // ignore: cast_nullable_to_non_nullable
              as dynamic Function(String)?,
      formatter: freezed == formatter
          ? _value.formatter
          : formatter // ignore: cast_nullable_to_non_nullable
              as String Function(dynamic)?,
      filterConfig: freezed == filterConfig
          ? _value.filterConfig
          : filterConfig // ignore: cast_nullable_to_non_nullable
              as FilterConfig?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TableColumnImpl implements _TableColumn {
  const _$TableColumnImpl(
      {required this.id,
      required this.field,
      required this.label,
      required this.type,
      this.visible = true,
      this.sortable = true,
      this.filterable = true,
      this.editable = false,
      this.resizable = false,
      this.fixed = false,
      this.width,
      this.minWidth,
      this.maxWidth,
      this.align,
      this.format,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.customRenderer,
      @JsonKey(includeFromJson: false, includeToJson: false) this.editRenderer,
      @JsonKey(includeFromJson: false, includeToJson: false) this.parser,
      @JsonKey(includeFromJson: false, includeToJson: false) this.formatter,
      this.filterConfig,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$TableColumnImpl.fromJson(Map<String, dynamic> json) =>
      _$$TableColumnImplFromJson(json);

  @override
  final String id;
  @override
  final String field;
  @override
  final String label;
  @override
  final ColumnType type;
  @override
  @JsonKey()
  final bool visible;
  @override
  @JsonKey()
  final bool sortable;
  @override
  @JsonKey()
  final bool filterable;
  @override
  @JsonKey()
  final bool editable;
  @override
  @JsonKey()
  final bool resizable;
  @override
  @JsonKey()
  final bool fixed;
  @override
  final double? width;
  @override
  final double? minWidth;
  @override
  final double? maxWidth;
  @override
  final TextAlign? align;
  @override
  final ColumnFormat? format;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Widget Function(dynamic, TableRowData)? customRenderer;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Widget Function(dynamic, TableRowData)? editRenderer;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final dynamic Function(String)? parser;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(dynamic)? formatter;
  @override
  final FilterConfig? filterConfig;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'TableColumn(id: $id, field: $field, label: $label, type: $type, visible: $visible, sortable: $sortable, filterable: $filterable, editable: $editable, resizable: $resizable, fixed: $fixed, width: $width, minWidth: $minWidth, maxWidth: $maxWidth, align: $align, format: $format, customRenderer: $customRenderer, editRenderer: $editRenderer, parser: $parser, formatter: $formatter, filterConfig: $filterConfig, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableColumnImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.sortable, sortable) ||
                other.sortable == sortable) &&
            (identical(other.filterable, filterable) ||
                other.filterable == filterable) &&
            (identical(other.editable, editable) ||
                other.editable == editable) &&
            (identical(other.resizable, resizable) ||
                other.resizable == resizable) &&
            (identical(other.fixed, fixed) || other.fixed == fixed) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.minWidth, minWidth) ||
                other.minWidth == minWidth) &&
            (identical(other.maxWidth, maxWidth) ||
                other.maxWidth == maxWidth) &&
            (identical(other.align, align) || other.align == align) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.customRenderer, customRenderer) ||
                other.customRenderer == customRenderer) &&
            (identical(other.editRenderer, editRenderer) ||
                other.editRenderer == editRenderer) &&
            (identical(other.parser, parser) || other.parser == parser) &&
            (identical(other.formatter, formatter) ||
                other.formatter == formatter) &&
            (identical(other.filterConfig, filterConfig) ||
                other.filterConfig == filterConfig) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        field,
        label,
        type,
        visible,
        sortable,
        filterable,
        editable,
        resizable,
        fixed,
        width,
        minWidth,
        maxWidth,
        align,
        format,
        customRenderer,
        editRenderer,
        parser,
        formatter,
        filterConfig,
        const DeepCollectionEquality().hash(_metadata)
      ]);

  /// Create a copy of TableColumn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TableColumnImplCopyWith<_$TableColumnImpl> get copyWith =>
      __$$TableColumnImplCopyWithImpl<_$TableColumnImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TableColumnImplToJson(
      this,
    );
  }
}

abstract class _TableColumn implements TableColumn {
  const factory _TableColumn(
      {required final String id,
      required final String field,
      required final String label,
      required final ColumnType type,
      final bool visible,
      final bool sortable,
      final bool filterable,
      final bool editable,
      final bool resizable,
      final bool fixed,
      final double? width,
      final double? minWidth,
      final double? maxWidth,
      final TextAlign? align,
      final ColumnFormat? format,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Widget Function(dynamic, TableRowData)? customRenderer,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Widget Function(dynamic, TableRowData)? editRenderer,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final dynamic Function(String)? parser,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final String Function(dynamic)? formatter,
      final FilterConfig? filterConfig,
      final Map<String, dynamic>? metadata}) = _$TableColumnImpl;

  factory _TableColumn.fromJson(Map<String, dynamic> json) =
      _$TableColumnImpl.fromJson;

  @override
  String get id;
  @override
  String get field;
  @override
  String get label;
  @override
  ColumnType get type;
  @override
  bool get visible;
  @override
  bool get sortable;
  @override
  bool get filterable;
  @override
  bool get editable;
  @override
  bool get resizable;
  @override
  bool get fixed;
  @override
  double? get width;
  @override
  double? get minWidth;
  @override
  double? get maxWidth;
  @override
  TextAlign? get align;
  @override
  ColumnFormat? get format;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Widget Function(dynamic, TableRowData)? get customRenderer;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Widget Function(dynamic, TableRowData)? get editRenderer;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  dynamic Function(String)? get parser;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String Function(dynamic)? get formatter;
  @override
  FilterConfig? get filterConfig;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of TableColumn
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TableColumnImplCopyWith<_$TableColumnImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ColumnFormat _$ColumnFormatFromJson(Map<String, dynamic> json) {
  return _ColumnFormat.fromJson(json);
}

/// @nodoc
mixin _$ColumnFormat {
// Number formatting
  int? get decimalPlaces => throw _privateConstructorUsedError;
  String? get thousandSeparator => throw _privateConstructorUsedError;
  String? get decimalSeparator => throw _privateConstructorUsedError;
  String? get prefix => throw _privateConstructorUsedError;
  String? get suffix => throw _privateConstructorUsedError; // Date formatting
  String? get dateFormat =>
      throw _privateConstructorUsedError; // Currency formatting
  String? get currencySymbol => throw _privateConstructorUsedError;
  String? get currencyCode =>
      throw _privateConstructorUsedError; // Status formatting
  Map<String, StatusConfig>? get statusConfig =>
      throw _privateConstructorUsedError; // Badge formatting
  Map<String, BadgeConfig>? get badgeConfig =>
      throw _privateConstructorUsedError;

  /// Serializes this ColumnFormat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ColumnFormat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ColumnFormatCopyWith<ColumnFormat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ColumnFormatCopyWith<$Res> {
  factory $ColumnFormatCopyWith(
          ColumnFormat value, $Res Function(ColumnFormat) then) =
      _$ColumnFormatCopyWithImpl<$Res, ColumnFormat>;
  @useResult
  $Res call(
      {int? decimalPlaces,
      String? thousandSeparator,
      String? decimalSeparator,
      String? prefix,
      String? suffix,
      String? dateFormat,
      String? currencySymbol,
      String? currencyCode,
      Map<String, StatusConfig>? statusConfig,
      Map<String, BadgeConfig>? badgeConfig});
}

/// @nodoc
class _$ColumnFormatCopyWithImpl<$Res, $Val extends ColumnFormat>
    implements $ColumnFormatCopyWith<$Res> {
  _$ColumnFormatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ColumnFormat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? decimalPlaces = freezed,
    Object? thousandSeparator = freezed,
    Object? decimalSeparator = freezed,
    Object? prefix = freezed,
    Object? suffix = freezed,
    Object? dateFormat = freezed,
    Object? currencySymbol = freezed,
    Object? currencyCode = freezed,
    Object? statusConfig = freezed,
    Object? badgeConfig = freezed,
  }) {
    return _then(_value.copyWith(
      decimalPlaces: freezed == decimalPlaces
          ? _value.decimalPlaces
          : decimalPlaces // ignore: cast_nullable_to_non_nullable
              as int?,
      thousandSeparator: freezed == thousandSeparator
          ? _value.thousandSeparator
          : thousandSeparator // ignore: cast_nullable_to_non_nullable
              as String?,
      decimalSeparator: freezed == decimalSeparator
          ? _value.decimalSeparator
          : decimalSeparator // ignore: cast_nullable_to_non_nullable
              as String?,
      prefix: freezed == prefix
          ? _value.prefix
          : prefix // ignore: cast_nullable_to_non_nullable
              as String?,
      suffix: freezed == suffix
          ? _value.suffix
          : suffix // ignore: cast_nullable_to_non_nullable
              as String?,
      dateFormat: freezed == dateFormat
          ? _value.dateFormat
          : dateFormat // ignore: cast_nullable_to_non_nullable
              as String?,
      currencySymbol: freezed == currencySymbol
          ? _value.currencySymbol
          : currencySymbol // ignore: cast_nullable_to_non_nullable
              as String?,
      currencyCode: freezed == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      statusConfig: freezed == statusConfig
          ? _value.statusConfig
          : statusConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, StatusConfig>?,
      badgeConfig: freezed == badgeConfig
          ? _value.badgeConfig
          : badgeConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, BadgeConfig>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ColumnFormatImplCopyWith<$Res>
    implements $ColumnFormatCopyWith<$Res> {
  factory _$$ColumnFormatImplCopyWith(
          _$ColumnFormatImpl value, $Res Function(_$ColumnFormatImpl) then) =
      __$$ColumnFormatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? decimalPlaces,
      String? thousandSeparator,
      String? decimalSeparator,
      String? prefix,
      String? suffix,
      String? dateFormat,
      String? currencySymbol,
      String? currencyCode,
      Map<String, StatusConfig>? statusConfig,
      Map<String, BadgeConfig>? badgeConfig});
}

/// @nodoc
class __$$ColumnFormatImplCopyWithImpl<$Res>
    extends _$ColumnFormatCopyWithImpl<$Res, _$ColumnFormatImpl>
    implements _$$ColumnFormatImplCopyWith<$Res> {
  __$$ColumnFormatImplCopyWithImpl(
      _$ColumnFormatImpl _value, $Res Function(_$ColumnFormatImpl) _then)
      : super(_value, _then);

  /// Create a copy of ColumnFormat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? decimalPlaces = freezed,
    Object? thousandSeparator = freezed,
    Object? decimalSeparator = freezed,
    Object? prefix = freezed,
    Object? suffix = freezed,
    Object? dateFormat = freezed,
    Object? currencySymbol = freezed,
    Object? currencyCode = freezed,
    Object? statusConfig = freezed,
    Object? badgeConfig = freezed,
  }) {
    return _then(_$ColumnFormatImpl(
      decimalPlaces: freezed == decimalPlaces
          ? _value.decimalPlaces
          : decimalPlaces // ignore: cast_nullable_to_non_nullable
              as int?,
      thousandSeparator: freezed == thousandSeparator
          ? _value.thousandSeparator
          : thousandSeparator // ignore: cast_nullable_to_non_nullable
              as String?,
      decimalSeparator: freezed == decimalSeparator
          ? _value.decimalSeparator
          : decimalSeparator // ignore: cast_nullable_to_non_nullable
              as String?,
      prefix: freezed == prefix
          ? _value.prefix
          : prefix // ignore: cast_nullable_to_non_nullable
              as String?,
      suffix: freezed == suffix
          ? _value.suffix
          : suffix // ignore: cast_nullable_to_non_nullable
              as String?,
      dateFormat: freezed == dateFormat
          ? _value.dateFormat
          : dateFormat // ignore: cast_nullable_to_non_nullable
              as String?,
      currencySymbol: freezed == currencySymbol
          ? _value.currencySymbol
          : currencySymbol // ignore: cast_nullable_to_non_nullable
              as String?,
      currencyCode: freezed == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      statusConfig: freezed == statusConfig
          ? _value._statusConfig
          : statusConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, StatusConfig>?,
      badgeConfig: freezed == badgeConfig
          ? _value._badgeConfig
          : badgeConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, BadgeConfig>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ColumnFormatImpl implements _ColumnFormat {
  const _$ColumnFormatImpl(
      {this.decimalPlaces,
      this.thousandSeparator,
      this.decimalSeparator,
      this.prefix,
      this.suffix,
      this.dateFormat,
      this.currencySymbol,
      this.currencyCode,
      final Map<String, StatusConfig>? statusConfig,
      final Map<String, BadgeConfig>? badgeConfig})
      : _statusConfig = statusConfig,
        _badgeConfig = badgeConfig;

  factory _$ColumnFormatImpl.fromJson(Map<String, dynamic> json) =>
      _$$ColumnFormatImplFromJson(json);

// Number formatting
  @override
  final int? decimalPlaces;
  @override
  final String? thousandSeparator;
  @override
  final String? decimalSeparator;
  @override
  final String? prefix;
  @override
  final String? suffix;
// Date formatting
  @override
  final String? dateFormat;
// Currency formatting
  @override
  final String? currencySymbol;
  @override
  final String? currencyCode;
// Status formatting
  final Map<String, StatusConfig>? _statusConfig;
// Status formatting
  @override
  Map<String, StatusConfig>? get statusConfig {
    final value = _statusConfig;
    if (value == null) return null;
    if (_statusConfig is EqualUnmodifiableMapView) return _statusConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// Badge formatting
  final Map<String, BadgeConfig>? _badgeConfig;
// Badge formatting
  @override
  Map<String, BadgeConfig>? get badgeConfig {
    final value = _badgeConfig;
    if (value == null) return null;
    if (_badgeConfig is EqualUnmodifiableMapView) return _badgeConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ColumnFormat(decimalPlaces: $decimalPlaces, thousandSeparator: $thousandSeparator, decimalSeparator: $decimalSeparator, prefix: $prefix, suffix: $suffix, dateFormat: $dateFormat, currencySymbol: $currencySymbol, currencyCode: $currencyCode, statusConfig: $statusConfig, badgeConfig: $badgeConfig)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ColumnFormatImpl &&
            (identical(other.decimalPlaces, decimalPlaces) ||
                other.decimalPlaces == decimalPlaces) &&
            (identical(other.thousandSeparator, thousandSeparator) ||
                other.thousandSeparator == thousandSeparator) &&
            (identical(other.decimalSeparator, decimalSeparator) ||
                other.decimalSeparator == decimalSeparator) &&
            (identical(other.prefix, prefix) || other.prefix == prefix) &&
            (identical(other.suffix, suffix) || other.suffix == suffix) &&
            (identical(other.dateFormat, dateFormat) ||
                other.dateFormat == dateFormat) &&
            (identical(other.currencySymbol, currencySymbol) ||
                other.currencySymbol == currencySymbol) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            const DeepCollectionEquality()
                .equals(other._statusConfig, _statusConfig) &&
            const DeepCollectionEquality()
                .equals(other._badgeConfig, _badgeConfig));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      decimalPlaces,
      thousandSeparator,
      decimalSeparator,
      prefix,
      suffix,
      dateFormat,
      currencySymbol,
      currencyCode,
      const DeepCollectionEquality().hash(_statusConfig),
      const DeepCollectionEquality().hash(_badgeConfig));

  /// Create a copy of ColumnFormat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ColumnFormatImplCopyWith<_$ColumnFormatImpl> get copyWith =>
      __$$ColumnFormatImplCopyWithImpl<_$ColumnFormatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ColumnFormatImplToJson(
      this,
    );
  }
}

abstract class _ColumnFormat implements ColumnFormat {
  const factory _ColumnFormat(
      {final int? decimalPlaces,
      final String? thousandSeparator,
      final String? decimalSeparator,
      final String? prefix,
      final String? suffix,
      final String? dateFormat,
      final String? currencySymbol,
      final String? currencyCode,
      final Map<String, StatusConfig>? statusConfig,
      final Map<String, BadgeConfig>? badgeConfig}) = _$ColumnFormatImpl;

  factory _ColumnFormat.fromJson(Map<String, dynamic> json) =
      _$ColumnFormatImpl.fromJson;

// Number formatting
  @override
  int? get decimalPlaces;
  @override
  String? get thousandSeparator;
  @override
  String? get decimalSeparator;
  @override
  String? get prefix;
  @override
  String? get suffix; // Date formatting
  @override
  String? get dateFormat; // Currency formatting
  @override
  String? get currencySymbol;
  @override
  String? get currencyCode; // Status formatting
  @override
  Map<String, StatusConfig>? get statusConfig; // Badge formatting
  @override
  Map<String, BadgeConfig>? get badgeConfig;

  /// Create a copy of ColumnFormat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ColumnFormatImplCopyWith<_$ColumnFormatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatusConfig _$StatusConfigFromJson(Map<String, dynamic> json) {
  return _StatusConfig.fromJson(json);
}

/// @nodoc
mixin _$StatusConfig {
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? get color => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get icon => throw _privateConstructorUsedError;

  /// Serializes this StatusConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatusConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatusConfigCopyWith<StatusConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusConfigCopyWith<$Res> {
  factory $StatusConfigCopyWith(
          StatusConfig value, $Res Function(StatusConfig) then) =
      _$StatusConfigCopyWithImpl<$Res, StatusConfig>;
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false) Color? color,
      String label,
      @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon});
}

/// @nodoc
class _$StatusConfigCopyWithImpl<$Res, $Val extends StatusConfig>
    implements $StatusConfigCopyWith<$Res> {
  _$StatusConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = freezed,
    Object? label = null,
    Object? icon = freezed,
  }) {
    return _then(_value.copyWith(
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatusConfigImplCopyWith<$Res>
    implements $StatusConfigCopyWith<$Res> {
  factory _$$StatusConfigImplCopyWith(
          _$StatusConfigImpl value, $Res Function(_$StatusConfigImpl) then) =
      __$$StatusConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false) Color? color,
      String label,
      @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon});
}

/// @nodoc
class __$$StatusConfigImplCopyWithImpl<$Res>
    extends _$StatusConfigCopyWithImpl<$Res, _$StatusConfigImpl>
    implements _$$StatusConfigImplCopyWith<$Res> {
  __$$StatusConfigImplCopyWithImpl(
      _$StatusConfigImpl _value, $Res Function(_$StatusConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatusConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = freezed,
    Object? label = null,
    Object? icon = freezed,
  }) {
    return _then(_$StatusConfigImpl(
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusConfigImpl implements _StatusConfig {
  const _$StatusConfigImpl(
      {@JsonKey(includeFromJson: false, includeToJson: false) this.color,
      required this.label,
      @JsonKey(includeFromJson: false, includeToJson: false) this.icon});

  factory _$StatusConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusConfigImplFromJson(json);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Color? color;
  @override
  final String label;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final IconData? icon;

  @override
  String toString() {
    return 'StatusConfig(color: $color, label: $label, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusConfigImpl &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, color, label, icon);

  /// Create a copy of StatusConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusConfigImplCopyWith<_$StatusConfigImpl> get copyWith =>
      __$$StatusConfigImplCopyWithImpl<_$StatusConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusConfigImplToJson(
      this,
    );
  }
}

abstract class _StatusConfig implements StatusConfig {
  const factory _StatusConfig(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      final Color? color,
      required final String label,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final IconData? icon}) = _$StatusConfigImpl;

  factory _StatusConfig.fromJson(Map<String, dynamic> json) =
      _$StatusConfigImpl.fromJson;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? get color;
  @override
  String get label;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get icon;

  /// Create a copy of StatusConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusConfigImplCopyWith<_$StatusConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BadgeConfig _$BadgeConfigFromJson(Map<String, dynamic> json) {
  return _BadgeConfig.fromJson(json);
}

/// @nodoc
mixin _$BadgeConfig {
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? get backgroundColor => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? get textColor => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get icon => throw _privateConstructorUsedError;

  /// Serializes this BadgeConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BadgeConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BadgeConfigCopyWith<BadgeConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgeConfigCopyWith<$Res> {
  factory $BadgeConfigCopyWith(
          BadgeConfig value, $Res Function(BadgeConfig) then) =
      _$BadgeConfigCopyWithImpl<$Res, BadgeConfig>;
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      Color? backgroundColor,
      @JsonKey(includeFromJson: false, includeToJson: false) Color? textColor,
      String label,
      @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon});
}

/// @nodoc
class _$BadgeConfigCopyWithImpl<$Res, $Val extends BadgeConfig>
    implements $BadgeConfigCopyWith<$Res> {
  _$BadgeConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BadgeConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = freezed,
    Object? textColor = freezed,
    Object? label = null,
    Object? icon = freezed,
  }) {
    return _then(_value.copyWith(
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      textColor: freezed == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BadgeConfigImplCopyWith<$Res>
    implements $BadgeConfigCopyWith<$Res> {
  factory _$$BadgeConfigImplCopyWith(
          _$BadgeConfigImpl value, $Res Function(_$BadgeConfigImpl) then) =
      __$$BadgeConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      Color? backgroundColor,
      @JsonKey(includeFromJson: false, includeToJson: false) Color? textColor,
      String label,
      @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon});
}

/// @nodoc
class __$$BadgeConfigImplCopyWithImpl<$Res>
    extends _$BadgeConfigCopyWithImpl<$Res, _$BadgeConfigImpl>
    implements _$$BadgeConfigImplCopyWith<$Res> {
  __$$BadgeConfigImplCopyWithImpl(
      _$BadgeConfigImpl _value, $Res Function(_$BadgeConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of BadgeConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = freezed,
    Object? textColor = freezed,
    Object? label = null,
    Object? icon = freezed,
  }) {
    return _then(_$BadgeConfigImpl(
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      textColor: freezed == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BadgeConfigImpl implements _BadgeConfig {
  const _$BadgeConfigImpl(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      this.backgroundColor,
      @JsonKey(includeFromJson: false, includeToJson: false) this.textColor,
      required this.label,
      @JsonKey(includeFromJson: false, includeToJson: false) this.icon});

  factory _$BadgeConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$BadgeConfigImplFromJson(json);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Color? backgroundColor;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Color? textColor;
  @override
  final String label;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final IconData? icon;

  @override
  String toString() {
    return 'BadgeConfig(backgroundColor: $backgroundColor, textColor: $textColor, label: $label, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeConfigImpl &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, backgroundColor, textColor, label, icon);

  /// Create a copy of BadgeConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgeConfigImplCopyWith<_$BadgeConfigImpl> get copyWith =>
      __$$BadgeConfigImplCopyWithImpl<_$BadgeConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BadgeConfigImplToJson(
      this,
    );
  }
}

abstract class _BadgeConfig implements BadgeConfig {
  const factory _BadgeConfig(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      final Color? backgroundColor,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Color? textColor,
      required final String label,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final IconData? icon}) = _$BadgeConfigImpl;

  factory _BadgeConfig.fromJson(Map<String, dynamic> json) =
      _$BadgeConfigImpl.fromJson;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? get backgroundColor;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? get textColor;
  @override
  String get label;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get icon;

  /// Create a copy of BadgeConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BadgeConfigImplCopyWith<_$BadgeConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TableRowData _$TableRowDataFromJson(Map<String, dynamic> json) {
  return _TableRowData.fromJson(json);
}

/// @nodoc
mixin _$TableRowData {
  String get id => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  bool get selected => throw _privateConstructorUsedError;
  bool get expanded => throw _privateConstructorUsedError;
  bool get disabled => throw _privateConstructorUsedError;
  bool get editing => throw _privateConstructorUsedError;
  List<TableRowData>? get children =>
      throw _privateConstructorUsedError; // For tree tables
  String? get parentId => throw _privateConstructorUsedError; // For tree tables
  int? get level => throw _privateConstructorUsedError; // For tree tables
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this TableRowData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TableRowData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TableRowDataCopyWith<TableRowData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableRowDataCopyWith<$Res> {
  factory $TableRowDataCopyWith(
          TableRowData value, $Res Function(TableRowData) then) =
      _$TableRowDataCopyWithImpl<$Res, TableRowData>;
  @useResult
  $Res call(
      {String id,
      Map<String, dynamic> data,
      bool selected,
      bool expanded,
      bool disabled,
      bool editing,
      List<TableRowData>? children,
      String? parentId,
      int? level,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$TableRowDataCopyWithImpl<$Res, $Val extends TableRowData>
    implements $TableRowDataCopyWith<$Res> {
  _$TableRowDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TableRowData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? data = null,
    Object? selected = null,
    Object? expanded = null,
    Object? disabled = null,
    Object? editing = null,
    Object? children = freezed,
    Object? parentId = freezed,
    Object? level = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
      expanded: null == expanded
          ? _value.expanded
          : expanded // ignore: cast_nullable_to_non_nullable
              as bool,
      disabled: null == disabled
          ? _value.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool,
      editing: null == editing
          ? _value.editing
          : editing // ignore: cast_nullable_to_non_nullable
              as bool,
      children: freezed == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<TableRowData>?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TableRowDataImplCopyWith<$Res>
    implements $TableRowDataCopyWith<$Res> {
  factory _$$TableRowDataImplCopyWith(
          _$TableRowDataImpl value, $Res Function(_$TableRowDataImpl) then) =
      __$$TableRowDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Map<String, dynamic> data,
      bool selected,
      bool expanded,
      bool disabled,
      bool editing,
      List<TableRowData>? children,
      String? parentId,
      int? level,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$TableRowDataImplCopyWithImpl<$Res>
    extends _$TableRowDataCopyWithImpl<$Res, _$TableRowDataImpl>
    implements _$$TableRowDataImplCopyWith<$Res> {
  __$$TableRowDataImplCopyWithImpl(
      _$TableRowDataImpl _value, $Res Function(_$TableRowDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TableRowData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? data = null,
    Object? selected = null,
    Object? expanded = null,
    Object? disabled = null,
    Object? editing = null,
    Object? children = freezed,
    Object? parentId = freezed,
    Object? level = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$TableRowDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
      expanded: null == expanded
          ? _value.expanded
          : expanded // ignore: cast_nullable_to_non_nullable
              as bool,
      disabled: null == disabled
          ? _value.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool,
      editing: null == editing
          ? _value.editing
          : editing // ignore: cast_nullable_to_non_nullable
              as bool,
      children: freezed == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<TableRowData>?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TableRowDataImpl implements _TableRowData {
  const _$TableRowDataImpl(
      {required this.id,
      required final Map<String, dynamic> data,
      this.selected = false,
      this.expanded = false,
      this.disabled = false,
      this.editing = false,
      final List<TableRowData>? children,
      this.parentId,
      this.level,
      final Map<String, dynamic>? metadata})
      : _data = data,
        _children = children,
        _metadata = metadata;

  factory _$TableRowDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TableRowDataImplFromJson(json);

  @override
  final String id;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  @JsonKey()
  final bool selected;
  @override
  @JsonKey()
  final bool expanded;
  @override
  @JsonKey()
  final bool disabled;
  @override
  @JsonKey()
  final bool editing;
  final List<TableRowData>? _children;
  @override
  List<TableRowData>? get children {
    final value = _children;
    if (value == null) return null;
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// For tree tables
  @override
  final String? parentId;
// For tree tables
  @override
  final int? level;
// For tree tables
  final Map<String, dynamic>? _metadata;
// For tree tables
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'TableRowData(id: $id, data: $data, selected: $selected, expanded: $expanded, disabled: $disabled, editing: $editing, children: $children, parentId: $parentId, level: $level, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableRowDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.selected, selected) ||
                other.selected == selected) &&
            (identical(other.expanded, expanded) ||
                other.expanded == expanded) &&
            (identical(other.disabled, disabled) ||
                other.disabled == disabled) &&
            (identical(other.editing, editing) || other.editing == editing) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.level, level) || other.level == level) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_data),
      selected,
      expanded,
      disabled,
      editing,
      const DeepCollectionEquality().hash(_children),
      parentId,
      level,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of TableRowData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TableRowDataImplCopyWith<_$TableRowDataImpl> get copyWith =>
      __$$TableRowDataImplCopyWithImpl<_$TableRowDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TableRowDataImplToJson(
      this,
    );
  }
}

abstract class _TableRowData implements TableRowData {
  const factory _TableRowData(
      {required final String id,
      required final Map<String, dynamic> data,
      final bool selected,
      final bool expanded,
      final bool disabled,
      final bool editing,
      final List<TableRowData>? children,
      final String? parentId,
      final int? level,
      final Map<String, dynamic>? metadata}) = _$TableRowDataImpl;

  factory _TableRowData.fromJson(Map<String, dynamic> json) =
      _$TableRowDataImpl.fromJson;

  @override
  String get id;
  @override
  Map<String, dynamic> get data;
  @override
  bool get selected;
  @override
  bool get expanded;
  @override
  bool get disabled;
  @override
  bool get editing;
  @override
  List<TableRowData>? get children; // For tree tables
  @override
  String? get parentId; // For tree tables
  @override
  int? get level; // For tree tables
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of TableRowData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TableRowDataImplCopyWith<_$TableRowDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TableData _$TableDataFromJson(Map<String, dynamic> json) {
  return _TableData.fromJson(json);
}

/// @nodoc
mixin _$TableData {
  List<TableColumn> get columns => throw _privateConstructorUsedError;
  List<TableRowData> get rows => throw _privateConstructorUsedError;
  int get totalRows => throw _privateConstructorUsedError;
  int get filteredRows => throw _privateConstructorUsedError;
  PaginationConfig? get pagination => throw _privateConstructorUsedError;
  SortConfig? get sortConfig => throw _privateConstructorUsedError;
  List<FilterConfig>? get filters => throw _privateConstructorUsedError;
  SelectionConfig? get selection => throw _privateConstructorUsedError;
  GroupConfig? get groupConfig => throw _privateConstructorUsedError;
  GroupingConfig? get grouping => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this TableData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TableData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TableDataCopyWith<TableData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableDataCopyWith<$Res> {
  factory $TableDataCopyWith(TableData value, $Res Function(TableData) then) =
      _$TableDataCopyWithImpl<$Res, TableData>;
  @useResult
  $Res call(
      {List<TableColumn> columns,
      List<TableRowData> rows,
      int totalRows,
      int filteredRows,
      PaginationConfig? pagination,
      SortConfig? sortConfig,
      List<FilterConfig>? filters,
      SelectionConfig? selection,
      GroupConfig? groupConfig,
      GroupingConfig? grouping,
      Map<String, dynamic>? metadata});

  $PaginationConfigCopyWith<$Res>? get pagination;
  $SortConfigCopyWith<$Res>? get sortConfig;
  $SelectionConfigCopyWith<$Res>? get selection;
  $GroupConfigCopyWith<$Res>? get groupConfig;
  $GroupingConfigCopyWith<$Res>? get grouping;
}

/// @nodoc
class _$TableDataCopyWithImpl<$Res, $Val extends TableData>
    implements $TableDataCopyWith<$Res> {
  _$TableDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TableData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? columns = null,
    Object? rows = null,
    Object? totalRows = null,
    Object? filteredRows = null,
    Object? pagination = freezed,
    Object? sortConfig = freezed,
    Object? filters = freezed,
    Object? selection = freezed,
    Object? groupConfig = freezed,
    Object? grouping = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      columns: null == columns
          ? _value.columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<TableColumn>,
      rows: null == rows
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<TableRowData>,
      totalRows: null == totalRows
          ? _value.totalRows
          : totalRows // ignore: cast_nullable_to_non_nullable
              as int,
      filteredRows: null == filteredRows
          ? _value.filteredRows
          : filteredRows // ignore: cast_nullable_to_non_nullable
              as int,
      pagination: freezed == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as PaginationConfig?,
      sortConfig: freezed == sortConfig
          ? _value.sortConfig
          : sortConfig // ignore: cast_nullable_to_non_nullable
              as SortConfig?,
      filters: freezed == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<FilterConfig>?,
      selection: freezed == selection
          ? _value.selection
          : selection // ignore: cast_nullable_to_non_nullable
              as SelectionConfig?,
      groupConfig: freezed == groupConfig
          ? _value.groupConfig
          : groupConfig // ignore: cast_nullable_to_non_nullable
              as GroupConfig?,
      grouping: freezed == grouping
          ? _value.grouping
          : grouping // ignore: cast_nullable_to_non_nullable
              as GroupingConfig?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of TableData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationConfigCopyWith<$Res>? get pagination {
    if (_value.pagination == null) {
      return null;
    }

    return $PaginationConfigCopyWith<$Res>(_value.pagination!, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }

  /// Create a copy of TableData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SortConfigCopyWith<$Res>? get sortConfig {
    if (_value.sortConfig == null) {
      return null;
    }

    return $SortConfigCopyWith<$Res>(_value.sortConfig!, (value) {
      return _then(_value.copyWith(sortConfig: value) as $Val);
    });
  }

  /// Create a copy of TableData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SelectionConfigCopyWith<$Res>? get selection {
    if (_value.selection == null) {
      return null;
    }

    return $SelectionConfigCopyWith<$Res>(_value.selection!, (value) {
      return _then(_value.copyWith(selection: value) as $Val);
    });
  }

  /// Create a copy of TableData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GroupConfigCopyWith<$Res>? get groupConfig {
    if (_value.groupConfig == null) {
      return null;
    }

    return $GroupConfigCopyWith<$Res>(_value.groupConfig!, (value) {
      return _then(_value.copyWith(groupConfig: value) as $Val);
    });
  }

  /// Create a copy of TableData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GroupingConfigCopyWith<$Res>? get grouping {
    if (_value.grouping == null) {
      return null;
    }

    return $GroupingConfigCopyWith<$Res>(_value.grouping!, (value) {
      return _then(_value.copyWith(grouping: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TableDataImplCopyWith<$Res>
    implements $TableDataCopyWith<$Res> {
  factory _$$TableDataImplCopyWith(
          _$TableDataImpl value, $Res Function(_$TableDataImpl) then) =
      __$$TableDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TableColumn> columns,
      List<TableRowData> rows,
      int totalRows,
      int filteredRows,
      PaginationConfig? pagination,
      SortConfig? sortConfig,
      List<FilterConfig>? filters,
      SelectionConfig? selection,
      GroupConfig? groupConfig,
      GroupingConfig? grouping,
      Map<String, dynamic>? metadata});

  @override
  $PaginationConfigCopyWith<$Res>? get pagination;
  @override
  $SortConfigCopyWith<$Res>? get sortConfig;
  @override
  $SelectionConfigCopyWith<$Res>? get selection;
  @override
  $GroupConfigCopyWith<$Res>? get groupConfig;
  @override
  $GroupingConfigCopyWith<$Res>? get grouping;
}

/// @nodoc
class __$$TableDataImplCopyWithImpl<$Res>
    extends _$TableDataCopyWithImpl<$Res, _$TableDataImpl>
    implements _$$TableDataImplCopyWith<$Res> {
  __$$TableDataImplCopyWithImpl(
      _$TableDataImpl _value, $Res Function(_$TableDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TableData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? columns = null,
    Object? rows = null,
    Object? totalRows = null,
    Object? filteredRows = null,
    Object? pagination = freezed,
    Object? sortConfig = freezed,
    Object? filters = freezed,
    Object? selection = freezed,
    Object? groupConfig = freezed,
    Object? grouping = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$TableDataImpl(
      columns: null == columns
          ? _value._columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<TableColumn>,
      rows: null == rows
          ? _value._rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<TableRowData>,
      totalRows: null == totalRows
          ? _value.totalRows
          : totalRows // ignore: cast_nullable_to_non_nullable
              as int,
      filteredRows: null == filteredRows
          ? _value.filteredRows
          : filteredRows // ignore: cast_nullable_to_non_nullable
              as int,
      pagination: freezed == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as PaginationConfig?,
      sortConfig: freezed == sortConfig
          ? _value.sortConfig
          : sortConfig // ignore: cast_nullable_to_non_nullable
              as SortConfig?,
      filters: freezed == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<FilterConfig>?,
      selection: freezed == selection
          ? _value.selection
          : selection // ignore: cast_nullable_to_non_nullable
              as SelectionConfig?,
      groupConfig: freezed == groupConfig
          ? _value.groupConfig
          : groupConfig // ignore: cast_nullable_to_non_nullable
              as GroupConfig?,
      grouping: freezed == grouping
          ? _value.grouping
          : grouping // ignore: cast_nullable_to_non_nullable
              as GroupingConfig?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TableDataImpl implements _TableData {
  const _$TableDataImpl(
      {required final List<TableColumn> columns,
      required final List<TableRowData> rows,
      this.totalRows = 0,
      this.filteredRows = 0,
      this.pagination,
      this.sortConfig,
      final List<FilterConfig>? filters,
      this.selection,
      this.groupConfig,
      this.grouping,
      final Map<String, dynamic>? metadata})
      : _columns = columns,
        _rows = rows,
        _filters = filters,
        _metadata = metadata;

  factory _$TableDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TableDataImplFromJson(json);

  final List<TableColumn> _columns;
  @override
  List<TableColumn> get columns {
    if (_columns is EqualUnmodifiableListView) return _columns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_columns);
  }

  final List<TableRowData> _rows;
  @override
  List<TableRowData> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  @JsonKey()
  final int totalRows;
  @override
  @JsonKey()
  final int filteredRows;
  @override
  final PaginationConfig? pagination;
  @override
  final SortConfig? sortConfig;
  final List<FilterConfig>? _filters;
  @override
  List<FilterConfig>? get filters {
    final value = _filters;
    if (value == null) return null;
    if (_filters is EqualUnmodifiableListView) return _filters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final SelectionConfig? selection;
  @override
  final GroupConfig? groupConfig;
  @override
  final GroupingConfig? grouping;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'TableData(columns: $columns, rows: $rows, totalRows: $totalRows, filteredRows: $filteredRows, pagination: $pagination, sortConfig: $sortConfig, filters: $filters, selection: $selection, groupConfig: $groupConfig, grouping: $grouping, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableDataImpl &&
            const DeepCollectionEquality().equals(other._columns, _columns) &&
            const DeepCollectionEquality().equals(other._rows, _rows) &&
            (identical(other.totalRows, totalRows) ||
                other.totalRows == totalRows) &&
            (identical(other.filteredRows, filteredRows) ||
                other.filteredRows == filteredRows) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination) &&
            (identical(other.sortConfig, sortConfig) ||
                other.sortConfig == sortConfig) &&
            const DeepCollectionEquality().equals(other._filters, _filters) &&
            (identical(other.selection, selection) ||
                other.selection == selection) &&
            (identical(other.groupConfig, groupConfig) ||
                other.groupConfig == groupConfig) &&
            (identical(other.grouping, grouping) ||
                other.grouping == grouping) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_columns),
      const DeepCollectionEquality().hash(_rows),
      totalRows,
      filteredRows,
      pagination,
      sortConfig,
      const DeepCollectionEquality().hash(_filters),
      selection,
      groupConfig,
      grouping,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of TableData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TableDataImplCopyWith<_$TableDataImpl> get copyWith =>
      __$$TableDataImplCopyWithImpl<_$TableDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TableDataImplToJson(
      this,
    );
  }
}

abstract class _TableData implements TableData {
  const factory _TableData(
      {required final List<TableColumn> columns,
      required final List<TableRowData> rows,
      final int totalRows,
      final int filteredRows,
      final PaginationConfig? pagination,
      final SortConfig? sortConfig,
      final List<FilterConfig>? filters,
      final SelectionConfig? selection,
      final GroupConfig? groupConfig,
      final GroupingConfig? grouping,
      final Map<String, dynamic>? metadata}) = _$TableDataImpl;

  factory _TableData.fromJson(Map<String, dynamic> json) =
      _$TableDataImpl.fromJson;

  @override
  List<TableColumn> get columns;
  @override
  List<TableRowData> get rows;
  @override
  int get totalRows;
  @override
  int get filteredRows;
  @override
  PaginationConfig? get pagination;
  @override
  SortConfig? get sortConfig;
  @override
  List<FilterConfig>? get filters;
  @override
  SelectionConfig? get selection;
  @override
  GroupConfig? get groupConfig;
  @override
  GroupingConfig? get grouping;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of TableData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TableDataImplCopyWith<_$TableDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaginationConfig _$PaginationConfigFromJson(Map<String, dynamic> json) {
  return _PaginationConfig.fromJson(json);
}

/// @nodoc
mixin _$PaginationConfig {
  int get currentPage => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  List<int> get pageSizeOptions => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get totalItems => throw _privateConstructorUsedError;
  bool get showPageSizeSelector => throw _privateConstructorUsedError;
  bool get showPageInfo => throw _privateConstructorUsedError;

  /// Serializes this PaginationConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginationConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginationConfigCopyWith<PaginationConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationConfigCopyWith<$Res> {
  factory $PaginationConfigCopyWith(
          PaginationConfig value, $Res Function(PaginationConfig) then) =
      _$PaginationConfigCopyWithImpl<$Res, PaginationConfig>;
  @useResult
  $Res call(
      {int currentPage,
      int pageSize,
      List<int> pageSizeOptions,
      int totalPages,
      int totalItems,
      bool showPageSizeSelector,
      bool showPageInfo});
}

/// @nodoc
class _$PaginationConfigCopyWithImpl<$Res, $Val extends PaginationConfig>
    implements $PaginationConfigCopyWith<$Res> {
  _$PaginationConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginationConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? pageSize = null,
    Object? pageSizeOptions = null,
    Object? totalPages = null,
    Object? totalItems = null,
    Object? showPageSizeSelector = null,
    Object? showPageInfo = null,
  }) {
    return _then(_value.copyWith(
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      pageSizeOptions: null == pageSizeOptions
          ? _value.pageSizeOptions
          : pageSizeOptions // ignore: cast_nullable_to_non_nullable
              as List<int>,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      showPageSizeSelector: null == showPageSizeSelector
          ? _value.showPageSizeSelector
          : showPageSizeSelector // ignore: cast_nullable_to_non_nullable
              as bool,
      showPageInfo: null == showPageInfo
          ? _value.showPageInfo
          : showPageInfo // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaginationConfigImplCopyWith<$Res>
    implements $PaginationConfigCopyWith<$Res> {
  factory _$$PaginationConfigImplCopyWith(_$PaginationConfigImpl value,
          $Res Function(_$PaginationConfigImpl) then) =
      __$$PaginationConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int currentPage,
      int pageSize,
      List<int> pageSizeOptions,
      int totalPages,
      int totalItems,
      bool showPageSizeSelector,
      bool showPageInfo});
}

/// @nodoc
class __$$PaginationConfigImplCopyWithImpl<$Res>
    extends _$PaginationConfigCopyWithImpl<$Res, _$PaginationConfigImpl>
    implements _$$PaginationConfigImplCopyWith<$Res> {
  __$$PaginationConfigImplCopyWithImpl(_$PaginationConfigImpl _value,
      $Res Function(_$PaginationConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaginationConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? pageSize = null,
    Object? pageSizeOptions = null,
    Object? totalPages = null,
    Object? totalItems = null,
    Object? showPageSizeSelector = null,
    Object? showPageInfo = null,
  }) {
    return _then(_$PaginationConfigImpl(
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      pageSizeOptions: null == pageSizeOptions
          ? _value._pageSizeOptions
          : pageSizeOptions // ignore: cast_nullable_to_non_nullable
              as List<int>,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      showPageSizeSelector: null == showPageSizeSelector
          ? _value.showPageSizeSelector
          : showPageSizeSelector // ignore: cast_nullable_to_non_nullable
              as bool,
      showPageInfo: null == showPageInfo
          ? _value.showPageInfo
          : showPageInfo // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginationConfigImpl implements _PaginationConfig {
  const _$PaginationConfigImpl(
      {this.currentPage = 1,
      this.pageSize = 10,
      final List<int> pageSizeOptions = const [10, 25, 50, 100],
      this.totalPages = 0,
      this.totalItems = 0,
      this.showPageSizeSelector = true,
      this.showPageInfo = true})
      : _pageSizeOptions = pageSizeOptions;

  factory _$PaginationConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginationConfigImplFromJson(json);

  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int pageSize;
  final List<int> _pageSizeOptions;
  @override
  @JsonKey()
  List<int> get pageSizeOptions {
    if (_pageSizeOptions is EqualUnmodifiableListView) return _pageSizeOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pageSizeOptions);
  }

  @override
  @JsonKey()
  final int totalPages;
  @override
  @JsonKey()
  final int totalItems;
  @override
  @JsonKey()
  final bool showPageSizeSelector;
  @override
  @JsonKey()
  final bool showPageInfo;

  @override
  String toString() {
    return 'PaginationConfig(currentPage: $currentPage, pageSize: $pageSize, pageSizeOptions: $pageSizeOptions, totalPages: $totalPages, totalItems: $totalItems, showPageSizeSelector: $showPageSizeSelector, showPageInfo: $showPageInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationConfigImpl &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            const DeepCollectionEquality()
                .equals(other._pageSizeOptions, _pageSizeOptions) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.showPageSizeSelector, showPageSizeSelector) ||
                other.showPageSizeSelector == showPageSizeSelector) &&
            (identical(other.showPageInfo, showPageInfo) ||
                other.showPageInfo == showPageInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentPage,
      pageSize,
      const DeepCollectionEquality().hash(_pageSizeOptions),
      totalPages,
      totalItems,
      showPageSizeSelector,
      showPageInfo);

  /// Create a copy of PaginationConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationConfigImplCopyWith<_$PaginationConfigImpl> get copyWith =>
      __$$PaginationConfigImplCopyWithImpl<_$PaginationConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginationConfigImplToJson(
      this,
    );
  }
}

abstract class _PaginationConfig implements PaginationConfig {
  const factory _PaginationConfig(
      {final int currentPage,
      final int pageSize,
      final List<int> pageSizeOptions,
      final int totalPages,
      final int totalItems,
      final bool showPageSizeSelector,
      final bool showPageInfo}) = _$PaginationConfigImpl;

  factory _PaginationConfig.fromJson(Map<String, dynamic> json) =
      _$PaginationConfigImpl.fromJson;

  @override
  int get currentPage;
  @override
  int get pageSize;
  @override
  List<int> get pageSizeOptions;
  @override
  int get totalPages;
  @override
  int get totalItems;
  @override
  bool get showPageSizeSelector;
  @override
  bool get showPageInfo;

  /// Create a copy of PaginationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginationConfigImplCopyWith<_$PaginationConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SortConfig _$SortConfigFromJson(Map<String, dynamic> json) {
  return _SortConfig.fromJson(json);
}

/// @nodoc
mixin _$SortConfig {
  String? get field => throw _privateConstructorUsedError;
  SortDirection? get direction => throw _privateConstructorUsedError;
  bool get multiSort => throw _privateConstructorUsedError;
  List<SortItem>? get sortItems => throw _privateConstructorUsedError;

  /// Serializes this SortConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SortConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SortConfigCopyWith<SortConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SortConfigCopyWith<$Res> {
  factory $SortConfigCopyWith(
          SortConfig value, $Res Function(SortConfig) then) =
      _$SortConfigCopyWithImpl<$Res, SortConfig>;
  @useResult
  $Res call(
      {String? field,
      SortDirection? direction,
      bool multiSort,
      List<SortItem>? sortItems});
}

/// @nodoc
class _$SortConfigCopyWithImpl<$Res, $Val extends SortConfig>
    implements $SortConfigCopyWith<$Res> {
  _$SortConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SortConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = freezed,
    Object? direction = freezed,
    Object? multiSort = null,
    Object? sortItems = freezed,
  }) {
    return _then(_value.copyWith(
      field: freezed == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as SortDirection?,
      multiSort: null == multiSort
          ? _value.multiSort
          : multiSort // ignore: cast_nullable_to_non_nullable
              as bool,
      sortItems: freezed == sortItems
          ? _value.sortItems
          : sortItems // ignore: cast_nullable_to_non_nullable
              as List<SortItem>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SortConfigImplCopyWith<$Res>
    implements $SortConfigCopyWith<$Res> {
  factory _$$SortConfigImplCopyWith(
          _$SortConfigImpl value, $Res Function(_$SortConfigImpl) then) =
      __$$SortConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? field,
      SortDirection? direction,
      bool multiSort,
      List<SortItem>? sortItems});
}

/// @nodoc
class __$$SortConfigImplCopyWithImpl<$Res>
    extends _$SortConfigCopyWithImpl<$Res, _$SortConfigImpl>
    implements _$$SortConfigImplCopyWith<$Res> {
  __$$SortConfigImplCopyWithImpl(
      _$SortConfigImpl _value, $Res Function(_$SortConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of SortConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = freezed,
    Object? direction = freezed,
    Object? multiSort = null,
    Object? sortItems = freezed,
  }) {
    return _then(_$SortConfigImpl(
      field: freezed == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as SortDirection?,
      multiSort: null == multiSort
          ? _value.multiSort
          : multiSort // ignore: cast_nullable_to_non_nullable
              as bool,
      sortItems: freezed == sortItems
          ? _value._sortItems
          : sortItems // ignore: cast_nullable_to_non_nullable
              as List<SortItem>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SortConfigImpl implements _SortConfig {
  const _$SortConfigImpl(
      {this.field,
      this.direction,
      this.multiSort = false,
      final List<SortItem>? sortItems})
      : _sortItems = sortItems;

  factory _$SortConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$SortConfigImplFromJson(json);

  @override
  final String? field;
  @override
  final SortDirection? direction;
  @override
  @JsonKey()
  final bool multiSort;
  final List<SortItem>? _sortItems;
  @override
  List<SortItem>? get sortItems {
    final value = _sortItems;
    if (value == null) return null;
    if (_sortItems is EqualUnmodifiableListView) return _sortItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SortConfig(field: $field, direction: $direction, multiSort: $multiSort, sortItems: $sortItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SortConfigImpl &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.multiSort, multiSort) ||
                other.multiSort == multiSort) &&
            const DeepCollectionEquality()
                .equals(other._sortItems, _sortItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, field, direction, multiSort,
      const DeepCollectionEquality().hash(_sortItems));

  /// Create a copy of SortConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SortConfigImplCopyWith<_$SortConfigImpl> get copyWith =>
      __$$SortConfigImplCopyWithImpl<_$SortConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SortConfigImplToJson(
      this,
    );
  }
}

abstract class _SortConfig implements SortConfig {
  const factory _SortConfig(
      {final String? field,
      final SortDirection? direction,
      final bool multiSort,
      final List<SortItem>? sortItems}) = _$SortConfigImpl;

  factory _SortConfig.fromJson(Map<String, dynamic> json) =
      _$SortConfigImpl.fromJson;

  @override
  String? get field;
  @override
  SortDirection? get direction;
  @override
  bool get multiSort;
  @override
  List<SortItem>? get sortItems;

  /// Create a copy of SortConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SortConfigImplCopyWith<_$SortConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SortItem _$SortItemFromJson(Map<String, dynamic> json) {
  return _SortItem.fromJson(json);
}

/// @nodoc
mixin _$SortItem {
  String get field => throw _privateConstructorUsedError;
  SortDirection get direction => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;

  /// Serializes this SortItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SortItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SortItemCopyWith<SortItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SortItemCopyWith<$Res> {
  factory $SortItemCopyWith(SortItem value, $Res Function(SortItem) then) =
      _$SortItemCopyWithImpl<$Res, SortItem>;
  @useResult
  $Res call({String field, SortDirection direction, int priority});
}

/// @nodoc
class _$SortItemCopyWithImpl<$Res, $Val extends SortItem>
    implements $SortItemCopyWith<$Res> {
  _$SortItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SortItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? direction = null,
    Object? priority = null,
  }) {
    return _then(_value.copyWith(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as SortDirection,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SortItemImplCopyWith<$Res>
    implements $SortItemCopyWith<$Res> {
  factory _$$SortItemImplCopyWith(
          _$SortItemImpl value, $Res Function(_$SortItemImpl) then) =
      __$$SortItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String field, SortDirection direction, int priority});
}

/// @nodoc
class __$$SortItemImplCopyWithImpl<$Res>
    extends _$SortItemCopyWithImpl<$Res, _$SortItemImpl>
    implements _$$SortItemImplCopyWith<$Res> {
  __$$SortItemImplCopyWithImpl(
      _$SortItemImpl _value, $Res Function(_$SortItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of SortItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? direction = null,
    Object? priority = null,
  }) {
    return _then(_$SortItemImpl(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as SortDirection,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SortItemImpl implements _SortItem {
  const _$SortItemImpl(
      {required this.field, required this.direction, this.priority = 0});

  factory _$SortItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$SortItemImplFromJson(json);

  @override
  final String field;
  @override
  final SortDirection direction;
  @override
  @JsonKey()
  final int priority;

  @override
  String toString() {
    return 'SortItem(field: $field, direction: $direction, priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SortItemImpl &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, field, direction, priority);

  /// Create a copy of SortItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SortItemImplCopyWith<_$SortItemImpl> get copyWith =>
      __$$SortItemImplCopyWithImpl<_$SortItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SortItemImplToJson(
      this,
    );
  }
}

abstract class _SortItem implements SortItem {
  const factory _SortItem(
      {required final String field,
      required final SortDirection direction,
      final int priority}) = _$SortItemImpl;

  factory _SortItem.fromJson(Map<String, dynamic> json) =
      _$SortItemImpl.fromJson;

  @override
  String get field;
  @override
  SortDirection get direction;
  @override
  int get priority;

  /// Create a copy of SortItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SortItemImplCopyWith<_$SortItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FilterConfig _$FilterConfigFromJson(Map<String, dynamic> json) {
  return _FilterConfig.fromJson(json);
}

/// @nodoc
mixin _$FilterConfig {
  String get field => throw _privateConstructorUsedError;
  FilterType get type => throw _privateConstructorUsedError;
  dynamic get value => throw _privateConstructorUsedError;
  String? get operator => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  List<SelectOption>? get options =>
      throw _privateConstructorUsedError; // For select filters
  dynamic get min => throw _privateConstructorUsedError; // For range filters
  dynamic get max => throw _privateConstructorUsedError; // For range filters
  @JsonKey(includeFromJson: false, includeToJson: false)
  Widget Function(FilterConfig, dynamic Function(dynamic))? get customFilter =>
      throw _privateConstructorUsedError;

  /// Serializes this FilterConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FilterConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FilterConfigCopyWith<FilterConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterConfigCopyWith<$Res> {
  factory $FilterConfigCopyWith(
          FilterConfig value, $Res Function(FilterConfig) then) =
      _$FilterConfigCopyWithImpl<$Res, FilterConfig>;
  @useResult
  $Res call(
      {String field,
      FilterType type,
      dynamic value,
      String? operator,
      String? label,
      List<SelectOption>? options,
      dynamic min,
      dynamic max,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Widget Function(FilterConfig, dynamic Function(dynamic))? customFilter});
}

/// @nodoc
class _$FilterConfigCopyWithImpl<$Res, $Val extends FilterConfig>
    implements $FilterConfigCopyWith<$Res> {
  _$FilterConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FilterConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? type = null,
    Object? value = freezed,
    Object? operator = freezed,
    Object? label = freezed,
    Object? options = freezed,
    Object? min = freezed,
    Object? max = freezed,
    Object? customFilter = freezed,
  }) {
    return _then(_value.copyWith(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FilterType,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
      operator: freezed == operator
          ? _value.operator
          : operator // ignore: cast_nullable_to_non_nullable
              as String?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      options: freezed == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<SelectOption>?,
      min: freezed == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as dynamic,
      max: freezed == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as dynamic,
      customFilter: freezed == customFilter
          ? _value.customFilter
          : customFilter // ignore: cast_nullable_to_non_nullable
              as Widget Function(FilterConfig, dynamic Function(dynamic))?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FilterConfigImplCopyWith<$Res>
    implements $FilterConfigCopyWith<$Res> {
  factory _$$FilterConfigImplCopyWith(
          _$FilterConfigImpl value, $Res Function(_$FilterConfigImpl) then) =
      __$$FilterConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String field,
      FilterType type,
      dynamic value,
      String? operator,
      String? label,
      List<SelectOption>? options,
      dynamic min,
      dynamic max,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Widget Function(FilterConfig, dynamic Function(dynamic))? customFilter});
}

/// @nodoc
class __$$FilterConfigImplCopyWithImpl<$Res>
    extends _$FilterConfigCopyWithImpl<$Res, _$FilterConfigImpl>
    implements _$$FilterConfigImplCopyWith<$Res> {
  __$$FilterConfigImplCopyWithImpl(
      _$FilterConfigImpl _value, $Res Function(_$FilterConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilterConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? type = null,
    Object? value = freezed,
    Object? operator = freezed,
    Object? label = freezed,
    Object? options = freezed,
    Object? min = freezed,
    Object? max = freezed,
    Object? customFilter = freezed,
  }) {
    return _then(_$FilterConfigImpl(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FilterType,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
      operator: freezed == operator
          ? _value.operator
          : operator // ignore: cast_nullable_to_non_nullable
              as String?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      options: freezed == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<SelectOption>?,
      min: freezed == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as dynamic,
      max: freezed == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as dynamic,
      customFilter: freezed == customFilter
          ? _value.customFilter
          : customFilter // ignore: cast_nullable_to_non_nullable
              as Widget Function(FilterConfig, dynamic Function(dynamic))?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FilterConfigImpl implements _FilterConfig {
  const _$FilterConfigImpl(
      {required this.field,
      required this.type,
      this.value,
      this.operator,
      this.label,
      final List<SelectOption>? options,
      this.min,
      this.max,
      @JsonKey(includeFromJson: false, includeToJson: false) this.customFilter})
      : _options = options;

  factory _$FilterConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilterConfigImplFromJson(json);

  @override
  final String field;
  @override
  final FilterType type;
  @override
  final dynamic value;
  @override
  final String? operator;
  @override
  final String? label;
  final List<SelectOption>? _options;
  @override
  List<SelectOption>? get options {
    final value = _options;
    if (value == null) return null;
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// For select filters
  @override
  final dynamic min;
// For range filters
  @override
  final dynamic max;
// For range filters
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Widget Function(FilterConfig, dynamic Function(dynamic))? customFilter;

  @override
  String toString() {
    return 'FilterConfig(field: $field, type: $type, value: $value, operator: $operator, label: $label, options: $options, min: $min, max: $max, customFilter: $customFilter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterConfigImpl &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            (identical(other.operator, operator) ||
                other.operator == operator) &&
            (identical(other.label, label) || other.label == label) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            const DeepCollectionEquality().equals(other.min, min) &&
            const DeepCollectionEquality().equals(other.max, max) &&
            (identical(other.customFilter, customFilter) ||
                other.customFilter == customFilter));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      field,
      type,
      const DeepCollectionEquality().hash(value),
      operator,
      label,
      const DeepCollectionEquality().hash(_options),
      const DeepCollectionEquality().hash(min),
      const DeepCollectionEquality().hash(max),
      customFilter);

  /// Create a copy of FilterConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterConfigImplCopyWith<_$FilterConfigImpl> get copyWith =>
      __$$FilterConfigImplCopyWithImpl<_$FilterConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FilterConfigImplToJson(
      this,
    );
  }
}

abstract class _FilterConfig implements FilterConfig {
  const factory _FilterConfig(
      {required final String field,
      required final FilterType type,
      final dynamic value,
      final String? operator,
      final String? label,
      final List<SelectOption>? options,
      final dynamic min,
      final dynamic max,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Widget Function(FilterConfig, dynamic Function(dynamic))?
          customFilter}) = _$FilterConfigImpl;

  factory _FilterConfig.fromJson(Map<String, dynamic> json) =
      _$FilterConfigImpl.fromJson;

  @override
  String get field;
  @override
  FilterType get type;
  @override
  dynamic get value;
  @override
  String? get operator;
  @override
  String? get label;
  @override
  List<SelectOption>? get options; // For select filters
  @override
  dynamic get min; // For range filters
  @override
  dynamic get max; // For range filters
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Widget Function(FilterConfig, dynamic Function(dynamic))? get customFilter;

  /// Create a copy of FilterConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterConfigImplCopyWith<_$FilterConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SelectOption _$SelectOptionFromJson(Map<String, dynamic> json) {
  return _SelectOption.fromJson(json);
}

/// @nodoc
mixin _$SelectOption {
  dynamic get value => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  bool get disabled => throw _privateConstructorUsedError;

  /// Serializes this SelectOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SelectOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectOptionCopyWith<SelectOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectOptionCopyWith<$Res> {
  factory $SelectOptionCopyWith(
          SelectOption value, $Res Function(SelectOption) then) =
      _$SelectOptionCopyWithImpl<$Res, SelectOption>;
  @useResult
  $Res call({dynamic value, String label, bool disabled});
}

/// @nodoc
class _$SelectOptionCopyWithImpl<$Res, $Val extends SelectOption>
    implements $SelectOptionCopyWith<$Res> {
  _$SelectOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? label = null,
    Object? disabled = null,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      disabled: null == disabled
          ? _value.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectOptionImplCopyWith<$Res>
    implements $SelectOptionCopyWith<$Res> {
  factory _$$SelectOptionImplCopyWith(
          _$SelectOptionImpl value, $Res Function(_$SelectOptionImpl) then) =
      __$$SelectOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic value, String label, bool disabled});
}

/// @nodoc
class __$$SelectOptionImplCopyWithImpl<$Res>
    extends _$SelectOptionCopyWithImpl<$Res, _$SelectOptionImpl>
    implements _$$SelectOptionImplCopyWith<$Res> {
  __$$SelectOptionImplCopyWithImpl(
      _$SelectOptionImpl _value, $Res Function(_$SelectOptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? label = null,
    Object? disabled = null,
  }) {
    return _then(_$SelectOptionImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      disabled: null == disabled
          ? _value.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SelectOptionImpl implements _SelectOption {
  const _$SelectOptionImpl(
      {required this.value, required this.label, this.disabled = false});

  factory _$SelectOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SelectOptionImplFromJson(json);

  @override
  final dynamic value;
  @override
  final String label;
  @override
  @JsonKey()
  final bool disabled;

  @override
  String toString() {
    return 'SelectOption(value: $value, label: $label, disabled: $disabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectOptionImpl &&
            const DeepCollectionEquality().equals(other.value, value) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.disabled, disabled) ||
                other.disabled == disabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(value), label, disabled);

  /// Create a copy of SelectOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectOptionImplCopyWith<_$SelectOptionImpl> get copyWith =>
      __$$SelectOptionImplCopyWithImpl<_$SelectOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SelectOptionImplToJson(
      this,
    );
  }
}

abstract class _SelectOption implements SelectOption {
  const factory _SelectOption(
      {required final dynamic value,
      required final String label,
      final bool disabled}) = _$SelectOptionImpl;

  factory _SelectOption.fromJson(Map<String, dynamic> json) =
      _$SelectOptionImpl.fromJson;

  @override
  dynamic get value;
  @override
  String get label;
  @override
  bool get disabled;

  /// Create a copy of SelectOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectOptionImplCopyWith<_$SelectOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SelectionConfig _$SelectionConfigFromJson(Map<String, dynamic> json) {
  return _SelectionConfig.fromJson(json);
}

/// @nodoc
mixin _$SelectionConfig {
  SelectionMode get mode => throw _privateConstructorUsedError;
  List<String> get selectedIds => throw _privateConstructorUsedError;
  bool get showCheckboxes => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  dynamic Function(List<String>)? get onSelectionChanged =>
      throw _privateConstructorUsedError;

  /// Serializes this SelectionConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SelectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectionConfigCopyWith<SelectionConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectionConfigCopyWith<$Res> {
  factory $SelectionConfigCopyWith(
          SelectionConfig value, $Res Function(SelectionConfig) then) =
      _$SelectionConfigCopyWithImpl<$Res, SelectionConfig>;
  @useResult
  $Res call(
      {SelectionMode mode,
      List<String> selectedIds,
      bool showCheckboxes,
      @JsonKey(includeFromJson: false, includeToJson: false)
      dynamic Function(List<String>)? onSelectionChanged});
}

/// @nodoc
class _$SelectionConfigCopyWithImpl<$Res, $Val extends SelectionConfig>
    implements $SelectionConfigCopyWith<$Res> {
  _$SelectionConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? selectedIds = null,
    Object? showCheckboxes = null,
    Object? onSelectionChanged = freezed,
  }) {
    return _then(_value.copyWith(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as SelectionMode,
      selectedIds: null == selectedIds
          ? _value.selectedIds
          : selectedIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      showCheckboxes: null == showCheckboxes
          ? _value.showCheckboxes
          : showCheckboxes // ignore: cast_nullable_to_non_nullable
              as bool,
      onSelectionChanged: freezed == onSelectionChanged
          ? _value.onSelectionChanged
          : onSelectionChanged // ignore: cast_nullable_to_non_nullable
              as dynamic Function(List<String>)?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectionConfigImplCopyWith<$Res>
    implements $SelectionConfigCopyWith<$Res> {
  factory _$$SelectionConfigImplCopyWith(_$SelectionConfigImpl value,
          $Res Function(_$SelectionConfigImpl) then) =
      __$$SelectionConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SelectionMode mode,
      List<String> selectedIds,
      bool showCheckboxes,
      @JsonKey(includeFromJson: false, includeToJson: false)
      dynamic Function(List<String>)? onSelectionChanged});
}

/// @nodoc
class __$$SelectionConfigImplCopyWithImpl<$Res>
    extends _$SelectionConfigCopyWithImpl<$Res, _$SelectionConfigImpl>
    implements _$$SelectionConfigImplCopyWith<$Res> {
  __$$SelectionConfigImplCopyWithImpl(
      _$SelectionConfigImpl _value, $Res Function(_$SelectionConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? selectedIds = null,
    Object? showCheckboxes = null,
    Object? onSelectionChanged = freezed,
  }) {
    return _then(_$SelectionConfigImpl(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as SelectionMode,
      selectedIds: null == selectedIds
          ? _value._selectedIds
          : selectedIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      showCheckboxes: null == showCheckboxes
          ? _value.showCheckboxes
          : showCheckboxes // ignore: cast_nullable_to_non_nullable
              as bool,
      onSelectionChanged: freezed == onSelectionChanged
          ? _value.onSelectionChanged
          : onSelectionChanged // ignore: cast_nullable_to_non_nullable
              as dynamic Function(List<String>)?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SelectionConfigImpl implements _SelectionConfig {
  const _$SelectionConfigImpl(
      {this.mode = SelectionMode.none,
      final List<String> selectedIds = const [],
      this.showCheckboxes = true,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.onSelectionChanged})
      : _selectedIds = selectedIds;

  factory _$SelectionConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$SelectionConfigImplFromJson(json);

  @override
  @JsonKey()
  final SelectionMode mode;
  final List<String> _selectedIds;
  @override
  @JsonKey()
  List<String> get selectedIds {
    if (_selectedIds is EqualUnmodifiableListView) return _selectedIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedIds);
  }

  @override
  @JsonKey()
  final bool showCheckboxes;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final dynamic Function(List<String>)? onSelectionChanged;

  @override
  String toString() {
    return 'SelectionConfig(mode: $mode, selectedIds: $selectedIds, showCheckboxes: $showCheckboxes, onSelectionChanged: $onSelectionChanged)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectionConfigImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            const DeepCollectionEquality()
                .equals(other._selectedIds, _selectedIds) &&
            (identical(other.showCheckboxes, showCheckboxes) ||
                other.showCheckboxes == showCheckboxes) &&
            (identical(other.onSelectionChanged, onSelectionChanged) ||
                other.onSelectionChanged == onSelectionChanged));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      mode,
      const DeepCollectionEquality().hash(_selectedIds),
      showCheckboxes,
      onSelectionChanged);

  /// Create a copy of SelectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectionConfigImplCopyWith<_$SelectionConfigImpl> get copyWith =>
      __$$SelectionConfigImplCopyWithImpl<_$SelectionConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SelectionConfigImplToJson(
      this,
    );
  }
}

abstract class _SelectionConfig implements SelectionConfig {
  const factory _SelectionConfig(
          {final SelectionMode mode,
          final List<String> selectedIds,
          final bool showCheckboxes,
          @JsonKey(includeFromJson: false, includeToJson: false)
          final dynamic Function(List<String>)? onSelectionChanged}) =
      _$SelectionConfigImpl;

  factory _SelectionConfig.fromJson(Map<String, dynamic> json) =
      _$SelectionConfigImpl.fromJson;

  @override
  SelectionMode get mode;
  @override
  List<String> get selectedIds;
  @override
  bool get showCheckboxes;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  dynamic Function(List<String>)? get onSelectionChanged;

  /// Create a copy of SelectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectionConfigImplCopyWith<_$SelectionConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GroupConfig _$GroupConfigFromJson(Map<String, dynamic> json) {
  return _GroupConfig.fromJson(json);
}

/// @nodoc
mixin _$GroupConfig {
  String get field => throw _privateConstructorUsedError;
  bool get collapsible => throw _privateConstructorUsedError;
  Map<String, bool> get expandedGroups => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String Function(dynamic)? get groupLabelFormatter =>
      throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Widget Function(String, List<TableRowData>)? get groupHeaderRenderer =>
      throw _privateConstructorUsedError;

  /// Serializes this GroupConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupConfigCopyWith<GroupConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupConfigCopyWith<$Res> {
  factory $GroupConfigCopyWith(
          GroupConfig value, $Res Function(GroupConfig) then) =
      _$GroupConfigCopyWithImpl<$Res, GroupConfig>;
  @useResult
  $Res call(
      {String field,
      bool collapsible,
      Map<String, bool> expandedGroups,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String Function(dynamic)? groupLabelFormatter,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Widget Function(String, List<TableRowData>)? groupHeaderRenderer});
}

/// @nodoc
class _$GroupConfigCopyWithImpl<$Res, $Val extends GroupConfig>
    implements $GroupConfigCopyWith<$Res> {
  _$GroupConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? collapsible = null,
    Object? expandedGroups = null,
    Object? groupLabelFormatter = freezed,
    Object? groupHeaderRenderer = freezed,
  }) {
    return _then(_value.copyWith(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      collapsible: null == collapsible
          ? _value.collapsible
          : collapsible // ignore: cast_nullable_to_non_nullable
              as bool,
      expandedGroups: null == expandedGroups
          ? _value.expandedGroups
          : expandedGroups // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      groupLabelFormatter: freezed == groupLabelFormatter
          ? _value.groupLabelFormatter
          : groupLabelFormatter // ignore: cast_nullable_to_non_nullable
              as String Function(dynamic)?,
      groupHeaderRenderer: freezed == groupHeaderRenderer
          ? _value.groupHeaderRenderer
          : groupHeaderRenderer // ignore: cast_nullable_to_non_nullable
              as Widget Function(String, List<TableRowData>)?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupConfigImplCopyWith<$Res>
    implements $GroupConfigCopyWith<$Res> {
  factory _$$GroupConfigImplCopyWith(
          _$GroupConfigImpl value, $Res Function(_$GroupConfigImpl) then) =
      __$$GroupConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String field,
      bool collapsible,
      Map<String, bool> expandedGroups,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String Function(dynamic)? groupLabelFormatter,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Widget Function(String, List<TableRowData>)? groupHeaderRenderer});
}

/// @nodoc
class __$$GroupConfigImplCopyWithImpl<$Res>
    extends _$GroupConfigCopyWithImpl<$Res, _$GroupConfigImpl>
    implements _$$GroupConfigImplCopyWith<$Res> {
  __$$GroupConfigImplCopyWithImpl(
      _$GroupConfigImpl _value, $Res Function(_$GroupConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? collapsible = null,
    Object? expandedGroups = null,
    Object? groupLabelFormatter = freezed,
    Object? groupHeaderRenderer = freezed,
  }) {
    return _then(_$GroupConfigImpl(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      collapsible: null == collapsible
          ? _value.collapsible
          : collapsible // ignore: cast_nullable_to_non_nullable
              as bool,
      expandedGroups: null == expandedGroups
          ? _value._expandedGroups
          : expandedGroups // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      groupLabelFormatter: freezed == groupLabelFormatter
          ? _value.groupLabelFormatter
          : groupLabelFormatter // ignore: cast_nullable_to_non_nullable
              as String Function(dynamic)?,
      groupHeaderRenderer: freezed == groupHeaderRenderer
          ? _value.groupHeaderRenderer
          : groupHeaderRenderer // ignore: cast_nullable_to_non_nullable
              as Widget Function(String, List<TableRowData>)?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupConfigImpl implements _GroupConfig {
  const _$GroupConfigImpl(
      {required this.field,
      this.collapsible = true,
      final Map<String, bool> expandedGroups = const {},
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.groupLabelFormatter,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.groupHeaderRenderer})
      : _expandedGroups = expandedGroups;

  factory _$GroupConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupConfigImplFromJson(json);

  @override
  final String field;
  @override
  @JsonKey()
  final bool collapsible;
  final Map<String, bool> _expandedGroups;
  @override
  @JsonKey()
  Map<String, bool> get expandedGroups {
    if (_expandedGroups is EqualUnmodifiableMapView) return _expandedGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_expandedGroups);
  }

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(dynamic)? groupLabelFormatter;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Widget Function(String, List<TableRowData>)? groupHeaderRenderer;

  @override
  String toString() {
    return 'GroupConfig(field: $field, collapsible: $collapsible, expandedGroups: $expandedGroups, groupLabelFormatter: $groupLabelFormatter, groupHeaderRenderer: $groupHeaderRenderer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupConfigImpl &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.collapsible, collapsible) ||
                other.collapsible == collapsible) &&
            const DeepCollectionEquality()
                .equals(other._expandedGroups, _expandedGroups) &&
            (identical(other.groupLabelFormatter, groupLabelFormatter) ||
                other.groupLabelFormatter == groupLabelFormatter) &&
            (identical(other.groupHeaderRenderer, groupHeaderRenderer) ||
                other.groupHeaderRenderer == groupHeaderRenderer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      field,
      collapsible,
      const DeepCollectionEquality().hash(_expandedGroups),
      groupLabelFormatter,
      groupHeaderRenderer);

  /// Create a copy of GroupConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupConfigImplCopyWith<_$GroupConfigImpl> get copyWith =>
      __$$GroupConfigImplCopyWithImpl<_$GroupConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupConfigImplToJson(
      this,
    );
  }
}

abstract class _GroupConfig implements GroupConfig {
  const factory _GroupConfig(
      {required final String field,
      final bool collapsible,
      final Map<String, bool> expandedGroups,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final String Function(dynamic)? groupLabelFormatter,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Widget Function(String, List<TableRowData>)?
          groupHeaderRenderer}) = _$GroupConfigImpl;

  factory _GroupConfig.fromJson(Map<String, dynamic> json) =
      _$GroupConfigImpl.fromJson;

  @override
  String get field;
  @override
  bool get collapsible;
  @override
  Map<String, bool> get expandedGroups;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String Function(dynamic)? get groupLabelFormatter;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Widget Function(String, List<TableRowData>)? get groupHeaderRenderer;

  /// Create a copy of GroupConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupConfigImplCopyWith<_$GroupConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GroupingConfig _$GroupingConfigFromJson(Map<String, dynamic> json) {
  return _GroupingConfig.fromJson(json);
}

/// @nodoc
mixin _$GroupingConfig {
  String get groupBy => throw _privateConstructorUsedError;
  bool get sortGroups => throw _privateConstructorUsedError;
  bool get showAggregates => throw _privateConstructorUsedError;
  Map<String, AggregateType> get aggregates =>
      throw _privateConstructorUsedError;
  Map<String, bool> get expandedGroups => throw _privateConstructorUsedError;

  /// Serializes this GroupingConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupingConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupingConfigCopyWith<GroupingConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupingConfigCopyWith<$Res> {
  factory $GroupingConfigCopyWith(
          GroupingConfig value, $Res Function(GroupingConfig) then) =
      _$GroupingConfigCopyWithImpl<$Res, GroupingConfig>;
  @useResult
  $Res call(
      {String groupBy,
      bool sortGroups,
      bool showAggregates,
      Map<String, AggregateType> aggregates,
      Map<String, bool> expandedGroups});
}

/// @nodoc
class _$GroupingConfigCopyWithImpl<$Res, $Val extends GroupingConfig>
    implements $GroupingConfigCopyWith<$Res> {
  _$GroupingConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupingConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupBy = null,
    Object? sortGroups = null,
    Object? showAggregates = null,
    Object? aggregates = null,
    Object? expandedGroups = null,
  }) {
    return _then(_value.copyWith(
      groupBy: null == groupBy
          ? _value.groupBy
          : groupBy // ignore: cast_nullable_to_non_nullable
              as String,
      sortGroups: null == sortGroups
          ? _value.sortGroups
          : sortGroups // ignore: cast_nullable_to_non_nullable
              as bool,
      showAggregates: null == showAggregates
          ? _value.showAggregates
          : showAggregates // ignore: cast_nullable_to_non_nullable
              as bool,
      aggregates: null == aggregates
          ? _value.aggregates
          : aggregates // ignore: cast_nullable_to_non_nullable
              as Map<String, AggregateType>,
      expandedGroups: null == expandedGroups
          ? _value.expandedGroups
          : expandedGroups // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupingConfigImplCopyWith<$Res>
    implements $GroupingConfigCopyWith<$Res> {
  factory _$$GroupingConfigImplCopyWith(_$GroupingConfigImpl value,
          $Res Function(_$GroupingConfigImpl) then) =
      __$$GroupingConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String groupBy,
      bool sortGroups,
      bool showAggregates,
      Map<String, AggregateType> aggregates,
      Map<String, bool> expandedGroups});
}

/// @nodoc
class __$$GroupingConfigImplCopyWithImpl<$Res>
    extends _$GroupingConfigCopyWithImpl<$Res, _$GroupingConfigImpl>
    implements _$$GroupingConfigImplCopyWith<$Res> {
  __$$GroupingConfigImplCopyWithImpl(
      _$GroupingConfigImpl _value, $Res Function(_$GroupingConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupingConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupBy = null,
    Object? sortGroups = null,
    Object? showAggregates = null,
    Object? aggregates = null,
    Object? expandedGroups = null,
  }) {
    return _then(_$GroupingConfigImpl(
      groupBy: null == groupBy
          ? _value.groupBy
          : groupBy // ignore: cast_nullable_to_non_nullable
              as String,
      sortGroups: null == sortGroups
          ? _value.sortGroups
          : sortGroups // ignore: cast_nullable_to_non_nullable
              as bool,
      showAggregates: null == showAggregates
          ? _value.showAggregates
          : showAggregates // ignore: cast_nullable_to_non_nullable
              as bool,
      aggregates: null == aggregates
          ? _value._aggregates
          : aggregates // ignore: cast_nullable_to_non_nullable
              as Map<String, AggregateType>,
      expandedGroups: null == expandedGroups
          ? _value._expandedGroups
          : expandedGroups // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupingConfigImpl implements _GroupingConfig {
  const _$GroupingConfigImpl(
      {required this.groupBy,
      this.sortGroups = true,
      this.showAggregates = true,
      final Map<String, AggregateType> aggregates = const {},
      final Map<String, bool> expandedGroups = const {}})
      : _aggregates = aggregates,
        _expandedGroups = expandedGroups;

  factory _$GroupingConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupingConfigImplFromJson(json);

  @override
  final String groupBy;
  @override
  @JsonKey()
  final bool sortGroups;
  @override
  @JsonKey()
  final bool showAggregates;
  final Map<String, AggregateType> _aggregates;
  @override
  @JsonKey()
  Map<String, AggregateType> get aggregates {
    if (_aggregates is EqualUnmodifiableMapView) return _aggregates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_aggregates);
  }

  final Map<String, bool> _expandedGroups;
  @override
  @JsonKey()
  Map<String, bool> get expandedGroups {
    if (_expandedGroups is EqualUnmodifiableMapView) return _expandedGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_expandedGroups);
  }

  @override
  String toString() {
    return 'GroupingConfig(groupBy: $groupBy, sortGroups: $sortGroups, showAggregates: $showAggregates, aggregates: $aggregates, expandedGroups: $expandedGroups)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupingConfigImpl &&
            (identical(other.groupBy, groupBy) || other.groupBy == groupBy) &&
            (identical(other.sortGroups, sortGroups) ||
                other.sortGroups == sortGroups) &&
            (identical(other.showAggregates, showAggregates) ||
                other.showAggregates == showAggregates) &&
            const DeepCollectionEquality()
                .equals(other._aggregates, _aggregates) &&
            const DeepCollectionEquality()
                .equals(other._expandedGroups, _expandedGroups));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      groupBy,
      sortGroups,
      showAggregates,
      const DeepCollectionEquality().hash(_aggregates),
      const DeepCollectionEquality().hash(_expandedGroups));

  /// Create a copy of GroupingConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupingConfigImplCopyWith<_$GroupingConfigImpl> get copyWith =>
      __$$GroupingConfigImplCopyWithImpl<_$GroupingConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupingConfigImplToJson(
      this,
    );
  }
}

abstract class _GroupingConfig implements GroupingConfig {
  const factory _GroupingConfig(
      {required final String groupBy,
      final bool sortGroups,
      final bool showAggregates,
      final Map<String, AggregateType> aggregates,
      final Map<String, bool> expandedGroups}) = _$GroupingConfigImpl;

  factory _GroupingConfig.fromJson(Map<String, dynamic> json) =
      _$GroupingConfigImpl.fromJson;

  @override
  String get groupBy;
  @override
  bool get sortGroups;
  @override
  bool get showAggregates;
  @override
  Map<String, AggregateType> get aggregates;
  @override
  Map<String, bool> get expandedGroups;

  /// Create a copy of GroupingConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupingConfigImplCopyWith<_$GroupingConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TableSettings _$TableSettingsFromJson(Map<String, dynamic> json) {
  return _TableSettings.fromJson(json);
}

/// @nodoc
mixin _$TableSettings {
  bool get striped => throw _privateConstructorUsedError;
  bool get bordered => throw _privateConstructorUsedError;
  bool get hoverable => throw _privateConstructorUsedError;
  bool get dense => throw _privateConstructorUsedError;
  bool get showHeader => throw _privateConstructorUsedError;
  bool get stickyHeader => throw _privateConstructorUsedError;
  bool get stickyFirstColumn => throw _privateConstructorUsedError;
  bool get virtualScroll => throw _privateConstructorUsedError;
  double get rowHeight => throw _privateConstructorUsedError;
  double get headerHeight => throw _privateConstructorUsedError;
  bool get responsive => throw _privateConstructorUsedError;
  bool get showColumnToggle => throw _privateConstructorUsedError;
  bool get showExport => throw _privateConstructorUsedError;
  bool get showPrint => throw _privateConstructorUsedError;
  bool get showSearch => throw _privateConstructorUsedError;
  bool get showFilters => throw _privateConstructorUsedError;
  bool get showRefresh => throw _privateConstructorUsedError;
  List<BulkAction>? get bulkActions => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this TableSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TableSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TableSettingsCopyWith<TableSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableSettingsCopyWith<$Res> {
  factory $TableSettingsCopyWith(
          TableSettings value, $Res Function(TableSettings) then) =
      _$TableSettingsCopyWithImpl<$Res, TableSettings>;
  @useResult
  $Res call(
      {bool striped,
      bool bordered,
      bool hoverable,
      bool dense,
      bool showHeader,
      bool stickyHeader,
      bool stickyFirstColumn,
      bool virtualScroll,
      double rowHeight,
      double headerHeight,
      bool responsive,
      bool showColumnToggle,
      bool showExport,
      bool showPrint,
      bool showSearch,
      bool showFilters,
      bool showRefresh,
      List<BulkAction>? bulkActions,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$TableSettingsCopyWithImpl<$Res, $Val extends TableSettings>
    implements $TableSettingsCopyWith<$Res> {
  _$TableSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TableSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? striped = null,
    Object? bordered = null,
    Object? hoverable = null,
    Object? dense = null,
    Object? showHeader = null,
    Object? stickyHeader = null,
    Object? stickyFirstColumn = null,
    Object? virtualScroll = null,
    Object? rowHeight = null,
    Object? headerHeight = null,
    Object? responsive = null,
    Object? showColumnToggle = null,
    Object? showExport = null,
    Object? showPrint = null,
    Object? showSearch = null,
    Object? showFilters = null,
    Object? showRefresh = null,
    Object? bulkActions = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      striped: null == striped
          ? _value.striped
          : striped // ignore: cast_nullable_to_non_nullable
              as bool,
      bordered: null == bordered
          ? _value.bordered
          : bordered // ignore: cast_nullable_to_non_nullable
              as bool,
      hoverable: null == hoverable
          ? _value.hoverable
          : hoverable // ignore: cast_nullable_to_non_nullable
              as bool,
      dense: null == dense
          ? _value.dense
          : dense // ignore: cast_nullable_to_non_nullable
              as bool,
      showHeader: null == showHeader
          ? _value.showHeader
          : showHeader // ignore: cast_nullable_to_non_nullable
              as bool,
      stickyHeader: null == stickyHeader
          ? _value.stickyHeader
          : stickyHeader // ignore: cast_nullable_to_non_nullable
              as bool,
      stickyFirstColumn: null == stickyFirstColumn
          ? _value.stickyFirstColumn
          : stickyFirstColumn // ignore: cast_nullable_to_non_nullable
              as bool,
      virtualScroll: null == virtualScroll
          ? _value.virtualScroll
          : virtualScroll // ignore: cast_nullable_to_non_nullable
              as bool,
      rowHeight: null == rowHeight
          ? _value.rowHeight
          : rowHeight // ignore: cast_nullable_to_non_nullable
              as double,
      headerHeight: null == headerHeight
          ? _value.headerHeight
          : headerHeight // ignore: cast_nullable_to_non_nullable
              as double,
      responsive: null == responsive
          ? _value.responsive
          : responsive // ignore: cast_nullable_to_non_nullable
              as bool,
      showColumnToggle: null == showColumnToggle
          ? _value.showColumnToggle
          : showColumnToggle // ignore: cast_nullable_to_non_nullable
              as bool,
      showExport: null == showExport
          ? _value.showExport
          : showExport // ignore: cast_nullable_to_non_nullable
              as bool,
      showPrint: null == showPrint
          ? _value.showPrint
          : showPrint // ignore: cast_nullable_to_non_nullable
              as bool,
      showSearch: null == showSearch
          ? _value.showSearch
          : showSearch // ignore: cast_nullable_to_non_nullable
              as bool,
      showFilters: null == showFilters
          ? _value.showFilters
          : showFilters // ignore: cast_nullable_to_non_nullable
              as bool,
      showRefresh: null == showRefresh
          ? _value.showRefresh
          : showRefresh // ignore: cast_nullable_to_non_nullable
              as bool,
      bulkActions: freezed == bulkActions
          ? _value.bulkActions
          : bulkActions // ignore: cast_nullable_to_non_nullable
              as List<BulkAction>?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TableSettingsImplCopyWith<$Res>
    implements $TableSettingsCopyWith<$Res> {
  factory _$$TableSettingsImplCopyWith(
          _$TableSettingsImpl value, $Res Function(_$TableSettingsImpl) then) =
      __$$TableSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool striped,
      bool bordered,
      bool hoverable,
      bool dense,
      bool showHeader,
      bool stickyHeader,
      bool stickyFirstColumn,
      bool virtualScroll,
      double rowHeight,
      double headerHeight,
      bool responsive,
      bool showColumnToggle,
      bool showExport,
      bool showPrint,
      bool showSearch,
      bool showFilters,
      bool showRefresh,
      List<BulkAction>? bulkActions,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$TableSettingsImplCopyWithImpl<$Res>
    extends _$TableSettingsCopyWithImpl<$Res, _$TableSettingsImpl>
    implements _$$TableSettingsImplCopyWith<$Res> {
  __$$TableSettingsImplCopyWithImpl(
      _$TableSettingsImpl _value, $Res Function(_$TableSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TableSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? striped = null,
    Object? bordered = null,
    Object? hoverable = null,
    Object? dense = null,
    Object? showHeader = null,
    Object? stickyHeader = null,
    Object? stickyFirstColumn = null,
    Object? virtualScroll = null,
    Object? rowHeight = null,
    Object? headerHeight = null,
    Object? responsive = null,
    Object? showColumnToggle = null,
    Object? showExport = null,
    Object? showPrint = null,
    Object? showSearch = null,
    Object? showFilters = null,
    Object? showRefresh = null,
    Object? bulkActions = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$TableSettingsImpl(
      striped: null == striped
          ? _value.striped
          : striped // ignore: cast_nullable_to_non_nullable
              as bool,
      bordered: null == bordered
          ? _value.bordered
          : bordered // ignore: cast_nullable_to_non_nullable
              as bool,
      hoverable: null == hoverable
          ? _value.hoverable
          : hoverable // ignore: cast_nullable_to_non_nullable
              as bool,
      dense: null == dense
          ? _value.dense
          : dense // ignore: cast_nullable_to_non_nullable
              as bool,
      showHeader: null == showHeader
          ? _value.showHeader
          : showHeader // ignore: cast_nullable_to_non_nullable
              as bool,
      stickyHeader: null == stickyHeader
          ? _value.stickyHeader
          : stickyHeader // ignore: cast_nullable_to_non_nullable
              as bool,
      stickyFirstColumn: null == stickyFirstColumn
          ? _value.stickyFirstColumn
          : stickyFirstColumn // ignore: cast_nullable_to_non_nullable
              as bool,
      virtualScroll: null == virtualScroll
          ? _value.virtualScroll
          : virtualScroll // ignore: cast_nullable_to_non_nullable
              as bool,
      rowHeight: null == rowHeight
          ? _value.rowHeight
          : rowHeight // ignore: cast_nullable_to_non_nullable
              as double,
      headerHeight: null == headerHeight
          ? _value.headerHeight
          : headerHeight // ignore: cast_nullable_to_non_nullable
              as double,
      responsive: null == responsive
          ? _value.responsive
          : responsive // ignore: cast_nullable_to_non_nullable
              as bool,
      showColumnToggle: null == showColumnToggle
          ? _value.showColumnToggle
          : showColumnToggle // ignore: cast_nullable_to_non_nullable
              as bool,
      showExport: null == showExport
          ? _value.showExport
          : showExport // ignore: cast_nullable_to_non_nullable
              as bool,
      showPrint: null == showPrint
          ? _value.showPrint
          : showPrint // ignore: cast_nullable_to_non_nullable
              as bool,
      showSearch: null == showSearch
          ? _value.showSearch
          : showSearch // ignore: cast_nullable_to_non_nullable
              as bool,
      showFilters: null == showFilters
          ? _value.showFilters
          : showFilters // ignore: cast_nullable_to_non_nullable
              as bool,
      showRefresh: null == showRefresh
          ? _value.showRefresh
          : showRefresh // ignore: cast_nullable_to_non_nullable
              as bool,
      bulkActions: freezed == bulkActions
          ? _value._bulkActions
          : bulkActions // ignore: cast_nullable_to_non_nullable
              as List<BulkAction>?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TableSettingsImpl implements _TableSettings {
  const _$TableSettingsImpl(
      {this.striped = true,
      this.bordered = true,
      this.hoverable = true,
      this.dense = false,
      this.showHeader = true,
      this.stickyHeader = false,
      this.stickyFirstColumn = false,
      this.virtualScroll = false,
      this.rowHeight = 50,
      this.headerHeight = 50,
      this.responsive = true,
      this.showColumnToggle = true,
      this.showExport = true,
      this.showPrint = true,
      this.showSearch = true,
      this.showFilters = true,
      this.showRefresh = true,
      final List<BulkAction>? bulkActions,
      final Map<String, dynamic>? metadata})
      : _bulkActions = bulkActions,
        _metadata = metadata;

  factory _$TableSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TableSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool striped;
  @override
  @JsonKey()
  final bool bordered;
  @override
  @JsonKey()
  final bool hoverable;
  @override
  @JsonKey()
  final bool dense;
  @override
  @JsonKey()
  final bool showHeader;
  @override
  @JsonKey()
  final bool stickyHeader;
  @override
  @JsonKey()
  final bool stickyFirstColumn;
  @override
  @JsonKey()
  final bool virtualScroll;
  @override
  @JsonKey()
  final double rowHeight;
  @override
  @JsonKey()
  final double headerHeight;
  @override
  @JsonKey()
  final bool responsive;
  @override
  @JsonKey()
  final bool showColumnToggle;
  @override
  @JsonKey()
  final bool showExport;
  @override
  @JsonKey()
  final bool showPrint;
  @override
  @JsonKey()
  final bool showSearch;
  @override
  @JsonKey()
  final bool showFilters;
  @override
  @JsonKey()
  final bool showRefresh;
  final List<BulkAction>? _bulkActions;
  @override
  List<BulkAction>? get bulkActions {
    final value = _bulkActions;
    if (value == null) return null;
    if (_bulkActions is EqualUnmodifiableListView) return _bulkActions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'TableSettings(striped: $striped, bordered: $bordered, hoverable: $hoverable, dense: $dense, showHeader: $showHeader, stickyHeader: $stickyHeader, stickyFirstColumn: $stickyFirstColumn, virtualScroll: $virtualScroll, rowHeight: $rowHeight, headerHeight: $headerHeight, responsive: $responsive, showColumnToggle: $showColumnToggle, showExport: $showExport, showPrint: $showPrint, showSearch: $showSearch, showFilters: $showFilters, showRefresh: $showRefresh, bulkActions: $bulkActions, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableSettingsImpl &&
            (identical(other.striped, striped) || other.striped == striped) &&
            (identical(other.bordered, bordered) ||
                other.bordered == bordered) &&
            (identical(other.hoverable, hoverable) ||
                other.hoverable == hoverable) &&
            (identical(other.dense, dense) || other.dense == dense) &&
            (identical(other.showHeader, showHeader) ||
                other.showHeader == showHeader) &&
            (identical(other.stickyHeader, stickyHeader) ||
                other.stickyHeader == stickyHeader) &&
            (identical(other.stickyFirstColumn, stickyFirstColumn) ||
                other.stickyFirstColumn == stickyFirstColumn) &&
            (identical(other.virtualScroll, virtualScroll) ||
                other.virtualScroll == virtualScroll) &&
            (identical(other.rowHeight, rowHeight) ||
                other.rowHeight == rowHeight) &&
            (identical(other.headerHeight, headerHeight) ||
                other.headerHeight == headerHeight) &&
            (identical(other.responsive, responsive) ||
                other.responsive == responsive) &&
            (identical(other.showColumnToggle, showColumnToggle) ||
                other.showColumnToggle == showColumnToggle) &&
            (identical(other.showExport, showExport) ||
                other.showExport == showExport) &&
            (identical(other.showPrint, showPrint) ||
                other.showPrint == showPrint) &&
            (identical(other.showSearch, showSearch) ||
                other.showSearch == showSearch) &&
            (identical(other.showFilters, showFilters) ||
                other.showFilters == showFilters) &&
            (identical(other.showRefresh, showRefresh) ||
                other.showRefresh == showRefresh) &&
            const DeepCollectionEquality()
                .equals(other._bulkActions, _bulkActions) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        striped,
        bordered,
        hoverable,
        dense,
        showHeader,
        stickyHeader,
        stickyFirstColumn,
        virtualScroll,
        rowHeight,
        headerHeight,
        responsive,
        showColumnToggle,
        showExport,
        showPrint,
        showSearch,
        showFilters,
        showRefresh,
        const DeepCollectionEquality().hash(_bulkActions),
        const DeepCollectionEquality().hash(_metadata)
      ]);

  /// Create a copy of TableSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TableSettingsImplCopyWith<_$TableSettingsImpl> get copyWith =>
      __$$TableSettingsImplCopyWithImpl<_$TableSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TableSettingsImplToJson(
      this,
    );
  }
}

abstract class _TableSettings implements TableSettings {
  const factory _TableSettings(
      {final bool striped,
      final bool bordered,
      final bool hoverable,
      final bool dense,
      final bool showHeader,
      final bool stickyHeader,
      final bool stickyFirstColumn,
      final bool virtualScroll,
      final double rowHeight,
      final double headerHeight,
      final bool responsive,
      final bool showColumnToggle,
      final bool showExport,
      final bool showPrint,
      final bool showSearch,
      final bool showFilters,
      final bool showRefresh,
      final List<BulkAction>? bulkActions,
      final Map<String, dynamic>? metadata}) = _$TableSettingsImpl;

  factory _TableSettings.fromJson(Map<String, dynamic> json) =
      _$TableSettingsImpl.fromJson;

  @override
  bool get striped;
  @override
  bool get bordered;
  @override
  bool get hoverable;
  @override
  bool get dense;
  @override
  bool get showHeader;
  @override
  bool get stickyHeader;
  @override
  bool get stickyFirstColumn;
  @override
  bool get virtualScroll;
  @override
  double get rowHeight;
  @override
  double get headerHeight;
  @override
  bool get responsive;
  @override
  bool get showColumnToggle;
  @override
  bool get showExport;
  @override
  bool get showPrint;
  @override
  bool get showSearch;
  @override
  bool get showFilters;
  @override
  bool get showRefresh;
  @override
  List<BulkAction>? get bulkActions;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of TableSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TableSettingsImplCopyWith<_$TableSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BulkAction _$BulkActionFromJson(Map<String, dynamic> json) {
  return _BulkAction.fromJson(json);
}

/// @nodoc
mixin _$BulkAction {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get icon => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  dynamic Function(List<String>)? get onAction =>
      throw _privateConstructorUsedError;
  bool get requireConfirmation => throw _privateConstructorUsedError;
  String? get confirmationMessage => throw _privateConstructorUsedError;
  bool get disabled => throw _privateConstructorUsedError;

  /// Serializes this BulkAction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BulkAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BulkActionCopyWith<BulkAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BulkActionCopyWith<$Res> {
  factory $BulkActionCopyWith(
          BulkAction value, $Res Function(BulkAction) then) =
      _$BulkActionCopyWithImpl<$Res, BulkAction>;
  @useResult
  $Res call(
      {String id,
      String label,
      @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon,
      @JsonKey(includeFromJson: false, includeToJson: false)
      dynamic Function(List<String>)? onAction,
      bool requireConfirmation,
      String? confirmationMessage,
      bool disabled});
}

/// @nodoc
class _$BulkActionCopyWithImpl<$Res, $Val extends BulkAction>
    implements $BulkActionCopyWith<$Res> {
  _$BulkActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BulkAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? icon = freezed,
    Object? onAction = freezed,
    Object? requireConfirmation = null,
    Object? confirmationMessage = freezed,
    Object? disabled = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      onAction: freezed == onAction
          ? _value.onAction
          : onAction // ignore: cast_nullable_to_non_nullable
              as dynamic Function(List<String>)?,
      requireConfirmation: null == requireConfirmation
          ? _value.requireConfirmation
          : requireConfirmation // ignore: cast_nullable_to_non_nullable
              as bool,
      confirmationMessage: freezed == confirmationMessage
          ? _value.confirmationMessage
          : confirmationMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      disabled: null == disabled
          ? _value.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BulkActionImplCopyWith<$Res>
    implements $BulkActionCopyWith<$Res> {
  factory _$$BulkActionImplCopyWith(
          _$BulkActionImpl value, $Res Function(_$BulkActionImpl) then) =
      __$$BulkActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String label,
      @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon,
      @JsonKey(includeFromJson: false, includeToJson: false)
      dynamic Function(List<String>)? onAction,
      bool requireConfirmation,
      String? confirmationMessage,
      bool disabled});
}

/// @nodoc
class __$$BulkActionImplCopyWithImpl<$Res>
    extends _$BulkActionCopyWithImpl<$Res, _$BulkActionImpl>
    implements _$$BulkActionImplCopyWith<$Res> {
  __$$BulkActionImplCopyWithImpl(
      _$BulkActionImpl _value, $Res Function(_$BulkActionImpl) _then)
      : super(_value, _then);

  /// Create a copy of BulkAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? icon = freezed,
    Object? onAction = freezed,
    Object? requireConfirmation = null,
    Object? confirmationMessage = freezed,
    Object? disabled = null,
  }) {
    return _then(_$BulkActionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      onAction: freezed == onAction
          ? _value.onAction
          : onAction // ignore: cast_nullable_to_non_nullable
              as dynamic Function(List<String>)?,
      requireConfirmation: null == requireConfirmation
          ? _value.requireConfirmation
          : requireConfirmation // ignore: cast_nullable_to_non_nullable
              as bool,
      confirmationMessage: freezed == confirmationMessage
          ? _value.confirmationMessage
          : confirmationMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      disabled: null == disabled
          ? _value.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BulkActionImpl implements _BulkAction {
  const _$BulkActionImpl(
      {required this.id,
      required this.label,
      @JsonKey(includeFromJson: false, includeToJson: false) this.icon,
      @JsonKey(includeFromJson: false, includeToJson: false) this.onAction,
      this.requireConfirmation = false,
      this.confirmationMessage,
      this.disabled = false});

  factory _$BulkActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$BulkActionImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final IconData? icon;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final dynamic Function(List<String>)? onAction;
  @override
  @JsonKey()
  final bool requireConfirmation;
  @override
  final String? confirmationMessage;
  @override
  @JsonKey()
  final bool disabled;

  @override
  String toString() {
    return 'BulkAction(id: $id, label: $label, icon: $icon, onAction: $onAction, requireConfirmation: $requireConfirmation, confirmationMessage: $confirmationMessage, disabled: $disabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BulkActionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.onAction, onAction) ||
                other.onAction == onAction) &&
            (identical(other.requireConfirmation, requireConfirmation) ||
                other.requireConfirmation == requireConfirmation) &&
            (identical(other.confirmationMessage, confirmationMessage) ||
                other.confirmationMessage == confirmationMessage) &&
            (identical(other.disabled, disabled) ||
                other.disabled == disabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, label, icon, onAction,
      requireConfirmation, confirmationMessage, disabled);

  /// Create a copy of BulkAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BulkActionImplCopyWith<_$BulkActionImpl> get copyWith =>
      __$$BulkActionImplCopyWithImpl<_$BulkActionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BulkActionImplToJson(
      this,
    );
  }
}

abstract class _BulkAction implements BulkAction {
  const factory _BulkAction(
      {required final String id,
      required final String label,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final IconData? icon,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final dynamic Function(List<String>)? onAction,
      final bool requireConfirmation,
      final String? confirmationMessage,
      final bool disabled}) = _$BulkActionImpl;

  factory _BulkAction.fromJson(Map<String, dynamic> json) =
      _$BulkActionImpl.fromJson;

  @override
  String get id;
  @override
  String get label;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get icon;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  dynamic Function(List<String>)? get onAction;
  @override
  bool get requireConfirmation;
  @override
  String? get confirmationMessage;
  @override
  bool get disabled;

  /// Create a copy of BulkAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BulkActionImplCopyWith<_$BulkActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InvoiceTableRow _$InvoiceTableRowFromJson(Map<String, dynamic> json) {
  return _InvoiceTableRow.fromJson(json);
}

/// @nodoc
mixin _$InvoiceTableRow {
  String get id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get unitPrice => throw _privateConstructorUsedError;
  double get discount => throw _privateConstructorUsedError;
  double get tax => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this InvoiceTableRow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InvoiceTableRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvoiceTableRowCopyWith<InvoiceTableRow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceTableRowCopyWith<$Res> {
  factory $InvoiceTableRowCopyWith(
          InvoiceTableRow value, $Res Function(InvoiceTableRow) then) =
      _$InvoiceTableRowCopyWithImpl<$Res, InvoiceTableRow>;
  @useResult
  $Res call(
      {String id,
      String description,
      int quantity,
      double unitPrice,
      double discount,
      double tax,
      double total,
      String? notes,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$InvoiceTableRowCopyWithImpl<$Res, $Val extends InvoiceTableRow>
    implements $InvoiceTableRowCopyWith<$Res> {
  _$InvoiceTableRowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvoiceTableRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? discount = null,
    Object? tax = null,
    Object? total = null,
    Object? notes = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoiceTableRowImplCopyWith<$Res>
    implements $InvoiceTableRowCopyWith<$Res> {
  factory _$$InvoiceTableRowImplCopyWith(_$InvoiceTableRowImpl value,
          $Res Function(_$InvoiceTableRowImpl) then) =
      __$$InvoiceTableRowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String description,
      int quantity,
      double unitPrice,
      double discount,
      double tax,
      double total,
      String? notes,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$InvoiceTableRowImplCopyWithImpl<$Res>
    extends _$InvoiceTableRowCopyWithImpl<$Res, _$InvoiceTableRowImpl>
    implements _$$InvoiceTableRowImplCopyWith<$Res> {
  __$$InvoiceTableRowImplCopyWithImpl(
      _$InvoiceTableRowImpl _value, $Res Function(_$InvoiceTableRowImpl) _then)
      : super(_value, _then);

  /// Create a copy of InvoiceTableRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? discount = null,
    Object? tax = null,
    Object? total = null,
    Object? notes = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$InvoiceTableRowImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceTableRowImpl implements _InvoiceTableRow {
  const _$InvoiceTableRowImpl(
      {required this.id,
      required this.description,
      required this.quantity,
      required this.unitPrice,
      required this.discount,
      required this.tax,
      required this.total,
      this.notes,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$InvoiceTableRowImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceTableRowImplFromJson(json);

  @override
  final String id;
  @override
  final String description;
  @override
  final int quantity;
  @override
  final double unitPrice;
  @override
  final double discount;
  @override
  final double tax;
  @override
  final double total;
  @override
  final String? notes;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'InvoiceTableRow(id: $id, description: $description, quantity: $quantity, unitPrice: $unitPrice, discount: $discount, tax: $tax, total: $total, notes: $notes, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceTableRowImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      description,
      quantity,
      unitPrice,
      discount,
      tax,
      total,
      notes,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of InvoiceTableRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceTableRowImplCopyWith<_$InvoiceTableRowImpl> get copyWith =>
      __$$InvoiceTableRowImplCopyWithImpl<_$InvoiceTableRowImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceTableRowImplToJson(
      this,
    );
  }
}

abstract class _InvoiceTableRow implements InvoiceTableRow {
  const factory _InvoiceTableRow(
      {required final String id,
      required final String description,
      required final int quantity,
      required final double unitPrice,
      required final double discount,
      required final double tax,
      required final double total,
      final String? notes,
      final Map<String, dynamic>? metadata}) = _$InvoiceTableRowImpl;

  factory _InvoiceTableRow.fromJson(Map<String, dynamic> json) =
      _$InvoiceTableRowImpl.fromJson;

  @override
  String get id;
  @override
  String get description;
  @override
  int get quantity;
  @override
  double get unitPrice;
  @override
  double get discount;
  @override
  double get tax;
  @override
  double get total;
  @override
  String? get notes;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of InvoiceTableRow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceTableRowImplCopyWith<_$InvoiceTableRowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductTableRow _$ProductTableRowFromJson(Map<String, dynamic> json) {
  return _ProductTableRow.fromJson(json);
}

/// @nodoc
mixin _$ProductTableRow {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get sku => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  int get stock => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this ProductTableRow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductTableRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductTableRowCopyWith<ProductTableRow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductTableRowCopyWith<$Res> {
  factory $ProductTableRowCopyWith(
          ProductTableRow value, $Res Function(ProductTableRow) then) =
      _$ProductTableRowCopyWithImpl<$Res, ProductTableRow>;
  @useResult
  $Res call(
      {String id,
      String name,
      String sku,
      String category,
      double price,
      int stock,
      String status,
      String? image,
      double? rating,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$ProductTableRowCopyWithImpl<$Res, $Val extends ProductTableRow>
    implements $ProductTableRowCopyWith<$Res> {
  _$ProductTableRowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductTableRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sku = null,
    Object? category = null,
    Object? price = null,
    Object? stock = null,
    Object? status = null,
    Object? image = freezed,
    Object? rating = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sku: null == sku
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      stock: null == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductTableRowImplCopyWith<$Res>
    implements $ProductTableRowCopyWith<$Res> {
  factory _$$ProductTableRowImplCopyWith(_$ProductTableRowImpl value,
          $Res Function(_$ProductTableRowImpl) then) =
      __$$ProductTableRowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String sku,
      String category,
      double price,
      int stock,
      String status,
      String? image,
      double? rating,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$ProductTableRowImplCopyWithImpl<$Res>
    extends _$ProductTableRowCopyWithImpl<$Res, _$ProductTableRowImpl>
    implements _$$ProductTableRowImplCopyWith<$Res> {
  __$$ProductTableRowImplCopyWithImpl(
      _$ProductTableRowImpl _value, $Res Function(_$ProductTableRowImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductTableRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sku = null,
    Object? category = null,
    Object? price = null,
    Object? stock = null,
    Object? status = null,
    Object? image = freezed,
    Object? rating = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$ProductTableRowImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sku: null == sku
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      stock: null == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductTableRowImpl implements _ProductTableRow {
  const _$ProductTableRowImpl(
      {required this.id,
      required this.name,
      required this.sku,
      required this.category,
      required this.price,
      required this.stock,
      required this.status,
      this.image,
      this.rating,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$ProductTableRowImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductTableRowImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String sku;
  @override
  final String category;
  @override
  final double price;
  @override
  final int stock;
  @override
  final String status;
  @override
  final String? image;
  @override
  final double? rating;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ProductTableRow(id: $id, name: $name, sku: $sku, category: $category, price: $price, stock: $stock, status: $status, image: $image, rating: $rating, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductTableRowImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      sku,
      category,
      price,
      stock,
      status,
      image,
      rating,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of ProductTableRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductTableRowImplCopyWith<_$ProductTableRowImpl> get copyWith =>
      __$$ProductTableRowImplCopyWithImpl<_$ProductTableRowImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductTableRowImplToJson(
      this,
    );
  }
}

abstract class _ProductTableRow implements ProductTableRow {
  const factory _ProductTableRow(
      {required final String id,
      required final String name,
      required final String sku,
      required final String category,
      required final double price,
      required final int stock,
      required final String status,
      final String? image,
      final double? rating,
      final Map<String, dynamic>? metadata}) = _$ProductTableRowImpl;

  factory _ProductTableRow.fromJson(Map<String, dynamic> json) =
      _$ProductTableRowImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get sku;
  @override
  String get category;
  @override
  double get price;
  @override
  int get stock;
  @override
  String get status;
  @override
  String? get image;
  @override
  double? get rating;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of ProductTableRow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductTableRowImplCopyWith<_$ProductTableRowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserTableRow _$UserTableRowFromJson(Map<String, dynamic> json) {
  return _UserTableRow.fromJson(json);
}

/// @nodoc
mixin _$UserTableRow {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastLogin => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this UserTableRow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserTableRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserTableRowCopyWith<UserTableRow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserTableRowCopyWith<$Res> {
  factory $UserTableRowCopyWith(
          UserTableRow value, $Res Function(UserTableRow) then) =
      _$UserTableRowCopyWithImpl<$Res, UserTableRow>;
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      String role,
      String status,
      DateTime createdAt,
      DateTime? lastLogin,
      String? avatar,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$UserTableRowCopyWithImpl<$Res, $Val extends UserTableRow>
    implements $UserTableRowCopyWith<$Res> {
  _$UserTableRowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserTableRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? role = null,
    Object? status = null,
    Object? createdAt = null,
    Object? lastLogin = freezed,
    Object? avatar = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastLogin: freezed == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserTableRowImplCopyWith<$Res>
    implements $UserTableRowCopyWith<$Res> {
  factory _$$UserTableRowImplCopyWith(
          _$UserTableRowImpl value, $Res Function(_$UserTableRowImpl) then) =
      __$$UserTableRowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      String role,
      String status,
      DateTime createdAt,
      DateTime? lastLogin,
      String? avatar,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$UserTableRowImplCopyWithImpl<$Res>
    extends _$UserTableRowCopyWithImpl<$Res, _$UserTableRowImpl>
    implements _$$UserTableRowImplCopyWith<$Res> {
  __$$UserTableRowImplCopyWithImpl(
      _$UserTableRowImpl _value, $Res Function(_$UserTableRowImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserTableRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? role = null,
    Object? status = null,
    Object? createdAt = null,
    Object? lastLogin = freezed,
    Object? avatar = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$UserTableRowImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastLogin: freezed == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserTableRowImpl implements _UserTableRow {
  const _$UserTableRowImpl(
      {required this.id,
      required this.name,
      required this.email,
      required this.role,
      required this.status,
      required this.createdAt,
      this.lastLogin,
      this.avatar,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$UserTableRowImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserTableRowImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String role;
  @override
  final String status;
  @override
  final DateTime createdAt;
  @override
  final DateTime? lastLogin;
  @override
  final String? avatar;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'UserTableRow(id: $id, name: $name, email: $email, role: $role, status: $status, createdAt: $createdAt, lastLogin: $lastLogin, avatar: $avatar, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserTableRowImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastLogin, lastLogin) ||
                other.lastLogin == lastLogin) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      email,
      role,
      status,
      createdAt,
      lastLogin,
      avatar,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of UserTableRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserTableRowImplCopyWith<_$UserTableRowImpl> get copyWith =>
      __$$UserTableRowImplCopyWithImpl<_$UserTableRowImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserTableRowImplToJson(
      this,
    );
  }
}

abstract class _UserTableRow implements UserTableRow {
  const factory _UserTableRow(
      {required final String id,
      required final String name,
      required final String email,
      required final String role,
      required final String status,
      required final DateTime createdAt,
      final DateTime? lastLogin,
      final String? avatar,
      final Map<String, dynamic>? metadata}) = _$UserTableRowImpl;

  factory _UserTableRow.fromJson(Map<String, dynamic> json) =
      _$UserTableRowImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String get role;
  @override
  String get status;
  @override
  DateTime get createdAt;
  @override
  DateTime? get lastLogin;
  @override
  String? get avatar;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of UserTableRow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserTableRowImplCopyWith<_$UserTableRowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderTableRow _$OrderTableRowFromJson(Map<String, dynamic> json) {
  return _OrderTableRow.fromJson(json);
}

/// @nodoc
mixin _$OrderTableRow {
  String get id => throw _privateConstructorUsedError;
  String get orderNumber => throw _privateConstructorUsedError;
  String get customer => throw _privateConstructorUsedError;
  DateTime get orderDate => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get paymentStatus => throw _privateConstructorUsedError;
  String? get shippingMethod => throw _privateConstructorUsedError;
  DateTime? get deliveryDate => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this OrderTableRow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderTableRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderTableRowCopyWith<OrderTableRow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderTableRowCopyWith<$Res> {
  factory $OrderTableRowCopyWith(
          OrderTableRow value, $Res Function(OrderTableRow) then) =
      _$OrderTableRowCopyWithImpl<$Res, OrderTableRow>;
  @useResult
  $Res call(
      {String id,
      String orderNumber,
      String customer,
      DateTime orderDate,
      double total,
      String status,
      String paymentStatus,
      String? shippingMethod,
      DateTime? deliveryDate,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$OrderTableRowCopyWithImpl<$Res, $Val extends OrderTableRow>
    implements $OrderTableRowCopyWith<$Res> {
  _$OrderTableRowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderTableRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderNumber = null,
    Object? customer = null,
    Object? orderDate = null,
    Object? total = null,
    Object? status = null,
    Object? paymentStatus = null,
    Object? shippingMethod = freezed,
    Object? deliveryDate = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      orderNumber: null == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as String,
      customer: null == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as String,
      orderDate: null == orderDate
          ? _value.orderDate
          : orderDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String,
      shippingMethod: freezed == shippingMethod
          ? _value.shippingMethod
          : shippingMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryDate: freezed == deliveryDate
          ? _value.deliveryDate
          : deliveryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderTableRowImplCopyWith<$Res>
    implements $OrderTableRowCopyWith<$Res> {
  factory _$$OrderTableRowImplCopyWith(
          _$OrderTableRowImpl value, $Res Function(_$OrderTableRowImpl) then) =
      __$$OrderTableRowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String orderNumber,
      String customer,
      DateTime orderDate,
      double total,
      String status,
      String paymentStatus,
      String? shippingMethod,
      DateTime? deliveryDate,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$OrderTableRowImplCopyWithImpl<$Res>
    extends _$OrderTableRowCopyWithImpl<$Res, _$OrderTableRowImpl>
    implements _$$OrderTableRowImplCopyWith<$Res> {
  __$$OrderTableRowImplCopyWithImpl(
      _$OrderTableRowImpl _value, $Res Function(_$OrderTableRowImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderTableRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderNumber = null,
    Object? customer = null,
    Object? orderDate = null,
    Object? total = null,
    Object? status = null,
    Object? paymentStatus = null,
    Object? shippingMethod = freezed,
    Object? deliveryDate = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$OrderTableRowImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      orderNumber: null == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as String,
      customer: null == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as String,
      orderDate: null == orderDate
          ? _value.orderDate
          : orderDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String,
      shippingMethod: freezed == shippingMethod
          ? _value.shippingMethod
          : shippingMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryDate: freezed == deliveryDate
          ? _value.deliveryDate
          : deliveryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderTableRowImpl implements _OrderTableRow {
  const _$OrderTableRowImpl(
      {required this.id,
      required this.orderNumber,
      required this.customer,
      required this.orderDate,
      required this.total,
      required this.status,
      required this.paymentStatus,
      this.shippingMethod,
      this.deliveryDate,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$OrderTableRowImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderTableRowImplFromJson(json);

  @override
  final String id;
  @override
  final String orderNumber;
  @override
  final String customer;
  @override
  final DateTime orderDate;
  @override
  final double total;
  @override
  final String status;
  @override
  final String paymentStatus;
  @override
  final String? shippingMethod;
  @override
  final DateTime? deliveryDate;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'OrderTableRow(id: $id, orderNumber: $orderNumber, customer: $customer, orderDate: $orderDate, total: $total, status: $status, paymentStatus: $paymentStatus, shippingMethod: $shippingMethod, deliveryDate: $deliveryDate, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderTableRowImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.orderDate, orderDate) ||
                other.orderDate == orderDate) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.shippingMethod, shippingMethod) ||
                other.shippingMethod == shippingMethod) &&
            (identical(other.deliveryDate, deliveryDate) ||
                other.deliveryDate == deliveryDate) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      orderNumber,
      customer,
      orderDate,
      total,
      status,
      paymentStatus,
      shippingMethod,
      deliveryDate,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of OrderTableRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderTableRowImplCopyWith<_$OrderTableRowImpl> get copyWith =>
      __$$OrderTableRowImplCopyWithImpl<_$OrderTableRowImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderTableRowImplToJson(
      this,
    );
  }
}

abstract class _OrderTableRow implements OrderTableRow {
  const factory _OrderTableRow(
      {required final String id,
      required final String orderNumber,
      required final String customer,
      required final DateTime orderDate,
      required final double total,
      required final String status,
      required final String paymentStatus,
      final String? shippingMethod,
      final DateTime? deliveryDate,
      final Map<String, dynamic>? metadata}) = _$OrderTableRowImpl;

  factory _OrderTableRow.fromJson(Map<String, dynamic> json) =
      _$OrderTableRowImpl.fromJson;

  @override
  String get id;
  @override
  String get orderNumber;
  @override
  String get customer;
  @override
  DateTime get orderDate;
  @override
  double get total;
  @override
  String get status;
  @override
  String get paymentStatus;
  @override
  String? get shippingMethod;
  @override
  DateTime? get deliveryDate;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of OrderTableRow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderTableRowImplCopyWith<_$OrderTableRowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReportTableRow _$ReportTableRowFromJson(Map<String, dynamic> json) {
  return _ReportTableRow.fromJson(json);
}

/// @nodoc
mixin _$ReportTableRow {
  String get id => throw _privateConstructorUsedError;
  Map<String, dynamic> get metrics => throw _privateConstructorUsedError;
  DateTime get period => throw _privateConstructorUsedError;
  Map<String, dynamic>? get dimensions => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this ReportTableRow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReportTableRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportTableRowCopyWith<ReportTableRow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportTableRowCopyWith<$Res> {
  factory $ReportTableRowCopyWith(
          ReportTableRow value, $Res Function(ReportTableRow) then) =
      _$ReportTableRowCopyWithImpl<$Res, ReportTableRow>;
  @useResult
  $Res call(
      {String id,
      Map<String, dynamic> metrics,
      DateTime period,
      Map<String, dynamic>? dimensions,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$ReportTableRowCopyWithImpl<$Res, $Val extends ReportTableRow>
    implements $ReportTableRowCopyWith<$Res> {
  _$ReportTableRowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportTableRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? metrics = null,
    Object? period = null,
    Object? dimensions = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dimensions: freezed == dimensions
          ? _value.dimensions
          : dimensions // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportTableRowImplCopyWith<$Res>
    implements $ReportTableRowCopyWith<$Res> {
  factory _$$ReportTableRowImplCopyWith(_$ReportTableRowImpl value,
          $Res Function(_$ReportTableRowImpl) then) =
      __$$ReportTableRowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Map<String, dynamic> metrics,
      DateTime period,
      Map<String, dynamic>? dimensions,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$ReportTableRowImplCopyWithImpl<$Res>
    extends _$ReportTableRowCopyWithImpl<$Res, _$ReportTableRowImpl>
    implements _$$ReportTableRowImplCopyWith<$Res> {
  __$$ReportTableRowImplCopyWithImpl(
      _$ReportTableRowImpl _value, $Res Function(_$ReportTableRowImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReportTableRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? metrics = null,
    Object? period = null,
    Object? dimensions = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$ReportTableRowImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      metrics: null == metrics
          ? _value._metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dimensions: freezed == dimensions
          ? _value._dimensions
          : dimensions // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportTableRowImpl implements _ReportTableRow {
  const _$ReportTableRowImpl(
      {required this.id,
      required final Map<String, dynamic> metrics,
      required this.period,
      final Map<String, dynamic>? dimensions,
      final Map<String, dynamic>? metadata})
      : _metrics = metrics,
        _dimensions = dimensions,
        _metadata = metadata;

  factory _$ReportTableRowImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportTableRowImplFromJson(json);

  @override
  final String id;
  final Map<String, dynamic> _metrics;
  @override
  Map<String, dynamic> get metrics {
    if (_metrics is EqualUnmodifiableMapView) return _metrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metrics);
  }

  @override
  final DateTime period;
  final Map<String, dynamic>? _dimensions;
  @override
  Map<String, dynamic>? get dimensions {
    final value = _dimensions;
    if (value == null) return null;
    if (_dimensions is EqualUnmodifiableMapView) return _dimensions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ReportTableRow(id: $id, metrics: $metrics, period: $period, dimensions: $dimensions, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportTableRowImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._metrics, _metrics) &&
            (identical(other.period, period) || other.period == period) &&
            const DeepCollectionEquality()
                .equals(other._dimensions, _dimensions) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_metrics),
      period,
      const DeepCollectionEquality().hash(_dimensions),
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of ReportTableRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportTableRowImplCopyWith<_$ReportTableRowImpl> get copyWith =>
      __$$ReportTableRowImplCopyWithImpl<_$ReportTableRowImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportTableRowImplToJson(
      this,
    );
  }
}

abstract class _ReportTableRow implements ReportTableRow {
  const factory _ReportTableRow(
      {required final String id,
      required final Map<String, dynamic> metrics,
      required final DateTime period,
      final Map<String, dynamic>? dimensions,
      final Map<String, dynamic>? metadata}) = _$ReportTableRowImpl;

  factory _ReportTableRow.fromJson(Map<String, dynamic> json) =
      _$ReportTableRowImpl.fromJson;

  @override
  String get id;
  @override
  Map<String, dynamic> get metrics;
  @override
  DateTime get period;
  @override
  Map<String, dynamic>? get dimensions;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of ReportTableRow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportTableRowImplCopyWith<_$ReportTableRowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExportConfig _$ExportConfigFromJson(Map<String, dynamic> json) {
  return _ExportConfig.fromJson(json);
}

/// @nodoc
mixin _$ExportConfig {
  ExportFormat get format => throw _privateConstructorUsedError;
  String get filename => throw _privateConstructorUsedError;
  bool get includeHeaders => throw _privateConstructorUsedError;
  bool get includeFilters => throw _privateConstructorUsedError;
  bool get includeSummary => throw _privateConstructorUsedError;
  List<String>? get selectedColumns => throw _privateConstructorUsedError;
  Map<String, String>? get columnMapping => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this ExportConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExportConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExportConfigCopyWith<ExportConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExportConfigCopyWith<$Res> {
  factory $ExportConfigCopyWith(
          ExportConfig value, $Res Function(ExportConfig) then) =
      _$ExportConfigCopyWithImpl<$Res, ExportConfig>;
  @useResult
  $Res call(
      {ExportFormat format,
      String filename,
      bool includeHeaders,
      bool includeFilters,
      bool includeSummary,
      List<String>? selectedColumns,
      Map<String, String>? columnMapping,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$ExportConfigCopyWithImpl<$Res, $Val extends ExportConfig>
    implements $ExportConfigCopyWith<$Res> {
  _$ExportConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExportConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? format = null,
    Object? filename = null,
    Object? includeHeaders = null,
    Object? includeFilters = null,
    Object? includeSummary = null,
    Object? selectedColumns = freezed,
    Object? columnMapping = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as ExportFormat,
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      includeHeaders: null == includeHeaders
          ? _value.includeHeaders
          : includeHeaders // ignore: cast_nullable_to_non_nullable
              as bool,
      includeFilters: null == includeFilters
          ? _value.includeFilters
          : includeFilters // ignore: cast_nullable_to_non_nullable
              as bool,
      includeSummary: null == includeSummary
          ? _value.includeSummary
          : includeSummary // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedColumns: freezed == selectedColumns
          ? _value.selectedColumns
          : selectedColumns // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      columnMapping: freezed == columnMapping
          ? _value.columnMapping
          : columnMapping // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExportConfigImplCopyWith<$Res>
    implements $ExportConfigCopyWith<$Res> {
  factory _$$ExportConfigImplCopyWith(
          _$ExportConfigImpl value, $Res Function(_$ExportConfigImpl) then) =
      __$$ExportConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ExportFormat format,
      String filename,
      bool includeHeaders,
      bool includeFilters,
      bool includeSummary,
      List<String>? selectedColumns,
      Map<String, String>? columnMapping,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$ExportConfigImplCopyWithImpl<$Res>
    extends _$ExportConfigCopyWithImpl<$Res, _$ExportConfigImpl>
    implements _$$ExportConfigImplCopyWith<$Res> {
  __$$ExportConfigImplCopyWithImpl(
      _$ExportConfigImpl _value, $Res Function(_$ExportConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExportConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? format = null,
    Object? filename = null,
    Object? includeHeaders = null,
    Object? includeFilters = null,
    Object? includeSummary = null,
    Object? selectedColumns = freezed,
    Object? columnMapping = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$ExportConfigImpl(
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as ExportFormat,
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      includeHeaders: null == includeHeaders
          ? _value.includeHeaders
          : includeHeaders // ignore: cast_nullable_to_non_nullable
              as bool,
      includeFilters: null == includeFilters
          ? _value.includeFilters
          : includeFilters // ignore: cast_nullable_to_non_nullable
              as bool,
      includeSummary: null == includeSummary
          ? _value.includeSummary
          : includeSummary // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedColumns: freezed == selectedColumns
          ? _value._selectedColumns
          : selectedColumns // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      columnMapping: freezed == columnMapping
          ? _value._columnMapping
          : columnMapping // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExportConfigImpl implements _ExportConfig {
  const _$ExportConfigImpl(
      {required this.format,
      required this.filename,
      this.includeHeaders = true,
      this.includeFilters = false,
      this.includeSummary = false,
      final List<String>? selectedColumns,
      final Map<String, String>? columnMapping,
      final Map<String, dynamic>? metadata})
      : _selectedColumns = selectedColumns,
        _columnMapping = columnMapping,
        _metadata = metadata;

  factory _$ExportConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExportConfigImplFromJson(json);

  @override
  final ExportFormat format;
  @override
  final String filename;
  @override
  @JsonKey()
  final bool includeHeaders;
  @override
  @JsonKey()
  final bool includeFilters;
  @override
  @JsonKey()
  final bool includeSummary;
  final List<String>? _selectedColumns;
  @override
  List<String>? get selectedColumns {
    final value = _selectedColumns;
    if (value == null) return null;
    if (_selectedColumns is EqualUnmodifiableListView) return _selectedColumns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, String>? _columnMapping;
  @override
  Map<String, String>? get columnMapping {
    final value = _columnMapping;
    if (value == null) return null;
    if (_columnMapping is EqualUnmodifiableMapView) return _columnMapping;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ExportConfig(format: $format, filename: $filename, includeHeaders: $includeHeaders, includeFilters: $includeFilters, includeSummary: $includeSummary, selectedColumns: $selectedColumns, columnMapping: $columnMapping, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExportConfigImpl &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.includeHeaders, includeHeaders) ||
                other.includeHeaders == includeHeaders) &&
            (identical(other.includeFilters, includeFilters) ||
                other.includeFilters == includeFilters) &&
            (identical(other.includeSummary, includeSummary) ||
                other.includeSummary == includeSummary) &&
            const DeepCollectionEquality()
                .equals(other._selectedColumns, _selectedColumns) &&
            const DeepCollectionEquality()
                .equals(other._columnMapping, _columnMapping) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      format,
      filename,
      includeHeaders,
      includeFilters,
      includeSummary,
      const DeepCollectionEquality().hash(_selectedColumns),
      const DeepCollectionEquality().hash(_columnMapping),
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of ExportConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExportConfigImplCopyWith<_$ExportConfigImpl> get copyWith =>
      __$$ExportConfigImplCopyWithImpl<_$ExportConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExportConfigImplToJson(
      this,
    );
  }
}

abstract class _ExportConfig implements ExportConfig {
  const factory _ExportConfig(
      {required final ExportFormat format,
      required final String filename,
      final bool includeHeaders,
      final bool includeFilters,
      final bool includeSummary,
      final List<String>? selectedColumns,
      final Map<String, String>? columnMapping,
      final Map<String, dynamic>? metadata}) = _$ExportConfigImpl;

  factory _ExportConfig.fromJson(Map<String, dynamic> json) =
      _$ExportConfigImpl.fromJson;

  @override
  ExportFormat get format;
  @override
  String get filename;
  @override
  bool get includeHeaders;
  @override
  bool get includeFilters;
  @override
  bool get includeSummary;
  @override
  List<String>? get selectedColumns;
  @override
  Map<String, String>? get columnMapping;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of ExportConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExportConfigImplCopyWith<_$ExportConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CellEditConfig _$CellEditConfigFromJson(Map<String, dynamic> json) {
  return _CellEditConfig.fromJson(json);
}

/// @nodoc
mixin _$CellEditConfig {
  String get columnId => throw _privateConstructorUsedError;
  dynamic get value => throw _privateConstructorUsedError;
  dynamic get newValue => throw _privateConstructorUsedError;
  String get rowId => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  dynamic Function(dynamic)? get onSave => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  VoidCallback? get onCancel => throw _privateConstructorUsedError;

  /// Serializes this CellEditConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CellEditConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CellEditConfigCopyWith<CellEditConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CellEditConfigCopyWith<$Res> {
  factory $CellEditConfigCopyWith(
          CellEditConfig value, $Res Function(CellEditConfig) then) =
      _$CellEditConfigCopyWithImpl<$Res, CellEditConfig>;
  @useResult
  $Res call(
      {String columnId,
      dynamic value,
      dynamic newValue,
      String rowId,
      bool isValid,
      String? errorMessage,
      @JsonKey(includeFromJson: false, includeToJson: false)
      dynamic Function(dynamic)? onSave,
      @JsonKey(includeFromJson: false, includeToJson: false)
      VoidCallback? onCancel});
}

/// @nodoc
class _$CellEditConfigCopyWithImpl<$Res, $Val extends CellEditConfig>
    implements $CellEditConfigCopyWith<$Res> {
  _$CellEditConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CellEditConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? columnId = null,
    Object? value = freezed,
    Object? newValue = freezed,
    Object? rowId = null,
    Object? isValid = null,
    Object? errorMessage = freezed,
    Object? onSave = freezed,
    Object? onCancel = freezed,
  }) {
    return _then(_value.copyWith(
      columnId: null == columnId
          ? _value.columnId
          : columnId // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
      newValue: freezed == newValue
          ? _value.newValue
          : newValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      rowId: null == rowId
          ? _value.rowId
          : rowId // ignore: cast_nullable_to_non_nullable
              as String,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      onSave: freezed == onSave
          ? _value.onSave
          : onSave // ignore: cast_nullable_to_non_nullable
              as dynamic Function(dynamic)?,
      onCancel: freezed == onCancel
          ? _value.onCancel
          : onCancel // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CellEditConfigImplCopyWith<$Res>
    implements $CellEditConfigCopyWith<$Res> {
  factory _$$CellEditConfigImplCopyWith(_$CellEditConfigImpl value,
          $Res Function(_$CellEditConfigImpl) then) =
      __$$CellEditConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String columnId,
      dynamic value,
      dynamic newValue,
      String rowId,
      bool isValid,
      String? errorMessage,
      @JsonKey(includeFromJson: false, includeToJson: false)
      dynamic Function(dynamic)? onSave,
      @JsonKey(includeFromJson: false, includeToJson: false)
      VoidCallback? onCancel});
}

/// @nodoc
class __$$CellEditConfigImplCopyWithImpl<$Res>
    extends _$CellEditConfigCopyWithImpl<$Res, _$CellEditConfigImpl>
    implements _$$CellEditConfigImplCopyWith<$Res> {
  __$$CellEditConfigImplCopyWithImpl(
      _$CellEditConfigImpl _value, $Res Function(_$CellEditConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of CellEditConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? columnId = null,
    Object? value = freezed,
    Object? newValue = freezed,
    Object? rowId = null,
    Object? isValid = null,
    Object? errorMessage = freezed,
    Object? onSave = freezed,
    Object? onCancel = freezed,
  }) {
    return _then(_$CellEditConfigImpl(
      columnId: null == columnId
          ? _value.columnId
          : columnId // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
      newValue: freezed == newValue
          ? _value.newValue
          : newValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      rowId: null == rowId
          ? _value.rowId
          : rowId // ignore: cast_nullable_to_non_nullable
              as String,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      onSave: freezed == onSave
          ? _value.onSave
          : onSave // ignore: cast_nullable_to_non_nullable
              as dynamic Function(dynamic)?,
      onCancel: freezed == onCancel
          ? _value.onCancel
          : onCancel // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CellEditConfigImpl implements _CellEditConfig {
  const _$CellEditConfigImpl(
      {required this.columnId,
      required this.value,
      required this.newValue,
      required this.rowId,
      this.isValid = false,
      this.errorMessage,
      @JsonKey(includeFromJson: false, includeToJson: false) this.onSave,
      @JsonKey(includeFromJson: false, includeToJson: false) this.onCancel});

  factory _$CellEditConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$CellEditConfigImplFromJson(json);

  @override
  final String columnId;
  @override
  final dynamic value;
  @override
  final dynamic newValue;
  @override
  final String rowId;
  @override
  @JsonKey()
  final bool isValid;
  @override
  final String? errorMessage;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final dynamic Function(dynamic)? onSave;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final VoidCallback? onCancel;

  @override
  String toString() {
    return 'CellEditConfig(columnId: $columnId, value: $value, newValue: $newValue, rowId: $rowId, isValid: $isValid, errorMessage: $errorMessage, onSave: $onSave, onCancel: $onCancel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CellEditConfigImpl &&
            (identical(other.columnId, columnId) ||
                other.columnId == columnId) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.newValue, newValue) &&
            (identical(other.rowId, rowId) || other.rowId == rowId) &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.onSave, onSave) || other.onSave == onSave) &&
            (identical(other.onCancel, onCancel) ||
                other.onCancel == onCancel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      columnId,
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(newValue),
      rowId,
      isValid,
      errorMessage,
      onSave,
      onCancel);

  /// Create a copy of CellEditConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CellEditConfigImplCopyWith<_$CellEditConfigImpl> get copyWith =>
      __$$CellEditConfigImplCopyWithImpl<_$CellEditConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CellEditConfigImplToJson(
      this,
    );
  }
}

abstract class _CellEditConfig implements CellEditConfig {
  const factory _CellEditConfig(
      {required final String columnId,
      required final dynamic value,
      required final dynamic newValue,
      required final String rowId,
      final bool isValid,
      final String? errorMessage,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final dynamic Function(dynamic)? onSave,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final VoidCallback? onCancel}) = _$CellEditConfigImpl;

  factory _CellEditConfig.fromJson(Map<String, dynamic> json) =
      _$CellEditConfigImpl.fromJson;

  @override
  String get columnId;
  @override
  dynamic get value;
  @override
  dynamic get newValue;
  @override
  String get rowId;
  @override
  bool get isValid;
  @override
  String? get errorMessage;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  dynamic Function(dynamic)? get onSave;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  VoidCallback? get onCancel;

  /// Create a copy of CellEditConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CellEditConfigImplCopyWith<_$CellEditConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
