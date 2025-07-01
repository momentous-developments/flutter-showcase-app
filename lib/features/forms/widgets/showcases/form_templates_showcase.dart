import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/form_providers.dart';

class FormTemplatesShowcase extends ConsumerWidget {
  const FormTemplatesShowcase({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templates = [
      _FormTemplate(
        id: 'contact',
        title: 'Contact Form',
        description: 'Basic contact form with name, email, and message',
        icon: Icons.contact_mail,
        color: Colors.blue,
      ),
      _FormTemplate(
        id: 'registration',
        title: 'Registration Form',
        description: 'User registration with validation',
        icon: Icons.person_add,
        color: Colors.green,
      ),
      _FormTemplate(
        id: 'checkout',
        title: 'Checkout Form',
        description: 'E-commerce checkout with payment details',
        icon: Icons.shopping_cart,
        color: Colors.orange,
      ),
      _FormTemplate(
        id: 'survey',
        title: 'Survey Form',
        description: 'Multi-step survey with various question types',
        icon: Icons.poll,
        color: Colors.purple,
      ),
      _FormTemplate(
        id: 'job_application',
        title: 'Job Application',
        description: 'Employment application with file uploads',
        icon: Icons.work,
        color: Colors.teal,
      ),
      _FormTemplate(
        id: 'feedback',
        title: 'Feedback Form',
        description: 'Customer feedback with ratings',
        icon: Icons.feedback,
        color: Colors.amber,
      ),
      _FormTemplate(
        id: 'appointment',
        title: 'Appointment Booking',
        description: 'Schedule appointments with date/time selection',
        icon: Icons.calendar_today,
        color: Colors.red,
      ),
      _FormTemplate(
        id: 'support',
        title: 'Support Ticket',
        description: 'Technical support request form',
        icon: Icons.support_agent,
        color: Colors.indigo,
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Form Templates',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pre-built form templates for common use cases',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 1200
                  ? 4
                  : constraints.maxWidth > 800
                      ? 3
                      : constraints.maxWidth > 500
                          ? 2
                          : 1;
              
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: templates.map((template) => _buildTemplateCard(
                  context,
                  ref,
                  template,
                )).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(
    BuildContext context,
    WidgetRef ref,
    _FormTemplate template,
  ) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: InkWell(
        onTap: () => _showTemplateDialog(context, ref, template),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: template.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  template.icon,
                  size: 32,
                  color: template.color,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                template.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                template.description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              TextButton(
                onPressed: () => _showTemplateDialog(context, ref, template),
                child: const Text('Use Template'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTemplateDialog(
    BuildContext context,
    WidgetRef ref,
    _FormTemplate template,
  ) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: _buildTemplatePreview(context, ref, template),
        ),
      ),
    );
  }

  Widget _buildTemplatePreview(
    BuildContext context,
    WidgetRef ref,
    _FormTemplate template,
  ) {
    // Get the template schema
    final schema = _getTemplateSchema(template.id);
    
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                template.icon,
                color: template.color,
                size: 32,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      template.title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      template.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Template Structure',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ...schema.sections.map((section) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              section.title,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${section.fields.length} fields',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                icon: const Icon(Icons.content_copy),
                label: const Text('Use This Template'),
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${template.title} template applied'),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  FormSchema _getTemplateSchema(String templateId) {
    // This would normally come from the provider
    // For now, return a basic schema
    switch (templateId) {
      case 'contact':
        return ref.read(contactFormTemplateProvider);
      case 'registration':
        return ref.read(registrationFormTemplateProvider);
      case 'checkout':
        return ref.read(checkoutFormTemplateProvider);
      case 'survey':
        return ref.read(surveyFormTemplateProvider);
      case 'job_application':
        return ref.read(jobApplicationFormTemplateProvider);
      default:
        return ref.read(contactFormTemplateProvider);
    }
  }
}

class _FormTemplate {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _FormTemplate({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}