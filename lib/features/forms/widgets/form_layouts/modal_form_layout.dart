import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/form_models.dart';
import '../../providers/form_providers.dart';

class ModalFormLayout extends ConsumerWidget {
  const ModalFormLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formStateProvider('modal_form'));
    final formNotifier = ref.read(formStateProvider('modal_form').notifier);
    
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 500,
          maxHeight: 600,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.feedback,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Send Feedback',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'We value your opinion',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            
            // Form Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Feedback Type
                    DropdownButtonFormField<String>(
                      value: formState.values['feedbackType'],
                      decoration: const InputDecoration(
                        labelText: 'Feedback Type',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.category),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'bug', child: Text('Bug Report')),
                        DropdownMenuItem(value: 'feature', child: Text('Feature Request')),
                        DropdownMenuItem(value: 'improvement', child: Text('Improvement')),
                        DropdownMenuItem(value: 'compliment', child: Text('Compliment')),
                        DropdownMenuItem(value: 'other', child: Text('Other')),
                      ],
                      onChanged: (value) => formNotifier.updateFieldValue('feedbackType', value),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Subject
                    TextFormField(
                      initialValue: formState.values['subject'],
                      decoration: const InputDecoration(
                        labelText: 'Subject',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.subject),
                      ),
                      onChanged: (value) => formNotifier.updateFieldValue('subject', value),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Description
                    TextFormField(
                      initialValue: formState.values['description'],
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.description),
                      ),
                      maxLines: 5,
                      minLines: 3,
                      onChanged: (value) => formNotifier.updateFieldValue('description', value),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Priority
                    Text(
                      'Priority',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(
                          value: 'low',
                          label: Text('Low'),
                          icon: Icon(Icons.low_priority),
                        ),
                        ButtonSegment(
                          value: 'medium',
                          label: Text('Medium'),
                          icon: Icon(Icons.priority_high),
                        ),
                        ButtonSegment(
                          value: 'high',
                          label: Text('High'),
                          icon: Icon(Icons.warning),
                        ),
                      ],
                      selected: {formState.values['priority'] ?? 'medium'},
                      onSelectionChanged: (selection) {
                        if (selection.isNotEmpty) {
                          formNotifier.updateFieldValue('priority', selection.first);
                        }
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Email for updates
                    TextFormField(
                      initialValue: formState.values['email'],
                      decoration: const InputDecoration(
                        labelText: 'Email (optional)',
                        helperText: 'We\'ll notify you when we address your feedback',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => formNotifier.updateFieldValue('email', value),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Include system info
                    CheckboxListTile(
                      value: formState.values['includeSystemInfo'] ?? true,
                      onChanged: (value) => formNotifier.updateFieldValue('includeSystemInfo', value),
                      title: const Text('Include system information'),
                      subtitle: const Text('Helps us diagnose issues faster'),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),
            
            // Footer Actions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: formState.isSubmitting
                        ? null
                        : () async {
                            await formNotifier.submitForm((values) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Thank you for your feedback!'),
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                ),
                              );
                            });
                          },
                    icon: formState.isSubmitting
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send),
                    label: Text(formState.isSubmitting ? 'Sending...' : 'Send Feedback'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleModalForm extends ConsumerWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<Widget> fields;
  final Function(Map<String, dynamic>) onSubmit;
  
  const SimpleModalForm({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.fields,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 28),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ...fields,
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () {
                    // Collect form data and submit
                    onSubmit({});
                    Navigator.of(context).pop();
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}