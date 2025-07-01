import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/form_models.dart';
import '../../providers/form_providers.dart';

class TabbedFormLayout extends ConsumerStatefulWidget {
  const TabbedFormLayout({super.key});

  @override
  ConsumerState<TabbedFormLayout> createState() => _TabbedFormLayoutState();
}

class _TabbedFormLayoutState extends ConsumerState<TabbedFormLayout>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(formStateProvider('tabbed_form'));
    final formNotifier = ref.read(formStateProvider('tabbed_form').notifier);
    
    return Column(
      children: [
        // Tab Bar
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Personal Info', icon: Icon(Icons.person)),
            Tab(text: 'Account', icon: Icon(Icons.account_circle)),
            Tab(text: 'Preferences', icon: Icon(Icons.settings)),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Tab Content
        SizedBox(
          height: 400,
          child: TabBarView(
            controller: _tabController,
            children: [
              // Personal Info Tab
              _buildPersonalInfoTab(formState, formNotifier),
              
              // Account Tab
              _buildAccountTab(formState, formNotifier),
              
              // Preferences Tab
              _buildPreferencesTab(formState, formNotifier),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Form Actions
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (_tabController.index > 0)
              TextButton(
                onPressed: () {
                  _tabController.animateTo(_tabController.index - 1);
                },
                child: const Text('Previous'),
              ),
            const SizedBox(width: 8),
            if (_tabController.index < 2)
              FilledButton(
                onPressed: () async {
                  // Validate current tab before proceeding
                  final isValid = await _validateCurrentTab(formNotifier);
                  if (isValid) {
                    _tabController.animateTo(_tabController.index + 1);
                  }
                },
                child: const Text('Next'),
              )
            else
              FilledButton(
                onPressed: formState.isSubmitting
                    ? null
                    : () async {
                        await formNotifier.submitForm((values) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Form submitted successfully!'),
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
    );
  }
  
  Widget _buildPersonalInfoTab(
    FormStateData formState,
    FormStateNotifier formNotifier,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: formState.values['firstName'],
            decoration: const InputDecoration(
              labelText: 'First Name',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => formNotifier.updateFieldValue('firstName', value),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: formState.values['lastName'],
            decoration: const InputDecoration(
              labelText: 'Last Name',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => formNotifier.updateFieldValue('lastName', value),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: formState.values['email'],
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => formNotifier.updateFieldValue('email', value),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: formState.values['phone'],
            decoration: const InputDecoration(
              labelText: 'Phone',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => formNotifier.updateFieldValue('phone', value),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAccountTab(
    FormStateData formState,
    FormStateNotifier formNotifier,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: formState.values['username'],
            decoration: const InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => formNotifier.updateFieldValue('username', value),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: formState.values['password'],
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => formNotifier.updateFieldValue('password', value),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: formState.values['confirmPassword'],
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => formNotifier.updateFieldValue('confirmPassword', value),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: formState.values['accountType'],
            decoration: const InputDecoration(
              labelText: 'Account Type',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'personal', child: Text('Personal')),
              DropdownMenuItem(value: 'business', child: Text('Business')),
              DropdownMenuItem(value: 'enterprise', child: Text('Enterprise')),
            ],
            onChanged: (value) => formNotifier.updateFieldValue('accountType', value),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPreferencesTab(
    FormStateData formState,
    FormStateNotifier formNotifier,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            title: const Text('Email Notifications'),
            subtitle: const Text('Receive email updates about your account'),
            value: formState.values['emailNotifications'] ?? false,
            onChanged: (value) => formNotifier.updateFieldValue('emailNotifications', value),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('SMS Notifications'),
            subtitle: const Text('Receive SMS updates about your account'),
            value: formState.values['smsNotifications'] ?? false,
            onChanged: (value) => formNotifier.updateFieldValue('smsNotifications', value),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Marketing Emails'),
            subtitle: const Text('Receive promotional offers and updates'),
            value: formState.values['marketingEmails'] ?? false,
            onChanged: (value) => formNotifier.updateFieldValue('marketingEmails', value),
          ),
          const Divider(),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: formState.values['language'],
            decoration: const InputDecoration(
              labelText: 'Language',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'en', child: Text('English')),
              DropdownMenuItem(value: 'es', child: Text('Spanish')),
              DropdownMenuItem(value: 'fr', child: Text('French')),
              DropdownMenuItem(value: 'de', child: Text('German')),
            ],
            onChanged: (value) => formNotifier.updateFieldValue('language', value),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: formState.values['timezone'],
            decoration: const InputDecoration(
              labelText: 'Timezone',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'UTC', child: Text('UTC')),
              DropdownMenuItem(value: 'EST', child: Text('Eastern Time')),
              DropdownMenuItem(value: 'CST', child: Text('Central Time')),
              DropdownMenuItem(value: 'PST', child: Text('Pacific Time')),
            ],
            onChanged: (value) => formNotifier.updateFieldValue('timezone', value),
          ),
        ],
      ),
    );
  }
  
  Future<bool> _validateCurrentTab(FormStateNotifier formNotifier) async {
    // Add validation logic for each tab
    switch (_tabController.index) {
      case 0:
        // Validate personal info
        return true;
      case 1:
        // Validate account info
        return true;
      case 2:
        // Validate preferences
        return true;
      default:
        return true;
    }
  }
}