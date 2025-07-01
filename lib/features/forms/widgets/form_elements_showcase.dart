import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/form_models.dart';
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

class FormElementsShowcase extends ConsumerStatefulWidget {
  const FormElementsShowcase({super.key});

  @override
  ConsumerState<FormElementsShowcase> createState() => _FormElementsShowcaseState();
}

class _FormElementsShowcaseState extends ConsumerState<FormElementsShowcase> {
  // State for form values
  final Map<String, dynamic> _values = {};
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSectionTitle('Text Inputs'),
        const SizedBox(height: 16),
        _buildTextInputsSection(),
        
        const SizedBox(height: 32),
        _buildSectionTitle('Selection Inputs'),
        const SizedBox(height: 16),
        _buildSelectionInputsSection(),
        
        const SizedBox(height: 32),
        _buildSectionTitle('Date & Time Inputs'),
        const SizedBox(height: 16),
        _buildDateTimeInputsSection(),
        
        const SizedBox(height: 32),
        _buildSectionTitle('Specialized Inputs'),
        const SizedBox(height: 16),
        _buildSpecializedInputsSection(),
      ],
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
  
  Widget _buildTextInputsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Text Input
            TextFormFieldWidget(
              field: const FormFieldModel(
                id: 'text',
                name: 'text',
                type: FormFieldType.text,
                label: 'Basic Text Input',
                placeholder: 'Enter some text',
                helperText: 'This is a basic text input field',
              ),
              value: _values['text'],
              onChanged: (value) => setState(() => _values['text'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Email Input
            TextFormFieldWidget(
              field: const FormFieldModel(
                id: 'email',
                name: 'email',
                type: FormFieldType.email,
                label: 'Email Input',
                placeholder: 'your@email.com',
                required: true,
                options: FormFieldOptions(
                  prefixIcon: Icons.email,
                ),
              ),
              value: _values['email'],
              onChanged: (value) => setState(() => _values['email'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Password Input
            TextFormFieldWidget(
              field: const FormFieldModel(
                id: 'password',
                name: 'password',
                type: FormFieldType.password,
                label: 'Password Input',
                placeholder: 'Enter password',
                helperText: 'Must be at least 8 characters',
                options: FormFieldOptions(
                  prefixIcon: Icons.lock,
                ),
              ),
              value: _values['password'],
              onChanged: (value) => setState(() => _values['password'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Number Input
            TextFormFieldWidget(
              field: const FormFieldModel(
                id: 'number',
                name: 'number',
                type: FormFieldType.number,
                label: 'Number Input',
                placeholder: '0',
                options: FormFieldOptions(
                  prefixIcon: Icons.numbers,
                  suffix: Text('units'),
                ),
              ),
              value: _values['number'],
              onChanged: (value) => setState(() => _values['number'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Phone Input
            TextFormFieldWidget(
              field: const FormFieldModel(
                id: 'phone',
                name: 'phone',
                type: FormFieldType.phone,
                label: 'Phone Input',
                placeholder: '(555) 000-0000',
                options: FormFieldOptions(
                  prefixIcon: Icons.phone,
                ),
              ),
              value: _values['phone'],
              onChanged: (value) => setState(() => _values['phone'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // URL Input
            TextFormFieldWidget(
              field: const FormFieldModel(
                id: 'url',
                name: 'url',
                type: FormFieldType.url,
                label: 'URL Input',
                placeholder: 'https://example.com',
                options: FormFieldOptions(
                  prefixIcon: Icons.link,
                ),
              ),
              value: _values['url'],
              onChanged: (value) => setState(() => _values['url'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Multiline Text
            TextFormFieldWidget(
              field: const FormFieldModel(
                id: 'multiline',
                name: 'multiline',
                type: FormFieldType.multiline,
                label: 'Multiline Text',
                placeholder: 'Enter multiple lines of text...',
                options: FormFieldOptions(
                  minLines: 3,
                  maxLines: 10,
                ),
              ),
              value: _values['multiline'],
              onChanged: (value) => setState(() => _values['multiline'] = value),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSelectionInputsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Single Select
            SelectFormField(
              field: const FormFieldModel(
                id: 'select',
                name: 'select',
                type: FormFieldType.select,
                label: 'Single Select',
                placeholder: 'Choose an option',
                options: FormFieldOptions(
                  options: [
                    SelectOption(value: 'option1', label: 'Option 1', icon: Icons.looks_one),
                    SelectOption(value: 'option2', label: 'Option 2', icon: Icons.looks_two),
                    SelectOption(value: 'option3', label: 'Option 3', icon: Icons.looks_3),
                  ],
                ),
              ),
              value: _values['select'],
              onChanged: (value) => setState(() => _values['select'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Multi Select
            SelectFormField(
              field: const FormFieldModel(
                id: 'multiSelect',
                name: 'multiSelect',
                type: FormFieldType.multiSelect,
                label: 'Multi Select',
                placeholder: 'Choose multiple options',
                options: FormFieldOptions(
                  options: [
                    SelectOption(value: 'red', label: 'Red', icon: Icons.circle),
                    SelectOption(value: 'green', label: 'Green', icon: Icons.circle),
                    SelectOption(value: 'blue', label: 'Blue', icon: Icons.circle),
                    SelectOption(value: 'yellow', label: 'Yellow', icon: Icons.circle),
                  ],
                ),
              ),
              value: _values['multiSelect'],
              onChanged: (value) => setState(() => _values['multiSelect'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Checkbox
            CheckboxFormField(
              field: const FormFieldModel(
                id: 'checkbox',
                name: 'checkbox',
                type: FormFieldType.checkbox,
                label: 'I agree to the terms and conditions',
                helperText: 'You must agree to continue',
              ),
              value: _values['checkbox'] ?? false,
              onChanged: (value) => setState(() => _values['checkbox'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Checkbox Group
            CheckboxGroupFormField(
              field: const FormFieldModel(
                id: 'checkboxGroup',
                name: 'checkboxGroup',
                type: FormFieldType.checkbox,
                label: 'Select your interests',
                options: FormFieldOptions(
                  options: [
                    SelectOption(value: 'sports', label: 'Sports', icon: Icons.sports_basketball),
                    SelectOption(value: 'music', label: 'Music', icon: Icons.music_note),
                    SelectOption(value: 'movies', label: 'Movies', icon: Icons.movie),
                    SelectOption(value: 'gaming', label: 'Gaming', icon: Icons.games),
                  ],
                ),
              ),
              value: _values['checkboxGroup'] ?? [],
              onChanged: (value) => setState(() => _values['checkboxGroup'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Radio Buttons
            RadioFormField(
              field: const FormFieldModel(
                id: 'radio',
                name: 'radio',
                type: FormFieldType.radio,
                label: 'Choose your plan',
                options: FormFieldOptions(
                  options: [
                    SelectOption(
                      value: 'free',
                      label: 'Free',
                      description: '\$0/month',
                      icon: Icons.eco,
                    ),
                    SelectOption(
                      value: 'pro',
                      label: 'Pro',
                      description: '\$9.99/month',
                      icon: Icons.star,
                    ),
                    SelectOption(
                      value: 'enterprise',
                      label: 'Enterprise',
                      description: 'Contact us',
                      icon: Icons.business,
                    ),
                  ],
                ),
              ),
              value: _values['radio'],
              onChanged: (value) => setState(() => _values['radio'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Toggle Switch
            ToggleFormField(
              field: const FormFieldModel(
                id: 'toggle',
                name: 'toggle',
                type: FormFieldType.toggle,
                label: 'Enable notifications',
                helperText: 'Receive updates about your account',
              ),
              value: _values['toggle'] ?? false,
              onChanged: (value) => setState(() => _values['toggle'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Segmented Button
            SegmentedButtonFormField(
              field: const FormFieldModel(
                id: 'segmented',
                name: 'segmented',
                type: FormFieldType.radio,
                label: 'View mode',
                options: FormFieldOptions(
                  options: [
                    SelectOption(value: 'list', label: 'List', icon: Icons.list),
                    SelectOption(value: 'grid', label: 'Grid', icon: Icons.grid_view),
                    SelectOption(value: 'cards', label: 'Cards', icon: Icons.dashboard),
                  ],
                ),
              ),
              value: _values['segmented'],
              onChanged: (value) => setState(() => _values['segmented'] = value),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDateTimeInputsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Picker
            DateFormField(
              field: const FormFieldModel(
                id: 'date',
                name: 'date',
                type: FormFieldType.date,
                label: 'Date Picker',
                placeholder: 'Select a date',
              ),
              value: _values['date'],
              onChanged: (value) => setState(() => _values['date'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Time Picker
            TimeFormField(
              field: const FormFieldModel(
                id: 'time',
                name: 'time',
                type: FormFieldType.time,
                label: 'Time Picker',
                placeholder: 'Select a time',
              ),
              value: _values['time'],
              onChanged: (value) => setState(() => _values['time'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // DateTime Picker
            DateTimeFormField(
              field: const FormFieldModel(
                id: 'dateTime',
                name: 'dateTime',
                type: FormFieldType.dateTime,
                label: 'Date & Time Picker',
                placeholder: 'Select date and time',
              ),
              value: _values['dateTime'],
              onChanged: (value) => setState(() => _values['dateTime'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Date Range Picker
            DateRangeFormField(
              field: const FormFieldModel(
                id: 'dateRange',
                name: 'dateRange',
                type: FormFieldType.dateRange,
                label: 'Date Range Picker',
                placeholder: 'Select date range',
              ),
              value: _values['dateRange'],
              onChanged: (value) => setState(() => _values['dateRange'] = value),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSpecializedInputsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // File Upload
            FileFormField(
              field: const FormFieldModel(
                id: 'file',
                name: 'file',
                type: FormFieldType.file,
                label: 'File Upload',
                helperText: 'Drag and drop or click to browse',
                options: FormFieldOptions(
                  acceptedFileTypes: ['pdf', 'doc', 'docx'],
                  maxFileSize: 5 * 1024 * 1024, // 5MB
                  multiple: true,
                  maxFiles: 3,
                ),
              ),
              value: _values['file'],
              onChanged: (value) => setState(() => _values['file'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Color Picker
            ColorFormField(
              field: const FormFieldModel(
                id: 'color',
                name: 'color',
                type: FormFieldType.color,
                label: 'Color Picker',
                placeholder: 'Select a color',
              ),
              value: _values['color'],
              onChanged: (value) => setState(() => _values['color'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Range Slider
            RangeFormField(
              field: const FormFieldModel(
                id: 'range',
                name: 'range',
                type: FormFieldType.range,
                label: 'Range Slider',
                options: FormFieldOptions(
                  min: 0,
                  max: 100,
                  step: 5,
                  suffix: Text('%'),
                ),
              ),
              value: _values['range'],
              onChanged: (value) => setState(() => _values['range'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Range Slider (Min/Max)
            RangeSliderFormField(
              field: const FormFieldModel(
                id: 'rangeSlider',
                name: 'rangeSlider',
                type: FormFieldType.range,
                label: 'Price Range',
                options: FormFieldOptions(
                  min: 0,
                  max: 1000,
                  step: 50,
                  prefix: Text(r'$'),
                ),
              ),
              value: _values['rangeSlider'],
              onChanged: (value) => setState(() => _values['rangeSlider'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Tag Input
            TagInputFormField(
              field: const FormFieldModel(
                id: 'tags',
                name: 'tags',
                type: FormFieldType.tags,
                label: 'Tag Input',
                placeholder: 'Enter tags separated by commas',
                helperText: 'Press enter or comma to add tag',
              ),
              value: _values['tags'],
              onChanged: (value) => setState(() => _values['tags'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Rating
            RatingFormField(
              field: const FormFieldModel(
                id: 'rating',
                name: 'rating',
                type: FormFieldType.rating,
                label: 'Star Rating',
                options: FormFieldOptions(
                  max: 5,
                  step: 0.5,
                ),
              ),
              value: _values['rating'],
              onChanged: (value) => setState(() => _values['rating'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Emoji Rating
            EmojiRatingFormField(
              field: const FormFieldModel(
                id: 'emojiRating',
                name: 'emojiRating',
                type: FormFieldType.rating,
                label: 'How was your experience?',
              ),
              value: _values['emojiRating'],
              onChanged: (value) => setState(() => _values['emojiRating'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Thumb Rating
            ThumbRatingFormField(
              field: const FormFieldModel(
                id: 'thumbRating',
                name: 'thumbRating',
                type: FormFieldType.rating,
                label: 'Was this helpful?',
              ),
              value: _values['thumbRating'],
              onChanged: (value) => setState(() => _values['thumbRating'] = value),
            ),
            
            const SizedBox(height: 16),
            
            // Rich Text Editor
            SimpleRichTextFormField(
              field: const FormFieldModel(
                id: 'richText',
                name: 'richText',
                type: FormFieldType.richText,
                label: 'Rich Text Editor',
                placeholder: 'Enter formatted text...',
                options: FormFieldOptions(
                  minLines: 5,
                  maxLines: 10,
                ),
              ),
              value: _values['richText'],
              onChanged: (value) => setState(() => _values['richText'] = value),
            ),
          ],
        ),
      ),
    );
  }
}