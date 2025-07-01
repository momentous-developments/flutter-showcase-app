import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/form_providers.dart';
import '../../validators/form_validators.dart';
import '../form_fields/form_fields.dart';

class FormValidationShowcase extends ConsumerStatefulWidget {
  const FormValidationShowcase({super.key});

  @override
  ConsumerState<FormValidationShowcase> createState() => _FormValidationShowcaseState();
}

class _FormValidationShowcaseState extends ConsumerState<FormValidationShowcase> {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Form Validation',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Comprehensive validation examples',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            
            // Basic Validation
            _buildValidationSection(
              context,
              'Basic Validation',
              'Required fields, length constraints, and format validation',
              [
                TextFormFieldWidget(
                  fieldId: 'required_field',
                  label: 'Required Field',
                  required: true,
                  onChanged: (value) {},
                  validator: (value) => FormValidators.required(value)?.message,
                ),
                TextFormFieldWidget(
                  fieldId: 'min_length',
                  label: 'Minimum Length (5 chars)',
                  onChanged: (value) {},
                  validator: (value) => FormValidators.minLength(value, 5)?.message,
                ),
                TextFormFieldWidget(
                  fieldId: 'max_length',
                  label: 'Maximum Length (10 chars)',
                  maxLength: 10,
                  onChanged: (value) {},
                  validator: (value) => FormValidators.maxLength(value, 10)?.message,
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Pattern Validation
            _buildValidationSection(
              context,
              'Pattern Validation',
              'Email, URL, phone, and custom patterns',
              [
                TextFormFieldWidget(
                  fieldId: 'email_validation',
                  label: 'Email Address',
                  fieldType: TextFieldType.email,
                  onChanged: (value) {},
                  validator: (value) => FormValidators.email(value)?.message,
                ),
                TextFormFieldWidget(
                  fieldId: 'url_validation',
                  label: 'Website URL',
                  fieldType: TextFieldType.url,
                  onChanged: (value) {},
                  validator: (value) => FormValidators.url(value)?.message,
                ),
                TextFormFieldWidget(
                  fieldId: 'phone_validation',
                  label: 'Phone Number',
                  fieldType: TextFieldType.phone,
                  onChanged: (value) {},
                  validator: (value) => FormValidators.phone(value)?.message,
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Number Validation
            _buildValidationSection(
              context,
              'Number Validation',
              'Numeric ranges, integers, and decimals',
              [
                TextFormFieldWidget(
                  fieldId: 'number_range',
                  label: 'Number (1-100)',
                  fieldType: TextFieldType.number,
                  onChanged: (value) {},
                  validator: (value) => FormValidators.numberRange(value, min: 1, max: 100)?.message,
                ),
                TextFormFieldWidget(
                  fieldId: 'integer_only',
                  label: 'Integer Only',
                  fieldType: TextFieldType.number,
                  onChanged: (value) {},
                  validator: (value) => FormValidators.integer(value)?.message,
                ),
                TextFormFieldWidget(
                  fieldId: 'decimal_places',
                  label: 'Max 2 Decimal Places',
                  fieldType: TextFieldType.number,
                  onChanged: (value) {},
                  validator: (value) => FormValidators.pattern(
                    value,
                    RegExp(r'^\d+(\.\d{1,2})?$'),
                    message: 'Maximum 2 decimal places allowed',
                  )?.message,
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Password Validation
            _buildValidationSection(
              context,
              'Password Validation',
              'Password strength and confirmation',
              [
                TextFormFieldWidget(
                  fieldId: 'password_strength',
                  label: 'Strong Password',
                  fieldType: TextFieldType.password,
                  helperText: 'Min 8 chars, uppercase, lowercase, number, special char',
                  onChanged: (value) {},
                  validator: (value) => FormValidators.passwordStrength(value)?.message,
                ),
                TextFormFieldWidget(
                  fieldId: 'password_confirm',
                  label: 'Confirm Password',
                  fieldType: TextFieldType.password,
                  onChanged: (value) {},
                  validator: (value) {
                    // This would normally compare with the password field
                    if (value != 'password123') {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Date Validation
            _buildValidationSection(
              context,
              'Date Validation',
              'Date ranges and age validation',
              [
                DateFormField(
                  fieldId: 'future_date',
                  label: 'Future Date Only',
                  firstDate: DateTime.now().add(const Duration(days: 1)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  onChanged: (value) {},
                ),
                DateFormField(
                  fieldId: 'past_date',
                  label: 'Past Date Only',
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().subtract(const Duration(days: 1)),
                  onChanged: (value) {},
                ),
                DateFormField(
                  fieldId: 'age_validation',
                  label: 'Date of Birth (18+)',
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Custom Validation
            _buildValidationSection(
              context,
              'Custom Validation',
              'Business rules and complex validation',
              [
                TextFormFieldWidget(
                  fieldId: 'username',
                  label: 'Username (alphanumeric, no spaces)',
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                      return 'Only letters and numbers allowed';
                    }
                    if (value.length < 3) {
                      return 'Username must be at least 3 characters';
                    }
                    return null;
                  },
                ),
                TextFormFieldWidget(
                  fieldId: 'credit_card',
                  label: 'Credit Card Number',
                  onChanged: (value) {},
                  validator: (value) => FormValidators.creditCard(value)?.message,
                ),
                SelectFormField(
                  fieldId: 'country_state',
                  label: 'Select Country',
                  options: const [
                    SelectOption(value: 'us', label: 'United States'),
                    SelectOption(value: 'ca', label: 'Canada'),
                    SelectOption(value: 'uk', label: 'United Kingdom'),
                  ],
                  required: true,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a country';
                    }
                    return null;
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Async Validation Example
            _buildValidationSection(
              context,
              'Async Validation',
              'Server-side validation and availability checks',
              [
                TextFormFieldWidget(
                  fieldId: 'username_async',
                  label: 'Check Username Availability',
                  helperText: 'Checking availability...',
                  onChanged: (value) {},
                  validator: (value) {
                    // Simulate async validation
                    if (value == 'admin' || value == 'user') {
                      return 'This username is already taken';
                    }
                    return null;
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Form Actions
            Row(
              children: [
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Form is valid!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fix the errors'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('Validate Form'),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () {
                    _formKey.currentState!.reset();
                  },
                  child: const Text('Reset Form'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildValidationSection(
    BuildContext context,
    String title,
    String description,
    List<Widget> fields,
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
        const SizedBox(height: 4),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        Card(
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
              children: fields.map((field) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: field,
              )).toList(),
            ),
          ),
        ),
      ],
    );
  }
}