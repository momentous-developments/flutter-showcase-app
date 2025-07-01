import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../models/form_models.dart';
import '../validators/form_validators.dart';

// Form state provider
final formStateProvider = StateNotifierProvider.family<FormStateNotifier, FormStateData, String>(
  (ref, formId) => FormStateNotifier(formId),
);

class FormStateNotifier extends StateNotifier<FormStateData> {
  FormStateNotifier(String formId) : super(FormStateData(formId: formId));
  
  Timer? _autoSaveTimer;
  
  // Update field value
  void updateFieldValue(String fieldName, dynamic value) {
    final newValues = Map<String, dynamic>.from(state.values);
    newValues[fieldName] = value;
    
    state = state.copyWith(
      values: newValues,
      isDirty: true,
    );
    
    // Trigger validation if needed
    if (state.fieldStates[fieldName] == FieldState.error) {
      validateField(fieldName);
    }
  }
  
  // Update multiple field values
  void updateFieldValues(Map<String, dynamic> values) {
    final newValues = Map<String, dynamic>.from(state.values);
    newValues.addAll(values);
    
    state = state.copyWith(
      values: newValues,
      isDirty: true,
    );
  }
  
  // Validate single field
  Future<ValidationResult> validateField(String fieldName) async {
    state = state.copyWith(isValidating: true);
    
    // Get field configuration and validators
    // This would normally come from the form schema
    // For now, returning a mock result
    await Future.delayed(const Duration(milliseconds: 300));
    
    final isValid = state.values[fieldName] != null && 
                   state.values[fieldName].toString().isNotEmpty;
    
    final newErrors = Map<String, String>.from(state.errors);
    final newFieldStates = Map<String, FieldState>.from(state.fieldStates);
    
    if (isValid) {
      newErrors.remove(fieldName);
      newFieldStates[fieldName] = FieldState.success;
    } else {
      newErrors[fieldName] = 'This field is required';
      newFieldStates[fieldName] = FieldState.error;
    }
    
    state = state.copyWith(
      errors: newErrors,
      fieldStates: newFieldStates,
      isValidating: false,
      isValid: newErrors.isEmpty,
    );
    
    return ValidationResult(
      isValid: isValid,
      message: isValid ? null : newErrors[fieldName],
    );
  }
  
  // Validate all fields
  Future<bool> validateForm() async {
    state = state.copyWith(isValidating: true);
    
    // Validate all fields
    // This would normally iterate through all fields in the schema
    // For now, returning a mock result
    await Future.delayed(const Duration(milliseconds: 500));
    
    final isValid = state.values.isNotEmpty;
    
    state = state.copyWith(
      isValidating: false,
      isValid: isValid,
    );
    
    return isValid;
  }
  
  // Submit form
  Future<void> submitForm(Function(Map<String, dynamic>) onSubmit) async {
    state = state.copyWith(isSubmitting: true, hasSubmitted: true);
    
    try {
      final isValid = await validateForm();
      if (!isValid) {
        state = state.copyWith(
          isSubmitting: false,
          fieldStates: _focusFirstError(),
        );
        return;
      }
      
      await onSubmit(state.values);
      
      state = state.copyWith(
        isSubmitting: false,
        isDirty: false,
      );
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        errors: {'_form': e.toString()},
      );
    }
  }
  
  // Reset form
  void resetForm() {
    state = FormStateData(formId: state.formId);
    _cancelAutoSave();
  }
  
  // Set field state
  void setFieldState(String fieldName, FieldState fieldState) {
    final newFieldStates = Map<String, FieldState>.from(state.fieldStates);
    newFieldStates[fieldName] = fieldState;
    
    state = state.copyWith(fieldStates: newFieldStates);
  }
  
  // Set field error
  void setFieldError(String fieldName, String? error) {
    final newErrors = Map<String, String>.from(state.errors);
    final newFieldStates = Map<String, FieldState>.from(state.fieldStates);
    
    if (error == null) {
      newErrors.remove(fieldName);
      newFieldStates[fieldName] = FieldState.normal;
    } else {
      newErrors[fieldName] = error;
      newFieldStates[fieldName] = FieldState.error;
    }
    
    state = state.copyWith(
      errors: newErrors,
      fieldStates: newFieldStates,
      isValid: newErrors.isEmpty,
    );
  }
  
  // Start auto-save
  void startAutoSave(Duration interval, Function(Map<String, dynamic>) onSave) {
    _cancelAutoSave();
    
    _autoSaveTimer = Timer.periodic(interval, (_) {
      if (state.isDirty && !state.isSubmitting) {
        onSave(state.values);
        state = state.copyWith(
          lastSaved: DateTime.now(),
          isDirty: false,
        );
      }
    });
  }
  
  // Cancel auto-save
  void _cancelAutoSave() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = null;
  }
  
  // Focus first error field
  Map<String, FieldState> _focusFirstError() {
    final fieldStates = Map<String, FieldState>.from(state.fieldStates);
    
    for (final entry in state.errors.entries) {
      if (entry.key != '_form') {
        fieldStates[entry.key] = FieldState.focused;
        break;
      }
    }
    
    return fieldStates;
  }
  
  @override
  void dispose() {
    _cancelAutoSave();
    super.dispose();
  }
}

// Form schema provider
final formSchemaProvider = Provider.family<FormSchema?, String>((ref, formId) {
  // This would normally fetch the schema from a service
  // For now, returning mock schemas
  
  switch (formId) {
    case 'contact':
      return _createContactFormSchema();
    case 'registration':
      return _createRegistrationFormSchema();
    case 'checkout':
      return _createCheckoutFormSchema();
    default:
      return null;
  }
});

// Form templates provider
final formTemplatesProvider = Provider<List<FormTemplate>>((ref) {
  return [
    FormTemplate(
      id: 'contact',
      name: 'Contact Form',
      description: 'Simple contact form template',
      category: 'General',
      schema: _createContactFormSchema(),
      icon: Icons.contact_mail,
      tags: ['contact', 'general', 'simple'],
    ),
    FormTemplate(
      id: 'registration',
      name: 'Registration Form',
      description: 'User registration form with validation',
      category: 'Authentication',
      schema: _createRegistrationFormSchema(),
      icon: Icons.person_add,
      tags: ['registration', 'auth', 'user'],
    ),
    FormTemplate(
      id: 'checkout',
      name: 'Checkout Form',
      description: 'E-commerce checkout form',
      category: 'E-commerce',
      schema: _createCheckoutFormSchema(),
      icon: Icons.shopping_cart,
      tags: ['checkout', 'ecommerce', 'payment'],
    ),
    FormTemplate(
      id: 'survey',
      name: 'Survey Form',
      description: 'Customer satisfaction survey',
      category: 'Feedback',
      schema: _createSurveyFormSchema(),
      icon: Icons.poll,
      tags: ['survey', 'feedback', 'rating'],
    ),
    FormTemplate(
      id: 'job_application',
      name: 'Job Application',
      description: 'Job application form with file upload',
      category: 'HR',
      schema: _createJobApplicationFormSchema(),
      icon: Icons.work,
      tags: ['job', 'application', 'hr'],
    ),
  ];
});

// Helper functions to create mock schemas
FormSchema _createContactFormSchema() {
  return FormSchema(
    id: 'contact',
    name: 'Contact Form',
    layoutType: FormLayoutType.vertical,
    sections: [
      FormSection(
        id: 'personal',
        title: 'Personal Information',
        fields: [
          const FormFieldModel(
            id: 'name',
            name: 'name',
            type: FormFieldType.text,
            label: 'Full Name',
            placeholder: 'Enter your full name',
            required: true,
            validators: [
              ValidationRule(
                type: ValidationRuleType.required,
                message: 'Name is required',
              ),
              ValidationRule(
                type: ValidationRuleType.minLength,
                value: 2,
                message: 'Name must be at least 2 characters',
              ),
            ],
          ),
          const FormFieldModel(
            id: 'email',
            name: 'email',
            type: FormFieldType.email,
            label: 'Email Address',
            placeholder: 'your@email.com',
            required: true,
            validators: [
              ValidationRule(
                type: ValidationRuleType.required,
                message: 'Email is required',
              ),
              ValidationRule(
                type: ValidationRuleType.email,
                message: 'Invalid email address',
              ),
            ],
          ),
          const FormFieldModel(
            id: 'phone',
            name: 'phone',
            type: FormFieldType.phone,
            label: 'Phone Number',
            placeholder: '+1 (555) 000-0000',
            validators: [
              ValidationRule(
                type: ValidationRuleType.phone,
                message: 'Invalid phone number',
              ),
            ],
          ),
        ],
      ),
      FormSection(
        id: 'message',
        title: 'Message',
        fields: [
          const FormFieldModel(
            id: 'subject',
            name: 'subject',
            type: FormFieldType.text,
            label: 'Subject',
            placeholder: 'What is this about?',
            required: true,
          ),
          const FormFieldModel(
            id: 'message',
            name: 'message',
            type: FormFieldType.multiline,
            label: 'Message',
            placeholder: 'Tell us more...',
            required: true,
            options: FormFieldOptions(
              minLines: 3,
              maxLines: 10,
              minLength: 10,
              maxLength: 1000,
            ),
          ),
        ],
      ),
    ],
    actions: FormActions(
      submitLabel: 'Send Message',
      showReset: true,
    ),
  );
}

FormSchema _createRegistrationFormSchema() {
  return FormSchema(
    id: 'registration',
    name: 'User Registration',
    layoutType: FormLayoutType.vertical,
    sections: [
      FormSection(
        id: 'account',
        title: 'Account Information',
        fields: [
          const FormFieldModel(
            id: 'username',
            name: 'username',
            type: FormFieldType.text,
            label: 'Username',
            placeholder: 'Choose a username',
            required: true,
            validators: [
              ValidationRule(
                type: ValidationRuleType.required,
              ),
              ValidationRule(
                type: ValidationRuleType.minLength,
                value: 3,
              ),
              ValidationRule(
                type: ValidationRuleType.pattern,
                value: r'^[a-zA-Z0-9_]+$',
                message: 'Username can only contain letters, numbers, and underscores',
              ),
              ValidationRule(
                type: ValidationRuleType.async,
                message: 'Checking username availability...',
              ),
            ],
          ),
          const FormFieldModel(
            id: 'email',
            name: 'email',
            type: FormFieldType.email,
            label: 'Email Address',
            placeholder: 'your@email.com',
            required: true,
            validators: [
              ValidationRule(
                type: ValidationRuleType.required,
              ),
              ValidationRule(
                type: ValidationRuleType.email,
              ),
              ValidationRule(
                type: ValidationRuleType.async,
                message: 'Checking email availability...',
              ),
            ],
          ),
          const FormFieldModel(
            id: 'password',
            name: 'password',
            type: FormFieldType.password,
            label: 'Password',
            placeholder: 'Choose a strong password',
            required: true,
            validators: [
              ValidationRule(
                type: ValidationRuleType.required,
              ),
              ValidationRule(
                type: ValidationRuleType.minLength,
                value: 8,
              ),
              ValidationRule(
                type: ValidationRuleType.custom,
                message: 'Password must contain uppercase, lowercase, number, and special character',
              ),
            ],
          ),
          const FormFieldModel(
            id: 'confirmPassword',
            name: 'confirmPassword',
            type: FormFieldType.password,
            label: 'Confirm Password',
            placeholder: 'Re-enter your password',
            required: true,
            validators: [
              ValidationRule(
                type: ValidationRuleType.required,
              ),
              ValidationRule(
                type: ValidationRuleType.crossField,
                message: 'Passwords do not match',
              ),
            ],
          ),
        ],
      ),
      FormSection(
        id: 'profile',
        title: 'Profile Information',
        fields: [
          const FormFieldModel(
            id: 'firstName',
            name: 'firstName',
            type: FormFieldType.text,
            label: 'First Name',
            required: true,
          ),
          const FormFieldModel(
            id: 'lastName',
            name: 'lastName',
            type: FormFieldType.text,
            label: 'Last Name',
            required: true,
          ),
          FormFieldModel(
            id: 'birthDate',
            name: 'birthDate',
            type: FormFieldType.date,
            label: 'Date of Birth',
            required: true,
            options: FormFieldOptions(
              maxDate: DateTime.now(),
            ),
          ),
          const FormFieldModel(
            id: 'country',
            name: 'country',
            type: FormFieldType.select,
            label: 'Country',
            required: true,
            options: FormFieldOptions(
              options: [
                SelectOption(value: 'us', label: 'United States'),
                SelectOption(value: 'uk', label: 'United Kingdom'),
                SelectOption(value: 'ca', label: 'Canada'),
                SelectOption(value: 'au', label: 'Australia'),
              ],
            ),
          ),
        ],
      ),
      FormSection(
        id: 'preferences',
        title: 'Preferences',
        collapsible: true,
        fields: [
          const FormFieldModel(
            id: 'newsletter',
            name: 'newsletter',
            type: FormFieldType.checkbox,
            label: 'Subscribe to newsletter',
            defaultValue: true,
          ),
          const FormFieldModel(
            id: 'notifications',
            name: 'notifications',
            type: FormFieldType.multiSelect,
            label: 'Notification Preferences',
            options: FormFieldOptions(
              options: [
                SelectOption(value: 'email', label: 'Email'),
                SelectOption(value: 'sms', label: 'SMS'),
                SelectOption(value: 'push', label: 'Push Notifications'),
              ],
            ),
          ),
          const FormFieldModel(
            id: 'terms',
            name: 'terms',
            type: FormFieldType.checkbox,
            label: 'I agree to the Terms of Service and Privacy Policy',
            required: true,
            validators: [
              ValidationRule(
                type: ValidationRuleType.required,
                message: 'You must agree to the terms',
              ),
            ],
          ),
        ],
      ),
    ],
    actions: FormActions(
      submitLabel: 'Create Account',
      showCancel: false,
    ),
    settings: const FormSettings(
      validateOnBlur: true,
      showProgressIndicator: true,
      focusFirstError: true,
    ),
  );
}

FormSchema _createCheckoutFormSchema() {
  return FormSchema(
    id: 'checkout',
    name: 'Checkout',
    layoutType: FormLayoutType.stepper,
    sections: [
      FormSection(
        id: 'shipping',
        title: 'Shipping Address',
        icon: Icons.local_shipping,
        fields: [
          const FormFieldModel(
            id: 'fullName',
            name: 'fullName',
            type: FormFieldType.text,
            label: 'Full Name',
            required: true,
          ),
          const FormFieldModel(
            id: 'streetAddress',
            name: 'streetAddress',
            type: FormFieldType.text,
            label: 'Street Address',
            required: true,
          ),
          const FormFieldModel(
            id: 'city',
            name: 'city',
            type: FormFieldType.text,
            label: 'City',
            required: true,
          ),
          const FormFieldModel(
            id: 'state',
            name: 'state',
            type: FormFieldType.select,
            label: 'State',
            required: true,
          ),
          const FormFieldModel(
            id: 'zipCode',
            name: 'zipCode',
            type: FormFieldType.text,
            label: 'ZIP Code',
            required: true,
            validators: [
              ValidationRule(
                type: ValidationRuleType.pattern,
                value: r'^\d{5}(-\d{4})?$',
                message: 'Invalid ZIP code',
              ),
            ],
          ),
        ],
      ),
      FormSection(
        id: 'payment',
        title: 'Payment Method',
        icon: Icons.payment,
        fields: [
          const FormFieldModel(
            id: 'cardNumber',
            name: 'cardNumber',
            type: FormFieldType.text,
            label: 'Card Number',
            required: true,
            validators: [
              ValidationRule(
                type: ValidationRuleType.creditCard,
              ),
            ],
          ),
          const FormFieldModel(
            id: 'cardholderName',
            name: 'cardholderName',
            type: FormFieldType.text,
            label: 'Cardholder Name',
            required: true,
          ),
          const FormFieldModel(
            id: 'expiryDate',
            name: 'expiryDate',
            type: FormFieldType.text,
            label: 'Expiry Date',
            placeholder: 'MM/YY',
            required: true,
            validators: [
              ValidationRule(
                type: ValidationRuleType.pattern,
                value: r'^(0[1-9]|1[0-2])\/\d{2}$',
                message: 'Invalid expiry date format',
              ),
            ],
          ),
          const FormFieldModel(
            id: 'cvv',
            name: 'cvv',
            type: FormFieldType.text,
            label: 'CVV',
            required: true,
            validators: [
              ValidationRule(
                type: ValidationRuleType.pattern,
                value: r'^\d{3,4}$',
                message: 'Invalid CVV',
              ),
            ],
          ),
        ],
      ),
      FormSection(
        id: 'review',
        title: 'Review Order',
        icon: Icons.check_circle,
        fields: [
          const FormFieldModel(
            id: 'promoCode',
            name: 'promoCode',
            type: FormFieldType.text,
            label: 'Promo Code',
            placeholder: 'Enter promo code',
          ),
          const FormFieldModel(
            id: 'giftMessage',
            name: 'giftMessage',
            type: FormFieldType.multiline,
            label: 'Gift Message (Optional)',
            options: FormFieldOptions(
              maxLines: 5,
            ),
          ),
        ],
      ),
    ],
    actions: FormActions(
      submitLabel: 'Place Order',
      showCancel: false,
    ),
    settings: const FormSettings(
      showProgressIndicator: true,
      disableOnSubmit: true,
    ),
  );
}

FormSchema _createSurveyFormSchema() {
  return FormSchema(
    id: 'survey',
    name: 'Customer Satisfaction Survey',
    layoutType: FormLayoutType.vertical,
    sections: [
      FormSection(
        id: 'rating',
        title: 'Overall Rating',
        fields: [
          const FormFieldModel(
            id: 'overallRating',
            name: 'overallRating',
            type: FormFieldType.rating,
            label: 'How would you rate your overall experience?',
            required: true,
          ),
          const FormFieldModel(
            id: 'recommend',
            name: 'recommend',
            type: FormFieldType.radio,
            label: 'Would you recommend us to others?',
            required: true,
            options: FormFieldOptions(
              options: [
                SelectOption(value: 'yes', label: 'Yes'),
                SelectOption(value: 'no', label: 'No'),
                SelectOption(value: 'maybe', label: 'Maybe'),
              ],
            ),
          ),
        ],
      ),
      FormSection(
        id: 'feedback',
        title: 'Detailed Feedback',
        fields: [
          const FormFieldModel(
            id: 'aspects',
            name: 'aspects',
            type: FormFieldType.multiSelect,
            label: 'What aspects did you like?',
            options: FormFieldOptions(
              options: [
                SelectOption(value: 'quality', label: 'Product Quality'),
                SelectOption(value: 'price', label: 'Price'),
                SelectOption(value: 'service', label: 'Customer Service'),
                SelectOption(value: 'delivery', label: 'Delivery'),
                SelectOption(value: 'website', label: 'Website Experience'),
              ],
            ),
          ),
          const FormFieldModel(
            id: 'improvements',
            name: 'improvements',
            type: FormFieldType.multiline,
            label: 'What could we improve?',
            options: FormFieldOptions(
              minLines: 3,
              maxLines: 10,
            ),
          ),
        ],
      ),
    ],
    actions: FormActions(
      submitLabel: 'Submit Survey',
      showCancel: false,
    ),
  );
}

FormSchema _createJobApplicationFormSchema() {
  return FormSchema(
    id: 'job_application',
    name: 'Job Application',
    layoutType: FormLayoutType.tabbed,
    sections: [
      FormSection(
        id: 'personal',
        title: 'Personal Information',
        icon: Icons.person,
        fields: [
          const FormFieldModel(
            id: 'fullName',
            name: 'fullName',
            type: FormFieldType.text,
            label: 'Full Name',
            required: true,
          ),
          const FormFieldModel(
            id: 'email',
            name: 'email',
            type: FormFieldType.email,
            label: 'Email Address',
            required: true,
          ),
          const FormFieldModel(
            id: 'phone',
            name: 'phone',
            type: FormFieldType.phone,
            label: 'Phone Number',
            required: true,
          ),
          const FormFieldModel(
            id: 'location',
            name: 'location',
            type: FormFieldType.location,
            label: 'Current Location',
            required: true,
          ),
        ],
      ),
      FormSection(
        id: 'experience',
        title: 'Experience',
        icon: Icons.work,
        fields: [
          const FormFieldModel(
            id: 'resume',
            name: 'resume',
            type: FormFieldType.file,
            label: 'Resume',
            required: true,
            options: FormFieldOptions(
              acceptedFileTypes: ['pdf', 'doc', 'docx'],
              maxFileSize: 5 * 1024 * 1024, // 5MB
            ),
          ),
          const FormFieldModel(
            id: 'coverLetter',
            name: 'coverLetter',
            type: FormFieldType.file,
            label: 'Cover Letter',
            options: FormFieldOptions(
              acceptedFileTypes: ['pdf', 'doc', 'docx'],
              maxFileSize: 5 * 1024 * 1024, // 5MB
            ),
          ),
          const FormFieldModel(
            id: 'yearsExperience',
            name: 'yearsExperience',
            type: FormFieldType.number,
            label: 'Years of Experience',
            required: true,
            options: FormFieldOptions(
              min: 0,
              max: 50,
              step: 1,
            ),
          ),
          const FormFieldModel(
            id: 'skills',
            name: 'skills',
            type: FormFieldType.tags,
            label: 'Skills',
            required: true,
            helperText: 'Add your relevant skills',
          ),
        ],
      ),
      FormSection(
        id: 'additional',
        title: 'Additional Information',
        icon: Icons.info,
        fields: [
          const FormFieldModel(
            id: 'portfolio',
            name: 'portfolio',
            type: FormFieldType.url,
            label: 'Portfolio URL',
            validators: [
              ValidationRule(
                type: ValidationRuleType.url,
              ),
            ],
          ),
          FormFieldModel(
            id: 'availability',
            name: 'availability',
            type: FormFieldType.date,
            label: 'Available Start Date',
            required: true,
            options: FormFieldOptions(
              minDate: DateTime.now(),
            ),
          ),
          const FormFieldModel(
            id: 'salaryExpectation',
            name: 'salaryExpectation',
            type: FormFieldType.range,
            label: 'Salary Expectation',
            options: FormFieldOptions(
              min: 30000,
              max: 200000,
              step: 5000,
            ),
          ),
          const FormFieldModel(
            id: 'additionalInfo',
            name: 'additionalInfo',
            type: FormFieldType.richText,
            label: 'Additional Information',
            helperText: 'Tell us anything else you\'d like us to know',
          ),
        ],
      ),
    ],
    actions: FormActions(
      submitLabel: 'Submit Application',
      showSaveAsDraft: true,
    ),
    settings: const FormSettings(
      autoSave: true,
      autoSaveInterval: 60,
      persistData: true,
      persistKey: 'job_application_draft',
    ),
  );
}