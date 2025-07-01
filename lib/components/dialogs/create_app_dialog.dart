import 'package:flutter/material.dart';
import 'models/dialog_models.dart';
import 'widgets/stepper_dialog.dart';
import 'widgets/form_dialog.dart';

/// Multi-step dialog for creating a new application
class CreateAppDialog extends StatefulWidget {
  const CreateAppDialog({
    super.key,
    this.onComplete,
    this.onCancel,
  });

  final Function(CreateAppStepData)? onComplete;
  final VoidCallback? onCancel;

  @override
  State<CreateAppDialog> createState() => _CreateAppDialogState();
}

class _CreateAppDialogState extends State<CreateAppDialog> {
  CreateAppStepData _appData = const CreateAppStepData();

  @override
  Widget build(BuildContext context) {
    return StepperDialog(
      title: 'Create New Application',
      subtitle: 'Set up your new application in just a few steps',
      steps: [
        DialogStep(
          title: 'Choose Framework',
          description: 'Select the framework for your application',
          content: _buildFrameworkStep(),
          canProceed: _appData.framework.isNotEmpty,
        ),
        DialogStep(
          title: 'Select Database',
          description: 'Choose your preferred database solution',
          content: _buildDatabaseStep(),
          canProceed: _appData.database.isNotEmpty,
        ),
        DialogStep(
          title: 'Application Details',
          description: 'Provide basic information about your app',
          content: _buildDetailsStep(),
          canProceed: _appData.name.isNotEmpty && _appData.region.isNotEmpty,
        ),
        DialogStep(
          title: 'Billing Information',
          description: 'Configure billing and payment details',
          content: _buildBillingStep(),
          canProceed: _appData.plan.isNotEmpty,
        ),
        DialogStep(
          title: 'Review & Submit',
          description: 'Review your configuration before creating the app',
          content: _buildSubmitStep(),
          canProceed: true,
        ),
      ],
      onComplete: () {
        widget.onComplete?.call(_appData);
        Navigator.of(context).pop();
      },
      onCancel: widget.onCancel,
    );
  }

  Widget _buildFrameworkStep() {
    final frameworks = [
      FrameworkOption(
        id: 'react',
        name: 'React',
        description: 'Build modern web apps with React',
        icon: Icons.web,
        color: Colors.blue,
        isPopular: true,
      ),
      FrameworkOption(
        id: 'vue',
        name: 'Vue.js',
        description: 'Progressive framework for building UIs',
        icon: Icons.web,
        color: Colors.green,
      ),
      FrameworkOption(
        id: 'angular',
        name: 'Angular',
        description: 'Platform for building mobile and desktop web apps',
        icon: Icons.web,
        color: Colors.red,
      ),
      FrameworkOption(
        id: 'svelte',
        name: 'Svelte',
        description: 'Cybernetically enhanced web apps',
        icon: Icons.web,
        color: Colors.orange,
      ),
      FrameworkOption(
        id: 'nextjs',
        name: 'Next.js',
        description: 'React framework for production',
        icon: Icons.web,
        color: Colors.black,
        isPopular: true,
      ),
      FrameworkOption(
        id: 'nuxt',
        name: 'Nuxt.js',
        description: 'Vue.js framework for building applications',
        icon: Icons.web,
        color: Colors.teal,
      ),
    ];

    return _FrameworkSelector(
      frameworks: frameworks,
      selectedFramework: _appData.framework,
      onFrameworkSelected: (framework) {
        setState(() {
          _appData = _appData.copyWith(framework: framework);
        });
      },
    );
  }

  Widget _buildDatabaseStep() {
    final databases = [
      DatabaseOption(
        id: 'postgresql',
        name: 'PostgreSQL',
        description: 'Open source relational database',
        icon: Icons.storage,
        color: Colors.blue,
        isRecommended: true,
      ),
      DatabaseOption(
        id: 'mysql',
        name: 'MySQL',
        description: 'Popular open source database',
        icon: Icons.storage,
        color: Colors.orange,
      ),
      DatabaseOption(
        id: 'mongodb',
        name: 'MongoDB',
        description: 'Document-based NoSQL database',
        icon: Icons.storage,
        color: Colors.green,
      ),
      DatabaseOption(
        id: 'redis',
        name: 'Redis',
        description: 'In-memory data structure store',
        icon: Icons.storage,
        color: Colors.red,
      ),
      DatabaseOption(
        id: 'firebase',
        name: 'Firebase',
        description: 'Google\'s mobile platform',
        icon: Icons.storage,
        color: Colors.amber,
      ),
      DatabaseOption(
        id: 'supabase',
        name: 'Supabase',
        description: 'Open source Firebase alternative',
        icon: Icons.storage,
        color: Colors.teal,
        isRecommended: true,
      ),
    ];

    return _DatabaseSelector(
      databases: databases,
      selectedDatabase: _appData.database,
      onDatabaseSelected: (database) {
        setState(() {
          _appData = _appData.copyWith(database: database);
        });
      },
    );
  }

  Widget _buildDetailsStep() {
    return _AppDetailsForm(
      appData: _appData,
      onAppDataChanged: (data) {
        setState(() {
          _appData = data;
        });
      },
    );
  }

  Widget _buildBillingStep() {
    final plans = [
      PricingPlanData(
        id: 'hobby',
        name: 'Hobby',
        description: 'Perfect for personal projects',
        price: 0,
        features: [
          '1 Project',
          '10GB Storage',
          'Community Support',
          'Basic Analytics',
        ],
      ),
      PricingPlanData(
        id: 'pro',
        name: 'Pro',
        description: 'For professional developers',
        price: 20,
        features: [
          '10 Projects',
          '100GB Storage',
          'Priority Support',
          'Advanced Analytics',
          'Custom Domains',
        ],
        isPopular: true,
      ),
      PricingPlanData(
        id: 'team',
        name: 'Team',
        description: 'For collaborative teams',
        price: 50,
        features: [
          'Unlimited Projects',
          '500GB Storage',
          '24/7 Support',
          'Team Collaboration',
          'Advanced Security',
          'Custom Integrations',
        ],
      ),
    ];

    return _BillingForm(
      plans: plans,
      selectedPlan: _appData.plan,
      billingData: _appData.billing,
      onPlanSelected: (plan) {
        setState(() {
          _appData = _appData.copyWith(plan: plan);
        });
      },
      onBillingDataChanged: (billing) {
        setState(() {
          _appData = _appData.copyWith(billing: billing);
        });
      },
    );
  }

  Widget _buildSubmitStep() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Configuration Summary',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildSummaryItem('Application Name', _appData.name),
              _buildSummaryItem('Framework', _appData.framework),
              _buildSummaryItem('Database', _appData.database),
              _buildSummaryItem('Region', _appData.region),
              _buildSummaryItem('Plan', _appData.plan),
              if (_appData.description.isNotEmpty)
                _buildSummaryItem('Description', _appData.description),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Your application will be created with the selected configuration. This may take a few minutes to complete.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Framework selector widget
class _FrameworkSelector extends StatelessWidget {
  const _FrameworkSelector({
    required this.frameworks,
    required this.selectedFramework,
    required this.onFrameworkSelected,
  });

  final List<FrameworkOption> frameworks;
  final String selectedFramework;
  final ValueChanged<String> onFrameworkSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: frameworks.length,
      itemBuilder: (context, index) {
        final framework = frameworks[index];
        final isSelected = selectedFramework == framework.id;
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return Material(
          color: isSelected
              ? colorScheme.primaryContainer
              : colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () => onFrameworkSelected(framework.id),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: framework.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      framework.icon,
                      color: framework.color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              framework.name,
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: isSelected
                                    ? colorScheme.onPrimaryContainer
                                    : colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (framework.isPopular) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Popular',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onPrimary,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          framework.description,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isSelected
                                ? colorScheme.onPrimaryContainer
                                : colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Database selector widget
class _DatabaseSelector extends StatelessWidget {
  const _DatabaseSelector({
    required this.databases,
    required this.selectedDatabase,
    required this.onDatabaseSelected,
  });

  final List<DatabaseOption> databases;
  final String selectedDatabase;
  final ValueChanged<String> onDatabaseSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: databases.length,
      itemBuilder: (context, index) {
        final database = databases[index];
        final isSelected = selectedDatabase == database.id;
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return Material(
          color: isSelected
              ? colorScheme.primaryContainer
              : colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () => onDatabaseSelected(database.id),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: database.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      database.icon,
                      color: database.color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              database.name,
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: isSelected
                                    ? colorScheme.onPrimaryContainer
                                    : colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (database.isRecommended) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Recommended',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onPrimary,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          database.description,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isSelected
                                ? colorScheme.onPrimaryContainer
                                : colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// App details form widget
class _AppDetailsForm extends StatefulWidget {
  const _AppDetailsForm({
    required this.appData,
    required this.onAppDataChanged,
  });

  final CreateAppStepData appData;
  final ValueChanged<CreateAppStepData> onAppDataChanged;

  @override
  State<_AppDetailsForm> createState() => _AppDetailsFormState();
}

class _AppDetailsFormState extends State<_AppDetailsForm> {
  final List<String> _regions = [
    'US East (N. Virginia)',
    'US West (Oregon)',
    'EU (Ireland)',
    'EU (Frankfurt)',
    'Asia Pacific (Tokyo)',
    'Asia Pacific (Sydney)',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DialogFormField(
          label: 'Application Name',
          hint: 'my-awesome-app',
          value: widget.appData.name,
          required: true,
          onChanged: (value) {
            widget.onAppDataChanged(widget.appData.copyWith(name: value));
          },
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Application name is required';
            }
            return null;
          },
        ),
        DialogFormField(
          label: 'Description',
          hint: 'Describe your application (optional)',
          value: widget.appData.description,
          maxLines: 3,
          onChanged: (value) {
            widget.onAppDataChanged(widget.appData.copyWith(description: value));
          },
        ),
        DialogDropdownField<String>(
          label: 'Region',
          value: widget.appData.region.isEmpty ? null : widget.appData.region,
          required: true,
          items: _regions.map((region) {
            return DropdownMenuItem<String>(
              value: region,
              child: Text(region),
            );
          }).toList(),
          onChanged: (value) {
            widget.onAppDataChanged(
              widget.appData.copyWith(region: value ?? ''),
            );
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Region is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}

// Billing form widget
class _BillingForm extends StatelessWidget {
  const _BillingForm({
    required this.plans,
    required this.selectedPlan,
    required this.billingData,
    required this.onPlanSelected,
    required this.onBillingDataChanged,
  });

  final List<PricingPlanData> plans;
  final String selectedPlan;
  final Map<String, dynamic> billingData;
  final ValueChanged<String> onPlanSelected;
  final ValueChanged<Map<String, dynamic>> onBillingDataChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose a Plan',
          style: theme.textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ...plans.map((plan) {
          final isSelected = selectedPlan == plan.id;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Material(
              color: isSelected
                  ? colorScheme.primaryContainer
                  : colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () => onPlanSelected(plan.id),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: plan.id,
                        groupValue: selectedPlan,
                        onChanged: (value) {
                          if (value != null) onPlanSelected(value);
                        },
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  plan.name,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: isSelected
                                        ? colorScheme.onPrimaryContainer
                                        : colorScheme.onSurfaceVariant,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '\$${plan.price.toStringAsFixed(0)}/${plan.interval}',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: isSelected
                                        ? colorScheme.onPrimaryContainer
                                        : colorScheme.onSurfaceVariant,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (plan.isPopular) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Most Popular',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: colorScheme.onPrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              plan.description,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: isSelected
                                    ? colorScheme.onPrimaryContainer
                                    : colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: plan.features.map((feature) {
                                return Text(
                                  '• $feature',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: isSelected
                                        ? colorScheme.onPrimaryContainer
                                        : colorScheme.onSurfaceVariant,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

// Data models for the dialog
class FrameworkOption {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final bool isPopular;

  const FrameworkOption({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    this.isPopular = false,
  });
}

class DatabaseOption {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final bool isRecommended;

  const DatabaseOption({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    this.isRecommended = false,
  });
}