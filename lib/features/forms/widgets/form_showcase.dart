import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/base_scaffold.dart';
import '../models/form_models.dart';
import '../providers/form_providers.dart';
import 'form_builder.dart';

class FormShowcase extends ConsumerWidget {
  final String formId;
  
  const FormShowcase({
    super.key,
    required this.formId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formSchema = ref.watch(formSchemaProvider(formId));
    
    if (formSchema == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Form Not Found'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Form with ID "$formId" not found',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(formSchema.name),
      ),
      body: FormBuilder(
        schema: formSchema,
        onSubmit: (values) {
          // Handle form submission
          _showSubmissionDialog(context, values);
        },
      ),
    );
  }
  
  void _showSubmissionDialog(BuildContext context, Map<String, dynamic> values) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Form Submitted'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Form values:'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  values.toString(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}