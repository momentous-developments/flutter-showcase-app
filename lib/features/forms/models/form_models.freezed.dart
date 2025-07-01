// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FormFieldModel _$FormFieldModelFromJson(Map<String, dynamic> json) {
  return _FormFieldModel.fromJson(json);
}

/// @nodoc
mixin _$FormFieldModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  FormFieldType get type => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  String? get placeholder => throw _privateConstructorUsedError;
  String? get helperText => throw _privateConstructorUsedError;
  dynamic get defaultValue => throw _privateConstructorUsedError;
  dynamic get value => throw _privateConstructorUsedError;
  bool get required => throw _privateConstructorUsedError;
  bool get disabled => throw _privateConstructorUsedError;
  bool get readonly => throw _privateConstructorUsedError;
  bool get hidden => throw _privateConstructorUsedError;
  List<ValidationRule> get validators => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  FormFieldOptions? get options => throw _privateConstructorUsedError;
  FieldState get state => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  List<String>? get dependencies => throw _privateConstructorUsedError;

  /// Serializes this FormFieldModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FormFieldModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FormFieldModelCopyWith<FormFieldModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormFieldModelCopyWith<$Res> {
  factory $FormFieldModelCopyWith(
          FormFieldModel value, $Res Function(FormFieldModel) then) =
      _$FormFieldModelCopyWithImpl<$Res, FormFieldModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      FormFieldType type,
      String? label,
      String? placeholder,
      String? helperText,
      dynamic defaultValue,
      dynamic value,
      bool required,
      bool disabled,
      bool readonly,
      bool hidden,
      List<ValidationRule> validators,
      Map<String, dynamic>? metadata,
      FormFieldOptions? options,
      FieldState state,
      String? errorMessage,
      List<String>? dependencies});

  $FormFieldOptionsCopyWith<$Res>? get options;
}

/// @nodoc
class _$FormFieldModelCopyWithImpl<$Res, $Val extends FormFieldModel>
    implements $FormFieldModelCopyWith<$Res> {
  _$FormFieldModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FormFieldModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? label = freezed,
    Object? placeholder = freezed,
    Object? helperText = freezed,
    Object? defaultValue = freezed,
    Object? value = freezed,
    Object? required = null,
    Object? disabled = null,
    Object? readonly = null,
    Object? hidden = null,
    Object? validators = null,
    Object? metadata = freezed,
    Object? options = freezed,
    Object? state = null,
    Object? errorMessage = freezed,
    Object? dependencies = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FormFieldType,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      placeholder: freezed == placeholder
          ? _value.placeholder
          : placeholder // ignore: cast_nullable_to_non_nullable
              as String?,
      helperText: freezed == helperText
          ? _value.helperText
          : helperText // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultValue: freezed == defaultValue
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
      required: null == required
          ? _value.required
          : required // ignore: cast_nullable_to_non_nullable
              as bool,
      disabled: null == disabled
          ? _value.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool,
      readonly: null == readonly
          ? _value.readonly
          : readonly // ignore: cast_nullable_to_non_nullable
              as bool,
      hidden: null == hidden
          ? _value.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool,
      validators: null == validators
          ? _value.validators
          : validators // ignore: cast_nullable_to_non_nullable
              as List<ValidationRule>,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      options: freezed == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as FormFieldOptions?,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as FieldState,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      dependencies: freezed == dependencies
          ? _value.dependencies
          : dependencies // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  /// Create a copy of FormFieldModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FormFieldOptionsCopyWith<$Res>? get options {
    if (_value.options == null) {
      return null;
    }

    return $FormFieldOptionsCopyWith<$Res>(_value.options!, (value) {
      return _then(_value.copyWith(options: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FormFieldModelImplCopyWith<$Res>
    implements $FormFieldModelCopyWith<$Res> {
  factory _$$FormFieldModelImplCopyWith(_$FormFieldModelImpl value,
          $Res Function(_$FormFieldModelImpl) then) =
      __$$FormFieldModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      FormFieldType type,
      String? label,
      String? placeholder,
      String? helperText,
      dynamic defaultValue,
      dynamic value,
      bool required,
      bool disabled,
      bool readonly,
      bool hidden,
      List<ValidationRule> validators,
      Map<String, dynamic>? metadata,
      FormFieldOptions? options,
      FieldState state,
      String? errorMessage,
      List<String>? dependencies});

  @override
  $FormFieldOptionsCopyWith<$Res>? get options;
}

/// @nodoc
class __$$FormFieldModelImplCopyWithImpl<$Res>
    extends _$FormFieldModelCopyWithImpl<$Res, _$FormFieldModelImpl>
    implements _$$FormFieldModelImplCopyWith<$Res> {
  __$$FormFieldModelImplCopyWithImpl(
      _$FormFieldModelImpl _value, $Res Function(_$FormFieldModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FormFieldModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? label = freezed,
    Object? placeholder = freezed,
    Object? helperText = freezed,
    Object? defaultValue = freezed,
    Object? value = freezed,
    Object? required = null,
    Object? disabled = null,
    Object? readonly = null,
    Object? hidden = null,
    Object? validators = null,
    Object? metadata = freezed,
    Object? options = freezed,
    Object? state = null,
    Object? errorMessage = freezed,
    Object? dependencies = freezed,
  }) {
    return _then(_$FormFieldModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FormFieldType,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      placeholder: freezed == placeholder
          ? _value.placeholder
          : placeholder // ignore: cast_nullable_to_non_nullable
              as String?,
      helperText: freezed == helperText
          ? _value.helperText
          : helperText // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultValue: freezed == defaultValue
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
      required: null == required
          ? _value.required
          : required // ignore: cast_nullable_to_non_nullable
              as bool,
      disabled: null == disabled
          ? _value.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool,
      readonly: null == readonly
          ? _value.readonly
          : readonly // ignore: cast_nullable_to_non_nullable
              as bool,
      hidden: null == hidden
          ? _value.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool,
      validators: null == validators
          ? _value._validators
          : validators // ignore: cast_nullable_to_non_nullable
              as List<ValidationRule>,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      options: freezed == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as FormFieldOptions?,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as FieldState,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      dependencies: freezed == dependencies
          ? _value._dependencies
          : dependencies // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FormFieldModelImpl implements _FormFieldModel {
  const _$FormFieldModelImpl(
      {required this.id,
      required this.name,
      required this.type,
      this.label,
      this.placeholder,
      this.helperText,
      this.defaultValue,
      this.value,
      this.required = false,
      this.disabled = false,
      this.readonly = false,
      this.hidden = false,
      final List<ValidationRule> validators = const [],
      final Map<String, dynamic>? metadata,
      this.options,
      this.state = FieldState.normal,
      this.errorMessage,
      final List<String>? dependencies})
      : _validators = validators,
        _metadata = metadata,
        _dependencies = dependencies;

  factory _$FormFieldModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FormFieldModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final FormFieldType type;
  @override
  final String? label;
  @override
  final String? placeholder;
  @override
  final String? helperText;
  @override
  final dynamic defaultValue;
  @override
  final dynamic value;
  @override
  @JsonKey()
  final bool required;
  @override
  @JsonKey()
  final bool disabled;
  @override
  @JsonKey()
  final bool readonly;
  @override
  @JsonKey()
  final bool hidden;
  final List<ValidationRule> _validators;
  @override
  @JsonKey()
  List<ValidationRule> get validators {
    if (_validators is EqualUnmodifiableListView) return _validators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_validators);
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
  final FormFieldOptions? options;
  @override
  @JsonKey()
  final FieldState state;
  @override
  final String? errorMessage;
  final List<String>? _dependencies;
  @override
  List<String>? get dependencies {
    final value = _dependencies;
    if (value == null) return null;
    if (_dependencies is EqualUnmodifiableListView) return _dependencies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'FormFieldModel(id: $id, name: $name, type: $type, label: $label, placeholder: $placeholder, helperText: $helperText, defaultValue: $defaultValue, value: $value, required: $required, disabled: $disabled, readonly: $readonly, hidden: $hidden, validators: $validators, metadata: $metadata, options: $options, state: $state, errorMessage: $errorMessage, dependencies: $dependencies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormFieldModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.placeholder, placeholder) ||
                other.placeholder == placeholder) &&
            (identical(other.helperText, helperText) ||
                other.helperText == helperText) &&
            const DeepCollectionEquality()
                .equals(other.defaultValue, defaultValue) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            (identical(other.required, required) ||
                other.required == required) &&
            (identical(other.disabled, disabled) ||
                other.disabled == disabled) &&
            (identical(other.readonly, readonly) ||
                other.readonly == readonly) &&
            (identical(other.hidden, hidden) || other.hidden == hidden) &&
            const DeepCollectionEquality()
                .equals(other._validators, _validators) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.options, options) || other.options == options) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality()
                .equals(other._dependencies, _dependencies));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      label,
      placeholder,
      helperText,
      const DeepCollectionEquality().hash(defaultValue),
      const DeepCollectionEquality().hash(value),
      required,
      disabled,
      readonly,
      hidden,
      const DeepCollectionEquality().hash(_validators),
      const DeepCollectionEquality().hash(_metadata),
      options,
      state,
      errorMessage,
      const DeepCollectionEquality().hash(_dependencies));

  /// Create a copy of FormFieldModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormFieldModelImplCopyWith<_$FormFieldModelImpl> get copyWith =>
      __$$FormFieldModelImplCopyWithImpl<_$FormFieldModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FormFieldModelImplToJson(
      this,
    );
  }
}

abstract class _FormFieldModel implements FormFieldModel {
  const factory _FormFieldModel(
      {required final String id,
      required final String name,
      required final FormFieldType type,
      final String? label,
      final String? placeholder,
      final String? helperText,
      final dynamic defaultValue,
      final dynamic value,
      final bool required,
      final bool disabled,
      final bool readonly,
      final bool hidden,
      final List<ValidationRule> validators,
      final Map<String, dynamic>? metadata,
      final FormFieldOptions? options,
      final FieldState state,
      final String? errorMessage,
      final List<String>? dependencies}) = _$FormFieldModelImpl;

  factory _FormFieldModel.fromJson(Map<String, dynamic> json) =
      _$FormFieldModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  FormFieldType get type;
  @override
  String? get label;
  @override
  String? get placeholder;
  @override
  String? get helperText;
  @override
  dynamic get defaultValue;
  @override
  dynamic get value;
  @override
  bool get required;
  @override
  bool get disabled;
  @override
  bool get readonly;
  @override
  bool get hidden;
  @override
  List<ValidationRule> get validators;
  @override
  Map<String, dynamic>? get metadata;
  @override
  FormFieldOptions? get options;
  @override
  FieldState get state;
  @override
  String? get errorMessage;
  @override
  List<String>? get dependencies;

  /// Create a copy of FormFieldModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormFieldModelImplCopyWith<_$FormFieldModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ValidationRule _$ValidationRuleFromJson(Map<String, dynamic> json) {
  return _ValidationRule.fromJson(json);
}

/// @nodoc
mixin _$ValidationRule {
  ValidationRuleType get type => throw _privateConstructorUsedError;
  dynamic get value => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool Function(dynamic, Map<String, dynamic>)? get customValidator =>
      throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Future<bool> Function(dynamic)? get asyncValidator =>
      throw _privateConstructorUsedError;

  /// Serializes this ValidationRule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ValidationRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ValidationRuleCopyWith<ValidationRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidationRuleCopyWith<$Res> {
  factory $ValidationRuleCopyWith(
          ValidationRule value, $Res Function(ValidationRule) then) =
      _$ValidationRuleCopyWithImpl<$Res, ValidationRule>;
  @useResult
  $Res call(
      {ValidationRuleType type,
      dynamic value,
      String? message,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool Function(dynamic, Map<String, dynamic>)? customValidator,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Future<bool> Function(dynamic)? asyncValidator});
}

/// @nodoc
class _$ValidationRuleCopyWithImpl<$Res, $Val extends ValidationRule>
    implements $ValidationRuleCopyWith<$Res> {
  _$ValidationRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ValidationRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? value = freezed,
    Object? message = freezed,
    Object? customValidator = freezed,
    Object? asyncValidator = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ValidationRuleType,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      customValidator: freezed == customValidator
          ? _value.customValidator
          : customValidator // ignore: cast_nullable_to_non_nullable
              as bool Function(dynamic, Map<String, dynamic>)?,
      asyncValidator: freezed == asyncValidator
          ? _value.asyncValidator
          : asyncValidator // ignore: cast_nullable_to_non_nullable
              as Future<bool> Function(dynamic)?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ValidationRuleImplCopyWith<$Res>
    implements $ValidationRuleCopyWith<$Res> {
  factory _$$ValidationRuleImplCopyWith(_$ValidationRuleImpl value,
          $Res Function(_$ValidationRuleImpl) then) =
      __$$ValidationRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ValidationRuleType type,
      dynamic value,
      String? message,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool Function(dynamic, Map<String, dynamic>)? customValidator,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Future<bool> Function(dynamic)? asyncValidator});
}

/// @nodoc
class __$$ValidationRuleImplCopyWithImpl<$Res>
    extends _$ValidationRuleCopyWithImpl<$Res, _$ValidationRuleImpl>
    implements _$$ValidationRuleImplCopyWith<$Res> {
  __$$ValidationRuleImplCopyWithImpl(
      _$ValidationRuleImpl _value, $Res Function(_$ValidationRuleImpl) _then)
      : super(_value, _then);

  /// Create a copy of ValidationRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? value = freezed,
    Object? message = freezed,
    Object? customValidator = freezed,
    Object? asyncValidator = freezed,
  }) {
    return _then(_$ValidationRuleImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ValidationRuleType,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      customValidator: freezed == customValidator
          ? _value.customValidator
          : customValidator // ignore: cast_nullable_to_non_nullable
              as bool Function(dynamic, Map<String, dynamic>)?,
      asyncValidator: freezed == asyncValidator
          ? _value.asyncValidator
          : asyncValidator // ignore: cast_nullable_to_non_nullable
              as Future<bool> Function(dynamic)?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ValidationRuleImpl implements _ValidationRule {
  const _$ValidationRuleImpl(
      {required this.type,
      this.value,
      this.message,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.customValidator,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.asyncValidator});

  factory _$ValidationRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$ValidationRuleImplFromJson(json);

  @override
  final ValidationRuleType type;
  @override
  final dynamic value;
  @override
  final String? message;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool Function(dynamic, Map<String, dynamic>)? customValidator;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Future<bool> Function(dynamic)? asyncValidator;

  @override
  String toString() {
    return 'ValidationRule(type: $type, value: $value, message: $message, customValidator: $customValidator, asyncValidator: $asyncValidator)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationRuleImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.customValidator, customValidator) ||
                other.customValidator == customValidator) &&
            (identical(other.asyncValidator, asyncValidator) ||
                other.asyncValidator == asyncValidator));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(value),
      message,
      customValidator,
      asyncValidator);

  /// Create a copy of ValidationRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationRuleImplCopyWith<_$ValidationRuleImpl> get copyWith =>
      __$$ValidationRuleImplCopyWithImpl<_$ValidationRuleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ValidationRuleImplToJson(
      this,
    );
  }
}

abstract class _ValidationRule implements ValidationRule {
  const factory _ValidationRule(
          {required final ValidationRuleType type,
          final dynamic value,
          final String? message,
          @JsonKey(includeFromJson: false, includeToJson: false)
          final bool Function(dynamic, Map<String, dynamic>)? customValidator,
          @JsonKey(includeFromJson: false, includeToJson: false)
          final Future<bool> Function(dynamic)? asyncValidator}) =
      _$ValidationRuleImpl;

  factory _ValidationRule.fromJson(Map<String, dynamic> json) =
      _$ValidationRuleImpl.fromJson;

  @override
  ValidationRuleType get type;
  @override
  dynamic get value;
  @override
  String? get message;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool Function(dynamic, Map<String, dynamic>)? get customValidator;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Future<bool> Function(dynamic)? get asyncValidator;

  /// Create a copy of ValidationRule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationRuleImplCopyWith<_$ValidationRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FormFieldOptions _$FormFieldOptionsFromJson(Map<String, dynamic> json) {
  return _FormFieldOptions.fromJson(json);
}

/// @nodoc
mixin _$FormFieldOptions {
// For select/radio/checkbox
  List<SelectOption>? get options =>
      throw _privateConstructorUsedError; // For number/range
  double? get min => throw _privateConstructorUsedError;
  double? get max => throw _privateConstructorUsedError;
  double? get step => throw _privateConstructorUsedError; // For text
  int? get minLength => throw _privateConstructorUsedError;
  int? get maxLength => throw _privateConstructorUsedError;
  int? get minLines => throw _privateConstructorUsedError;
  int? get maxLines => throw _privateConstructorUsedError; // For date/time
  DateTime? get minDate => throw _privateConstructorUsedError;
  DateTime? get maxDate => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  TimeOfDay? get minTime => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  TimeOfDay? get maxTime => throw _privateConstructorUsedError;
  String? get dateFormat => throw _privateConstructorUsedError; // For file
  List<String>? get acceptedFileTypes => throw _privateConstructorUsedError;
  int? get maxFileSize => throw _privateConstructorUsedError;
  int? get maxFiles => throw _privateConstructorUsedError;
  bool get multiple => throw _privateConstructorUsedError; // For autocomplete
  @JsonKey(includeFromJson: false, includeToJson: false)
  Future<List<SelectOption>> Function(String)? get autocompleteSearch =>
      throw _privateConstructorUsedError; // UI options
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get prefixIcon => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get suffixIcon => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Widget? get prefix => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Widget? get suffix => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  InputBorder? get border => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  TextInputType? get keyboardType => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  TextCapitalization? get textCapitalization =>
      throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  TextInputAction? get textInputAction => throw _privateConstructorUsedError;

  /// Serializes this FormFieldOptions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FormFieldOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FormFieldOptionsCopyWith<FormFieldOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormFieldOptionsCopyWith<$Res> {
  factory $FormFieldOptionsCopyWith(
          FormFieldOptions value, $Res Function(FormFieldOptions) then) =
      _$FormFieldOptionsCopyWithImpl<$Res, FormFieldOptions>;
  @useResult
  $Res call(
      {List<SelectOption>? options,
      double? min,
      double? max,
      double? step,
      int? minLength,
      int? maxLength,
      int? minLines,
      int? maxLines,
      DateTime? minDate,
      DateTime? maxDate,
      @JsonKey(includeFromJson: false, includeToJson: false) TimeOfDay? minTime,
      @JsonKey(includeFromJson: false, includeToJson: false) TimeOfDay? maxTime,
      String? dateFormat,
      List<String>? acceptedFileTypes,
      int? maxFileSize,
      int? maxFiles,
      bool multiple,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Future<List<SelectOption>> Function(String)? autocompleteSearch,
      @JsonKey(includeFromJson: false, includeToJson: false)
      IconData? prefixIcon,
      @JsonKey(includeFromJson: false, includeToJson: false)
      IconData? suffixIcon,
      @JsonKey(includeFromJson: false, includeToJson: false) Widget? prefix,
      @JsonKey(includeFromJson: false, includeToJson: false) Widget? suffix,
      @JsonKey(includeFromJson: false, includeToJson: false)
      InputBorder? border,
      @JsonKey(includeFromJson: false, includeToJson: false)
      TextInputType? keyboardType,
      @JsonKey(includeFromJson: false, includeToJson: false)
      TextCapitalization? textCapitalization,
      @JsonKey(includeFromJson: false, includeToJson: false)
      TextInputAction? textInputAction});
}

/// @nodoc
class _$FormFieldOptionsCopyWithImpl<$Res, $Val extends FormFieldOptions>
    implements $FormFieldOptionsCopyWith<$Res> {
  _$FormFieldOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FormFieldOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? options = freezed,
    Object? min = freezed,
    Object? max = freezed,
    Object? step = freezed,
    Object? minLength = freezed,
    Object? maxLength = freezed,
    Object? minLines = freezed,
    Object? maxLines = freezed,
    Object? minDate = freezed,
    Object? maxDate = freezed,
    Object? minTime = freezed,
    Object? maxTime = freezed,
    Object? dateFormat = freezed,
    Object? acceptedFileTypes = freezed,
    Object? maxFileSize = freezed,
    Object? maxFiles = freezed,
    Object? multiple = null,
    Object? autocompleteSearch = freezed,
    Object? prefixIcon = freezed,
    Object? suffixIcon = freezed,
    Object? prefix = freezed,
    Object? suffix = freezed,
    Object? border = freezed,
    Object? keyboardType = freezed,
    Object? textCapitalization = freezed,
    Object? textInputAction = freezed,
  }) {
    return _then(_value.copyWith(
      options: freezed == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<SelectOption>?,
      min: freezed == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as double?,
      max: freezed == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as double?,
      step: freezed == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as double?,
      minLength: freezed == minLength
          ? _value.minLength
          : minLength // ignore: cast_nullable_to_non_nullable
              as int?,
      maxLength: freezed == maxLength
          ? _value.maxLength
          : maxLength // ignore: cast_nullable_to_non_nullable
              as int?,
      minLines: freezed == minLines
          ? _value.minLines
          : minLines // ignore: cast_nullable_to_non_nullable
              as int?,
      maxLines: freezed == maxLines
          ? _value.maxLines
          : maxLines // ignore: cast_nullable_to_non_nullable
              as int?,
      minDate: freezed == minDate
          ? _value.minDate
          : minDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      maxDate: freezed == maxDate
          ? _value.maxDate
          : maxDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      minTime: freezed == minTime
          ? _value.minTime
          : minTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      maxTime: freezed == maxTime
          ? _value.maxTime
          : maxTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      dateFormat: freezed == dateFormat
          ? _value.dateFormat
          : dateFormat // ignore: cast_nullable_to_non_nullable
              as String?,
      acceptedFileTypes: freezed == acceptedFileTypes
          ? _value.acceptedFileTypes
          : acceptedFileTypes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      maxFileSize: freezed == maxFileSize
          ? _value.maxFileSize
          : maxFileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      maxFiles: freezed == maxFiles
          ? _value.maxFiles
          : maxFiles // ignore: cast_nullable_to_non_nullable
              as int?,
      multiple: null == multiple
          ? _value.multiple
          : multiple // ignore: cast_nullable_to_non_nullable
              as bool,
      autocompleteSearch: freezed == autocompleteSearch
          ? _value.autocompleteSearch
          : autocompleteSearch // ignore: cast_nullable_to_non_nullable
              as Future<List<SelectOption>> Function(String)?,
      prefixIcon: freezed == prefixIcon
          ? _value.prefixIcon
          : prefixIcon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      suffixIcon: freezed == suffixIcon
          ? _value.suffixIcon
          : suffixIcon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      prefix: freezed == prefix
          ? _value.prefix
          : prefix // ignore: cast_nullable_to_non_nullable
              as Widget?,
      suffix: freezed == suffix
          ? _value.suffix
          : suffix // ignore: cast_nullable_to_non_nullable
              as Widget?,
      border: freezed == border
          ? _value.border
          : border // ignore: cast_nullable_to_non_nullable
              as InputBorder?,
      keyboardType: freezed == keyboardType
          ? _value.keyboardType
          : keyboardType // ignore: cast_nullable_to_non_nullable
              as TextInputType?,
      textCapitalization: freezed == textCapitalization
          ? _value.textCapitalization
          : textCapitalization // ignore: cast_nullable_to_non_nullable
              as TextCapitalization?,
      textInputAction: freezed == textInputAction
          ? _value.textInputAction
          : textInputAction // ignore: cast_nullable_to_non_nullable
              as TextInputAction?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FormFieldOptionsImplCopyWith<$Res>
    implements $FormFieldOptionsCopyWith<$Res> {
  factory _$$FormFieldOptionsImplCopyWith(_$FormFieldOptionsImpl value,
          $Res Function(_$FormFieldOptionsImpl) then) =
      __$$FormFieldOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SelectOption>? options,
      double? min,
      double? max,
      double? step,
      int? minLength,
      int? maxLength,
      int? minLines,
      int? maxLines,
      DateTime? minDate,
      DateTime? maxDate,
      @JsonKey(includeFromJson: false, includeToJson: false) TimeOfDay? minTime,
      @JsonKey(includeFromJson: false, includeToJson: false) TimeOfDay? maxTime,
      String? dateFormat,
      List<String>? acceptedFileTypes,
      int? maxFileSize,
      int? maxFiles,
      bool multiple,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Future<List<SelectOption>> Function(String)? autocompleteSearch,
      @JsonKey(includeFromJson: false, includeToJson: false)
      IconData? prefixIcon,
      @JsonKey(includeFromJson: false, includeToJson: false)
      IconData? suffixIcon,
      @JsonKey(includeFromJson: false, includeToJson: false) Widget? prefix,
      @JsonKey(includeFromJson: false, includeToJson: false) Widget? suffix,
      @JsonKey(includeFromJson: false, includeToJson: false)
      InputBorder? border,
      @JsonKey(includeFromJson: false, includeToJson: false)
      TextInputType? keyboardType,
      @JsonKey(includeFromJson: false, includeToJson: false)
      TextCapitalization? textCapitalization,
      @JsonKey(includeFromJson: false, includeToJson: false)
      TextInputAction? textInputAction});
}

/// @nodoc
class __$$FormFieldOptionsImplCopyWithImpl<$Res>
    extends _$FormFieldOptionsCopyWithImpl<$Res, _$FormFieldOptionsImpl>
    implements _$$FormFieldOptionsImplCopyWith<$Res> {
  __$$FormFieldOptionsImplCopyWithImpl(_$FormFieldOptionsImpl _value,
      $Res Function(_$FormFieldOptionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FormFieldOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? options = freezed,
    Object? min = freezed,
    Object? max = freezed,
    Object? step = freezed,
    Object? minLength = freezed,
    Object? maxLength = freezed,
    Object? minLines = freezed,
    Object? maxLines = freezed,
    Object? minDate = freezed,
    Object? maxDate = freezed,
    Object? minTime = freezed,
    Object? maxTime = freezed,
    Object? dateFormat = freezed,
    Object? acceptedFileTypes = freezed,
    Object? maxFileSize = freezed,
    Object? maxFiles = freezed,
    Object? multiple = null,
    Object? autocompleteSearch = freezed,
    Object? prefixIcon = freezed,
    Object? suffixIcon = freezed,
    Object? prefix = freezed,
    Object? suffix = freezed,
    Object? border = freezed,
    Object? keyboardType = freezed,
    Object? textCapitalization = freezed,
    Object? textInputAction = freezed,
  }) {
    return _then(_$FormFieldOptionsImpl(
      options: freezed == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<SelectOption>?,
      min: freezed == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as double?,
      max: freezed == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as double?,
      step: freezed == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as double?,
      minLength: freezed == minLength
          ? _value.minLength
          : minLength // ignore: cast_nullable_to_non_nullable
              as int?,
      maxLength: freezed == maxLength
          ? _value.maxLength
          : maxLength // ignore: cast_nullable_to_non_nullable
              as int?,
      minLines: freezed == minLines
          ? _value.minLines
          : minLines // ignore: cast_nullable_to_non_nullable
              as int?,
      maxLines: freezed == maxLines
          ? _value.maxLines
          : maxLines // ignore: cast_nullable_to_non_nullable
              as int?,
      minDate: freezed == minDate
          ? _value.minDate
          : minDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      maxDate: freezed == maxDate
          ? _value.maxDate
          : maxDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      minTime: freezed == minTime
          ? _value.minTime
          : minTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      maxTime: freezed == maxTime
          ? _value.maxTime
          : maxTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      dateFormat: freezed == dateFormat
          ? _value.dateFormat
          : dateFormat // ignore: cast_nullable_to_non_nullable
              as String?,
      acceptedFileTypes: freezed == acceptedFileTypes
          ? _value._acceptedFileTypes
          : acceptedFileTypes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      maxFileSize: freezed == maxFileSize
          ? _value.maxFileSize
          : maxFileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      maxFiles: freezed == maxFiles
          ? _value.maxFiles
          : maxFiles // ignore: cast_nullable_to_non_nullable
              as int?,
      multiple: null == multiple
          ? _value.multiple
          : multiple // ignore: cast_nullable_to_non_nullable
              as bool,
      autocompleteSearch: freezed == autocompleteSearch
          ? _value.autocompleteSearch
          : autocompleteSearch // ignore: cast_nullable_to_non_nullable
              as Future<List<SelectOption>> Function(String)?,
      prefixIcon: freezed == prefixIcon
          ? _value.prefixIcon
          : prefixIcon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      suffixIcon: freezed == suffixIcon
          ? _value.suffixIcon
          : suffixIcon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      prefix: freezed == prefix
          ? _value.prefix
          : prefix // ignore: cast_nullable_to_non_nullable
              as Widget?,
      suffix: freezed == suffix
          ? _value.suffix
          : suffix // ignore: cast_nullable_to_non_nullable
              as Widget?,
      border: freezed == border
          ? _value.border
          : border // ignore: cast_nullable_to_non_nullable
              as InputBorder?,
      keyboardType: freezed == keyboardType
          ? _value.keyboardType
          : keyboardType // ignore: cast_nullable_to_non_nullable
              as TextInputType?,
      textCapitalization: freezed == textCapitalization
          ? _value.textCapitalization
          : textCapitalization // ignore: cast_nullable_to_non_nullable
              as TextCapitalization?,
      textInputAction: freezed == textInputAction
          ? _value.textInputAction
          : textInputAction // ignore: cast_nullable_to_non_nullable
              as TextInputAction?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FormFieldOptionsImpl implements _FormFieldOptions {
  const _$FormFieldOptionsImpl(
      {final List<SelectOption>? options,
      this.min,
      this.max,
      this.step,
      this.minLength,
      this.maxLength,
      this.minLines,
      this.maxLines,
      this.minDate,
      this.maxDate,
      @JsonKey(includeFromJson: false, includeToJson: false) this.minTime,
      @JsonKey(includeFromJson: false, includeToJson: false) this.maxTime,
      this.dateFormat,
      final List<String>? acceptedFileTypes,
      this.maxFileSize,
      this.maxFiles,
      this.multiple = false,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.autocompleteSearch,
      @JsonKey(includeFromJson: false, includeToJson: false) this.prefixIcon,
      @JsonKey(includeFromJson: false, includeToJson: false) this.suffixIcon,
      @JsonKey(includeFromJson: false, includeToJson: false) this.prefix,
      @JsonKey(includeFromJson: false, includeToJson: false) this.suffix,
      @JsonKey(includeFromJson: false, includeToJson: false) this.border,
      @JsonKey(includeFromJson: false, includeToJson: false) this.keyboardType,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.textCapitalization,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.textInputAction})
      : _options = options,
        _acceptedFileTypes = acceptedFileTypes;

  factory _$FormFieldOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$FormFieldOptionsImplFromJson(json);

// For select/radio/checkbox
  final List<SelectOption>? _options;
// For select/radio/checkbox
  @override
  List<SelectOption>? get options {
    final value = _options;
    if (value == null) return null;
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// For number/range
  @override
  final double? min;
  @override
  final double? max;
  @override
  final double? step;
// For text
  @override
  final int? minLength;
  @override
  final int? maxLength;
  @override
  final int? minLines;
  @override
  final int? maxLines;
// For date/time
  @override
  final DateTime? minDate;
  @override
  final DateTime? maxDate;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final TimeOfDay? minTime;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final TimeOfDay? maxTime;
  @override
  final String? dateFormat;
// For file
  final List<String>? _acceptedFileTypes;
// For file
  @override
  List<String>? get acceptedFileTypes {
    final value = _acceptedFileTypes;
    if (value == null) return null;
    if (_acceptedFileTypes is EqualUnmodifiableListView)
      return _acceptedFileTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? maxFileSize;
  @override
  final int? maxFiles;
  @override
  @JsonKey()
  final bool multiple;
// For autocomplete
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Future<List<SelectOption>> Function(String)? autocompleteSearch;
// UI options
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final IconData? prefixIcon;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final IconData? suffixIcon;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Widget? prefix;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Widget? suffix;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final InputBorder? border;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final TextInputType? keyboardType;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final TextCapitalization? textCapitalization;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final TextInputAction? textInputAction;

  @override
  String toString() {
    return 'FormFieldOptions(options: $options, min: $min, max: $max, step: $step, minLength: $minLength, maxLength: $maxLength, minLines: $minLines, maxLines: $maxLines, minDate: $minDate, maxDate: $maxDate, minTime: $minTime, maxTime: $maxTime, dateFormat: $dateFormat, acceptedFileTypes: $acceptedFileTypes, maxFileSize: $maxFileSize, maxFiles: $maxFiles, multiple: $multiple, autocompleteSearch: $autocompleteSearch, prefixIcon: $prefixIcon, suffixIcon: $suffixIcon, prefix: $prefix, suffix: $suffix, border: $border, keyboardType: $keyboardType, textCapitalization: $textCapitalization, textInputAction: $textInputAction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormFieldOptionsImpl &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.step, step) || other.step == step) &&
            (identical(other.minLength, minLength) ||
                other.minLength == minLength) &&
            (identical(other.maxLength, maxLength) ||
                other.maxLength == maxLength) &&
            (identical(other.minLines, minLines) ||
                other.minLines == minLines) &&
            (identical(other.maxLines, maxLines) ||
                other.maxLines == maxLines) &&
            (identical(other.minDate, minDate) || other.minDate == minDate) &&
            (identical(other.maxDate, maxDate) || other.maxDate == maxDate) &&
            (identical(other.minTime, minTime) || other.minTime == minTime) &&
            (identical(other.maxTime, maxTime) || other.maxTime == maxTime) &&
            (identical(other.dateFormat, dateFormat) ||
                other.dateFormat == dateFormat) &&
            const DeepCollectionEquality()
                .equals(other._acceptedFileTypes, _acceptedFileTypes) &&
            (identical(other.maxFileSize, maxFileSize) ||
                other.maxFileSize == maxFileSize) &&
            (identical(other.maxFiles, maxFiles) ||
                other.maxFiles == maxFiles) &&
            (identical(other.multiple, multiple) ||
                other.multiple == multiple) &&
            (identical(other.autocompleteSearch, autocompleteSearch) ||
                other.autocompleteSearch == autocompleteSearch) &&
            (identical(other.prefixIcon, prefixIcon) ||
                other.prefixIcon == prefixIcon) &&
            (identical(other.suffixIcon, suffixIcon) ||
                other.suffixIcon == suffixIcon) &&
            (identical(other.prefix, prefix) || other.prefix == prefix) &&
            (identical(other.suffix, suffix) || other.suffix == suffix) &&
            (identical(other.border, border) || other.border == border) &&
            (identical(other.keyboardType, keyboardType) ||
                other.keyboardType == keyboardType) &&
            (identical(other.textCapitalization, textCapitalization) ||
                other.textCapitalization == textCapitalization) &&
            (identical(other.textInputAction, textInputAction) ||
                other.textInputAction == textInputAction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(_options),
        min,
        max,
        step,
        minLength,
        maxLength,
        minLines,
        maxLines,
        minDate,
        maxDate,
        minTime,
        maxTime,
        dateFormat,
        const DeepCollectionEquality().hash(_acceptedFileTypes),
        maxFileSize,
        maxFiles,
        multiple,
        autocompleteSearch,
        prefixIcon,
        suffixIcon,
        prefix,
        suffix,
        border,
        keyboardType,
        textCapitalization,
        textInputAction
      ]);

  /// Create a copy of FormFieldOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormFieldOptionsImplCopyWith<_$FormFieldOptionsImpl> get copyWith =>
      __$$FormFieldOptionsImplCopyWithImpl<_$FormFieldOptionsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FormFieldOptionsImplToJson(
      this,
    );
  }
}

abstract class _FormFieldOptions implements FormFieldOptions {
  const factory _FormFieldOptions(
      {final List<SelectOption>? options,
      final double? min,
      final double? max,
      final double? step,
      final int? minLength,
      final int? maxLength,
      final int? minLines,
      final int? maxLines,
      final DateTime? minDate,
      final DateTime? maxDate,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final TimeOfDay? minTime,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final TimeOfDay? maxTime,
      final String? dateFormat,
      final List<String>? acceptedFileTypes,
      final int? maxFileSize,
      final int? maxFiles,
      final bool multiple,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Future<List<SelectOption>> Function(String)? autocompleteSearch,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final IconData? prefixIcon,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final IconData? suffixIcon,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Widget? prefix,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Widget? suffix,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final InputBorder? border,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final TextInputType? keyboardType,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final TextCapitalization? textCapitalization,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final TextInputAction? textInputAction}) = _$FormFieldOptionsImpl;

  factory _FormFieldOptions.fromJson(Map<String, dynamic> json) =
      _$FormFieldOptionsImpl.fromJson;

// For select/radio/checkbox
  @override
  List<SelectOption>? get options; // For number/range
  @override
  double? get min;
  @override
  double? get max;
  @override
  double? get step; // For text
  @override
  int? get minLength;
  @override
  int? get maxLength;
  @override
  int? get minLines;
  @override
  int? get maxLines; // For date/time
  @override
  DateTime? get minDate;
  @override
  DateTime? get maxDate;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  TimeOfDay? get minTime;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  TimeOfDay? get maxTime;
  @override
  String? get dateFormat; // For file
  @override
  List<String>? get acceptedFileTypes;
  @override
  int? get maxFileSize;
  @override
  int? get maxFiles;
  @override
  bool get multiple; // For autocomplete
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Future<List<SelectOption>> Function(String)?
      get autocompleteSearch; // UI options
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get prefixIcon;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get suffixIcon;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Widget? get prefix;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Widget? get suffix;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  InputBorder? get border;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  TextInputType? get keyboardType;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  TextCapitalization? get textCapitalization;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  TextInputAction? get textInputAction;

  /// Create a copy of FormFieldOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormFieldOptionsImplCopyWith<_$FormFieldOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SelectOption _$SelectOptionFromJson(Map<String, dynamic> json) {
  return _SelectOption.fromJson(json);
}

/// @nodoc
mixin _$SelectOption {
  dynamic get value => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get icon => throw _privateConstructorUsedError;
  bool get disabled => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

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
  $Res call(
      {dynamic value,
      String label,
      String? description,
      @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon,
      bool disabled,
      Map<String, dynamic>? metadata});
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
    Object? description = freezed,
    Object? icon = freezed,
    Object? disabled = null,
    Object? metadata = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      disabled: null == disabled
          ? _value.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
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
  $Res call(
      {dynamic value,
      String label,
      String? description,
      @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon,
      bool disabled,
      Map<String, dynamic>? metadata});
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
    Object? description = freezed,
    Object? icon = freezed,
    Object? disabled = null,
    Object? metadata = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      disabled: null == disabled
          ? _value.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SelectOptionImpl implements _SelectOption {
  const _$SelectOptionImpl(
      {required this.value,
      required this.label,
      this.description,
      @JsonKey(includeFromJson: false, includeToJson: false) this.icon,
      this.disabled = false,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$SelectOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SelectOptionImplFromJson(json);

  @override
  final dynamic value;
  @override
  final String label;
  @override
  final String? description;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final IconData? icon;
  @override
  @JsonKey()
  final bool disabled;
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
    return 'SelectOption(value: $value, label: $label, description: $description, icon: $icon, disabled: $disabled, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectOptionImpl &&
            const DeepCollectionEquality().equals(other.value, value) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.disabled, disabled) ||
                other.disabled == disabled) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(value),
      label,
      description,
      icon,
      disabled,
      const DeepCollectionEquality().hash(_metadata));

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
      final String? description,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final IconData? icon,
      final bool disabled,
      final Map<String, dynamic>? metadata}) = _$SelectOptionImpl;

  factory _SelectOption.fromJson(Map<String, dynamic> json) =
      _$SelectOptionImpl.fromJson;

  @override
  dynamic get value;
  @override
  String get label;
  @override
  String? get description;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get icon;
  @override
  bool get disabled;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of SelectOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectOptionImplCopyWith<_$SelectOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FormSection _$FormSectionFromJson(Map<String, dynamic> json) {
  return _FormSection.fromJson(json);
}

/// @nodoc
mixin _$FormSection {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<FormFieldModel> get fields => throw _privateConstructorUsedError;
  bool get collapsible => throw _privateConstructorUsedError;
  bool get expanded => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get icon => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this FormSection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FormSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FormSectionCopyWith<FormSection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormSectionCopyWith<$Res> {
  factory $FormSectionCopyWith(
          FormSection value, $Res Function(FormSection) then) =
      _$FormSectionCopyWithImpl<$Res, FormSection>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      List<FormFieldModel> fields,
      bool collapsible,
      bool expanded,
      @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$FormSectionCopyWithImpl<$Res, $Val extends FormSection>
    implements $FormSectionCopyWith<$Res> {
  _$FormSectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FormSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? fields = null,
    Object? collapsible = null,
    Object? expanded = null,
    Object? icon = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<FormFieldModel>,
      collapsible: null == collapsible
          ? _value.collapsible
          : collapsible // ignore: cast_nullable_to_non_nullable
              as bool,
      expanded: null == expanded
          ? _value.expanded
          : expanded // ignore: cast_nullable_to_non_nullable
              as bool,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FormSectionImplCopyWith<$Res>
    implements $FormSectionCopyWith<$Res> {
  factory _$$FormSectionImplCopyWith(
          _$FormSectionImpl value, $Res Function(_$FormSectionImpl) then) =
      __$$FormSectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      List<FormFieldModel> fields,
      bool collapsible,
      bool expanded,
      @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$FormSectionImplCopyWithImpl<$Res>
    extends _$FormSectionCopyWithImpl<$Res, _$FormSectionImpl>
    implements _$$FormSectionImplCopyWith<$Res> {
  __$$FormSectionImplCopyWithImpl(
      _$FormSectionImpl _value, $Res Function(_$FormSectionImpl) _then)
      : super(_value, _then);

  /// Create a copy of FormSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? fields = null,
    Object? collapsible = null,
    Object? expanded = null,
    Object? icon = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$FormSectionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<FormFieldModel>,
      collapsible: null == collapsible
          ? _value.collapsible
          : collapsible // ignore: cast_nullable_to_non_nullable
              as bool,
      expanded: null == expanded
          ? _value.expanded
          : expanded // ignore: cast_nullable_to_non_nullable
              as bool,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FormSectionImpl implements _FormSection {
  const _$FormSectionImpl(
      {required this.id,
      required this.title,
      this.description,
      final List<FormFieldModel> fields = const [],
      this.collapsible = false,
      this.expanded = true,
      @JsonKey(includeFromJson: false, includeToJson: false) this.icon,
      final Map<String, dynamic>? metadata})
      : _fields = fields,
        _metadata = metadata;

  factory _$FormSectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$FormSectionImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  final List<FormFieldModel> _fields;
  @override
  @JsonKey()
  List<FormFieldModel> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  @override
  @JsonKey()
  final bool collapsible;
  @override
  @JsonKey()
  final bool expanded;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final IconData? icon;
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
    return 'FormSection(id: $id, title: $title, description: $description, fields: $fields, collapsible: $collapsible, expanded: $expanded, icon: $icon, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormSectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._fields, _fields) &&
            (identical(other.collapsible, collapsible) ||
                other.collapsible == collapsible) &&
            (identical(other.expanded, expanded) ||
                other.expanded == expanded) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      const DeepCollectionEquality().hash(_fields),
      collapsible,
      expanded,
      icon,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of FormSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormSectionImplCopyWith<_$FormSectionImpl> get copyWith =>
      __$$FormSectionImplCopyWithImpl<_$FormSectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FormSectionImplToJson(
      this,
    );
  }
}

abstract class _FormSection implements FormSection {
  const factory _FormSection(
      {required final String id,
      required final String title,
      final String? description,
      final List<FormFieldModel> fields,
      final bool collapsible,
      final bool expanded,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final IconData? icon,
      final Map<String, dynamic>? metadata}) = _$FormSectionImpl;

  factory _FormSection.fromJson(Map<String, dynamic> json) =
      _$FormSectionImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  List<FormFieldModel> get fields;
  @override
  bool get collapsible;
  @override
  bool get expanded;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get icon;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of FormSection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormSectionImplCopyWith<_$FormSectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FormSchema _$FormSchemaFromJson(Map<String, dynamic> json) {
  return _FormSchema.fromJson(json);
}

/// @nodoc
mixin _$FormSchema {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  FormLayoutType get layoutType => throw _privateConstructorUsedError;
  List<FormSection> get sections => throw _privateConstructorUsedError;
  Map<String, dynamic> get initialValues => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  FormActions? get actions => throw _privateConstructorUsedError;
  FormSettings? get settings => throw _privateConstructorUsedError;

  /// Serializes this FormSchema to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FormSchema
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FormSchemaCopyWith<FormSchema> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormSchemaCopyWith<$Res> {
  factory $FormSchemaCopyWith(
          FormSchema value, $Res Function(FormSchema) then) =
      _$FormSchemaCopyWithImpl<$Res, FormSchema>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      FormLayoutType layoutType,
      List<FormSection> sections,
      Map<String, dynamic> initialValues,
      Map<String, dynamic> metadata,
      FormActions? actions,
      FormSettings? settings});

  $FormActionsCopyWith<$Res>? get actions;
  $FormSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class _$FormSchemaCopyWithImpl<$Res, $Val extends FormSchema>
    implements $FormSchemaCopyWith<$Res> {
  _$FormSchemaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FormSchema
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? layoutType = null,
    Object? sections = null,
    Object? initialValues = null,
    Object? metadata = null,
    Object? actions = freezed,
    Object? settings = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      layoutType: null == layoutType
          ? _value.layoutType
          : layoutType // ignore: cast_nullable_to_non_nullable
              as FormLayoutType,
      sections: null == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<FormSection>,
      initialValues: null == initialValues
          ? _value.initialValues
          : initialValues // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      actions: freezed == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as FormActions?,
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as FormSettings?,
    ) as $Val);
  }

  /// Create a copy of FormSchema
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FormActionsCopyWith<$Res>? get actions {
    if (_value.actions == null) {
      return null;
    }

    return $FormActionsCopyWith<$Res>(_value.actions!, (value) {
      return _then(_value.copyWith(actions: value) as $Val);
    });
  }

  /// Create a copy of FormSchema
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FormSettingsCopyWith<$Res>? get settings {
    if (_value.settings == null) {
      return null;
    }

    return $FormSettingsCopyWith<$Res>(_value.settings!, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FormSchemaImplCopyWith<$Res>
    implements $FormSchemaCopyWith<$Res> {
  factory _$$FormSchemaImplCopyWith(
          _$FormSchemaImpl value, $Res Function(_$FormSchemaImpl) then) =
      __$$FormSchemaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      FormLayoutType layoutType,
      List<FormSection> sections,
      Map<String, dynamic> initialValues,
      Map<String, dynamic> metadata,
      FormActions? actions,
      FormSettings? settings});

  @override
  $FormActionsCopyWith<$Res>? get actions;
  @override
  $FormSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class __$$FormSchemaImplCopyWithImpl<$Res>
    extends _$FormSchemaCopyWithImpl<$Res, _$FormSchemaImpl>
    implements _$$FormSchemaImplCopyWith<$Res> {
  __$$FormSchemaImplCopyWithImpl(
      _$FormSchemaImpl _value, $Res Function(_$FormSchemaImpl) _then)
      : super(_value, _then);

  /// Create a copy of FormSchema
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? layoutType = null,
    Object? sections = null,
    Object? initialValues = null,
    Object? metadata = null,
    Object? actions = freezed,
    Object? settings = freezed,
  }) {
    return _then(_$FormSchemaImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      layoutType: null == layoutType
          ? _value.layoutType
          : layoutType // ignore: cast_nullable_to_non_nullable
              as FormLayoutType,
      sections: null == sections
          ? _value._sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<FormSection>,
      initialValues: null == initialValues
          ? _value._initialValues
          : initialValues // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      actions: freezed == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as FormActions?,
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as FormSettings?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FormSchemaImpl implements _FormSchema {
  const _$FormSchemaImpl(
      {required this.id,
      required this.name,
      this.description,
      required this.layoutType,
      final List<FormSection> sections = const [],
      final Map<String, dynamic> initialValues = const {},
      final Map<String, dynamic> metadata = const {},
      this.actions,
      this.settings})
      : _sections = sections,
        _initialValues = initialValues,
        _metadata = metadata;

  factory _$FormSchemaImpl.fromJson(Map<String, dynamic> json) =>
      _$$FormSchemaImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final FormLayoutType layoutType;
  final List<FormSection> _sections;
  @override
  @JsonKey()
  List<FormSection> get sections {
    if (_sections is EqualUnmodifiableListView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sections);
  }

  final Map<String, dynamic> _initialValues;
  @override
  @JsonKey()
  Map<String, dynamic> get initialValues {
    if (_initialValues is EqualUnmodifiableMapView) return _initialValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_initialValues);
  }

  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final FormActions? actions;
  @override
  final FormSettings? settings;

  @override
  String toString() {
    return 'FormSchema(id: $id, name: $name, description: $description, layoutType: $layoutType, sections: $sections, initialValues: $initialValues, metadata: $metadata, actions: $actions, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormSchemaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.layoutType, layoutType) ||
                other.layoutType == layoutType) &&
            const DeepCollectionEquality().equals(other._sections, _sections) &&
            const DeepCollectionEquality()
                .equals(other._initialValues, _initialValues) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.actions, actions) || other.actions == actions) &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      layoutType,
      const DeepCollectionEquality().hash(_sections),
      const DeepCollectionEquality().hash(_initialValues),
      const DeepCollectionEquality().hash(_metadata),
      actions,
      settings);

  /// Create a copy of FormSchema
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormSchemaImplCopyWith<_$FormSchemaImpl> get copyWith =>
      __$$FormSchemaImplCopyWithImpl<_$FormSchemaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FormSchemaImplToJson(
      this,
    );
  }
}

abstract class _FormSchema implements FormSchema {
  const factory _FormSchema(
      {required final String id,
      required final String name,
      final String? description,
      required final FormLayoutType layoutType,
      final List<FormSection> sections,
      final Map<String, dynamic> initialValues,
      final Map<String, dynamic> metadata,
      final FormActions? actions,
      final FormSettings? settings}) = _$FormSchemaImpl;

  factory _FormSchema.fromJson(Map<String, dynamic> json) =
      _$FormSchemaImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  FormLayoutType get layoutType;
  @override
  List<FormSection> get sections;
  @override
  Map<String, dynamic> get initialValues;
  @override
  Map<String, dynamic> get metadata;
  @override
  FormActions? get actions;
  @override
  FormSettings? get settings;

  /// Create a copy of FormSchema
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormSchemaImplCopyWith<_$FormSchemaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FormActions _$FormActionsFromJson(Map<String, dynamic> json) {
  return _FormActions.fromJson(json);
}

/// @nodoc
mixin _$FormActions {
  String? get submitLabel => throw _privateConstructorUsedError;
  String? get cancelLabel => throw _privateConstructorUsedError;
  String? get resetLabel => throw _privateConstructorUsedError;
  String? get saveAsDraftLabel => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  dynamic Function(Map<String, dynamic>)? get onSubmit =>
      throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  VoidCallback? get onCancel => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  VoidCallback? get onReset => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  dynamic Function(Map<String, dynamic>)? get onSaveAsDraft =>
      throw _privateConstructorUsedError;
  bool get showSubmit => throw _privateConstructorUsedError;
  bool get showCancel => throw _privateConstructorUsedError;
  bool get showReset => throw _privateConstructorUsedError;
  bool get showSaveAsDraft => throw _privateConstructorUsedError;

  /// Serializes this FormActions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FormActions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FormActionsCopyWith<FormActions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormActionsCopyWith<$Res> {
  factory $FormActionsCopyWith(
          FormActions value, $Res Function(FormActions) then) =
      _$FormActionsCopyWithImpl<$Res, FormActions>;
  @useResult
  $Res call(
      {String? submitLabel,
      String? cancelLabel,
      String? resetLabel,
      String? saveAsDraftLabel,
      @JsonKey(includeFromJson: false, includeToJson: false)
      dynamic Function(Map<String, dynamic>)? onSubmit,
      @JsonKey(includeFromJson: false, includeToJson: false)
      VoidCallback? onCancel,
      @JsonKey(includeFromJson: false, includeToJson: false)
      VoidCallback? onReset,
      @JsonKey(includeFromJson: false, includeToJson: false)
      dynamic Function(Map<String, dynamic>)? onSaveAsDraft,
      bool showSubmit,
      bool showCancel,
      bool showReset,
      bool showSaveAsDraft});
}

/// @nodoc
class _$FormActionsCopyWithImpl<$Res, $Val extends FormActions>
    implements $FormActionsCopyWith<$Res> {
  _$FormActionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FormActions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? submitLabel = freezed,
    Object? cancelLabel = freezed,
    Object? resetLabel = freezed,
    Object? saveAsDraftLabel = freezed,
    Object? onSubmit = freezed,
    Object? onCancel = freezed,
    Object? onReset = freezed,
    Object? onSaveAsDraft = freezed,
    Object? showSubmit = null,
    Object? showCancel = null,
    Object? showReset = null,
    Object? showSaveAsDraft = null,
  }) {
    return _then(_value.copyWith(
      submitLabel: freezed == submitLabel
          ? _value.submitLabel
          : submitLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      cancelLabel: freezed == cancelLabel
          ? _value.cancelLabel
          : cancelLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      resetLabel: freezed == resetLabel
          ? _value.resetLabel
          : resetLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      saveAsDraftLabel: freezed == saveAsDraftLabel
          ? _value.saveAsDraftLabel
          : saveAsDraftLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      onSubmit: freezed == onSubmit
          ? _value.onSubmit
          : onSubmit // ignore: cast_nullable_to_non_nullable
              as dynamic Function(Map<String, dynamic>)?,
      onCancel: freezed == onCancel
          ? _value.onCancel
          : onCancel // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      onReset: freezed == onReset
          ? _value.onReset
          : onReset // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      onSaveAsDraft: freezed == onSaveAsDraft
          ? _value.onSaveAsDraft
          : onSaveAsDraft // ignore: cast_nullable_to_non_nullable
              as dynamic Function(Map<String, dynamic>)?,
      showSubmit: null == showSubmit
          ? _value.showSubmit
          : showSubmit // ignore: cast_nullable_to_non_nullable
              as bool,
      showCancel: null == showCancel
          ? _value.showCancel
          : showCancel // ignore: cast_nullable_to_non_nullable
              as bool,
      showReset: null == showReset
          ? _value.showReset
          : showReset // ignore: cast_nullable_to_non_nullable
              as bool,
      showSaveAsDraft: null == showSaveAsDraft
          ? _value.showSaveAsDraft
          : showSaveAsDraft // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FormActionsImplCopyWith<$Res>
    implements $FormActionsCopyWith<$Res> {
  factory _$$FormActionsImplCopyWith(
          _$FormActionsImpl value, $Res Function(_$FormActionsImpl) then) =
      __$$FormActionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? submitLabel,
      String? cancelLabel,
      String? resetLabel,
      String? saveAsDraftLabel,
      @JsonKey(includeFromJson: false, includeToJson: false)
      dynamic Function(Map<String, dynamic>)? onSubmit,
      @JsonKey(includeFromJson: false, includeToJson: false)
      VoidCallback? onCancel,
      @JsonKey(includeFromJson: false, includeToJson: false)
      VoidCallback? onReset,
      @JsonKey(includeFromJson: false, includeToJson: false)
      dynamic Function(Map<String, dynamic>)? onSaveAsDraft,
      bool showSubmit,
      bool showCancel,
      bool showReset,
      bool showSaveAsDraft});
}

/// @nodoc
class __$$FormActionsImplCopyWithImpl<$Res>
    extends _$FormActionsCopyWithImpl<$Res, _$FormActionsImpl>
    implements _$$FormActionsImplCopyWith<$Res> {
  __$$FormActionsImplCopyWithImpl(
      _$FormActionsImpl _value, $Res Function(_$FormActionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FormActions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? submitLabel = freezed,
    Object? cancelLabel = freezed,
    Object? resetLabel = freezed,
    Object? saveAsDraftLabel = freezed,
    Object? onSubmit = freezed,
    Object? onCancel = freezed,
    Object? onReset = freezed,
    Object? onSaveAsDraft = freezed,
    Object? showSubmit = null,
    Object? showCancel = null,
    Object? showReset = null,
    Object? showSaveAsDraft = null,
  }) {
    return _then(_$FormActionsImpl(
      submitLabel: freezed == submitLabel
          ? _value.submitLabel
          : submitLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      cancelLabel: freezed == cancelLabel
          ? _value.cancelLabel
          : cancelLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      resetLabel: freezed == resetLabel
          ? _value.resetLabel
          : resetLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      saveAsDraftLabel: freezed == saveAsDraftLabel
          ? _value.saveAsDraftLabel
          : saveAsDraftLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      onSubmit: freezed == onSubmit
          ? _value.onSubmit
          : onSubmit // ignore: cast_nullable_to_non_nullable
              as dynamic Function(Map<String, dynamic>)?,
      onCancel: freezed == onCancel
          ? _value.onCancel
          : onCancel // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      onReset: freezed == onReset
          ? _value.onReset
          : onReset // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      onSaveAsDraft: freezed == onSaveAsDraft
          ? _value.onSaveAsDraft
          : onSaveAsDraft // ignore: cast_nullable_to_non_nullable
              as dynamic Function(Map<String, dynamic>)?,
      showSubmit: null == showSubmit
          ? _value.showSubmit
          : showSubmit // ignore: cast_nullable_to_non_nullable
              as bool,
      showCancel: null == showCancel
          ? _value.showCancel
          : showCancel // ignore: cast_nullable_to_non_nullable
              as bool,
      showReset: null == showReset
          ? _value.showReset
          : showReset // ignore: cast_nullable_to_non_nullable
              as bool,
      showSaveAsDraft: null == showSaveAsDraft
          ? _value.showSaveAsDraft
          : showSaveAsDraft // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FormActionsImpl implements _FormActions {
  const _$FormActionsImpl(
      {this.submitLabel,
      this.cancelLabel,
      this.resetLabel,
      this.saveAsDraftLabel,
      @JsonKey(includeFromJson: false, includeToJson: false) this.onSubmit,
      @JsonKey(includeFromJson: false, includeToJson: false) this.onCancel,
      @JsonKey(includeFromJson: false, includeToJson: false) this.onReset,
      @JsonKey(includeFromJson: false, includeToJson: false) this.onSaveAsDraft,
      this.showSubmit = true,
      this.showCancel = true,
      this.showReset = false,
      this.showSaveAsDraft = false});

  factory _$FormActionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$FormActionsImplFromJson(json);

  @override
  final String? submitLabel;
  @override
  final String? cancelLabel;
  @override
  final String? resetLabel;
  @override
  final String? saveAsDraftLabel;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final dynamic Function(Map<String, dynamic>)? onSubmit;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final VoidCallback? onCancel;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final VoidCallback? onReset;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final dynamic Function(Map<String, dynamic>)? onSaveAsDraft;
  @override
  @JsonKey()
  final bool showSubmit;
  @override
  @JsonKey()
  final bool showCancel;
  @override
  @JsonKey()
  final bool showReset;
  @override
  @JsonKey()
  final bool showSaveAsDraft;

  @override
  String toString() {
    return 'FormActions(submitLabel: $submitLabel, cancelLabel: $cancelLabel, resetLabel: $resetLabel, saveAsDraftLabel: $saveAsDraftLabel, onSubmit: $onSubmit, onCancel: $onCancel, onReset: $onReset, onSaveAsDraft: $onSaveAsDraft, showSubmit: $showSubmit, showCancel: $showCancel, showReset: $showReset, showSaveAsDraft: $showSaveAsDraft)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormActionsImpl &&
            (identical(other.submitLabel, submitLabel) ||
                other.submitLabel == submitLabel) &&
            (identical(other.cancelLabel, cancelLabel) ||
                other.cancelLabel == cancelLabel) &&
            (identical(other.resetLabel, resetLabel) ||
                other.resetLabel == resetLabel) &&
            (identical(other.saveAsDraftLabel, saveAsDraftLabel) ||
                other.saveAsDraftLabel == saveAsDraftLabel) &&
            (identical(other.onSubmit, onSubmit) ||
                other.onSubmit == onSubmit) &&
            (identical(other.onCancel, onCancel) ||
                other.onCancel == onCancel) &&
            (identical(other.onReset, onReset) || other.onReset == onReset) &&
            (identical(other.onSaveAsDraft, onSaveAsDraft) ||
                other.onSaveAsDraft == onSaveAsDraft) &&
            (identical(other.showSubmit, showSubmit) ||
                other.showSubmit == showSubmit) &&
            (identical(other.showCancel, showCancel) ||
                other.showCancel == showCancel) &&
            (identical(other.showReset, showReset) ||
                other.showReset == showReset) &&
            (identical(other.showSaveAsDraft, showSaveAsDraft) ||
                other.showSaveAsDraft == showSaveAsDraft));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      submitLabel,
      cancelLabel,
      resetLabel,
      saveAsDraftLabel,
      onSubmit,
      onCancel,
      onReset,
      onSaveAsDraft,
      showSubmit,
      showCancel,
      showReset,
      showSaveAsDraft);

  /// Create a copy of FormActions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormActionsImplCopyWith<_$FormActionsImpl> get copyWith =>
      __$$FormActionsImplCopyWithImpl<_$FormActionsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FormActionsImplToJson(
      this,
    );
  }
}

abstract class _FormActions implements FormActions {
  const factory _FormActions(
      {final String? submitLabel,
      final String? cancelLabel,
      final String? resetLabel,
      final String? saveAsDraftLabel,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final dynamic Function(Map<String, dynamic>)? onSubmit,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final VoidCallback? onCancel,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final VoidCallback? onReset,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final dynamic Function(Map<String, dynamic>)? onSaveAsDraft,
      final bool showSubmit,
      final bool showCancel,
      final bool showReset,
      final bool showSaveAsDraft}) = _$FormActionsImpl;

  factory _FormActions.fromJson(Map<String, dynamic> json) =
      _$FormActionsImpl.fromJson;

  @override
  String? get submitLabel;
  @override
  String? get cancelLabel;
  @override
  String? get resetLabel;
  @override
  String? get saveAsDraftLabel;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  dynamic Function(Map<String, dynamic>)? get onSubmit;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  VoidCallback? get onCancel;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  VoidCallback? get onReset;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  dynamic Function(Map<String, dynamic>)? get onSaveAsDraft;
  @override
  bool get showSubmit;
  @override
  bool get showCancel;
  @override
  bool get showReset;
  @override
  bool get showSaveAsDraft;

  /// Create a copy of FormActions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormActionsImplCopyWith<_$FormActionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FormSettings _$FormSettingsFromJson(Map<String, dynamic> json) {
  return _FormSettings.fromJson(json);
}

/// @nodoc
mixin _$FormSettings {
  bool get validateOnChange => throw _privateConstructorUsedError;
  bool get validateOnBlur => throw _privateConstructorUsedError;
  bool get showErrorMessages => throw _privateConstructorUsedError;
  bool get showSuccessMessages => throw _privateConstructorUsedError;
  bool get autoSave => throw _privateConstructorUsedError;
  int get autoSaveInterval => throw _privateConstructorUsedError; // seconds
  bool get showProgressIndicator => throw _privateConstructorUsedError;
  bool get disableOnSubmit => throw _privateConstructorUsedError;
  bool get focusFirstError => throw _privateConstructorUsedError;
  bool get persistData => throw _privateConstructorUsedError;
  String? get persistKey => throw _privateConstructorUsedError;

  /// Serializes this FormSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FormSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FormSettingsCopyWith<FormSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormSettingsCopyWith<$Res> {
  factory $FormSettingsCopyWith(
          FormSettings value, $Res Function(FormSettings) then) =
      _$FormSettingsCopyWithImpl<$Res, FormSettings>;
  @useResult
  $Res call(
      {bool validateOnChange,
      bool validateOnBlur,
      bool showErrorMessages,
      bool showSuccessMessages,
      bool autoSave,
      int autoSaveInterval,
      bool showProgressIndicator,
      bool disableOnSubmit,
      bool focusFirstError,
      bool persistData,
      String? persistKey});
}

/// @nodoc
class _$FormSettingsCopyWithImpl<$Res, $Val extends FormSettings>
    implements $FormSettingsCopyWith<$Res> {
  _$FormSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FormSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? validateOnChange = null,
    Object? validateOnBlur = null,
    Object? showErrorMessages = null,
    Object? showSuccessMessages = null,
    Object? autoSave = null,
    Object? autoSaveInterval = null,
    Object? showProgressIndicator = null,
    Object? disableOnSubmit = null,
    Object? focusFirstError = null,
    Object? persistData = null,
    Object? persistKey = freezed,
  }) {
    return _then(_value.copyWith(
      validateOnChange: null == validateOnChange
          ? _value.validateOnChange
          : validateOnChange // ignore: cast_nullable_to_non_nullable
              as bool,
      validateOnBlur: null == validateOnBlur
          ? _value.validateOnBlur
          : validateOnBlur // ignore: cast_nullable_to_non_nullable
              as bool,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      showSuccessMessages: null == showSuccessMessages
          ? _value.showSuccessMessages
          : showSuccessMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      autoSave: null == autoSave
          ? _value.autoSave
          : autoSave // ignore: cast_nullable_to_non_nullable
              as bool,
      autoSaveInterval: null == autoSaveInterval
          ? _value.autoSaveInterval
          : autoSaveInterval // ignore: cast_nullable_to_non_nullable
              as int,
      showProgressIndicator: null == showProgressIndicator
          ? _value.showProgressIndicator
          : showProgressIndicator // ignore: cast_nullable_to_non_nullable
              as bool,
      disableOnSubmit: null == disableOnSubmit
          ? _value.disableOnSubmit
          : disableOnSubmit // ignore: cast_nullable_to_non_nullable
              as bool,
      focusFirstError: null == focusFirstError
          ? _value.focusFirstError
          : focusFirstError // ignore: cast_nullable_to_non_nullable
              as bool,
      persistData: null == persistData
          ? _value.persistData
          : persistData // ignore: cast_nullable_to_non_nullable
              as bool,
      persistKey: freezed == persistKey
          ? _value.persistKey
          : persistKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FormSettingsImplCopyWith<$Res>
    implements $FormSettingsCopyWith<$Res> {
  factory _$$FormSettingsImplCopyWith(
          _$FormSettingsImpl value, $Res Function(_$FormSettingsImpl) then) =
      __$$FormSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool validateOnChange,
      bool validateOnBlur,
      bool showErrorMessages,
      bool showSuccessMessages,
      bool autoSave,
      int autoSaveInterval,
      bool showProgressIndicator,
      bool disableOnSubmit,
      bool focusFirstError,
      bool persistData,
      String? persistKey});
}

/// @nodoc
class __$$FormSettingsImplCopyWithImpl<$Res>
    extends _$FormSettingsCopyWithImpl<$Res, _$FormSettingsImpl>
    implements _$$FormSettingsImplCopyWith<$Res> {
  __$$FormSettingsImplCopyWithImpl(
      _$FormSettingsImpl _value, $Res Function(_$FormSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FormSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? validateOnChange = null,
    Object? validateOnBlur = null,
    Object? showErrorMessages = null,
    Object? showSuccessMessages = null,
    Object? autoSave = null,
    Object? autoSaveInterval = null,
    Object? showProgressIndicator = null,
    Object? disableOnSubmit = null,
    Object? focusFirstError = null,
    Object? persistData = null,
    Object? persistKey = freezed,
  }) {
    return _then(_$FormSettingsImpl(
      validateOnChange: null == validateOnChange
          ? _value.validateOnChange
          : validateOnChange // ignore: cast_nullable_to_non_nullable
              as bool,
      validateOnBlur: null == validateOnBlur
          ? _value.validateOnBlur
          : validateOnBlur // ignore: cast_nullable_to_non_nullable
              as bool,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      showSuccessMessages: null == showSuccessMessages
          ? _value.showSuccessMessages
          : showSuccessMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      autoSave: null == autoSave
          ? _value.autoSave
          : autoSave // ignore: cast_nullable_to_non_nullable
              as bool,
      autoSaveInterval: null == autoSaveInterval
          ? _value.autoSaveInterval
          : autoSaveInterval // ignore: cast_nullable_to_non_nullable
              as int,
      showProgressIndicator: null == showProgressIndicator
          ? _value.showProgressIndicator
          : showProgressIndicator // ignore: cast_nullable_to_non_nullable
              as bool,
      disableOnSubmit: null == disableOnSubmit
          ? _value.disableOnSubmit
          : disableOnSubmit // ignore: cast_nullable_to_non_nullable
              as bool,
      focusFirstError: null == focusFirstError
          ? _value.focusFirstError
          : focusFirstError // ignore: cast_nullable_to_non_nullable
              as bool,
      persistData: null == persistData
          ? _value.persistData
          : persistData // ignore: cast_nullable_to_non_nullable
              as bool,
      persistKey: freezed == persistKey
          ? _value.persistKey
          : persistKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FormSettingsImpl implements _FormSettings {
  const _$FormSettingsImpl(
      {this.validateOnChange = true,
      this.validateOnBlur = false,
      this.showErrorMessages = true,
      this.showSuccessMessages = true,
      this.autoSave = false,
      this.autoSaveInterval = 30,
      this.showProgressIndicator = true,
      this.disableOnSubmit = false,
      this.focusFirstError = true,
      this.persistData = false,
      this.persistKey});

  factory _$FormSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$FormSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool validateOnChange;
  @override
  @JsonKey()
  final bool validateOnBlur;
  @override
  @JsonKey()
  final bool showErrorMessages;
  @override
  @JsonKey()
  final bool showSuccessMessages;
  @override
  @JsonKey()
  final bool autoSave;
  @override
  @JsonKey()
  final int autoSaveInterval;
// seconds
  @override
  @JsonKey()
  final bool showProgressIndicator;
  @override
  @JsonKey()
  final bool disableOnSubmit;
  @override
  @JsonKey()
  final bool focusFirstError;
  @override
  @JsonKey()
  final bool persistData;
  @override
  final String? persistKey;

  @override
  String toString() {
    return 'FormSettings(validateOnChange: $validateOnChange, validateOnBlur: $validateOnBlur, showErrorMessages: $showErrorMessages, showSuccessMessages: $showSuccessMessages, autoSave: $autoSave, autoSaveInterval: $autoSaveInterval, showProgressIndicator: $showProgressIndicator, disableOnSubmit: $disableOnSubmit, focusFirstError: $focusFirstError, persistData: $persistData, persistKey: $persistKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormSettingsImpl &&
            (identical(other.validateOnChange, validateOnChange) ||
                other.validateOnChange == validateOnChange) &&
            (identical(other.validateOnBlur, validateOnBlur) ||
                other.validateOnBlur == validateOnBlur) &&
            (identical(other.showErrorMessages, showErrorMessages) ||
                other.showErrorMessages == showErrorMessages) &&
            (identical(other.showSuccessMessages, showSuccessMessages) ||
                other.showSuccessMessages == showSuccessMessages) &&
            (identical(other.autoSave, autoSave) ||
                other.autoSave == autoSave) &&
            (identical(other.autoSaveInterval, autoSaveInterval) ||
                other.autoSaveInterval == autoSaveInterval) &&
            (identical(other.showProgressIndicator, showProgressIndicator) ||
                other.showProgressIndicator == showProgressIndicator) &&
            (identical(other.disableOnSubmit, disableOnSubmit) ||
                other.disableOnSubmit == disableOnSubmit) &&
            (identical(other.focusFirstError, focusFirstError) ||
                other.focusFirstError == focusFirstError) &&
            (identical(other.persistData, persistData) ||
                other.persistData == persistData) &&
            (identical(other.persistKey, persistKey) ||
                other.persistKey == persistKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      validateOnChange,
      validateOnBlur,
      showErrorMessages,
      showSuccessMessages,
      autoSave,
      autoSaveInterval,
      showProgressIndicator,
      disableOnSubmit,
      focusFirstError,
      persistData,
      persistKey);

  /// Create a copy of FormSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormSettingsImplCopyWith<_$FormSettingsImpl> get copyWith =>
      __$$FormSettingsImplCopyWithImpl<_$FormSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FormSettingsImplToJson(
      this,
    );
  }
}

abstract class _FormSettings implements FormSettings {
  const factory _FormSettings(
      {final bool validateOnChange,
      final bool validateOnBlur,
      final bool showErrorMessages,
      final bool showSuccessMessages,
      final bool autoSave,
      final int autoSaveInterval,
      final bool showProgressIndicator,
      final bool disableOnSubmit,
      final bool focusFirstError,
      final bool persistData,
      final String? persistKey}) = _$FormSettingsImpl;

  factory _FormSettings.fromJson(Map<String, dynamic> json) =
      _$FormSettingsImpl.fromJson;

  @override
  bool get validateOnChange;
  @override
  bool get validateOnBlur;
  @override
  bool get showErrorMessages;
  @override
  bool get showSuccessMessages;
  @override
  bool get autoSave;
  @override
  int get autoSaveInterval; // seconds
  @override
  bool get showProgressIndicator;
  @override
  bool get disableOnSubmit;
  @override
  bool get focusFirstError;
  @override
  bool get persistData;
  @override
  String? get persistKey;

  /// Create a copy of FormSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormSettingsImplCopyWith<_$FormSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FormStateData _$FormStateDataFromJson(Map<String, dynamic> json) {
  return _FormStateData.fromJson(json);
}

/// @nodoc
mixin _$FormStateData {
  String get formId => throw _privateConstructorUsedError;
  Map<String, dynamic> get values => throw _privateConstructorUsedError;
  Map<String, String> get errors => throw _privateConstructorUsedError;
  Map<String, FieldState> get fieldStates => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  bool get isValidating => throw _privateConstructorUsedError;
  bool get isDirty => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;
  bool get hasSubmitted => throw _privateConstructorUsedError;
  DateTime? get lastSaved => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this FormStateData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FormStateData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FormStateDataCopyWith<FormStateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormStateDataCopyWith<$Res> {
  factory $FormStateDataCopyWith(
          FormStateData value, $Res Function(FormStateData) then) =
      _$FormStateDataCopyWithImpl<$Res, FormStateData>;
  @useResult
  $Res call(
      {String formId,
      Map<String, dynamic> values,
      Map<String, String> errors,
      Map<String, FieldState> fieldStates,
      bool isSubmitting,
      bool isValidating,
      bool isDirty,
      bool isValid,
      bool hasSubmitted,
      DateTime? lastSaved,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$FormStateDataCopyWithImpl<$Res, $Val extends FormStateData>
    implements $FormStateDataCopyWith<$Res> {
  _$FormStateDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FormStateData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? formId = null,
    Object? values = null,
    Object? errors = null,
    Object? fieldStates = null,
    Object? isSubmitting = null,
    Object? isValidating = null,
    Object? isDirty = null,
    Object? isValid = null,
    Object? hasSubmitted = null,
    Object? lastSaved = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      formId: null == formId
          ? _value.formId
          : formId // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      fieldStates: null == fieldStates
          ? _value.fieldStates
          : fieldStates // ignore: cast_nullable_to_non_nullable
              as Map<String, FieldState>,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      isValidating: null == isValidating
          ? _value.isValidating
          : isValidating // ignore: cast_nullable_to_non_nullable
              as bool,
      isDirty: null == isDirty
          ? _value.isDirty
          : isDirty // ignore: cast_nullable_to_non_nullable
              as bool,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      hasSubmitted: null == hasSubmitted
          ? _value.hasSubmitted
          : hasSubmitted // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSaved: freezed == lastSaved
          ? _value.lastSaved
          : lastSaved // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FormStateDataImplCopyWith<$Res>
    implements $FormStateDataCopyWith<$Res> {
  factory _$$FormStateDataImplCopyWith(
          _$FormStateDataImpl value, $Res Function(_$FormStateDataImpl) then) =
      __$$FormStateDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String formId,
      Map<String, dynamic> values,
      Map<String, String> errors,
      Map<String, FieldState> fieldStates,
      bool isSubmitting,
      bool isValidating,
      bool isDirty,
      bool isValid,
      bool hasSubmitted,
      DateTime? lastSaved,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$FormStateDataImplCopyWithImpl<$Res>
    extends _$FormStateDataCopyWithImpl<$Res, _$FormStateDataImpl>
    implements _$$FormStateDataImplCopyWith<$Res> {
  __$$FormStateDataImplCopyWithImpl(
      _$FormStateDataImpl _value, $Res Function(_$FormStateDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of FormStateData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? formId = null,
    Object? values = null,
    Object? errors = null,
    Object? fieldStates = null,
    Object? isSubmitting = null,
    Object? isValidating = null,
    Object? isDirty = null,
    Object? isValid = null,
    Object? hasSubmitted = null,
    Object? lastSaved = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$FormStateDataImpl(
      formId: null == formId
          ? _value.formId
          : formId // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      fieldStates: null == fieldStates
          ? _value._fieldStates
          : fieldStates // ignore: cast_nullable_to_non_nullable
              as Map<String, FieldState>,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      isValidating: null == isValidating
          ? _value.isValidating
          : isValidating // ignore: cast_nullable_to_non_nullable
              as bool,
      isDirty: null == isDirty
          ? _value.isDirty
          : isDirty // ignore: cast_nullable_to_non_nullable
              as bool,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      hasSubmitted: null == hasSubmitted
          ? _value.hasSubmitted
          : hasSubmitted // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSaved: freezed == lastSaved
          ? _value.lastSaved
          : lastSaved // ignore: cast_nullable_to_non_nullable
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
class _$FormStateDataImpl implements _FormStateData {
  const _$FormStateDataImpl(
      {required this.formId,
      final Map<String, dynamic> values = const {},
      final Map<String, String> errors = const {},
      final Map<String, FieldState> fieldStates = const {},
      this.isSubmitting = false,
      this.isValidating = false,
      this.isDirty = false,
      this.isValid = false,
      this.hasSubmitted = false,
      this.lastSaved,
      final Map<String, dynamic>? metadata})
      : _values = values,
        _errors = errors,
        _fieldStates = fieldStates,
        _metadata = metadata;

  factory _$FormStateDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$FormStateDataImplFromJson(json);

  @override
  final String formId;
  final Map<String, dynamic> _values;
  @override
  @JsonKey()
  Map<String, dynamic> get values {
    if (_values is EqualUnmodifiableMapView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_values);
  }

  final Map<String, String> _errors;
  @override
  @JsonKey()
  Map<String, String> get errors {
    if (_errors is EqualUnmodifiableMapView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_errors);
  }

  final Map<String, FieldState> _fieldStates;
  @override
  @JsonKey()
  Map<String, FieldState> get fieldStates {
    if (_fieldStates is EqualUnmodifiableMapView) return _fieldStates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_fieldStates);
  }

  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  @JsonKey()
  final bool isValidating;
  @override
  @JsonKey()
  final bool isDirty;
  @override
  @JsonKey()
  final bool isValid;
  @override
  @JsonKey()
  final bool hasSubmitted;
  @override
  final DateTime? lastSaved;
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
    return 'FormStateData(formId: $formId, values: $values, errors: $errors, fieldStates: $fieldStates, isSubmitting: $isSubmitting, isValidating: $isValidating, isDirty: $isDirty, isValid: $isValid, hasSubmitted: $hasSubmitted, lastSaved: $lastSaved, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormStateDataImpl &&
            (identical(other.formId, formId) || other.formId == formId) &&
            const DeepCollectionEquality().equals(other._values, _values) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            const DeepCollectionEquality()
                .equals(other._fieldStates, _fieldStates) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.isValidating, isValidating) ||
                other.isValidating == isValidating) &&
            (identical(other.isDirty, isDirty) || other.isDirty == isDirty) &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            (identical(other.hasSubmitted, hasSubmitted) ||
                other.hasSubmitted == hasSubmitted) &&
            (identical(other.lastSaved, lastSaved) ||
                other.lastSaved == lastSaved) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      formId,
      const DeepCollectionEquality().hash(_values),
      const DeepCollectionEquality().hash(_errors),
      const DeepCollectionEquality().hash(_fieldStates),
      isSubmitting,
      isValidating,
      isDirty,
      isValid,
      hasSubmitted,
      lastSaved,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of FormStateData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormStateDataImplCopyWith<_$FormStateDataImpl> get copyWith =>
      __$$FormStateDataImplCopyWithImpl<_$FormStateDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FormStateDataImplToJson(
      this,
    );
  }
}

abstract class _FormStateData implements FormStateData {
  const factory _FormStateData(
      {required final String formId,
      final Map<String, dynamic> values,
      final Map<String, String> errors,
      final Map<String, FieldState> fieldStates,
      final bool isSubmitting,
      final bool isValidating,
      final bool isDirty,
      final bool isValid,
      final bool hasSubmitted,
      final DateTime? lastSaved,
      final Map<String, dynamic>? metadata}) = _$FormStateDataImpl;

  factory _FormStateData.fromJson(Map<String, dynamic> json) =
      _$FormStateDataImpl.fromJson;

  @override
  String get formId;
  @override
  Map<String, dynamic> get values;
  @override
  Map<String, String> get errors;
  @override
  Map<String, FieldState> get fieldStates;
  @override
  bool get isSubmitting;
  @override
  bool get isValidating;
  @override
  bool get isDirty;
  @override
  bool get isValid;
  @override
  bool get hasSubmitted;
  @override
  DateTime? get lastSaved;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of FormStateData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormStateDataImplCopyWith<_$FormStateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ValidationResult _$ValidationResultFromJson(Map<String, dynamic> json) {
  return _ValidationResult.fromJson(json);
}

/// @nodoc
mixin _$ValidationResult {
  bool get isValid => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Map<String, String>? get fieldErrors => throw _privateConstructorUsedError;

  /// Serializes this ValidationResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ValidationResultCopyWith<ValidationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidationResultCopyWith<$Res> {
  factory $ValidationResultCopyWith(
          ValidationResult value, $Res Function(ValidationResult) then) =
      _$ValidationResultCopyWithImpl<$Res, ValidationResult>;
  @useResult
  $Res call({bool isValid, String? message, Map<String, String>? fieldErrors});
}

/// @nodoc
class _$ValidationResultCopyWithImpl<$Res, $Val extends ValidationResult>
    implements $ValidationResultCopyWith<$Res> {
  _$ValidationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isValid = null,
    Object? message = freezed,
    Object? fieldErrors = freezed,
  }) {
    return _then(_value.copyWith(
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldErrors: freezed == fieldErrors
          ? _value.fieldErrors
          : fieldErrors // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ValidationResultImplCopyWith<$Res>
    implements $ValidationResultCopyWith<$Res> {
  factory _$$ValidationResultImplCopyWith(_$ValidationResultImpl value,
          $Res Function(_$ValidationResultImpl) then) =
      __$$ValidationResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isValid, String? message, Map<String, String>? fieldErrors});
}

/// @nodoc
class __$$ValidationResultImplCopyWithImpl<$Res>
    extends _$ValidationResultCopyWithImpl<$Res, _$ValidationResultImpl>
    implements _$$ValidationResultImplCopyWith<$Res> {
  __$$ValidationResultImplCopyWithImpl(_$ValidationResultImpl _value,
      $Res Function(_$ValidationResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of ValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isValid = null,
    Object? message = freezed,
    Object? fieldErrors = freezed,
  }) {
    return _then(_$ValidationResultImpl(
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldErrors: freezed == fieldErrors
          ? _value._fieldErrors
          : fieldErrors // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ValidationResultImpl implements _ValidationResult {
  const _$ValidationResultImpl(
      {this.isValid = true,
      this.message,
      final Map<String, String>? fieldErrors})
      : _fieldErrors = fieldErrors;

  factory _$ValidationResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ValidationResultImplFromJson(json);

  @override
  @JsonKey()
  final bool isValid;
  @override
  final String? message;
  final Map<String, String>? _fieldErrors;
  @override
  Map<String, String>? get fieldErrors {
    final value = _fieldErrors;
    if (value == null) return null;
    if (_fieldErrors is EqualUnmodifiableMapView) return _fieldErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ValidationResult(isValid: $isValid, message: $message, fieldErrors: $fieldErrors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationResultImpl &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._fieldErrors, _fieldErrors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isValid, message,
      const DeepCollectionEquality().hash(_fieldErrors));

  /// Create a copy of ValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationResultImplCopyWith<_$ValidationResultImpl> get copyWith =>
      __$$ValidationResultImplCopyWithImpl<_$ValidationResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ValidationResultImplToJson(
      this,
    );
  }
}

abstract class _ValidationResult implements ValidationResult {
  const factory _ValidationResult(
      {final bool isValid,
      final String? message,
      final Map<String, String>? fieldErrors}) = _$ValidationResultImpl;

  factory _ValidationResult.fromJson(Map<String, dynamic> json) =
      _$ValidationResultImpl.fromJson;

  @override
  bool get isValid;
  @override
  String? get message;
  @override
  Map<String, String>? get fieldErrors;

  /// Create a copy of ValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationResultImplCopyWith<_$ValidationResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FormTemplate _$FormTemplateFromJson(Map<String, dynamic> json) {
  return _FormTemplate.fromJson(json);
}

/// @nodoc
mixin _$FormTemplate {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  FormSchema get schema => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get icon => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this FormTemplate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FormTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FormTemplateCopyWith<FormTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormTemplateCopyWith<$Res> {
  factory $FormTemplateCopyWith(
          FormTemplate value, $Res Function(FormTemplate) then) =
      _$FormTemplateCopyWithImpl<$Res, FormTemplate>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String category,
      FormSchema schema,
      @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon,
      List<String>? tags,
      Map<String, dynamic>? metadata});

  $FormSchemaCopyWith<$Res> get schema;
}

/// @nodoc
class _$FormTemplateCopyWithImpl<$Res, $Val extends FormTemplate>
    implements $FormTemplateCopyWith<$Res> {
  _$FormTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FormTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? category = null,
    Object? schema = null,
    Object? icon = freezed,
    Object? tags = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as FormSchema,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of FormTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FormSchemaCopyWith<$Res> get schema {
    return $FormSchemaCopyWith<$Res>(_value.schema, (value) {
      return _then(_value.copyWith(schema: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FormTemplateImplCopyWith<$Res>
    implements $FormTemplateCopyWith<$Res> {
  factory _$$FormTemplateImplCopyWith(
          _$FormTemplateImpl value, $Res Function(_$FormTemplateImpl) then) =
      __$$FormTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String category,
      FormSchema schema,
      @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon,
      List<String>? tags,
      Map<String, dynamic>? metadata});

  @override
  $FormSchemaCopyWith<$Res> get schema;
}

/// @nodoc
class __$$FormTemplateImplCopyWithImpl<$Res>
    extends _$FormTemplateCopyWithImpl<$Res, _$FormTemplateImpl>
    implements _$$FormTemplateImplCopyWith<$Res> {
  __$$FormTemplateImplCopyWithImpl(
      _$FormTemplateImpl _value, $Res Function(_$FormTemplateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FormTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? category = null,
    Object? schema = null,
    Object? icon = freezed,
    Object? tags = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$FormTemplateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as FormSchema,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FormTemplateImpl implements _FormTemplate {
  const _$FormTemplateImpl(
      {required this.id,
      required this.name,
      this.description,
      required this.category,
      required this.schema,
      @JsonKey(includeFromJson: false, includeToJson: false) this.icon,
      final List<String>? tags,
      final Map<String, dynamic>? metadata})
      : _tags = tags,
        _metadata = metadata;

  factory _$FormTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$FormTemplateImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String category;
  @override
  final FormSchema schema;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final IconData? icon;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
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
    return 'FormTemplate(id: $id, name: $name, description: $description, category: $category, schema: $schema, icon: $icon, tags: $tags, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      category,
      schema,
      icon,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of FormTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormTemplateImplCopyWith<_$FormTemplateImpl> get copyWith =>
      __$$FormTemplateImplCopyWithImpl<_$FormTemplateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FormTemplateImplToJson(
      this,
    );
  }
}

abstract class _FormTemplate implements FormTemplate {
  const factory _FormTemplate(
      {required final String id,
      required final String name,
      final String? description,
      required final String category,
      required final FormSchema schema,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final IconData? icon,
      final List<String>? tags,
      final Map<String, dynamic>? metadata}) = _$FormTemplateImpl;

  factory _FormTemplate.fromJson(Map<String, dynamic> json) =
      _$FormTemplateImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String get category;
  @override
  FormSchema get schema;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get icon;
  @override
  List<String>? get tags;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of FormTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormTemplateImplCopyWith<_$FormTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FormStep _$FormStepFromJson(Map<String, dynamic> json) {
  return _FormStep.fromJson(json);
}

/// @nodoc
mixin _$FormStep {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;
  List<FormFieldModel> get fields => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get icon => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isOptional => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  ValidationResult Function(Map<String, dynamic>)? get validator =>
      throw _privateConstructorUsedError;

  /// Serializes this FormStep to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FormStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FormStepCopyWith<FormStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormStepCopyWith<$Res> {
  factory $FormStepCopyWith(FormStep value, $Res Function(FormStep) then) =
      _$FormStepCopyWithImpl<$Res, FormStep>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? subtitle,
      List<FormFieldModel> fields,
      @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon,
      bool isCompleted,
      bool isActive,
      bool isOptional,
      @JsonKey(includeFromJson: false, includeToJson: false)
      ValidationResult Function(Map<String, dynamic>)? validator});
}

/// @nodoc
class _$FormStepCopyWithImpl<$Res, $Val extends FormStep>
    implements $FormStepCopyWith<$Res> {
  _$FormStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FormStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? fields = null,
    Object? icon = freezed,
    Object? isCompleted = null,
    Object? isActive = null,
    Object? isOptional = null,
    Object? validator = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<FormFieldModel>,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isOptional: null == isOptional
          ? _value.isOptional
          : isOptional // ignore: cast_nullable_to_non_nullable
              as bool,
      validator: freezed == validator
          ? _value.validator
          : validator // ignore: cast_nullable_to_non_nullable
              as ValidationResult Function(Map<String, dynamic>)?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FormStepImplCopyWith<$Res>
    implements $FormStepCopyWith<$Res> {
  factory _$$FormStepImplCopyWith(
          _$FormStepImpl value, $Res Function(_$FormStepImpl) then) =
      __$$FormStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? subtitle,
      List<FormFieldModel> fields,
      @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon,
      bool isCompleted,
      bool isActive,
      bool isOptional,
      @JsonKey(includeFromJson: false, includeToJson: false)
      ValidationResult Function(Map<String, dynamic>)? validator});
}

/// @nodoc
class __$$FormStepImplCopyWithImpl<$Res>
    extends _$FormStepCopyWithImpl<$Res, _$FormStepImpl>
    implements _$$FormStepImplCopyWith<$Res> {
  __$$FormStepImplCopyWithImpl(
      _$FormStepImpl _value, $Res Function(_$FormStepImpl) _then)
      : super(_value, _then);

  /// Create a copy of FormStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? fields = null,
    Object? icon = freezed,
    Object? isCompleted = null,
    Object? isActive = null,
    Object? isOptional = null,
    Object? validator = freezed,
  }) {
    return _then(_$FormStepImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<FormFieldModel>,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isOptional: null == isOptional
          ? _value.isOptional
          : isOptional // ignore: cast_nullable_to_non_nullable
              as bool,
      validator: freezed == validator
          ? _value.validator
          : validator // ignore: cast_nullable_to_non_nullable
              as ValidationResult Function(Map<String, dynamic>)?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FormStepImpl implements _FormStep {
  const _$FormStepImpl(
      {required this.id,
      required this.title,
      this.subtitle,
      required final List<FormFieldModel> fields,
      @JsonKey(includeFromJson: false, includeToJson: false) this.icon,
      this.isCompleted = false,
      this.isActive = false,
      this.isOptional = false,
      @JsonKey(includeFromJson: false, includeToJson: false) this.validator})
      : _fields = fields;

  factory _$FormStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$FormStepImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? subtitle;
  final List<FormFieldModel> _fields;
  @override
  List<FormFieldModel> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final IconData? icon;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isOptional;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ValidationResult Function(Map<String, dynamic>)? validator;

  @override
  String toString() {
    return 'FormStep(id: $id, title: $title, subtitle: $subtitle, fields: $fields, icon: $icon, isCompleted: $isCompleted, isActive: $isActive, isOptional: $isOptional, validator: $validator)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormStepImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            const DeepCollectionEquality().equals(other._fields, _fields) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isOptional, isOptional) ||
                other.isOptional == isOptional) &&
            (identical(other.validator, validator) ||
                other.validator == validator));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      subtitle,
      const DeepCollectionEquality().hash(_fields),
      icon,
      isCompleted,
      isActive,
      isOptional,
      validator);

  /// Create a copy of FormStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormStepImplCopyWith<_$FormStepImpl> get copyWith =>
      __$$FormStepImplCopyWithImpl<_$FormStepImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FormStepImplToJson(
      this,
    );
  }
}

abstract class _FormStep implements FormStep {
  const factory _FormStep(
          {required final String id,
          required final String title,
          final String? subtitle,
          required final List<FormFieldModel> fields,
          @JsonKey(includeFromJson: false, includeToJson: false)
          final IconData? icon,
          final bool isCompleted,
          final bool isActive,
          final bool isOptional,
          @JsonKey(includeFromJson: false, includeToJson: false)
          final ValidationResult Function(Map<String, dynamic>)? validator}) =
      _$FormStepImpl;

  factory _FormStep.fromJson(Map<String, dynamic> json) =
      _$FormStepImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get subtitle;
  @override
  List<FormFieldModel> get fields;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get icon;
  @override
  bool get isCompleted;
  @override
  bool get isActive;
  @override
  bool get isOptional;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  ValidationResult Function(Map<String, dynamic>)? get validator;

  /// Create a copy of FormStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormStepImplCopyWith<_$FormStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FileUploadModel _$FileUploadModelFromJson(Map<String, dynamic> json) {
  return _FileUploadModel.fromJson(json);
}

/// @nodoc
mixin _$FileUploadModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  double get uploadProgress => throw _privateConstructorUsedError;
  FileUploadStatus get status => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this FileUploadModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FileUploadModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FileUploadModelCopyWith<FileUploadModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileUploadModelCopyWith<$Res> {
  factory $FileUploadModelCopyWith(
          FileUploadModel value, $Res Function(FileUploadModel) then) =
      _$FileUploadModelCopyWithImpl<$Res, FileUploadModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      int size,
      String type,
      String? url,
      String? thumbnailUrl,
      double uploadProgress,
      FileUploadStatus status,
      String? error,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$FileUploadModelCopyWithImpl<$Res, $Val extends FileUploadModel>
    implements $FileUploadModelCopyWith<$Res> {
  _$FileUploadModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FileUploadModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? size = null,
    Object? type = null,
    Object? url = freezed,
    Object? thumbnailUrl = freezed,
    Object? uploadProgress = null,
    Object? status = null,
    Object? error = freezed,
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
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadProgress: null == uploadProgress
          ? _value.uploadProgress
          : uploadProgress // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FileUploadStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FileUploadModelImplCopyWith<$Res>
    implements $FileUploadModelCopyWith<$Res> {
  factory _$$FileUploadModelImplCopyWith(_$FileUploadModelImpl value,
          $Res Function(_$FileUploadModelImpl) then) =
      __$$FileUploadModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int size,
      String type,
      String? url,
      String? thumbnailUrl,
      double uploadProgress,
      FileUploadStatus status,
      String? error,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$FileUploadModelImplCopyWithImpl<$Res>
    extends _$FileUploadModelCopyWithImpl<$Res, _$FileUploadModelImpl>
    implements _$$FileUploadModelImplCopyWith<$Res> {
  __$$FileUploadModelImplCopyWithImpl(
      _$FileUploadModelImpl _value, $Res Function(_$FileUploadModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FileUploadModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? size = null,
    Object? type = null,
    Object? url = freezed,
    Object? thumbnailUrl = freezed,
    Object? uploadProgress = null,
    Object? status = null,
    Object? error = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$FileUploadModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadProgress: null == uploadProgress
          ? _value.uploadProgress
          : uploadProgress // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FileUploadStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
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
class _$FileUploadModelImpl implements _FileUploadModel {
  const _$FileUploadModelImpl(
      {required this.id,
      required this.name,
      required this.size,
      required this.type,
      this.url,
      this.thumbnailUrl,
      this.uploadProgress = 0,
      this.status = FileUploadStatus.pending,
      this.error,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$FileUploadModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FileUploadModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int size;
  @override
  final String type;
  @override
  final String? url;
  @override
  final String? thumbnailUrl;
  @override
  @JsonKey()
  final double uploadProgress;
  @override
  @JsonKey()
  final FileUploadStatus status;
  @override
  final String? error;
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
    return 'FileUploadModel(id: $id, name: $name, size: $size, type: $type, url: $url, thumbnailUrl: $thumbnailUrl, uploadProgress: $uploadProgress, status: $status, error: $error, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileUploadModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.uploadProgress, uploadProgress) ||
                other.uploadProgress == uploadProgress) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      size,
      type,
      url,
      thumbnailUrl,
      uploadProgress,
      status,
      error,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of FileUploadModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FileUploadModelImplCopyWith<_$FileUploadModelImpl> get copyWith =>
      __$$FileUploadModelImplCopyWithImpl<_$FileUploadModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FileUploadModelImplToJson(
      this,
    );
  }
}

abstract class _FileUploadModel implements FileUploadModel {
  const factory _FileUploadModel(
      {required final String id,
      required final String name,
      required final int size,
      required final String type,
      final String? url,
      final String? thumbnailUrl,
      final double uploadProgress,
      final FileUploadStatus status,
      final String? error,
      final Map<String, dynamic>? metadata}) = _$FileUploadModelImpl;

  factory _FileUploadModel.fromJson(Map<String, dynamic> json) =
      _$FileUploadModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get size;
  @override
  String get type;
  @override
  String? get url;
  @override
  String? get thumbnailUrl;
  @override
  double get uploadProgress;
  @override
  FileUploadStatus get status;
  @override
  String? get error;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of FileUploadModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FileUploadModelImplCopyWith<_$FileUploadModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RichTextContent _$RichTextContentFromJson(Map<String, dynamic> json) {
  return _RichTextContent.fromJson(json);
}

/// @nodoc
mixin _$RichTextContent {
  String get html => throw _privateConstructorUsedError;
  String get plainText => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this RichTextContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RichTextContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RichTextContentCopyWith<RichTextContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RichTextContentCopyWith<$Res> {
  factory $RichTextContentCopyWith(
          RichTextContent value, $Res Function(RichTextContent) then) =
      _$RichTextContentCopyWithImpl<$Res, RichTextContent>;
  @useResult
  $Res call({String html, String plainText, Map<String, dynamic> metadata});
}

/// @nodoc
class _$RichTextContentCopyWithImpl<$Res, $Val extends RichTextContent>
    implements $RichTextContentCopyWith<$Res> {
  _$RichTextContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RichTextContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? html = null,
    Object? plainText = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      html: null == html
          ? _value.html
          : html // ignore: cast_nullable_to_non_nullable
              as String,
      plainText: null == plainText
          ? _value.plainText
          : plainText // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RichTextContentImplCopyWith<$Res>
    implements $RichTextContentCopyWith<$Res> {
  factory _$$RichTextContentImplCopyWith(_$RichTextContentImpl value,
          $Res Function(_$RichTextContentImpl) then) =
      __$$RichTextContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String html, String plainText, Map<String, dynamic> metadata});
}

/// @nodoc
class __$$RichTextContentImplCopyWithImpl<$Res>
    extends _$RichTextContentCopyWithImpl<$Res, _$RichTextContentImpl>
    implements _$$RichTextContentImplCopyWith<$Res> {
  __$$RichTextContentImplCopyWithImpl(
      _$RichTextContentImpl _value, $Res Function(_$RichTextContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of RichTextContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? html = null,
    Object? plainText = null,
    Object? metadata = null,
  }) {
    return _then(_$RichTextContentImpl(
      html: null == html
          ? _value.html
          : html // ignore: cast_nullable_to_non_nullable
              as String,
      plainText: null == plainText
          ? _value.plainText
          : plainText // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RichTextContentImpl implements _RichTextContent {
  const _$RichTextContentImpl(
      {required this.html,
      required this.plainText,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata;

  factory _$RichTextContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$RichTextContentImplFromJson(json);

  @override
  final String html;
  @override
  final String plainText;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'RichTextContent(html: $html, plainText: $plainText, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RichTextContentImpl &&
            (identical(other.html, html) || other.html == html) &&
            (identical(other.plainText, plainText) ||
                other.plainText == plainText) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, html, plainText,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of RichTextContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RichTextContentImplCopyWith<_$RichTextContentImpl> get copyWith =>
      __$$RichTextContentImplCopyWithImpl<_$RichTextContentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RichTextContentImplToJson(
      this,
    );
  }
}

abstract class _RichTextContent implements RichTextContent {
  const factory _RichTextContent(
      {required final String html,
      required final String plainText,
      final Map<String, dynamic> metadata}) = _$RichTextContentImpl;

  factory _RichTextContent.fromJson(Map<String, dynamic> json) =
      _$RichTextContentImpl.fromJson;

  @override
  String get html;
  @override
  String get plainText;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of RichTextContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RichTextContentImplCopyWith<_$RichTextContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TagModel _$TagModelFromJson(Map<String, dynamic> json) {
  return _TagModel.fromJson(json);
}

/// @nodoc
mixin _$TagModel {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? get color => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get icon => throw _privateConstructorUsedError;
  bool get removable => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this TagModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TagModelCopyWith<TagModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagModelCopyWith<$Res> {
  factory $TagModelCopyWith(TagModel value, $Res Function(TagModel) then) =
      _$TagModelCopyWithImpl<$Res, TagModel>;
  @useResult
  $Res call(
      {String id,
      String label,
      String? value,
      @JsonKey(includeFromJson: false, includeToJson: false) Color? color,
      @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon,
      bool removable,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$TagModelCopyWithImpl<$Res, $Val extends TagModel>
    implements $TagModelCopyWith<$Res> {
  _$TagModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? value = freezed,
    Object? color = freezed,
    Object? icon = freezed,
    Object? removable = null,
    Object? metadata = freezed,
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
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      removable: null == removable
          ? _value.removable
          : removable // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TagModelImplCopyWith<$Res>
    implements $TagModelCopyWith<$Res> {
  factory _$$TagModelImplCopyWith(
          _$TagModelImpl value, $Res Function(_$TagModelImpl) then) =
      __$$TagModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String label,
      String? value,
      @JsonKey(includeFromJson: false, includeToJson: false) Color? color,
      @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon,
      bool removable,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$TagModelImplCopyWithImpl<$Res>
    extends _$TagModelCopyWithImpl<$Res, _$TagModelImpl>
    implements _$$TagModelImplCopyWith<$Res> {
  __$$TagModelImplCopyWithImpl(
      _$TagModelImpl _value, $Res Function(_$TagModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? value = freezed,
    Object? color = freezed,
    Object? icon = freezed,
    Object? removable = null,
    Object? metadata = freezed,
  }) {
    return _then(_$TagModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      removable: null == removable
          ? _value.removable
          : removable // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TagModelImpl implements _TagModel {
  const _$TagModelImpl(
      {required this.id,
      required this.label,
      this.value,
      @JsonKey(includeFromJson: false, includeToJson: false) this.color,
      @JsonKey(includeFromJson: false, includeToJson: false) this.icon,
      this.removable = false,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$TagModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagModelImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  final String? value;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Color? color;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final IconData? icon;
  @override
  @JsonKey()
  final bool removable;
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
    return 'TagModel(id: $id, label: $label, value: $value, color: $color, icon: $icon, removable: $removable, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.removable, removable) ||
                other.removable == removable) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, label, value, color, icon,
      removable, const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TagModelImplCopyWith<_$TagModelImpl> get copyWith =>
      __$$TagModelImplCopyWithImpl<_$TagModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagModelImplToJson(
      this,
    );
  }
}

abstract class _TagModel implements TagModel {
  const factory _TagModel(
      {required final String id,
      required final String label,
      final String? value,
      @JsonKey(includeFromJson: false, includeToJson: false) final Color? color,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final IconData? icon,
      final bool removable,
      final Map<String, dynamic>? metadata}) = _$TagModelImpl;

  factory _TagModel.fromJson(Map<String, dynamic> json) =
      _$TagModelImpl.fromJson;

  @override
  String get id;
  @override
  String get label;
  @override
  String? get value;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? get color;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get icon;
  @override
  bool get removable;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TagModelImplCopyWith<_$TagModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
