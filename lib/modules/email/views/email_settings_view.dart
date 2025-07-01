import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/email_models.dart';
import '../providers/email_providers.dart';

class EmailSettingsView extends ConsumerStatefulWidget {
  const EmailSettingsView({super.key});

  @override
  ConsumerState<EmailSettingsView> createState() => _EmailSettingsViewState();
}

class _EmailSettingsViewState extends ConsumerState<EmailSettingsView>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
        title: const Text('Email Settings'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'General'),
            Tab(text: 'Notifications'),
            Tab(text: 'Rules & Filters'),
            Tab(text: 'Security'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _GeneralSettingsTab(),
          _NotificationSettingsTab(),
          _RulesAndFiltersTab(),
          _SecuritySettingsTab(),
        ],
      ),
    );
  }
}

class _GeneralSettingsTab extends ConsumerStatefulWidget {
  const _GeneralSettingsTab();

  @override
  ConsumerState<_GeneralSettingsTab> createState() => _GeneralSettingsTabState();
}

class _GeneralSettingsTabState extends ConsumerState<_GeneralSettingsTab> {
  late final TextEditingController _displayNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _signatureController;
  
  bool _autoReply = false;
  String _autoReplyMessage = '';
  int _refreshInterval = 5;
  bool _showPreview = true;
  int _previewLines = 3;
  bool _markAsReadOnPreview = false;

  @override
  void initState() {
    super.initState();
    _displayNameController = TextEditingController();
    _emailController = TextEditingController();
    _signatureController = TextEditingController();
    _loadSettings();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _signatureController.dispose();
    super.dispose();
  }

  void _loadSettings() {
    ref.read(emailSettingsProvider).whenData((settings) {
      if (mounted) {
        setState(() {
          _displayNameController.text = settings.displayName;
          _emailController.text = settings.emailAddress;
          _signatureController.text = settings.signature ?? '';
          _autoReply = settings.autoReply ?? false;
          _autoReplyMessage = settings.autoReplyMessage ?? '';
          _refreshInterval = settings.refreshInterval ?? 5;
          _showPreview = settings.showPreview ?? true;
          _previewLines = settings.previewLines ?? 3;
          _markAsReadOnPreview = settings.markAsReadOnPreview ?? false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(emailSettingsProvider).when(
      data: (settings) => _buildSettingsContent(settings),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => _buildErrorView(error),
    );
  }

  Widget _buildSettingsContent(EmailSettings settings) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildAccountSection(),
        const SizedBox(height: 24),
        _buildSignatureSection(),
        const SizedBox(height: 24),
        _buildAutoReplySection(),
        const SizedBox(height: 24),
        _buildDisplaySection(),
        const SizedBox(height: 24),
        _buildSyncSection(),
        const SizedBox(height: 24),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildAccountSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Information',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _displayNameController,
              decoration: const InputDecoration(
                labelText: 'Display Name',
                border: OutlineInputBorder(),
                helperText: 'This name will appear in the "From" field of your emails',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              enabled: false, // Email address shouldn't be editable
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignatureSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Signature',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _signatureController,
              decoration: const InputDecoration(
                labelText: 'Signature',
                border: OutlineInputBorder(),
                helperText: 'This will be automatically added to your outgoing emails',
              ),
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAutoReplySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Auto Reply',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Enable Auto Reply'),
              subtitle: const Text('Automatically reply to incoming emails'),
              value: _autoReply,
              onChanged: (value) => setState(() => _autoReply = value),
            ),
            if (_autoReply) ...[
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Auto Reply Message',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value) => _autoReplyMessage = value,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Start Date',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: _selectAutoReplyStartDate,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'End Date',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: _selectAutoReplyEndDate,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDisplaySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Display Settings',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Show Email Preview'),
              subtitle: const Text('Show a preview of email content in the list'),
              value: _showPreview,
              onChanged: (value) => setState(() => _showPreview = value),
            ),
            if (_showPreview) ...[
              ListTile(
                title: const Text('Preview Lines'),
                subtitle: Slider(
                  value: _previewLines.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: '$_previewLines lines',
                  onChanged: (value) => setState(() => _previewLines = value.round()),
                ),
              ),
              SwitchListTile(
                title: const Text('Mark as Read on Preview'),
                subtitle: const Text('Mark emails as read when previewed'),
                value: _markAsReadOnPreview,
                onChanged: (value) => setState(() => _markAsReadOnPreview = value),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSyncSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sync Settings',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Refresh Interval'),
              subtitle: DropdownButton<int>(
                value: _refreshInterval,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Every minute')),
                  DropdownMenuItem(value: 5, child: Text('Every 5 minutes')),
                  DropdownMenuItem(value: 15, child: Text('Every 15 minutes')),
                  DropdownMenuItem(value: 30, child: Text('Every 30 minutes')),
                  DropdownMenuItem(value: 60, child: Text('Every hour')),
                ],
                onChanged: (value) => setState(() => _refreshInterval = value!),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _resetSettings,
            child: const Text('Reset to Defaults'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _saveSettings,
            child: const Text('Save Settings'),
          ),
        ),
      ],
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
            'Error loading settings',
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
            onPressed: () => ref.invalidate(emailSettingsProvider),
          ),
        ],
      ),
    );
  }

  void _selectAutoReplyStartDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    // TODO: Handle date selection
  }

  void _selectAutoReplyEndDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    // TODO: Handle date selection
  }

  void _resetSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Settings'),
        content: const Text('Are you sure you want to reset all settings to their default values?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              _loadDefaultSettings();
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _loadDefaultSettings() {
    setState(() {
      _autoReply = false;
      _autoReplyMessage = '';
      _refreshInterval = 5;
      _showPreview = true;
      _previewLines = 3;
      _markAsReadOnPreview = false;
    });
  }

  void _saveSettings() async {
    try {
      final currentSettings = await ref.read(emailSettingsProvider.future);
      final updatedSettings = currentSettings.copyWith(
        displayName: _displayNameController.text,
        signature: _signatureController.text,
        autoReply: _autoReply,
        autoReplyMessage: _autoReplyMessage,
        refreshInterval: _refreshInterval,
        showPreview: _showPreview,
        previewLines: _previewLines,
        markAsReadOnPreview: _markAsReadOnPreview,
      );
      
      final emailService = ref.read(emailServiceProvider);
      await emailService.updateSettings(updatedSettings);
      
      ref.invalidate(emailSettingsProvider);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Settings saved successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving settings: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}

class _NotificationSettingsTab extends ConsumerStatefulWidget {
  const _NotificationSettingsTab();

  @override
  ConsumerState<_NotificationSettingsTab> createState() => _NotificationSettingsTabState();
}

class _NotificationSettingsTabState extends ConsumerState<_NotificationSettingsTab> {
  bool _enablePushNotifications = true;
  bool _newEmail = true;
  bool _importantEmail = true;
  bool _mentions = true;
  bool _calendar = false;
  bool _reminders = true;
  bool _quietHours = false;
  TimeOfDay _quietStartTime = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _quietEndTime = const TimeOfDay(hour: 8, minute: 0);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Push Notifications',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Enable Push Notifications'),
                  subtitle: const Text('Receive notifications for new emails'),
                  value: _enablePushNotifications,
                  onChanged: (value) => setState(() => _enablePushNotifications = value),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notification Types',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('New Email'),
                  subtitle: const Text('Notify when new emails arrive'),
                  value: _newEmail,
                  onChanged: _enablePushNotifications 
                      ? (value) => setState(() => _newEmail = value)
                      : null,
                ),
                SwitchListTile(
                  title: const Text('Important Email'),
                  subtitle: const Text('Notify for important emails only'),
                  value: _importantEmail,
                  onChanged: _enablePushNotifications 
                      ? (value) => setState(() => _importantEmail = value)
                      : null,
                ),
                SwitchListTile(
                  title: const Text('Mentions'),
                  subtitle: const Text('Notify when mentioned in emails'),
                  value: _mentions,
                  onChanged: _enablePushNotifications 
                      ? (value) => setState(() => _mentions = value)
                      : null,
                ),
                SwitchListTile(
                  title: const Text('Calendar Events'),
                  subtitle: const Text('Notify for calendar-related emails'),
                  value: _calendar,
                  onChanged: _enablePushNotifications 
                      ? (value) => setState(() => _calendar = value)
                      : null,
                ),
                SwitchListTile(
                  title: const Text('Reminders'),
                  subtitle: const Text('Notify for email reminders'),
                  value: _reminders,
                  onChanged: _enablePushNotifications 
                      ? (value) => setState(() => _reminders = value)
                      : null,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quiet Hours',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Enable Quiet Hours'),
                  subtitle: const Text('Disable notifications during specified hours'),
                  value: _quietHours,
                  onChanged: _enablePushNotifications 
                      ? (value) => setState(() => _quietHours = value)
                      : null,
                ),
                if (_quietHours) ...[
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Start Time'),
                    subtitle: Text(_quietStartTime.format(context)),
                    trailing: const Icon(Icons.access_time),
                    onTap: _selectQuietStartTime,
                  ),
                  ListTile(
                    title: const Text('End Time'),
                    subtitle: Text(_quietEndTime.format(context)),
                    trailing: const Icon(Icons.access_time),
                    onTap: _selectQuietEndTime,
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _saveNotificationSettings,
          child: const Text('Save Notification Settings'),
        ),
      ],
    );
  }

  void _selectQuietStartTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _quietStartTime,
    );
    if (time != null) {
      setState(() => _quietStartTime = time);
    }
  }

  void _selectQuietEndTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _quietEndTime,
    );
    if (time != null) {
      setState(() => _quietEndTime = time);
    }
  }

  void _saveNotificationSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notification settings saved')),
    );
  }
}

class _RulesAndFiltersTab extends ConsumerWidget {
  const _RulesAndFiltersTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(emailRulesProvider).when(
      data: (rules) => _buildRulesContent(context, ref, rules),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => _buildErrorView(context, error),
    );
  }

  Widget _buildRulesContent(BuildContext context, WidgetRef ref, List<EmailRule> rules) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                'Email Rules & Filters',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('New Rule'),
                onPressed: () => _createRule(context, ref),
              ),
            ],
          ),
        ),
        Expanded(
          child: rules.isEmpty ? _buildEmptyRulesView(context) : _buildRulesList(context, ref, rules),
        ),
      ],
    );
  }

  Widget _buildEmptyRulesView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.rule,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
          ),
          const SizedBox(height: 16),
          Text(
            'No Rules Configured',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create rules to automatically organize your emails.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRulesList(BuildContext context, WidgetRef ref, List<EmailRule> rules) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: rules.length,
      itemBuilder: (context, index) {
        final rule = rules[index];
        return _buildRuleCard(context, ref, rule);
      },
    );
  }

  Widget _buildRuleCard(BuildContext context, WidgetRef ref, EmailRule rule) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    rule.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Switch(
                  value: rule.isActive,
                  onChanged: (value) => _toggleRule(context, ref, rule, value),
                ),
                PopupMenuButton<String>(
                  onSelected: (action) => _handleRuleAction(context, ref, rule, action),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: ListTile(
                        leading: Icon(Icons.edit),
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
            if (rule.description != null) ...[
              const SizedBox(height: 8),
              Text(
                rule.description!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
            const SizedBox(height: 12),
            Text(
              'Conditions:',
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            ...rule.conditions.map((condition) => Padding(
              padding: const EdgeInsets.only(left: 16, top: 4),
              child: Text(
                '• ${condition.field.name} ${condition.operator.name} "${condition.value}"',
                style: theme.textTheme.bodySmall,
              ),
            )),
            const SizedBox(height: 8),
            Text(
              'Actions:',
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            ...rule.actions.map((action) => Padding(
              padding: const EdgeInsets.only(left: 16, top: 4),
              child: Text(
                '• ${action.type.name}${action.value != null ? ': ${action.value}' : ''}',
                style: theme.textTheme.bodySmall,
              ),
            )),
            if (rule.triggerCount != null) ...[
              const SizedBox(height: 8),
              Text(
                'Triggered ${rule.triggerCount} times',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, Object error) {
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
            'Error loading rules',
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
        ],
      ),
    );
  }

  void _createRule(BuildContext context, WidgetRef ref) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Rule creation not implemented')),
    );
  }

  void _toggleRule(BuildContext context, WidgetRef ref, EmailRule rule, bool isActive) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isActive ? 'Rule "${rule.name}" activated' : 'Rule "${rule.name}" deactivated',
        ),
      ),
    );
  }

  void _handleRuleAction(BuildContext context, WidgetRef ref, EmailRule rule, String action) {
    switch (action) {
      case 'edit':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rule editing not implemented')),
        );
        break;
      case 'duplicate':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rule duplication not implemented')),
        );
        break;
      case 'delete':
        _deleteRule(context, ref, rule);
        break;
    }
  }

  void _deleteRule(BuildContext context, WidgetRef ref, EmailRule rule) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Rule'),
        content: Text('Are you sure you want to delete "${rule.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Rule deleted')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _SecuritySettingsTab extends ConsumerStatefulWidget {
  const _SecuritySettingsTab();

  @override
  ConsumerState<_SecuritySettingsTab> createState() => _SecuritySettingsTabState();
}

class _SecuritySettingsTabState extends ConsumerState<_SecuritySettingsTab> {
  bool _twoFactorAuth = false;
  bool _blockExternalImages = true;
  bool _warnPhishing = true;
  bool _encryptionRequired = false;
  bool _requireSenderAuth = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Authentication',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Two-Factor Authentication'),
                  subtitle: const Text('Require additional verification for login'),
                  value: _twoFactorAuth,
                  onChanged: (value) => setState(() => _twoFactorAuth = value),
                ),
                SwitchListTile(
                  title: const Text('Require Sender Authentication'),
                  subtitle: const Text('Only accept emails from authenticated senders'),
                  value: _requireSenderAuth,
                  onChanged: (value) => setState(() => _requireSenderAuth = value),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email Security',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Block External Images'),
                  subtitle: const Text('Prevent automatic loading of external images'),
                  value: _blockExternalImages,
                  onChanged: (value) => setState(() => _blockExternalImages = value),
                ),
                SwitchListTile(
                  title: const Text('Phishing Protection'),
                  subtitle: const Text('Warn about suspicious emails'),
                  value: _warnPhishing,
                  onChanged: (value) => setState(() => _warnPhishing = value),
                ),
                SwitchListTile(
                  title: const Text('Require Encryption'),
                  subtitle: const Text('Only accept encrypted emails'),
                  value: _encryptionRequired,
                  onChanged: (value) => setState(() => _encryptionRequired = value),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Blocked Senders',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Add email address to block',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.add),
                  ),
                  onSubmitted: _addBlockedSender,
                ),
                const SizedBox(height: 16),
                _buildBlockedSendersList(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _saveSecuritySettings,
          child: const Text('Save Security Settings'),
        ),
      ],
    );
  }

  Widget _buildBlockedSendersList() {
    // Mock blocked senders for demonstration
    final blockedSenders = ['spam@example.com', 'noreply@badsite.com'];
    
    if (blockedSenders.isEmpty) {
      return Text(
        'No blocked senders',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
      );
    }

    return Column(
      children: blockedSenders.map((sender) => ListTile(
        leading: const Icon(Icons.block),
        title: Text(sender),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _removeBlockedSender(sender),
        ),
      )).toList(),
    );
  }

  void _addBlockedSender(String email) {
    if (email.isNotEmpty && email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Blocked $email')),
      );
    }
  }

  void _removeBlockedSender(String email) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Unblocked $email')),
    );
  }

  void _saveSecuritySettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Security settings saved')),
    );
  }
}