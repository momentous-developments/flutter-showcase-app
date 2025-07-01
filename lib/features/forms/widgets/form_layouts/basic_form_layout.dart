import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/form_models.dart';
import '../../providers/form_providers.dart';
import '../form_fields/text_form_field_widget.dart';
import '../form_fields/select_form_field.dart';
import '../form_fields/checkbox_form_field.dart';
import '../form_fields/radio_form_field.dart';
import '../form_fields/date_form_field.dart';

class BasicFormLayout extends ConsumerWidget {
  const BasicFormLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formStateProvider('basic_form'));
    final formNotifier = ref.read(formStateProvider('basic_form').notifier);
    
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Personal Information Section
          _buildSectionTitle(context, 'Personal Information'),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: TextFormFieldWidget(
                  field: const FormFieldModel(
                    id: 'firstName',
                    name: 'firstName',
                    type: FormFieldType.text,
                    label: 'First Name',
                    placeholder: 'Enter your first name',
                    required: true,
                  ),
                  value: formState.values['firstName'],
                  error: formState.errors['firstName'],
                  onChanged: (value) => formNotifier.updateFieldValue('firstName', value),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormFieldWidget(
                  field: const FormFieldModel(
                    id: 'lastName',
                    name: 'lastName',
                    type: FormFieldType.text,
                    label: 'Last Name',
                    placeholder: 'Enter your last name',
                    required: true,
                  ),
                  value: formState.values['lastName'],
                  error: formState.errors['lastName'],
                  onChanged: (value) => formNotifier.updateFieldValue('lastName', value),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          TextFormFieldWidget(
            field: const FormFieldModel(
              id: 'email',
              name: 'email',
              type: FormFieldType.email,
              label: 'Email Address',
              placeholder: 'your@email.com',
              required: true,
            ),
            value: formState.values['email'],
            error: formState.errors['email'],
            onChanged: (value) => formNotifier.updateFieldValue('email', value),
          ),
          
          const SizedBox(height: 16),
          
          TextFormFieldWidget(
            field: const FormFieldModel(
              id: 'phone',
              name: 'phone',
              type: FormFieldType.phone,
              label: 'Phone Number',
              placeholder: '+1 (555) 000-0000',
            ),
            value: formState.values['phone'],
            error: formState.errors['phone'],
            onChanged: (value) => formNotifier.updateFieldValue('phone', value),
          ),
          
          const SizedBox(height: 24),
          
          // Address Section
          _buildSectionTitle(context, 'Address'),
          const SizedBox(height: 16),
          
          TextFormFieldWidget(
            field: const FormFieldModel(
              id: 'street',
              name: 'street',
              type: FormFieldType.text,
              label: 'Street Address',
              placeholder: '123 Main St',
              required: true,
            ),
            value: formState.values['street'],
            error: formState.errors['street'],
            onChanged: (value) => formNotifier.updateFieldValue('street', value),
          ),
          
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormFieldWidget(
                  field: const FormFieldModel(
                    id: 'city',
                    name: 'city',
                    type: FormFieldType.text,
                    label: 'City',
                    placeholder: 'New York',
                    required: true,
                  ),
                  value: formState.values['city'],
                  error: formState.errors['city'],
                  onChanged: (value) => formNotifier.updateFieldValue('city', value),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SelectFormField(
                  field: const FormFieldModel(
                    id: 'state',
                    name: 'state',
                    type: FormFieldType.select,
                    label: 'State',
                    required: true,
                    options: FormFieldOptions(
                      options: [
                        SelectOption(value: 'ny', label: 'NY'),
                        SelectOption(value: 'ca', label: 'CA'),
                        SelectOption(value: 'tx', label: 'TX'),
                        SelectOption(value: 'fl', label: 'FL'),
                      ],
                    ),
                  ),
                  value: formState.values['state'],
                  error: formState.errors['state'],
                  onChanged: (value) => formNotifier.updateFieldValue('state', value),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormFieldWidget(
                  field: const FormFieldModel(
                    id: 'zipCode',
                    name: 'zipCode',
                    type: FormFieldType.text,
                    label: 'ZIP Code',
                    placeholder: '10001',
                    required: true,
                  ),
                  value: formState.values['zipCode'],
                  error: formState.errors['zipCode'],
                  onChanged: (value) => formNotifier.updateFieldValue('zipCode', value),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Preferences Section
          _buildSectionTitle(context, 'Preferences'),
          const SizedBox(height: 16),
          
          SelectFormField(
            field: const FormFieldModel(
              id: 'contactMethod',
              name: 'contactMethod',
              type: FormFieldType.select,
              label: 'Preferred Contact Method',
              options: FormFieldOptions(
                options: [
                  SelectOption(value: 'email', label: 'Email'),
                  SelectOption(value: 'phone', label: 'Phone'),
                  SelectOption(value: 'sms', label: 'SMS'),
                  SelectOption(value: 'mail', label: 'Mail'),
                ],
              ),
            ),
            value: formState.values['contactMethod'],
            onChanged: (value) => formNotifier.updateFieldValue('contactMethod', value),
          ),
          
          const SizedBox(height: 16),
          
          DateFormField(
            field: FormFieldModel(
              id: 'birthDate',
              name: 'birthDate',
              type: FormFieldType.date,
              label: 'Date of Birth',
              options: FormFieldOptions(
                maxDate: DateTime.now(),
              ),
            ),
            value: formState.values['birthDate'],
            onChanged: (value) => formNotifier.updateFieldValue('birthDate', value),
          ),
          
          const SizedBox(height: 16),
          
          RadioFormField(
            field: const FormFieldModel(
              id: 'gender',
              name: 'gender',
              type: FormFieldType.radio,
              label: 'Gender',
              options: FormFieldOptions(
                options: [
                  SelectOption(value: 'male', label: 'Male'),
                  SelectOption(value: 'female', label: 'Female'),
                  SelectOption(value: 'other', label: 'Other'),
                  SelectOption(value: 'prefer_not_to_say', label: 'Prefer not to say'),
                ],
              ),
            ),
            value: formState.values['gender'],
            onChanged: (value) => formNotifier.updateFieldValue('gender', value),
          ),
          
          const SizedBox(height: 16),
          
          CheckboxFormField(
            field: const FormFieldModel(
              id: 'newsletter',
              name: 'newsletter',
              type: FormFieldType.checkbox,
              label: 'Subscribe to newsletter',
            ),
            value: formState.values['newsletter'] ?? false,
            onChanged: (value) => formNotifier.updateFieldValue('newsletter', value),
          ),
          
          CheckboxFormField(
            field: const FormFieldModel(
              id: 'terms',
              name: 'terms',
              type: FormFieldType.checkbox,
              label: 'I agree to the Terms of Service and Privacy Policy',
              required: true,
            ),
            value: formState.values['terms'] ?? false,
            error: formState.errors['terms'],
            onChanged: (value) => formNotifier.updateFieldValue('terms', value),
          ),
          
          const SizedBox(height: 24),
          
          // Form Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => formNotifier.resetForm(),
                child: const Text('Reset'),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: formState.isSubmitting
                    ? null
                    : () async {
                        await formNotifier.submitForm((values) {
                          // Handle form submission
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Form submitted: ${values.toString()}'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        });
                      },
                child: formState.isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}