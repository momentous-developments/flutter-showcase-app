import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/base_scaffold.dart';
import 'providers/form_providers.dart';
import 'widgets/form_layouts/basic_form_layout.dart';
import 'widgets/form_layouts/tabbed_form_layout.dart';
import 'widgets/form_layouts/stepper_form_layout.dart';
import 'widgets/form_layouts/collapsible_form_layout.dart';
import 'widgets/form_layouts/modal_form_layout.dart';
import 'widgets/form_layouts/sidebar_form_layout.dart';
import 'widgets/form_showcase.dart';
import 'widgets/form_elements_showcase.dart';
import 'widgets/form_validation_showcase.dart';
import 'widgets/form_templates_grid.dart';

class FormsPage extends ConsumerStatefulWidget {
  const FormsPage({super.key});

  @override
  ConsumerState<FormsPage> createState() => _FormsPageState();
}

class _FormsPageState extends ConsumerState<FormsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forms'),
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: const [
                Tab(text: 'Form Layouts'),
                Tab(text: 'Form Elements'),
                Tab(text: 'Validation'),
                Tab(text: 'Templates'),
                Tab(text: 'Examples'),
              ],
            ),
          ),
          
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Form Layouts Tab
                _buildFormLayoutsTab(),
                
                // Form Elements Tab
                const FormElementsShowcase(),
                
                // Validation Tab
                const FormValidationShowcase(),
                
                // Templates Tab
                _buildTemplatesTab(),
                
                // Examples Tab
                _buildExamplesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFormLayoutsTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSectionTitle('Form Layout Types'),
        const SizedBox(height: 16),
        
        // Basic Form Layout
        _buildLayoutCard(
          title: 'Basic Form Layout',
          description: 'Simple vertical form layout with standard field arrangement',
          child: const BasicFormLayout(),
        ),
        
        const SizedBox(height: 24),
        
        // Tabbed Form Layout
        _buildLayoutCard(
          title: 'Tabbed Form Layout',
          description: 'Form organized into multiple tabs for complex data entry',
          child: const TabbedFormLayout(),
        ),
        
        const SizedBox(height: 24),
        
        // Stepper Form Layout
        _buildLayoutCard(
          title: 'Stepper Form Layout',
          description: 'Multi-step wizard form with progress indication',
          child: const StepperFormLayout(),
        ),
        
        const SizedBox(height: 24),
        
        // Collapsible Form Layout
        _buildLayoutCard(
          title: 'Collapsible Form Layout',
          description: 'Form with expandable sections for better organization',
          child: const CollapsibleFormLayout(),
        ),
        
        const SizedBox(height: 24),
        
        // Modal Form Layout
        _buildLayoutCard(
          title: 'Modal Form Layout',
          description: 'Form displayed in a popup modal dialog',
          child: Center(
            child: ElevatedButton.icon(
              onPressed: () => _showModalForm(context),
              icon: const Icon(Icons.open_in_new),
              label: const Text('Open Modal Form'),
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Sidebar Form Layout
        _buildLayoutCard(
          title: 'Sidebar Form Layout',
          description: 'Form with sidebar navigation for long forms',
          child: const SidebarFormLayout(),
        ),
      ],
    );
  }
  
  Widget _buildTemplatesTab() {
    final templates = ref.watch(formTemplatesProvider);
    
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSectionTitle('Form Templates'),
        const SizedBox(height: 8),
        Text(
          'Pre-built form templates for common use cases',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 24),
        FormTemplatesGrid(templates: templates),
      ],
    );
  }
  
  Widget _buildExamplesTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSectionTitle('Complete Form Examples'),
        const SizedBox(height: 16),
        
        // Contact Form
        _buildExampleCard(
          title: 'Contact Form',
          description: 'Simple contact form with validation',
          formId: 'contact',
        ),
        
        const SizedBox(height: 16),
        
        // Registration Form
        _buildExampleCard(
          title: 'Registration Form',
          description: 'User registration with async validation',
          formId: 'registration',
        ),
        
        const SizedBox(height: 16),
        
        // Checkout Form
        _buildExampleCard(
          title: 'Checkout Form',
          description: 'E-commerce checkout with stepper layout',
          formId: 'checkout',
        ),
        
        const SizedBox(height: 16),
        
        // Survey Form
        _buildExampleCard(
          title: 'Survey Form',
          description: 'Customer satisfaction survey with ratings',
          formId: 'survey',
        ),
        
        const SizedBox(height: 16),
        
        // Job Application Form
        _buildExampleCard(
          title: 'Job Application Form',
          description: 'Complex form with file uploads and rich text',
          formId: 'job_application',
        ),
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
  
  Widget _buildLayoutCard({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }
  
  Widget _buildExampleCard({
    required String title,
    required String description,
    required String formId,
  }) {
    return Card(
      child: InkWell(
        onTap: () => _showFormExample(context, formId),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
  
  void _showModalForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ModalFormLayout(),
    );
  }
  
  void _showFormExample(BuildContext context, String formId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormShowcase(formId: formId),
      ),
    );
  }
}