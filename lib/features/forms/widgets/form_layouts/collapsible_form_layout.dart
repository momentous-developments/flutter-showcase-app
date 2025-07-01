import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/form_models.dart';
import '../../providers/form_providers.dart';

class CollapsibleFormLayout extends ConsumerStatefulWidget {
  const CollapsibleFormLayout({super.key});

  @override
  ConsumerState<CollapsibleFormLayout> createState() => _CollapsibleFormLayoutState();
}

class _CollapsibleFormLayoutState extends ConsumerState<CollapsibleFormLayout> {
  final Map<String, bool> _expandedSections = {
    'personal': true,
    'contact': false,
    'employment': false,
    'emergency': false,
  };
  
  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(formStateProvider('collapsible_form'));
    final formNotifier = ref.read(formStateProvider('collapsible_form').notifier);
    
    return Column(
      children: [
        // Personal Information
        _buildExpansionPanel(
          key: 'personal',
          title: 'Personal Information',
          icon: Icons.person,
          isRequired: true,
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
            DropdownButtonFormField<String>(
              value: formState.values['gender'],
              decoration: const InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'male', child: Text('Male')),
                DropdownMenuItem(value: 'female', child: Text('Female')),
                DropdownMenuItem(value: 'other', child: Text('Other')),
              ],
              onChanged: (value) => formNotifier.updateFieldValue('gender', value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: formState.values['dateOfBirth'],
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onChanged: (value) => formNotifier.updateFieldValue('dateOfBirth', value),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        // Contact Information
        _buildExpansionPanel(
          key: 'contact',
          title: 'Contact Information',
          icon: Icons.contact_mail,
          isRequired: true,
          children: [
            TextFormField(
              initialValue: formState.values['email'],
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => formNotifier.updateFieldValue('email', value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: formState.values['phone'],
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => formNotifier.updateFieldValue('phone', value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: formState.values['address'],
              decoration: const InputDecoration(
                labelText: 'Street Address',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
              onChanged: (value) => formNotifier.updateFieldValue('address', value),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    initialValue: formState.values['city'],
                    decoration: const InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => formNotifier.updateFieldValue('city', value),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: formState.values['state'],
                    decoration: const InputDecoration(
                      labelText: 'State',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => formNotifier.updateFieldValue('state', value),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: formState.values['zipCode'],
                    decoration: const InputDecoration(
                      labelText: 'ZIP',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => formNotifier.updateFieldValue('zipCode', value),
                  ),
                ),
              ],
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        // Employment Information
        _buildExpansionPanel(
          key: 'employment',
          title: 'Employment Information',
          icon: Icons.work,
          isRequired: false,
          children: [
            TextFormField(
              initialValue: formState.values['employer'],
              decoration: const InputDecoration(
                labelText: 'Current Employer',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => formNotifier.updateFieldValue('employer', value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: formState.values['jobTitle'],
              decoration: const InputDecoration(
                labelText: 'Job Title',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => formNotifier.updateFieldValue('jobTitle', value),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: formState.values['employmentStatus'],
              decoration: const InputDecoration(
                labelText: 'Employment Status',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'full_time', child: Text('Full Time')),
                DropdownMenuItem(value: 'part_time', child: Text('Part Time')),
                DropdownMenuItem(value: 'contract', child: Text('Contract')),
                DropdownMenuItem(value: 'freelance', child: Text('Freelance')),
                DropdownMenuItem(value: 'unemployed', child: Text('Unemployed')),
              ],
              onChanged: (value) => formNotifier.updateFieldValue('employmentStatus', value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: formState.values['annualIncome'],
              decoration: const InputDecoration(
                labelText: 'Annual Income',
                border: OutlineInputBorder(),
                prefixText: '\$ ',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => formNotifier.updateFieldValue('annualIncome', value),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        // Emergency Contact
        _buildExpansionPanel(
          key: 'emergency',
          title: 'Emergency Contact',
          icon: Icons.emergency,
          isRequired: false,
          children: [
            TextFormField(
              initialValue: formState.values['emergencyName'],
              decoration: const InputDecoration(
                labelText: 'Contact Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => formNotifier.updateFieldValue('emergencyName', value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: formState.values['emergencyRelation'],
              decoration: const InputDecoration(
                labelText: 'Relationship',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => formNotifier.updateFieldValue('emergencyRelation', value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: formState.values['emergencyPhone'],
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => formNotifier.updateFieldValue('emergencyPhone', value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: formState.values['emergencyEmail'],
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => formNotifier.updateFieldValue('emergencyEmail', value),
            ),
          ],
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
            FilledButton.icon(
              onPressed: () {
                // Expand all sections
                setState(() {
                  _expandedSections.updateAll((key, value) => true);
                });
              },
              icon: const Icon(Icons.expand),
              label: const Text('Expand All'),
            ),
            const SizedBox(width: 8),
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
  
  Widget _buildExpansionPanel({
    required String key,
    required String title,
    required IconData icon,
    required bool isRequired,
    required List<Widget> children,
  }) {
    final isExpanded = _expandedSections[key] ?? false;
    
    return Card(
      elevation: isExpanded ? 2 : 1,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _expandedSections[key] = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(icon, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (isRequired) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.errorContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Required',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onErrorContainer,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (!isExpanded) ...[
                          const SizedBox(height: 4),
                          Text(
                            _getSectionSummary(key),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(children: children),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
  
  String _getSectionSummary(String key) {
    switch (key) {
      case 'personal':
        return 'Basic personal information';
      case 'contact':
        return 'Email, phone, and address';
      case 'employment':
        return 'Current job and income details';
      case 'emergency':
        return 'Emergency contact information';
      default:
        return '';
    }
  }
}