import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/email_models.dart';
import '../providers/email_providers.dart';

class TemplatesView extends ConsumerStatefulWidget {
  const TemplatesView({super.key});

  @override
  ConsumerState<TemplatesView> createState() => _TemplatesViewState();
}

class _TemplatesViewState extends ConsumerState<TemplatesView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  TemplateType? _selectedType;
  TemplateViewMode _viewMode = TemplateViewMode.grid;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTemplatesTab(null),
                _buildTemplatesTab(TemplateType.personal),
                _buildTemplatesTab(TemplateType.business),
                _buildTemplatesTab(TemplateType.marketing),
                _buildTemplatesTab(TemplateType.support),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTemplate,
        child: const Icon(Icons.add),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Email Templates'),
      actions: [
        IconButton(
          icon: Icon(
            _viewMode == TemplateViewMode.grid ? Icons.view_list : Icons.view_module,
          ),
          onPressed: _toggleViewMode,
          tooltip: _viewMode == TemplateViewMode.grid ? 'List view' : 'Grid view',
        ),
        PopupMenuButton<String>(
          onSelected: _handleMenuAction,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'import',
              child: ListTile(
                leading: Icon(Icons.file_upload),
                title: Text('Import templates'),
              ),
            ),
            const PopupMenuItem(
              value: 'export',
              child: ListTile(
                leading: Icon(Icons.file_download),
                title: Text('Export templates'),
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem(
              value: 'settings',
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Template settings'),
              ),
            ),
          ],
        ),
      ],
      bottom: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabs: const [
          Tab(text: 'All'),
          Tab(text: 'Personal'),
          Tab(text: 'Business'),
          Tab(text: 'Marketing'),
          Tab(text: 'Support'),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        children: [
          SearchBar(
            controller: _searchController,
            hintText: 'Search templates...',
            leading: const Icon(Icons.search),
            trailing: [
              if (_searchController.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                ),
            ],
          ),
          const SizedBox(height: 8),
          _buildSortOptions(),
        ],
      ),
    );
  }

  Widget _buildSortOptions() {
    return Row(
      children: [
        Text(
          'Sort by:',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(width: 8),
        DropdownButton<String>(
          value: 'name',
          underline: const SizedBox(),
          items: const [
            DropdownMenuItem(value: 'name', child: Text('Name')),
            DropdownMenuItem(value: 'date', child: Text('Date Created')),
            DropdownMenuItem(value: 'usage', child: Text('Usage Count')),
            DropdownMenuItem(value: 'recent', child: Text('Recently Used')),
          ],
          onChanged: (value) {
            // TODO: Implement sorting
          },
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.sort),
          onPressed: () {
            // TODO: Toggle sort direction
          },
        ),
      ],
    );
  }

  Widget _buildTemplatesTab(TemplateType? type) {
    final templatesParams = TemplatesParams(
      type: type,
      query: _searchQuery.isEmpty ? null : _searchQuery,
    );

    return ref.watch(emailTemplatesProvider(templatesParams)).when(
      data: (templates) => _buildTemplatesList(templates),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => _buildErrorView(error),
    );
  }

  Widget _buildTemplatesList(List<EmailTemplate> templates) {
    if (templates.isEmpty) {
      return _buildEmptyTemplatesView();
    }

    if (_viewMode == TemplateViewMode.grid) {
      return _buildTemplatesGrid(templates);
    } else {
      return _buildTemplatesListView(templates);
    }
  }

  Widget _buildTemplatesGrid(List<EmailTemplate> templates) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: templates.length,
      itemBuilder: (context, index) {
        final template = templates[index];
        return _buildTemplateCard(template);
      },
    );
  }

  Widget _buildTemplatesListView(List<EmailTemplate> templates) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: templates.length,
      itemBuilder: (context, index) {
        final template = templates[index];
        return _buildTemplateListItem(template);
      },
    );
  }

  Widget _buildTemplateCard(EmailTemplate template) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => _previewTemplate(template),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      template.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (action) => _handleTemplateAction(template, action),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'use',
                        child: ListTile(
                          leading: Icon(Icons.edit),
                          title: Text('Use Template'),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'preview',
                        child: ListTile(
                          leading: Icon(Icons.visibility),
                          title: Text('Preview'),
                        ),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                        value: 'edit',
                        child: ListTile(
                          leading: Icon(Icons.edit_note),
                          title: Text('Edit'),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'duplicate',
                        child: ListTile(
                          leading: Icon(Icons.copy),
                          title: Text('Duplicate'),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'share',
                        child: ListTile(
                          leading: Icon(Icons.share),
                          title: Text('Share'),
                        ),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                        value: 'delete',
                        child: ListTile(
                          leading: Icon(Icons.delete, color: Colors.red),
                          title: Text('Delete', style: TextStyle(color: Colors.red)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (template.type != null) ...[
                const SizedBox(height: 8),
                Chip(
                  label: Text(
                    template.type!.name.toUpperCase(),
                    style: theme.textTheme.labelSmall,
                  ),
                  backgroundColor: _getTypeColor(template.type!),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
              const SizedBox(height: 8),
              Text(
                template.subject,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Text(
                  template.body,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              if (template.tags?.isNotEmpty == true) ...[
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: template.tags!.take(2).map((tag) => Chip(
                    label: Text(
                      tag,
                      style: theme.textTheme.labelSmall,
                    ),
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )).toList(),
                ),
                const SizedBox(height: 8),
              ],
              Row(
                children: [
                  if (template.useCount != null) ...[
                    Icon(
                      Icons.analytics,
                      size: 14,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${template.useCount}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => _useTemplate(template),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(60, 30),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: const Text('Use', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTemplateListItem(EmailTemplate template) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => _previewTemplate(template),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: template.type != null 
                      ? _getTypeColor(template.type!).withOpacity(0.2)
                      : theme.colorScheme.primaryContainer.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getTemplateIcon(template.type),
                  color: template.type != null 
                      ? _getTypeColor(template.type!)
                      : theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      template.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      template.subject,
                      style: theme.textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      template.body,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (template.tags?.isNotEmpty == true) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 4,
                        children: template.tags!.take(3).map((tag) => Chip(
                          label: Text(
                            tag,
                            style: theme.textTheme.labelSmall,
                          ),
                          backgroundColor: theme.colorScheme.surfaceContainerHighest,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        )).toList(),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  if (template.useCount != null) ...[
                    Text(
                      '${template.useCount}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'uses',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _useTemplate(template),
                    child: const Text('Use'),
                  ),
                ],
              ),
              PopupMenuButton<String>(
                onSelected: (action) => _handleTemplateAction(template, action),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'preview',
                    child: Text('Preview'),
                  ),
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem(
                    value: 'duplicate',
                    child: Text('Duplicate'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyTemplatesView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isEmpty ? 'No Templates' : 'No Results',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isEmpty
                ? 'Create templates to speed up your email composition.'
                : 'No templates match your search criteria.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Create Template'),
            onPressed: _createTemplate,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(Object error) {
    return Center(
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
            'Error loading templates',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            onPressed: () => ref.invalidate(emailTemplatesProvider),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(TemplateType type) {
    switch (type) {
      case TemplateType.personal:
        return Colors.blue;
      case TemplateType.business:
        return Colors.green;
      case TemplateType.marketing:
        return Colors.orange;
      case TemplateType.support:
        return Colors.purple;
      case TemplateType.newsletter:
        return Colors.red;
    }
  }

  IconData _getTemplateIcon(TemplateType? type) {
    switch (type) {
      case TemplateType.personal:
        return Icons.person;
      case TemplateType.business:
        return Icons.business;
      case TemplateType.marketing:
        return Icons.campaign;
      case TemplateType.support:
        return Icons.support_agent;
      case TemplateType.newsletter:
        return Icons.newspaper;
      default:
        return Icons.description;
    }
  }

  void _toggleViewMode() {
    setState(() {
      _viewMode = _viewMode == TemplateViewMode.grid
          ? TemplateViewMode.list
          : TemplateViewMode.grid;
    });
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'import':
        _importTemplates();
        break;
      case 'export':
        _exportTemplates();
        break;
      case 'settings':
        _showTemplateSettings();
        break;
    }
  }

  void _createTemplate() {
    showDialog(
      context: context,
      builder: (context) => const _TemplateFormDialog(),
    );
  }

  void _useTemplate(EmailTemplate template) {
    final composeActions = ref.read(composeActionsProvider);
    composeActions.newEmail();
    
    final currentState = ref.read(composeStateProvider) ?? const ComposeState();
    final newState = currentState.copyWith(
      subject: template.subject,
      body: template.body,
    );
    ref.read(composeStateProvider.notifier).state = newState;
    ref.read(emailViewModeProvider.notifier).state = EmailViewMode.compose;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Using template: ${template.name}')),
    );
  }

  void _previewTemplate(EmailTemplate template) {
    showDialog(
      context: context,
      builder: (context) => _TemplatePreviewDialog(template: template),
    );
  }

  void _handleTemplateAction(EmailTemplate template, String action) {
    switch (action) {
      case 'use':
        _useTemplate(template);
        break;
      case 'preview':
        _previewTemplate(template);
        break;
      case 'edit':
        _editTemplate(template);
        break;
      case 'duplicate':
        _duplicateTemplate(template);
        break;
      case 'share':
        _shareTemplate(template);
        break;
      case 'delete':
        _deleteTemplate(template);
        break;
    }
  }

  void _editTemplate(EmailTemplate template) {
    showDialog(
      context: context,
      builder: (context) => _TemplateFormDialog(template: template),
    );
  }

  void _duplicateTemplate(EmailTemplate template) {
    showDialog(
      context: context,
      builder: (context) => _TemplateFormDialog(
        template: template.copyWith(
          name: 'Copy of ${template.name}',
        ),
      ),
    );
  }

  void _shareTemplate(EmailTemplate template) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Template sharing not implemented')),
    );
  }

  void _deleteTemplate(EmailTemplate template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Template'),
        content: Text('Are you sure you want to delete "${template.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Delete template via API
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Template deleted')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _importTemplates() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Template import not implemented')),
    );
  }

  void _exportTemplates() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Template export not implemented')),
    );
  }

  void _showTemplateSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Template settings not implemented')),
    );
  }
}

enum TemplateViewMode { grid, list }

class _TemplateFormDialog extends StatefulWidget {
  final EmailTemplate? template;

  const _TemplateFormDialog({this.template});

  @override
  State<_TemplateFormDialog> createState() => _TemplateFormDialogState();
}

class _TemplateFormDialogState extends State<_TemplateFormDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _subjectController;
  late final TextEditingController _bodyController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _tagsController;
  
  TemplateType _selectedType = TemplateType.personal;
  bool _isPublic = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.template?.name ?? '');
    _subjectController = TextEditingController(text: widget.template?.subject ?? '');
    _bodyController = TextEditingController(text: widget.template?.body ?? '');
    _descriptionController = TextEditingController(text: widget.template?.description ?? '');
    _tagsController = TextEditingController(
      text: widget.template?.tags?.join(', ') ?? '',
    );
    _selectedType = widget.template?.type ?? TemplateType.personal;
    _isPublic = widget.template?.isPublic ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.template == null ? 'Create Template' : 'Edit Template'),
      content: SizedBox(
        width: 500,
        height: 600,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Template Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<TemplateType>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Type',
                  border: OutlineInputBorder(),
                ),
                items: TemplateType.values.map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type.name.toUpperCase()),
                )).toList(),
                onChanged: (value) => setState(() => _selectedType = value!),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  labelText: 'Body',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 8,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _tagsController,
                decoration: const InputDecoration(
                  labelText: 'Tags (comma separated)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Make Public'),
                subtitle: const Text('Allow other users to use this template'),
                value: _isPublic,
                onChanged: (value) => setState(() => _isPublic = value!),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _saveTemplate,
          child: Text(widget.template == null ? 'Create' : 'Save'),
        ),
      ],
    );
  }

  void _saveTemplate() {
    if (_nameController.text.isEmpty || _subjectController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name and subject are required')),
      );
      return;
    }

    // TODO: Save template via API
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.template == null ? 'Template created' : 'Template updated',
        ),
      ),
    );
  }
}

class _TemplatePreviewDialog extends StatelessWidget {
  final EmailTemplate template;

  const _TemplatePreviewDialog({required this.template});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Dialog(
      child: Container(
        width: 600,
        height: 500,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    template.name,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Subject:',
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          template.subject,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (template.type != null) ...[
                    Row(
                      children: [
                        Text(
                          'Type:',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Chip(
                          label: Text(
                            template.type!.name.toUpperCase(),
                            style: theme.textTheme.labelSmall,
                          ),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (template.tags?.isNotEmpty == true) ...[
                    Text(
                      'Tags:',
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: template.tags!.map((tag) => Chip(
                        label: Text(
                          tag,
                          style: theme.textTheme.labelSmall,
                        ),
                        backgroundColor: theme.colorScheme.surfaceContainerHighest,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      )).toList(),
                    ),
                    const SizedBox(height: 8),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Body:',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    template.body,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (template.useCount != null) ...[
                  Icon(
                    Icons.analytics,
                    size: 16,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Used ${template.useCount} times',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
                const Spacer(),
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // TODO: Use template
                  },
                  child: const Text('Use Template'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}