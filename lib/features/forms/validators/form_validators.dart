import 'package:flutter/material.dart';
import '../models/form_models.dart';

class FormValidators {
  // Required validator
  static ValidationResult required(dynamic value, {String? message}) {
    if (value == null || 
        (value is String && value.isEmpty) ||
        (value is List && value.isEmpty)) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'This field is required',
      );
    }
    return const ValidationResult(isValid: true);
  }

  // Email validator
  static ValidationResult email(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return const ValidationResult(isValid: true);
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Please enter a valid email address',
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  // URL validator
  static ValidationResult url(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return const ValidationResult(isValid: true);
    }
    
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    
    if (!urlRegex.hasMatch(value)) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Please enter a valid URL',
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  // Phone validator
  static ValidationResult phone(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return const ValidationResult(isValid: true);
    }
    
    final phoneRegex = RegExp(
      r'^\+?[1-9]\d{1,14}$',
    );
    
    if (!phoneRegex.hasMatch(value.replaceAll(RegExp(r'[\s\-\(\)]'), ''))) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Please enter a valid phone number',
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  // Length validators
  static ValidationResult minLength(String? value, int min, {String? message}) {
    if (value == null || value.isEmpty) {
      return const ValidationResult(isValid: true);
    }
    
    if (value.length < min) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Must be at least $min characters',
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  static ValidationResult maxLength(String? value, int max, {String? message}) {
    if (value == null || value.isEmpty) {
      return const ValidationResult(isValid: true);
    }
    
    if (value.length > max) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Must be no more than $max characters',
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  // Pattern validator
  static ValidationResult pattern(String? value, RegExp pattern, {String? message}) {
    if (value == null || value.isEmpty) {
      return const ValidationResult(isValid: true);
    }
    
    if (!pattern.hasMatch(value)) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Invalid format',
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  // Numeric validators
  static ValidationResult numeric(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return const ValidationResult(isValid: true);
    }
    
    if (double.tryParse(value) == null) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Must be a valid number',
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  static ValidationResult minValue(dynamic value, num min, {String? message}) {
    if (value == null) {
      return const ValidationResult(isValid: true);
    }
    
    final numValue = value is num ? value : double.tryParse(value.toString());
    
    if (numValue == null || numValue < min) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Must be at least $min',
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  static ValidationResult maxValue(dynamic value, num max, {String? message}) {
    if (value == null) {
      return const ValidationResult(isValid: true);
    }
    
    final numValue = value is num ? value : double.tryParse(value.toString());
    
    if (numValue == null || numValue > max) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Must be no more than $max',
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  // Date validators
  static ValidationResult dateAfter(DateTime? value, DateTime after, {String? message}) {
    if (value == null) {
      return const ValidationResult(isValid: true);
    }
    
    if (value.isBefore(after) || value.isAtSameMomentAs(after)) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Must be after ${after.toLocal()}',
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  static ValidationResult dateBefore(DateTime? value, DateTime before, {String? message}) {
    if (value == null) {
      return const ValidationResult(isValid: true);
    }
    
    if (value.isAfter(before) || value.isAtSameMomentAs(before)) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Must be before ${before.toLocal()}',
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  // Credit card validator
  static ValidationResult creditCard(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return const ValidationResult(isValid: true);
    }
    
    // Remove spaces and dashes
    final cleanValue = value.replaceAll(RegExp(r'[\s\-]'), '');
    
    // Check if it's a valid number
    if (!RegExp(r'^\d+$').hasMatch(cleanValue)) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Invalid credit card number',
      );
    }
    
    // Luhn algorithm
    var sum = 0;
    var isEven = false;
    
    for (var i = cleanValue.length - 1; i >= 0; i--) {
      var digit = int.parse(cleanValue[i]);
      
      if (isEven) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }
      
      sum += digit;
      isEven = !isEven;
    }
    
    if (sum % 10 != 0) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Invalid credit card number',
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  // Password strength validator
  static ValidationResult passwordStrength(String? value, {
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumbers = true,
    bool requireSpecialChars = true,
    int minLength = 8,
    String? message,
  }) {
    if (value == null || value.isEmpty) {
      return const ValidationResult(isValid: true);
    }
    
    final errors = <String>[];
    
    if (value.length < minLength) {
      errors.add('at least $minLength characters');
    }
    
    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      errors.add('an uppercase letter');
    }
    
    if (requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
      errors.add('a lowercase letter');
    }
    
    if (requireNumbers && !value.contains(RegExp(r'[0-9]'))) {
      errors.add('a number');
    }
    
    if (requireSpecialChars && !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      errors.add('a special character');
    }
    
    if (errors.isNotEmpty) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Password must contain ${errors.join(', ')}',
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  // Match validator (for password confirmation)
  static ValidationResult match(dynamic value, dynamic matchValue, {String? message}) {
    if (value != matchValue) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Values do not match',
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  // File validators
  static ValidationResult fileSize(List<FileUploadModel>? files, int maxSizeInBytes, {String? message}) {
    if (files == null || files.isEmpty) {
      return const ValidationResult(isValid: true);
    }
    
    for (final file in files) {
      if (file.size > maxSizeInBytes) {
        return ValidationResult(
          isValid: false,
          message: message ?? 'File size must not exceed ${_formatBytes(maxSizeInBytes)}',
        );
      }
    }
    
    return const ValidationResult(isValid: true);
  }

  static ValidationResult fileType(List<FileUploadModel>? files, List<String> allowedTypes, {String? message}) {
    if (files == null || files.isEmpty) {
      return const ValidationResult(isValid: true);
    }
    
    for (final file in files) {
      final extension = file.name.split('.').last.toLowerCase();
      if (!allowedTypes.contains(extension)) {
        return ValidationResult(
          isValid: false,
          message: message ?? 'Allowed file types: ${allowedTypes.join(', ')}',
        );
      }
    }
    
    return const ValidationResult(isValid: true);
  }

  // Helper method to format bytes
  static String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }
}

// Async validators
class AsyncValidators {
  // Check if username is available
  static Future<ValidationResult> checkUsernameAvailability(String? username) async {
    if (username == null || username.isEmpty) {
      return const ValidationResult(isValid: true);
    }
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock unavailable usernames
    final unavailableUsernames = ['admin', 'test', 'user', 'demo'];
    
    if (unavailableUsernames.contains(username.toLowerCase())) {
      return ValidationResult(
        isValid: false,
        message: 'Username "$username" is already taken',
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  // Check if email is registered
  static Future<ValidationResult> checkEmailAvailability(String? email) async {
    if (email == null || email.isEmpty) {
      return const ValidationResult(isValid: true);
    }
    
    // First check if it's a valid email
    final emailValidation = FormValidators.email(email);
    if (!emailValidation.isValid) {
      return emailValidation;
    }
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock registered emails
    final registeredEmails = ['test@example.com', 'user@example.com'];
    
    if (registeredEmails.contains(email.toLowerCase())) {
      return ValidationResult(
        isValid: false,
        message: 'Email "$email" is already registered',
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  // Validate address
  static Future<ValidationResult> validateAddress(Map<String, dynamic>? address) async {
    if (address == null || address.isEmpty) {
      return const ValidationResult(isValid: true);
    }
    
    // Simulate API call to address validation service
    await Future.delayed(const Duration(seconds: 1));
    
    // Check required fields
    final requiredFields = ['street', 'city', 'state', 'zipCode'];
    final missingFields = <String>[];
    
    for (final field in requiredFields) {
      if (address[field] == null || address[field].toString().isEmpty) {
        missingFields.add(field);
      }
    }
    
    if (missingFields.isNotEmpty) {
      return ValidationResult(
        isValid: false,
        message: 'Missing required fields: ${missingFields.join(', ')}',
      );
    }
    
    // Mock invalid zip codes
    final zipCode = address['zipCode'].toString();
    if (zipCode.length != 5 || int.tryParse(zipCode) == null) {
      return const ValidationResult(
        isValid: false,
        message: 'Invalid zip code',
      );
    }
    
    return const ValidationResult(isValid: true);
  }
}

// Conditional validators
class ConditionalValidators {
  // Validate if another field has a specific value
  static ValidationResult requiredIf(
    dynamic value,
    Map<String, dynamic> formData,
    String conditionField,
    dynamic conditionValue, {
    String? message,
  }) {
    if (formData[conditionField] == conditionValue) {
      return FormValidators.required(value, message: message);
    }
    
    return const ValidationResult(isValid: true);
  }

  // Validate based on multiple conditions
  static ValidationResult requiredIfAny(
    dynamic value,
    Map<String, dynamic> formData,
    Map<String, dynamic> conditions, {
    String? message,
  }) {
    for (final entry in conditions.entries) {
      if (formData[entry.key] == entry.value) {
        return FormValidators.required(value, message: message);
      }
    }
    
    return const ValidationResult(isValid: true);
  }

  // Validate based on all conditions being met
  static ValidationResult requiredIfAll(
    dynamic value,
    Map<String, dynamic> formData,
    Map<String, dynamic> conditions, {
    String? message,
  }) {
    bool allConditionsMet = true;
    
    for (final entry in conditions.entries) {
      if (formData[entry.key] != entry.value) {
        allConditionsMet = false;
        break;
      }
    }
    
    if (allConditionsMet) {
      return FormValidators.required(value, message: message);
    }
    
    return const ValidationResult(isValid: true);
  }
}

// Cross-field validators
class CrossFieldValidators {
  // Date range validation
  static ValidationResult dateRange(
    Map<String, dynamic> formData,
    String startDateField,
    String endDateField, {
    String? message,
  }) {
    final startDate = formData[startDateField] as DateTime?;
    final endDate = formData[endDateField] as DateTime?;
    
    if (startDate == null || endDate == null) {
      return const ValidationResult(isValid: true);
    }
    
    if (startDate.isAfter(endDate)) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Start date must be before end date',
        fieldErrors: {
          startDateField: 'Must be before end date',
          endDateField: 'Must be after start date',
        },
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  // Number range validation
  static ValidationResult numberRange(
    Map<String, dynamic> formData,
    String minField,
    String maxField, {
    String? message,
  }) {
    final minValue = formData[minField] as num?;
    final maxValue = formData[maxField] as num?;
    
    if (minValue == null || maxValue == null) {
      return const ValidationResult(isValid: true);
    }
    
    if (minValue > maxValue) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Minimum value must be less than maximum value',
        fieldErrors: {
          minField: 'Must be less than maximum',
          maxField: 'Must be greater than minimum',
        },
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  // Sum validation
  static ValidationResult sum(
    Map<String, dynamic> formData,
    List<String> fields,
    num expectedSum, {
    String? message,
  }) {
    num actualSum = 0;
    
    for (final field in fields) {
      final value = formData[field];
      if (value is num) {
        actualSum += value;
      }
    }
    
    if (actualSum != expectedSum) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Sum must equal $expectedSum (current: $actualSum)',
      );
    }
    
    return const ValidationResult(isValid: true);
  }

  // Percentage validation
  static ValidationResult percentage(
    Map<String, dynamic> formData,
    List<String> fields, {
    num total = 100,
    String? message,
  }) {
    num actualTotal = 0;
    
    for (final field in fields) {
      final value = formData[field];
      if (value is num) {
        actualTotal += value;
      }
    }
    
    if (actualTotal != total) {
      return ValidationResult(
        isValid: false,
        message: message ?? 'Total must equal $total% (current: $actualTotal%)',
      );
    }
    
    return const ValidationResult(isValid: true);
  }
}