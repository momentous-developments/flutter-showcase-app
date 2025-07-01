// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FormFieldModelImpl _$$FormFieldModelImplFromJson(Map<String, dynamic> json) =>
    _$FormFieldModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$FormFieldTypeEnumMap, json['type']),
      label: json['label'] as String?,
      placeholder: json['placeholder'] as String?,
      helperText: json['helperText'] as String?,
      defaultValue: json['defaultValue'],
      value: json['value'],
      required: json['required'] as bool? ?? false,
      disabled: json['disabled'] as bool? ?? false,
      readonly: json['readonly'] as bool? ?? false,
      hidden: json['hidden'] as bool? ?? false,
      validators: (json['validators'] as List<dynamic>?)
              ?.map((e) => ValidationRule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      metadata: json['metadata'] as Map<String, dynamic>?,
      options: json['options'] == null
          ? null
          : FormFieldOptions.fromJson(json['options'] as Map<String, dynamic>),
      state: $enumDecodeNullable(_$FieldStateEnumMap, json['state']) ??
          FieldState.normal,
      errorMessage: json['errorMessage'] as String?,
      dependencies: (json['dependencies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$FormFieldModelImplToJson(
        _$FormFieldModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$FormFieldTypeEnumMap[instance.type]!,
      'label': instance.label,
      'placeholder': instance.placeholder,
      'helperText': instance.helperText,
      'defaultValue': instance.defaultValue,
      'value': instance.value,
      'required': instance.required,
      'disabled': instance.disabled,
      'readonly': instance.readonly,
      'hidden': instance.hidden,
      'validators': instance.validators,
      'metadata': instance.metadata,
      'options': instance.options,
      'state': _$FieldStateEnumMap[instance.state]!,
      'errorMessage': instance.errorMessage,
      'dependencies': instance.dependencies,
    };

const _$FormFieldTypeEnumMap = {
  FormFieldType.text: 'text',
  FormFieldType.email: 'email',
  FormFieldType.password: 'password',
  FormFieldType.number: 'number',
  FormFieldType.phone: 'phone',
  FormFieldType.url: 'url',
  FormFieldType.multiline: 'multiline',
  FormFieldType.select: 'select',
  FormFieldType.multiSelect: 'multiSelect',
  FormFieldType.checkbox: 'checkbox',
  FormFieldType.radio: 'radio',
  FormFieldType.date: 'date',
  FormFieldType.time: 'time',
  FormFieldType.dateTime: 'dateTime',
  FormFieldType.dateRange: 'dateRange',
  FormFieldType.file: 'file',
  FormFieldType.color: 'color',
  FormFieldType.range: 'range',
  FormFieldType.richText: 'richText',
  FormFieldType.tags: 'tags',
  FormFieldType.rating: 'rating',
  FormFieldType.toggle: 'toggle',
  FormFieldType.signature: 'signature',
  FormFieldType.location: 'location',
  FormFieldType.autocomplete: 'autocomplete',
};

const _$FieldStateEnumMap = {
  FieldState.normal: 'normal',
  FieldState.focused: 'focused',
  FieldState.disabled: 'disabled',
  FieldState.readonly: 'readonly',
  FieldState.loading: 'loading',
  FieldState.error: 'error',
  FieldState.success: 'success',
};

_$ValidationRuleImpl _$$ValidationRuleImplFromJson(Map<String, dynamic> json) =>
    _$ValidationRuleImpl(
      type: $enumDecode(_$ValidationRuleTypeEnumMap, json['type']),
      value: json['value'],
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$ValidationRuleImplToJson(
        _$ValidationRuleImpl instance) =>
    <String, dynamic>{
      'type': _$ValidationRuleTypeEnumMap[instance.type]!,
      'value': instance.value,
      'message': instance.message,
    };

const _$ValidationRuleTypeEnumMap = {
  ValidationRuleType.required: 'required',
  ValidationRuleType.minLength: 'minLength',
  ValidationRuleType.maxLength: 'maxLength',
  ValidationRuleType.pattern: 'pattern',
  ValidationRuleType.email: 'email',
  ValidationRuleType.url: 'url',
  ValidationRuleType.numeric: 'numeric',
  ValidationRuleType.alphanumeric: 'alphanumeric',
  ValidationRuleType.phone: 'phone',
  ValidationRuleType.creditCard: 'creditCard',
  ValidationRuleType.custom: 'custom',
  ValidationRuleType.async: 'async',
  ValidationRuleType.conditional: 'conditional',
  ValidationRuleType.crossField: 'crossField',
};

_$FormFieldOptionsImpl _$$FormFieldOptionsImplFromJson(
        Map<String, dynamic> json) =>
    _$FormFieldOptionsImpl(
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => SelectOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      min: (json['min'] as num?)?.toDouble(),
      max: (json['max'] as num?)?.toDouble(),
      step: (json['step'] as num?)?.toDouble(),
      minLength: (json['minLength'] as num?)?.toInt(),
      maxLength: (json['maxLength'] as num?)?.toInt(),
      minLines: (json['minLines'] as num?)?.toInt(),
      maxLines: (json['maxLines'] as num?)?.toInt(),
      minDate: json['minDate'] == null
          ? null
          : DateTime.parse(json['minDate'] as String),
      maxDate: json['maxDate'] == null
          ? null
          : DateTime.parse(json['maxDate'] as String),
      dateFormat: json['dateFormat'] as String?,
      acceptedFileTypes: (json['acceptedFileTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      maxFileSize: (json['maxFileSize'] as num?)?.toInt(),
      maxFiles: (json['maxFiles'] as num?)?.toInt(),
      multiple: json['multiple'] as bool? ?? false,
    );

Map<String, dynamic> _$$FormFieldOptionsImplToJson(
        _$FormFieldOptionsImpl instance) =>
    <String, dynamic>{
      'options': instance.options,
      'min': instance.min,
      'max': instance.max,
      'step': instance.step,
      'minLength': instance.minLength,
      'maxLength': instance.maxLength,
      'minLines': instance.minLines,
      'maxLines': instance.maxLines,
      'minDate': instance.minDate?.toIso8601String(),
      'maxDate': instance.maxDate?.toIso8601String(),
      'dateFormat': instance.dateFormat,
      'acceptedFileTypes': instance.acceptedFileTypes,
      'maxFileSize': instance.maxFileSize,
      'maxFiles': instance.maxFiles,
      'multiple': instance.multiple,
    };

_$SelectOptionImpl _$$SelectOptionImplFromJson(Map<String, dynamic> json) =>
    _$SelectOptionImpl(
      value: json['value'],
      label: json['label'] as String,
      description: json['description'] as String?,
      disabled: json['disabled'] as bool? ?? false,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$SelectOptionImplToJson(_$SelectOptionImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
      'description': instance.description,
      'disabled': instance.disabled,
      'metadata': instance.metadata,
    };

_$FormSectionImpl _$$FormSectionImplFromJson(Map<String, dynamic> json) =>
    _$FormSectionImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      fields: (json['fields'] as List<dynamic>?)
              ?.map((e) => FormFieldModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      collapsible: json['collapsible'] as bool? ?? false,
      expanded: json['expanded'] as bool? ?? true,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$FormSectionImplToJson(_$FormSectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'fields': instance.fields,
      'collapsible': instance.collapsible,
      'expanded': instance.expanded,
      'metadata': instance.metadata,
    };

_$FormSchemaImpl _$$FormSchemaImplFromJson(Map<String, dynamic> json) =>
    _$FormSchemaImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      layoutType: $enumDecode(_$FormLayoutTypeEnumMap, json['layoutType']),
      sections: (json['sections'] as List<dynamic>?)
              ?.map((e) => FormSection.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      initialValues: json['initialValues'] as Map<String, dynamic>? ?? const {},
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      actions: json['actions'] == null
          ? null
          : FormActions.fromJson(json['actions'] as Map<String, dynamic>),
      settings: json['settings'] == null
          ? null
          : FormSettings.fromJson(json['settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FormSchemaImplToJson(_$FormSchemaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'layoutType': _$FormLayoutTypeEnumMap[instance.layoutType]!,
      'sections': instance.sections,
      'initialValues': instance.initialValues,
      'metadata': instance.metadata,
      'actions': instance.actions,
      'settings': instance.settings,
    };

const _$FormLayoutTypeEnumMap = {
  FormLayoutType.vertical: 'vertical',
  FormLayoutType.horizontal: 'horizontal',
  FormLayoutType.inline: 'inline',
  FormLayoutType.tabbed: 'tabbed',
  FormLayoutType.stepper: 'stepper',
  FormLayoutType.collapsible: 'collapsible',
  FormLayoutType.modal: 'modal',
  FormLayoutType.sidebar: 'sidebar',
  FormLayoutType.grid: 'grid',
};

_$FormActionsImpl _$$FormActionsImplFromJson(Map<String, dynamic> json) =>
    _$FormActionsImpl(
      submitLabel: json['submitLabel'] as String?,
      cancelLabel: json['cancelLabel'] as String?,
      resetLabel: json['resetLabel'] as String?,
      saveAsDraftLabel: json['saveAsDraftLabel'] as String?,
      showSubmit: json['showSubmit'] as bool? ?? true,
      showCancel: json['showCancel'] as bool? ?? true,
      showReset: json['showReset'] as bool? ?? false,
      showSaveAsDraft: json['showSaveAsDraft'] as bool? ?? false,
    );

Map<String, dynamic> _$$FormActionsImplToJson(_$FormActionsImpl instance) =>
    <String, dynamic>{
      'submitLabel': instance.submitLabel,
      'cancelLabel': instance.cancelLabel,
      'resetLabel': instance.resetLabel,
      'saveAsDraftLabel': instance.saveAsDraftLabel,
      'showSubmit': instance.showSubmit,
      'showCancel': instance.showCancel,
      'showReset': instance.showReset,
      'showSaveAsDraft': instance.showSaveAsDraft,
    };

_$FormSettingsImpl _$$FormSettingsImplFromJson(Map<String, dynamic> json) =>
    _$FormSettingsImpl(
      validateOnChange: json['validateOnChange'] as bool? ?? true,
      validateOnBlur: json['validateOnBlur'] as bool? ?? false,
      showErrorMessages: json['showErrorMessages'] as bool? ?? true,
      showSuccessMessages: json['showSuccessMessages'] as bool? ?? true,
      autoSave: json['autoSave'] as bool? ?? false,
      autoSaveInterval: (json['autoSaveInterval'] as num?)?.toInt() ?? 30,
      showProgressIndicator: json['showProgressIndicator'] as bool? ?? true,
      disableOnSubmit: json['disableOnSubmit'] as bool? ?? false,
      focusFirstError: json['focusFirstError'] as bool? ?? true,
      persistData: json['persistData'] as bool? ?? false,
      persistKey: json['persistKey'] as String?,
    );

Map<String, dynamic> _$$FormSettingsImplToJson(_$FormSettingsImpl instance) =>
    <String, dynamic>{
      'validateOnChange': instance.validateOnChange,
      'validateOnBlur': instance.validateOnBlur,
      'showErrorMessages': instance.showErrorMessages,
      'showSuccessMessages': instance.showSuccessMessages,
      'autoSave': instance.autoSave,
      'autoSaveInterval': instance.autoSaveInterval,
      'showProgressIndicator': instance.showProgressIndicator,
      'disableOnSubmit': instance.disableOnSubmit,
      'focusFirstError': instance.focusFirstError,
      'persistData': instance.persistData,
      'persistKey': instance.persistKey,
    };

_$FormStateDataImpl _$$FormStateDataImplFromJson(Map<String, dynamic> json) =>
    _$FormStateDataImpl(
      formId: json['formId'] as String,
      values: json['values'] as Map<String, dynamic>? ?? const {},
      errors: (json['errors'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      fieldStates: (json['fieldStates'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, $enumDecode(_$FieldStateEnumMap, e)),
          ) ??
          const {},
      isSubmitting: json['isSubmitting'] as bool? ?? false,
      isValidating: json['isValidating'] as bool? ?? false,
      isDirty: json['isDirty'] as bool? ?? false,
      isValid: json['isValid'] as bool? ?? false,
      hasSubmitted: json['hasSubmitted'] as bool? ?? false,
      lastSaved: json['lastSaved'] == null
          ? null
          : DateTime.parse(json['lastSaved'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$FormStateDataImplToJson(_$FormStateDataImpl instance) =>
    <String, dynamic>{
      'formId': instance.formId,
      'values': instance.values,
      'errors': instance.errors,
      'fieldStates': instance.fieldStates
          .map((k, e) => MapEntry(k, _$FieldStateEnumMap[e]!)),
      'isSubmitting': instance.isSubmitting,
      'isValidating': instance.isValidating,
      'isDirty': instance.isDirty,
      'isValid': instance.isValid,
      'hasSubmitted': instance.hasSubmitted,
      'lastSaved': instance.lastSaved?.toIso8601String(),
      'metadata': instance.metadata,
    };

_$ValidationResultImpl _$$ValidationResultImplFromJson(
        Map<String, dynamic> json) =>
    _$ValidationResultImpl(
      isValid: json['isValid'] as bool? ?? true,
      message: json['message'] as String?,
      fieldErrors: (json['fieldErrors'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$ValidationResultImplToJson(
        _$ValidationResultImpl instance) =>
    <String, dynamic>{
      'isValid': instance.isValid,
      'message': instance.message,
      'fieldErrors': instance.fieldErrors,
    };

_$FormTemplateImpl _$$FormTemplateImplFromJson(Map<String, dynamic> json) =>
    _$FormTemplateImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      category: json['category'] as String,
      schema: FormSchema.fromJson(json['schema'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$FormTemplateImplToJson(_$FormTemplateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'schema': instance.schema,
      'tags': instance.tags,
      'metadata': instance.metadata,
    };

_$FormStepImpl _$$FormStepImplFromJson(Map<String, dynamic> json) =>
    _$FormStepImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      fields: (json['fields'] as List<dynamic>)
          .map((e) => FormFieldModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isCompleted: json['isCompleted'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? false,
      isOptional: json['isOptional'] as bool? ?? false,
    );

Map<String, dynamic> _$$FormStepImplToJson(_$FormStepImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'fields': instance.fields,
      'isCompleted': instance.isCompleted,
      'isActive': instance.isActive,
      'isOptional': instance.isOptional,
    };

_$FileUploadModelImpl _$$FileUploadModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FileUploadModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      size: (json['size'] as num).toInt(),
      type: json['type'] as String,
      url: json['url'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      uploadProgress: (json['uploadProgress'] as num?)?.toDouble() ?? 0,
      status: $enumDecodeNullable(_$FileUploadStatusEnumMap, json['status']) ??
          FileUploadStatus.pending,
      error: json['error'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$FileUploadModelImplToJson(
        _$FileUploadModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'size': instance.size,
      'type': instance.type,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
      'uploadProgress': instance.uploadProgress,
      'status': _$FileUploadStatusEnumMap[instance.status]!,
      'error': instance.error,
      'metadata': instance.metadata,
    };

const _$FileUploadStatusEnumMap = {
  FileUploadStatus.pending: 'pending',
  FileUploadStatus.uploading: 'uploading',
  FileUploadStatus.completed: 'completed',
  FileUploadStatus.error: 'error',
  FileUploadStatus.cancelled: 'cancelled',
};

_$RichTextContentImpl _$$RichTextContentImplFromJson(
        Map<String, dynamic> json) =>
    _$RichTextContentImpl(
      html: json['html'] as String,
      plainText: json['plainText'] as String,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$RichTextContentImplToJson(
        _$RichTextContentImpl instance) =>
    <String, dynamic>{
      'html': instance.html,
      'plainText': instance.plainText,
      'metadata': instance.metadata,
    };

_$TagModelImpl _$$TagModelImplFromJson(Map<String, dynamic> json) =>
    _$TagModelImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      value: json['value'] as String?,
      removable: json['removable'] as bool? ?? false,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$TagModelImplToJson(_$TagModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'value': instance.value,
      'removable': instance.removable,
      'metadata': instance.metadata,
    };
