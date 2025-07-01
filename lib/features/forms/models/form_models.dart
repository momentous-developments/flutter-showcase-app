import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'form_models.freezed.dart';
part 'form_models.g.dart';

// Form Field Types
enum FormFieldType {
  text,
  email,
  password,
  number,
  phone,
  url,
  multiline,
  select,
  multiSelect,
  checkbox,
  radio,
  date,
  time,
  dateTime,
  dateRange,
  file,
  color,
  range,
  richText,
  tags,
  rating,
  toggle,
  signature,
  location,
  autocomplete,
}

// Validation Rule Types
enum ValidationRuleType {
  required,
  minLength,
  maxLength,
  pattern,
  email,
  url,
  numeric,
  alphanumeric,
  phone,
  creditCard,
  custom,
  async,
  conditional,
  crossField,
}

// Form Layout Types
enum FormLayoutType {
  vertical,
  horizontal,
  inline,
  tabbed,
  stepper,
  collapsible,
  modal,
  sidebar,
  grid,
}

// Field States
enum FieldState {
  normal,
  focused,
  disabled,
  readonly,
  loading,
  error,
  success,
}

@freezed
class FormFieldModel with _$FormFieldModel {
  const factory FormFieldModel({
    required String id,
    required String name,
    required FormFieldType type,
    String? label,
    String? placeholder,
    String? helperText,
    dynamic defaultValue,
    dynamic value,
    @Default(false) bool required,
    @Default(false) bool disabled,
    @Default(false) bool readonly,
    @Default(false) bool hidden,
    @Default([]) List<ValidationRule> validators,
    Map<String, dynamic>? metadata,
    FormFieldOptions? options,
    @Default(FieldState.normal) FieldState state,
    String? errorMessage,
    List<String>? dependencies,
  }) = _FormFieldModel;

  factory FormFieldModel.fromJson(Map<String, dynamic> json) =>
      _$FormFieldModelFromJson(json);
}

@freezed
class ValidationRule with _$ValidationRule {
  const factory ValidationRule({
    required ValidationRuleType type,
    dynamic value,
    String? message,
    @JsonKey(includeFromJson: false, includeToJson: false)
    bool Function(dynamic value, Map<String, dynamic> formData)? customValidator,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Future<bool> Function(dynamic value)? asyncValidator,
  }) = _ValidationRule;

  factory ValidationRule.fromJson(Map<String, dynamic> json) =>
      _$ValidationRuleFromJson(json);
}

@freezed
class FormFieldOptions with _$FormFieldOptions {
  const factory FormFieldOptions({
    // For select/radio/checkbox
    List<SelectOption>? options,
    
    // For number/range
    double? min,
    double? max,
    double? step,
    
    // For text
    int? minLength,
    int? maxLength,
    int? minLines,
    int? maxLines,
    
    // For date/time
    DateTime? minDate,
    DateTime? maxDate,
    @JsonKey(includeFromJson: false, includeToJson: false)
    TimeOfDay? minTime,
    @JsonKey(includeFromJson: false, includeToJson: false)
    TimeOfDay? maxTime,
    String? dateFormat,
    
    // For file
    List<String>? acceptedFileTypes,
    int? maxFileSize,
    int? maxFiles,
    @Default(false) bool multiple,
    
    // For autocomplete
    @JsonKey(includeFromJson: false, includeToJson: false)
    Future<List<SelectOption>> Function(String query)? autocompleteSearch,
    
    // UI options
    @JsonKey(includeFromJson: false, includeToJson: false)
    IconData? prefixIcon,
    @JsonKey(includeFromJson: false, includeToJson: false)
    IconData? suffixIcon,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Widget? prefix,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Widget? suffix,
    @JsonKey(includeFromJson: false, includeToJson: false)
    InputBorder? border,
    @JsonKey(includeFromJson: false, includeToJson: false)
    TextInputType? keyboardType,
    @JsonKey(includeFromJson: false, includeToJson: false)
    TextCapitalization? textCapitalization,
    @JsonKey(includeFromJson: false, includeToJson: false)
    TextInputAction? textInputAction,
  }) = _FormFieldOptions;

  factory FormFieldOptions.fromJson(Map<String, dynamic> json) =>
      _$FormFieldOptionsFromJson(json);
}

@freezed
class SelectOption with _$SelectOption {
  const factory SelectOption({
    required dynamic value,
    required String label,
    String? description,
    @JsonKey(includeFromJson: false, includeToJson: false)
    IconData? icon,
    @Default(false) bool disabled,
    Map<String, dynamic>? metadata,
  }) = _SelectOption;

  factory SelectOption.fromJson(Map<String, dynamic> json) =>
      _$SelectOptionFromJson(json);
}

@freezed
class FormSection with _$FormSection {
  const factory FormSection({
    required String id,
    required String title,
    String? description,
    @Default([]) List<FormFieldModel> fields,
    @Default(false) bool collapsible,
    @Default(true) bool expanded,
    @JsonKey(includeFromJson: false, includeToJson: false)
    IconData? icon,
    Map<String, dynamic>? metadata,
  }) = _FormSection;

  factory FormSection.fromJson(Map<String, dynamic> json) =>
      _$FormSectionFromJson(json);
}

@freezed
class FormSchema with _$FormSchema {
  const factory FormSchema({
    required String id,
    required String name,
    String? description,
    required FormLayoutType layoutType,
    @Default([]) List<FormSection> sections,
    @Default({}) Map<String, dynamic> initialValues,
    @Default({}) Map<String, dynamic> metadata,
    FormActions? actions,
    FormSettings? settings,
  }) = _FormSchema;

  factory FormSchema.fromJson(Map<String, dynamic> json) =>
      _$FormSchemaFromJson(json);
}

@freezed
class FormActions with _$FormActions {
  const factory FormActions({
    String? submitLabel,
    String? cancelLabel,
    String? resetLabel,
    String? saveAsDraftLabel,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Function(Map<String, dynamic> values)? onSubmit,
    @JsonKey(includeFromJson: false, includeToJson: false)
    VoidCallback? onCancel,
    @JsonKey(includeFromJson: false, includeToJson: false)
    VoidCallback? onReset,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Function(Map<String, dynamic> values)? onSaveAsDraft,
    @Default(true) bool showSubmit,
    @Default(true) bool showCancel,
    @Default(false) bool showReset,
    @Default(false) bool showSaveAsDraft,
  }) = _FormActions;

  factory FormActions.fromJson(Map<String, dynamic> json) =>
      _$FormActionsFromJson(json);
}

@freezed
class FormSettings with _$FormSettings {
  const factory FormSettings({
    @Default(true) bool validateOnChange,
    @Default(false) bool validateOnBlur,
    @Default(true) bool showErrorMessages,
    @Default(true) bool showSuccessMessages,
    @Default(false) bool autoSave,
    @Default(30) int autoSaveInterval, // seconds
    @Default(true) bool showProgressIndicator,
    @Default(false) bool disableOnSubmit,
    @Default(true) bool focusFirstError,
    @Default(false) bool persistData,
    String? persistKey,
  }) = _FormSettings;

  factory FormSettings.fromJson(Map<String, dynamic> json) =>
      _$FormSettingsFromJson(json);
}

@freezed
class FormStateData with _$FormStateData {
  const factory FormStateData({
    required String formId,
    @Default({}) Map<String, dynamic> values,
    @Default({}) Map<String, String> errors,
    @Default({}) Map<String, FieldState> fieldStates,
    @Default(false) bool isSubmitting,
    @Default(false) bool isValidating,
    @Default(false) bool isDirty,
    @Default(false) bool isValid,
    @Default(false) bool hasSubmitted,
    DateTime? lastSaved,
    Map<String, dynamic>? metadata,
  }) = _FormStateData;

  factory FormStateData.fromJson(Map<String, dynamic> json) =>
      _$FormStateDataFromJson(json);
}

@freezed
class ValidationResult with _$ValidationResult {
  const factory ValidationResult({
    @Default(true) bool isValid,
    String? message,
    Map<String, String>? fieldErrors,
  }) = _ValidationResult;

  factory ValidationResult.fromJson(Map<String, dynamic> json) =>
      _$ValidationResultFromJson(json);
}

// Form Templates
@freezed
class FormTemplate with _$FormTemplate {
  const factory FormTemplate({
    required String id,
    required String name,
    String? description,
    required String category,
    required FormSchema schema,
    @JsonKey(includeFromJson: false, includeToJson: false)
    IconData? icon,
    List<String>? tags,
    Map<String, dynamic>? metadata,
  }) = _FormTemplate;

  factory FormTemplate.fromJson(Map<String, dynamic> json) =>
      _$FormTemplateFromJson(json);
}

// Form Step for Stepper Forms
@freezed
class FormStep with _$FormStep {
  const factory FormStep({
    required String id,
    required String title,
    String? subtitle,
    required List<FormFieldModel> fields,
    @JsonKey(includeFromJson: false, includeToJson: false)
    IconData? icon,
    @Default(false) bool isCompleted,
    @Default(false) bool isActive,
    @Default(false) bool isOptional,
    @JsonKey(includeFromJson: false, includeToJson: false)
    ValidationResult Function(Map<String, dynamic> values)? validator,
  }) = _FormStep;

  factory FormStep.fromJson(Map<String, dynamic> json) =>
      _$FormStepFromJson(json);
}

// File Upload Models
@freezed
class FileUploadModel with _$FileUploadModel {
  const factory FileUploadModel({
    required String id,
    required String name,
    required int size,
    required String type,
    String? url,
    String? thumbnailUrl,
    @Default(0) double uploadProgress,
    @Default(FileUploadStatus.pending) FileUploadStatus status,
    String? error,
    Map<String, dynamic>? metadata,
  }) = _FileUploadModel;

  factory FileUploadModel.fromJson(Map<String, dynamic> json) =>
      _$FileUploadModelFromJson(json);
}

enum FileUploadStatus {
  pending,
  uploading,
  completed,
  error,
  cancelled,
}

// Rich Text Editor Models
@freezed
class RichTextContent with _$RichTextContent {
  const factory RichTextContent({
    required String html,
    required String plainText,
    @Default({}) Map<String, dynamic> metadata,
  }) = _RichTextContent;

  factory RichTextContent.fromJson(Map<String, dynamic> json) =>
      _$RichTextContentFromJson(json);
}

// Tag Input Models
@freezed
class TagModel with _$TagModel {
  const factory TagModel({
    required String id,
    required String label,
    String? value,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Color? color,
    @JsonKey(includeFromJson: false, includeToJson: false)
    IconData? icon,
    @Default(false) bool removable,
    Map<String, dynamic>? metadata,
  }) = _TagModel;

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);
}