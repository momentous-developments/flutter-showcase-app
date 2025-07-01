import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/form_models.dart';
import '../providers/form_providers.dart';
import '../validators/form_validators.dart';

class FormValidationShowcase extends ConsumerStatefulWidget {
  const FormValidationShowcase({super.key});

  @override
  ConsumerState<FormValidationShowcase> createState() => _FormValidationShowcaseState();
}

class _FormValidationShowcaseState extends ConsumerState<FormValidationShowcase> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _values = {};
  final Map<String, String> _errors = {};
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSectionTitle('Basic Validation'),
        const SizedBox(height: 16),
        _buildBasicValidationSection(),
        
        const SizedBox(height: 32),
        _buildSectionTitle('Pattern Validation'),
        const SizedBox(height: 16),
        _buildPatternValidationSection(),
        
        const SizedBox(height: 32),
        _buildSectionTitle('Conditional Validation'),
        const SizedBox(height: 16),
        _buildConditionalValidationSection(),
        
        const SizedBox(height: 32),
        _buildSectionTitle('Cross-Field Validation'),
        const SizedBox(height: 16),
        _buildCrossFieldValidationSection(),
        
        const SizedBox(height: 32),
        _buildSectionTitle('Async Validation'),
        const SizedBox(height: 16),
        _buildAsyncValidationSection(),
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
  
  Widget _buildBasicValidationSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Required Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Required Field *',
                  border: OutlineInputBorder(),
                  helperText: 'This field is required',
                ),
                validator: (value) {
                  final result = FormValidators.required(value);
                  return result.isValid ? null : result.message;
                },
                onChanged: (value) => _values['required'] = value,
              ),
              
              const SizedBox(height: 16),
              
              // Min Length
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Minimum Length (5 chars)',
                  border: OutlineInputBorder(),
                  helperText: 'Must be at least 5 characters',
                ),
                validator: (value) {
                  final result = FormValidators.minLength(value, 5);
                  return result.isValid ? null : result.message;
                },
                onChanged: (value) => _values['minLength'] = value,
              ),
              
              const SizedBox(height: 16),
              
              // Max Length
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Maximum Length (10 chars)',
                  border: OutlineInputBorder(),
                  helperText: 'Must be no more than 10 characters',
                  counterText: '',
                ),
                maxLength: 10,
                validator: (value) {
                  final result = FormValidators.maxLength(value, 10);
                  return result.isValid ? null : result.message;
                },
                onChanged: (value) => _values['maxLength'] = value,
              ),
              
              const SizedBox(height: 16),
              
              // Numeric
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Numeric Value',
                  border: OutlineInputBorder(),
                  helperText: 'Must be a valid number',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final result = FormValidators.numeric(value);
                  return result.isValid ? null : result.message;
                },
                onChanged: (value) => _values['numeric'] = value,
              ),
              
              const SizedBox(height: 16),
              
              // Min/Max Value
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Age (18-65)',
                  border: OutlineInputBorder(),
                  helperText: 'Must be between 18 and 65',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  var result = FormValidators.numeric(value);
                  if (!result.isValid) return result.message;
                  
                  result = FormValidators.minValue(value, 18);
                  if (!result.isValid) return result.message;
                  
                  result = FormValidators.maxValue(value, 65);
                  return result.isValid ? null : result.message;
                },
                onChanged: (value) => _values['age'] = value,
              ),
              
              const SizedBox(height: 24),
              
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Basic validation passed!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                child: const Text('Validate Basic Fields'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildPatternValidationSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email Validation
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
                helperText: 'Must be a valid email address',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                final result = FormValidators.email(value);
                return result.isValid ? null : result.message;
              },
              onChanged: (value) => _values['email'] = value,
            ),
            
            const SizedBox(height: 16),
            
            // URL Validation
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Website URL',
                border: OutlineInputBorder(),
                helperText: 'Must be a valid URL',
                prefixIcon: Icon(Icons.link),
              ),
              keyboardType: TextInputType.url,
              validator: (value) {
                final result = FormValidators.url(value);
                return result.isValid ? null : result.message;
              },
              onChanged: (value) => _values['url'] = value,
            ),
            
            const SizedBox(height: 16),
            
            // Phone Validation
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                helperText: 'Must be a valid phone number',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                final result = FormValidators.phone(value);
                return result.isValid ? null : result.message;
              },
              onChanged: (value) => _values['phone'] = value,
            ),
            
            const SizedBox(height: 16),
            
            // Credit Card Validation
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Credit Card Number',
                border: OutlineInputBorder(),
                helperText: 'Must be a valid credit card number',
                prefixIcon: Icon(Icons.credit_card),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                final result = FormValidators.creditCard(value);
                return result.isValid ? null : result.message;
              },
              onChanged: (value) => _values['creditCard'] = value,
            ),
            
            const SizedBox(height: 16),
            
            // Password Strength
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Strong Password',
                border: OutlineInputBorder(),
                helperText: 'Must contain uppercase, lowercase, number, and special character',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              validator: (value) {
                final result = FormValidators.passwordStrength(value);
                return result.isValid ? null : result.message;
              },
              onChanged: (value) => _values['password'] = value,
            ),
            
            const SizedBox(height: 16),
            
            // Custom Pattern
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Username (alphanumeric + underscore)',
                border: OutlineInputBorder(),
                helperText: 'Only letters, numbers, and underscores allowed',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                final result = FormValidators.pattern(
                  value,
                  RegExp(r'^[a-zA-Z0-9_]+$'),
                  message: 'Username can only contain letters, numbers, and underscores',
                );
                return result.isValid ? null : result.message;
              },
              onChanged: (value) => _values['username'] = value,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildConditionalValidationSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Enable shipping address
            SwitchListTile(
              title: const Text('Ship to different address'),
              value: _values['shipToDifferent'] ?? false,
              onChanged: (value) {
                setState(() {
                  _values['shipToDifferent'] = value;
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Shipping address (required if enabled)
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Shipping Address ${_values['shipToDifferent'] == true ? '*' : ''}',
                border: const OutlineInputBorder(),
                helperText: 'Required if shipping to different address',
                enabled: _values['shipToDifferent'] ?? false,
              ),
              validator: (value) {
                final result = ConditionalValidators.requiredIf(
                  value,
                  _values,
                  'shipToDifferent',
                  true,
                  message: 'Shipping address is required',
                );
                return result.isValid ? null : result.message;
              },
              onChanged: (value) => _values['shippingAddress'] = value,
            ),
            
            const SizedBox(height: 24),
            
            // Account type selection
            DropdownButtonFormField<String>(
              value: _values['accountType'],
              decoration: const InputDecoration(
                labelText: 'Account Type',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'personal', child: Text('Personal')),
                DropdownMenuItem(value: 'business', child: Text('Business')),
              ],
              onChanged: (value) {
                setState(() {
                  _values['accountType'] = value;
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Company name (required for business accounts)
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Company Name ${_values['accountType'] == 'business' ? '*' : ''}',
                border: const OutlineInputBorder(),
                helperText: 'Required for business accounts',
                enabled: _values['accountType'] == 'business',
              ),
              validator: (value) {
                final result = ConditionalValidators.requiredIf(
                  value,
                  _values,
                  'accountType',
                  'business',
                  message: 'Company name is required for business accounts',
                );
                return result.isValid ? null : result.message;
              },
              onChanged: (value) => _values['companyName'] = value,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCrossFieldValidationSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Password
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              onChanged: (value) => _values['newPassword'] = value,
            ),
            
            const SizedBox(height: 16),
            
            // Confirm Password
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
              validator: (value) {
                final result = FormValidators.match(
                  value,
                  _values['newPassword'],
                  message: 'Passwords do not match',
                );
                return result.isValid ? null : result.message;
              },
              onChanged: (value) => _values['confirmPassword'] = value,
            ),
            
            const SizedBox(height: 24),
            
            // Date Range
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Start Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (date != null) {
                        setState(() {
                          _values['startDate'] = date;
                        });
                      }
                    },
                    controller: TextEditingController(
                      text: _values['startDate'] != null
                          ? '${_values['startDate'].toLocal()}'.split(' ')[0]
                          : '',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'End Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _values['startDate'] ?? DateTime.now(),
                        firstDate: _values['startDate'] ?? DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (date != null) {
                        setState(() {
                          _values['endDate'] = date;
                        });
                      }
                    },
                    controller: TextEditingController(
                      text: _values['endDate'] != null
                          ? '${_values['endDate'].toLocal()}'.split(' ')[0]
                          : '',
                    ),
                    validator: (value) {
                      if (_values['startDate'] != null && _values['endDate'] != null) {
                        final result = CrossFieldValidators.dateRange(
                          _values,
                          'startDate',
                          'endDate',
                        );
                        return result.isValid ? null : 'End date must be after start date';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Percentage Allocation
            Text(
              'Budget Allocation (must total 100%)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Marketing %',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(() {
                      _values['marketingPercent'] = num.tryParse(value) ?? 0;
                    }),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Development %',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(() {
                      _values['developmentPercent'] = num.tryParse(value) ?? 0;
                    }),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Operations %',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(() {
                      _values['operationsPercent'] = num.tryParse(value) ?? 0;
                    }),
                    validator: (value) {
                      final result = CrossFieldValidators.percentage(
                        _values,
                        ['marketingPercent', 'developmentPercent', 'operationsPercent'],
                      );
                      return result.isValid ? null : result.message;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAsyncValidationSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'These fields validate against a mock API',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            
            // Username availability
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: const OutlineInputBorder(),
                helperText: 'Try: admin, test, user (unavailable)',
                prefixIcon: const Icon(Icons.person),
                suffixIcon: _values['checkingUsername'] == true
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : null,
              ),
              validator: (value) {
                if (_errors['username'] != null) {
                  return _errors['username'];
                }
                return null;
              },
              onChanged: (value) async {
                _values['username'] = value;
                if (value != null && value.length >= 3) {
                  setState(() {
                    _values['checkingUsername'] = true;
                    _errors.remove('username');
                  });
                  
                  final result = await AsyncValidators.checkUsernameAvailability(value);
                  
                  setState(() {
                    _values['checkingUsername'] = false;
                    if (!result.isValid) {
                      _errors['username'] = result.message!;
                    } else {
                      _errors.remove('username');
                    }
                  });
                }
              },
            ),
            
            const SizedBox(height: 16),
            
            // Email availability
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: const OutlineInputBorder(),
                helperText: 'Try: test@example.com (unavailable)',
                prefixIcon: const Icon(Icons.email),
                suffixIcon: _values['checkingEmail'] == true
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : null,
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (_errors['email'] != null) {
                  return _errors['email'];
                }
                return null;
              },
              onChanged: (value) async {
                _values['email'] = value;
                if (value != null && value.contains('@')) {
                  setState(() {
                    _values['checkingEmail'] = true;
                    _errors.remove('email');
                  });
                  
                  final result = await AsyncValidators.checkEmailAvailability(value);
                  
                  setState(() {
                    _values['checkingEmail'] = false;
                    if (!result.isValid) {
                      _errors['email'] = result.message!;
                    } else {
                      _errors.remove('email');
                    }
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}