import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../form_layouts/form_layouts.dart';

class FormLayoutsShowcase extends ConsumerWidget {
  const FormLayoutsShowcase({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 6,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
            child: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Basic'),
                Tab(text: 'Tabbed'),
                Tab(text: 'Stepper'),
                Tab(text: 'Collapsible'),
                Tab(text: 'Modal'),
                Tab(text: 'Sidebar'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildLayoutCard(
                  context,
                  'Basic Form Layout',
                  'Standard vertical form layout with sections',
                  const BasicFormLayout(formId: 'basic_layout'),
                ),
                _buildLayoutCard(
                  context,
                  'Tabbed Form Layout',
                  'Organize form fields into tabs',
                  const TabbedFormLayout(formId: 'tabbed_layout'),
                ),
                _buildLayoutCard(
                  context,
                  'Stepper Form Layout',
                  'Multi-step wizard with progress indicator',
                  const StepperFormLayout(formId: 'stepper_layout'),
                ),
                _buildLayoutCard(
                  context,
                  'Collapsible Form Layout',
                  'Expandable sections for better organization',
                  const CollapsibleFormLayout(formId: 'collapsible_layout'),
                ),
                _buildLayoutCard(
                  context,
                  'Modal Form Layout',
                  'Forms that open in a modal dialog',
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _showModalForm(context),
                      child: const Text('Open Modal Form'),
                    ),
                  ),
                ),
                _buildLayoutCard(
                  context,
                  'Sidebar Form Layout',
                  'Settings-style form with navigation sidebar',
                  const SidebarFormLayout(formId: 'sidebar_layout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLayoutCard(
    BuildContext context,
    String title,
    String description,
    Widget content,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          content,
        ],
      ),
    );
  }

  void _showModalForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: const ModalFormLayout(formId: 'modal_layout'),
        ),
      ),
    );
  }
}