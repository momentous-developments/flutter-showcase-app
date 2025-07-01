import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/form_models.dart';
import '../providers/form_providers.dart';
import 'form_fields/text_form_field_widget.dart';
import 'form_fields/select_form_field.dart';
import 'form_fields/checkbox_form_field.dart';
import 'form_fields/radio_form_field.dart';
import 'form_fields/date_form_field.dart';
import 'form_fields/file_form_field.dart';
import 'form_fields/range_form_field.dart';
import 'form_fields/color_form_field.dart';
import 'form_fields/tag_form_field.dart';
import 'form_fields/rich_text_form_field.dart';
import 'form_fields/toggle_form_field.dart';
import 'form_fields/rating_form_field.dart';

class FormBuilder extends ConsumerStatefulWidget {
  final FormSchema schema;
  final Function(Map<String, dynamic>) onSubmit;
  
  const FormBuilder({
    super.key,
    required this.schema,
    required this.onSubmit,
  });

  @override
  ConsumerState<FormBuilder> createState() => _FormBuilderState();
}

class _FormBuilderState extends ConsumerState<FormBuilder> {
  late String _formStateKey;
  
  @override
  void initState() {
    super.initState();
    _formStateKey = 'form_builder_${widget.schema.id}';
  }
  
  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(formStateProvider(_formStateKey));
    final formNotifier = ref.read(formStateProvider(_formStateKey).notifier);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.schema.description != null) ...[
            Text(
              widget.schema.description!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
          ],
          
          // Render form based on layout type
          _buildFormLayout(formState, formNotifier),
          
          const SizedBox(height: 32),
          
          // Form actions
          _buildFormActions(formState, formNotifier),
        ],
      ),
    );
  }
  
  Widget _buildFormLayout(
    FormStateData formState,
    FormStateNotifier formNotifier,
  ) {
    switch (widget.schema.layoutType) {
      case FormLayoutType.stepper:
        return _buildStepperLayout(formState, formNotifier);
      case FormLayoutType.tabbed:
        return _buildTabbedLayout(formState, formNotifier);
      case FormLayoutType.collapsible:
        return _buildCollapsibleLayout(formState, formNotifier);
      case FormLayoutType.grid:
        return _buildGridLayout(formState, formNotifier);
      default:
        return _buildVerticalLayout(formState, formNotifier);
    }
  }
  
  Widget _buildVerticalLayout(
    FormStateData formState,
    FormStateNotifier formNotifier,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.schema.sections.map((section) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (section.title.isNotEmpty) ...[
              _buildSectionHeader(section),
              const SizedBox(height: 16),
            ],
            ...section.fields.map((field) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildFormField(field, formState, formNotifier),
            )),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }
  
  Widget _buildStepperLayout(
    FormStateData formState,
    FormStateNotifier formNotifier,
  ) {
    // Simplified stepper implementation
    return Column(
      children: widget.schema.sections.asMap().entries.map((entry) {
        final index = entry.key;
        final section = entry.value;
        
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text('${index + 1}'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildSectionHeader(section),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...section.fields.map((field) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildFormField(field, formState, formNotifier),
                )),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildTabbedLayout(
    FormStateData formState,
    FormStateNotifier formNotifier,
  ) {
    return DefaultTabController(
      length: widget.schema.sections.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabs: widget.schema.sections.map((section) {
              return Tab(
                text: section.title,
                icon: section.icon != null ? Icon(section.icon) : null,
              );
            }).toList(),
          ),
          SizedBox(
            height: 400,
            child: TabBarView(
              children: widget.schema.sections.map((section) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: section.fields.map((field) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildFormField(field, formState, formNotifier),
                    )).toList(),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCollapsibleLayout(
    FormStateData formState,
    FormStateNotifier formNotifier,
  ) {
    return Column(
      children: widget.schema.sections.map((section) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ExpansionTile(
            initiallyExpanded: section.expanded,
            leading: section.icon != null ? Icon(section.icon) : null,
            title: Text(section.title),
            subtitle: section.description != null
                ? Text(section.description!)
                : null,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: section.fields.map((field) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildFormField(field, formState, formNotifier),
                  )).toList(),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildGridLayout(
    FormStateData formState,
    FormStateNotifier formNotifier,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.schema.sections.map((section) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (section.title.isNotEmpty) ...[
              _buildSectionHeader(section),
              const SizedBox(height: 16),
            ],
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 800 ? 2 : 1;
                
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: section.fields.map((field) {
                    return SizedBox(
                      width: (constraints.maxWidth - 16) / crossAxisCount,
                      child: _buildFormField(field, formState, formNotifier),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }
  
  Widget _buildSectionHeader(FormSection section) {
    return Row(
      children: [
        if (section.icon != null) ...[
          Icon(section.icon, size: 24),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                section.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (section.description != null) ...[
                const SizedBox(height: 4),
                Text(
                  section.description!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildFormField(
    FormFieldModel field,
    FormStateData formState,
    FormStateNotifier formNotifier,
  ) {
    if (field.hidden) {
      return const SizedBox.shrink();
    }
    
    final value = formState.values[field.name] ?? field.defaultValue;
    final error = formState.errors[field.name];
    
    switch (field.type) {
      case FormFieldType.text:
      case FormFieldType.email:
      case FormFieldType.password:
      case FormFieldType.number:
      case FormFieldType.phone:
      case FormFieldType.url:
      case FormFieldType.multiline:
        return TextFormFieldWidget(
          field: field,
          value: value,
          error: error,
          onChanged: (val) => formNotifier.updateFieldValue(field.name, val),
        );
        
      case FormFieldType.select:
      case FormFieldType.multiSelect:
        return SelectFormField(
          field: field,
          value: value,
          error: error,
          onChanged: (val) => formNotifier.updateFieldValue(field.name, val),
        );
        
      case FormFieldType.checkbox:
        return CheckboxFormField(
          field: field,
          value: value ?? false,
          error: error,
          onChanged: (val) => formNotifier.updateFieldValue(field.name, val),
        );
        
      case FormFieldType.radio:
        return RadioFormField(
          field: field,
          value: value,
          error: error,
          onChanged: (val) => formNotifier.updateFieldValue(field.name, val),
        );
        
      case FormFieldType.date:
        return DateFormField(
          field: field,
          value: value is DateTime ? value : null,
          error: error,
          onChanged: (val) => formNotifier.updateFieldValue(field.name, val),
        );
        
      case FormFieldType.time:
        return TimeFormField(
          field: field,
          value: value is TimeOfDay ? value : null,
          error: error,
          onChanged: (val) => formNotifier.updateFieldValue(field.name, val),
        );
        
      case FormFieldType.dateTime:
        return DateTimeFormField(
          field: field,
          value: value is DateTime ? value : null,
          error: error,
          onChanged: (val) => formNotifier.updateFieldValue(field.name, val),
        );
        
      case FormFieldType.dateRange:
        return DateRangeFormField(
          field: field,
          value: value is DateTimeRange ? value : null,
          error: error,
          onChanged: (val) => formNotifier.updateFieldValue(field.name, val),
        );
        
      case FormFieldType.file:
        return FileFormField(
          field: field,
          value: value is List<FileUploadModel> ? value : null,
          error: error,
          onChanged: (val) => formNotifier.updateFieldValue(field.name, val),
        );
        
      case FormFieldType.color:
        return ColorFormField(
          field: field,
          value: value is Color ? value : null,
          error: error,
          onChanged: (val) => formNotifier.updateFieldValue(field.name, val),
        );
        
      case FormFieldType.range:
        return RangeFormField(
          field: field,
          value: value is double ? value : null,
          error: error,
          onChanged: (val) => formNotifier.updateFieldValue(field.name, val),
        );
        
      case FormFieldType.richText:
        return SimpleRichTextFormField(
          field: field,
          value: value?.toString(),
          error: error,
          onChanged: (val) => formNotifier.updateFieldValue(field.name, val),
        );
        
      case FormFieldType.tags:
        return TagInputFormField(
          field: field,
          value: value is List<String> ? value : null,
          error: error,
          onChanged: (val) => formNotifier.updateFieldValue(field.name, val),
        );
        
      case FormFieldType.rating:
        return RatingFormField(
          field: field,
          value: value is double ? value : null,
          error: error,
          onChanged: (val) => formNotifier.updateFieldValue(field.name, val),
        );
        
      case FormFieldType.toggle:
        return ToggleFormField(
          field: field,
          value: value ?? false,
          error: error,
          onChanged: (val) => formNotifier.updateFieldValue(field.name, val),
        );
        
      default:
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.error),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text('Unsupported field type: ${field.type}'),
        );
    }
  }
  
  Widget _buildFormActions(
    FormStateData formState,
    FormStateNotifier formNotifier,
  ) {
    final actions = widget.schema.actions ?? const FormActions();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (actions.showCancel)
          TextButton(
            onPressed: actions.onCancel ?? () => Navigator.of(context).pop(),
            child: Text(actions.cancelLabel ?? 'Cancel'),
          ),
        const SizedBox(width: 8),
        
        if (actions.showReset)
          TextButton(
            onPressed: actions.onReset ?? () => formNotifier.resetForm(),
            child: Text(actions.resetLabel ?? 'Reset'),
          ),
        const SizedBox(width: 8),
        
        if (actions.showSaveAsDraft)
          OutlinedButton(
            onPressed: () {
              final onSaveAsDraft = actions.onSaveAsDraft ?? widget.onSubmit;
              onSaveAsDraft(formState.values);
            },
            child: Text(actions.saveAsDraftLabel ?? 'Save as Draft'),
          ),
        const SizedBox(width: 8),
        
        if (actions.showSubmit)
          FilledButton(
            onPressed: formState.isSubmitting
                ? null
                : () async {
                    await formNotifier.submitForm(
                      actions.onSubmit ?? widget.onSubmit,
                    );
                  },
            child: formState.isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(actions.submitLabel ?? 'Submit'),
          ),
      ],
    );
  }
}