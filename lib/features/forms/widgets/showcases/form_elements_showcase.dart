import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../form_fields/form_fields.dart';

class FormElementsShowcase extends ConsumerWidget {
  const FormElementsShowcase({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Form Elements',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'All available form field types',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          
          // Text inputs
          _buildSection(
            context,
            'Text Inputs',
            [
              _FormFieldDemo(
                title: 'Text Field',
                field: TextFormFieldWidget(
                  fieldId: 'text_demo',
                  label: 'Text Input',
                  onChanged: (value) {},
                ),
              ),
              _FormFieldDemo(
                title: 'Email Field',
                field: TextFormFieldWidget(
                  fieldId: 'email_demo',
                  label: 'Email',
                  fieldType: TextFieldType.email,
                  onChanged: (value) {},
                ),
              ),
              _FormFieldDemo(
                title: 'Password Field',
                field: TextFormFieldWidget(
                  fieldId: 'password_demo',
                  label: 'Password',
                  fieldType: TextFieldType.password,
                  onChanged: (value) {},
                ),
              ),
              _FormFieldDemo(
                title: 'Number Field',
                field: TextFormFieldWidget(
                  fieldId: 'number_demo',
                  label: 'Number',
                  fieldType: TextFieldType.number,
                  onChanged: (value) {},
                ),
              ),
              _FormFieldDemo(
                title: 'Multiline Field',
                field: TextFormFieldWidget(
                  fieldId: 'multiline_demo',
                  label: 'Description',
                  fieldType: TextFieldType.multiline,
                  maxLines: 4,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          // Selection inputs
          _buildSection(
            context,
            'Selection Inputs',
            [
              _FormFieldDemo(
                title: 'Select Dropdown',
                field: SelectFormField(
                  fieldId: 'select_demo',
                  label: 'Select Option',
                  options: const [
                    SelectOption(value: 'option1', label: 'Option 1'),
                    SelectOption(value: 'option2', label: 'Option 2'),
                    SelectOption(value: 'option3', label: 'Option 3'),
                  ],
                  onChanged: (value) {},
                ),
              ),
              _FormFieldDemo(
                title: 'Multi-Select',
                field: SelectFormField(
                  fieldId: 'multiselect_demo',
                  label: 'Select Multiple',
                  multiple: true,
                  options: const [
                    SelectOption(value: 'option1', label: 'Option 1'),
                    SelectOption(value: 'option2', label: 'Option 2'),
                    SelectOption(value: 'option3', label: 'Option 3'),
                    SelectOption(value: 'option4', label: 'Option 4'),
                  ],
                  onChanged: (value) {},
                ),
              ),
              _FormFieldDemo(
                title: 'Checkbox',
                field: CheckboxFormField(
                  fieldId: 'checkbox_demo',
                  label: 'I agree to the terms',
                  onChanged: (value) {},
                ),
              ),
              _FormFieldDemo(
                title: 'Checkbox Group',
                field: CheckboxFormField(
                  fieldId: 'checkbox_group_demo',
                  label: 'Select Options',
                  options: const [
                    SelectOption(value: 'option1', label: 'Option 1'),
                    SelectOption(value: 'option2', label: 'Option 2'),
                    SelectOption(value: 'option3', label: 'Option 3'),
                  ],
                  onChanged: (value) {},
                ),
              ),
              _FormFieldDemo(
                title: 'Radio Buttons',
                field: RadioFormField(
                  fieldId: 'radio_demo',
                  label: 'Choose One',
                  options: const [
                    SelectOption(value: 'option1', label: 'Option 1'),
                    SelectOption(value: 'option2', label: 'Option 2'),
                    SelectOption(value: 'option3', label: 'Option 3'),
                  ],
                  onChanged: (value) {},
                ),
              ),
              _FormFieldDemo(
                title: 'Toggle Switch',
                field: ToggleFormField(
                  fieldId: 'toggle_demo',
                  label: 'Enable Feature',
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          // Date & Time inputs
          _buildSection(
            context,
            'Date & Time Inputs',
            [
              _FormFieldDemo(
                title: 'Date Picker',
                field: DateFormField(
                  fieldId: 'date_demo',
                  label: 'Select Date',
                  onChanged: (value) {},
                ),
              ),
              _FormFieldDemo(
                title: 'Time Picker',
                field: DateFormField(
                  fieldId: 'time_demo',
                  label: 'Select Time',
                  fieldType: DateFieldType.time,
                  onChanged: (value) {},
                ),
              ),
              _FormFieldDemo(
                title: 'DateTime Picker',
                field: DateFormField(
                  fieldId: 'datetime_demo',
                  label: 'Select Date & Time',
                  fieldType: DateFieldType.dateTime,
                  onChanged: (value) {},
                ),
              ),
              _FormFieldDemo(
                title: 'Date Range',
                field: DateFormField(
                  fieldId: 'daterange_demo',
                  label: 'Select Date Range',
                  fieldType: DateFieldType.dateRange,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          // Advanced inputs
          _buildSection(
            context,
            'Advanced Inputs',
            [
              _FormFieldDemo(
                title: 'File Upload',
                field: FileFormField(
                  fieldId: 'file_demo',
                  label: 'Upload File',
                  onChanged: (value) {},
                ),
              ),
              _FormFieldDemo(
                title: 'Color Picker',
                field: ColorFormField(
                  fieldId: 'color_demo',
                  label: 'Choose Color',
                  onChanged: (value) {},
                ),
              ),
              _FormFieldDemo(
                title: 'Range Slider',
                field: RangeFormField(
                  fieldId: 'range_demo',
                  label: 'Select Range',
                  min: 0,
                  max: 100,
                  onChanged: (value) {},
                ),
              ),
              _FormFieldDemo(
                title: 'Tag Input',
                field: TagFormField(
                  fieldId: 'tag_demo',
                  label: 'Add Tags',
                  onChanged: (value) {},
                ),
              ),
              _FormFieldDemo(
                title: 'Rating',
                field: RatingFormField(
                  fieldId: 'rating_demo',
                  label: 'Rate this',
                  onChanged: (value) {},
                ),
              ),
              _FormFieldDemo(
                title: 'Rich Text Editor',
                field: RichTextFormField(
                  fieldId: 'richtext_demo',
                  label: 'Content',
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<_FormFieldDemo> fields,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 1200
                ? 3
                : constraints.maxWidth > 800
                    ? 2
                    : 1;
            
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2.5,
              children: fields.map((demo) => Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        demo.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(child: demo.field),
                    ],
                  ),
                ),
              )).toList(),
            );
          },
        ),
      ],
    );
  }
}

class _FormFieldDemo {
  final String title;
  final Widget field;

  const _FormFieldDemo({
    required this.title,
    required this.field,
  });
}