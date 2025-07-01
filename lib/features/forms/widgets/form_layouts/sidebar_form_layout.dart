import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/form_models.dart';
import '../../providers/form_providers.dart';

class SidebarFormLayout extends ConsumerStatefulWidget {
  const SidebarFormLayout({super.key});

  @override
  ConsumerState<SidebarFormLayout> createState() => _SidebarFormLayoutState();
}

class _SidebarFormLayoutState extends ConsumerState<SidebarFormLayout> {
  String _activeSection = 'account';
  final ScrollController _scrollController = ScrollController();
  
  final Map<String, GlobalKey> _sectionKeys = {
    'account': GlobalKey(),
    'profile': GlobalKey(),
    'security': GlobalKey(),
    'notifications': GlobalKey(),
    'privacy': GlobalKey(),
    'billing': GlobalKey(),
  };
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(formStateProvider('sidebar_form'));
    final formNotifier = ref.read(formStateProvider('sidebar_form').notifier);
    
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          // Mobile layout - sidebar on top
          return Column(
            children: [
              _buildMobileSidebar(),
              const Divider(),
              Expanded(
                child: _buildFormContent(formState, formNotifier),
              ),
            ],
          );
        } else {
          // Desktop layout - sidebar on left
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 250,
                child: _buildDesktopSidebar(),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                child: _buildFormContent(formState, formNotifier),
              ),
            ],
          );
        }
      },
    );
  }
  
  Widget _buildDesktopSidebar() {
    return Container(
      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Settings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildSidebarItem('account', 'Account', Icons.account_circle),
          _buildSidebarItem('profile', 'Profile', Icons.person),
          _buildSidebarItem('security', 'Security', Icons.security),
          _buildSidebarItem('notifications', 'Notifications', Icons.notifications),
          _buildSidebarItem('privacy', 'Privacy', Icons.privacy_tip),
          _buildSidebarItem('billing', 'Billing', Icons.credit_card),
        ],
      ),
    );
  }
  
  Widget _buildMobileSidebar() {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildMobileSidebarChip('account', 'Account', Icons.account_circle),
          _buildMobileSidebarChip('profile', 'Profile', Icons.person),
          _buildMobileSidebarChip('security', 'Security', Icons.security),
          _buildMobileSidebarChip('notifications', 'Notifications', Icons.notifications),
          _buildMobileSidebarChip('privacy', 'Privacy', Icons.privacy_tip),
          _buildMobileSidebarChip('billing', 'Billing', Icons.credit_card),
        ],
      ),
    );
  }
  
  Widget _buildSidebarItem(String key, String label, IconData icon) {
    final isActive = _activeSection == key;
    
    return ListTile(
      leading: Icon(icon, color: isActive ? Theme.of(context).colorScheme.primary : null),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          color: isActive ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
      selected: isActive,
      selectedTileColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
      onTap: () => _navigateToSection(key),
    );
  }
  
  Widget _buildMobileSidebarChip(String key, String label, IconData icon) {
    final isActive = _activeSection == key;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        avatar: Icon(icon, size: 18),
        label: Text(label),
        selected: isActive,
        onSelected: (_) => _navigateToSection(key),
      ),
    );
  }
  
  Widget _buildFormContent(
    FormStateData formState,
    FormStateNotifier formNotifier,
  ) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Account Section
          _buildSection(
            key: 'account',
            title: 'Account Settings',
            description: 'Manage your account information',
            children: [
              TextFormField(
                initialValue: formState.values['username'],
                decoration: const InputDecoration(
                  labelText: 'Username',
                  helperText: 'This is your public display name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => formNotifier.updateFieldValue('username', value),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formState.values['email'],
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => formNotifier.updateFieldValue('email', value),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: formState.values['accountType'],
                decoration: const InputDecoration(
                  labelText: 'Account Type',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'free', child: Text('Free')),
                  DropdownMenuItem(value: 'pro', child: Text('Pro')),
                  DropdownMenuItem(value: 'business', child: Text('Business')),
                ],
                onChanged: (value) => formNotifier.updateFieldValue('accountType', value),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Profile Section
          _buildSection(
            key: 'profile',
            title: 'Profile Information',
            description: 'Update your personal information',
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: formState.values['firstName'],
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => formNotifier.updateFieldValue('firstName', value),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      initialValue: formState.values['lastName'],
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => formNotifier.updateFieldValue('lastName', value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formState.values['bio'],
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  helperText: 'Tell us about yourself',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value) => formNotifier.updateFieldValue('bio', value),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formState.values['website'],
                decoration: const InputDecoration(
                  labelText: 'Website',
                  prefixText: 'https://',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => formNotifier.updateFieldValue('website', value),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Security Section
          _buildSection(
            key: 'security',
            title: 'Security Settings',
            description: 'Keep your account secure',
            children: [
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.password),
                label: const Text('Change Password'),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Two-Factor Authentication'),
                subtitle: const Text('Add an extra layer of security to your account'),
                value: formState.values['twoFactorEnabled'] ?? false,
                onChanged: (value) => formNotifier.updateFieldValue('twoFactorEnabled', value),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 16),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.devices),
                  title: const Text('Active Sessions'),
                  subtitle: const Text('3 devices'),
                  trailing: TextButton(
                    onPressed: () {},
                    child: const Text('Manage'),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Notifications Section
          _buildSection(
            key: 'notifications',
            title: 'Notification Preferences',
            description: 'Choose how you want to be notified',
            children: [
              Text(
                'Email Notifications',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              CheckboxListTile(
                title: const Text('Account Updates'),
                subtitle: const Text('Important updates about your account'),
                value: formState.values['emailAccountUpdates'] ?? true,
                onChanged: (value) => formNotifier.updateFieldValue('emailAccountUpdates', value),
                contentPadding: EdgeInsets.zero,
              ),
              CheckboxListTile(
                title: const Text('Marketing'),
                subtitle: const Text('News, announcements, and offers'),
                value: formState.values['emailMarketing'] ?? false,
                onChanged: (value) => formNotifier.updateFieldValue('emailMarketing', value),
                contentPadding: EdgeInsets.zero,
              ),
              CheckboxListTile(
                title: const Text('Social'),
                subtitle: const Text('Updates from your connections'),
                value: formState.values['emailSocial'] ?? true,
                onChanged: (value) => formNotifier.updateFieldValue('emailSocial', value),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 24),
              Text(
                'Push Notifications',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                title: const Text('Enable Push Notifications'),
                value: formState.values['pushEnabled'] ?? true,
                onChanged: (value) => formNotifier.updateFieldValue('pushEnabled', value),
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Privacy Section
          _buildSection(
            key: 'privacy',
            title: 'Privacy Settings',
            description: 'Control your privacy and data',
            children: [
              DropdownButtonFormField<String>(
                value: formState.values['profileVisibility'],
                decoration: const InputDecoration(
                  labelText: 'Profile Visibility',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'public', child: Text('Public')),
                  DropdownMenuItem(value: 'friends', child: Text('Friends Only')),
                  DropdownMenuItem(value: 'private', child: Text('Private')),
                ],
                onChanged: (value) => formNotifier.updateFieldValue('profileVisibility', value),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Show Online Status'),
                subtitle: const Text('Let others see when you\'re online'),
                value: formState.values['showOnlineStatus'] ?? true,
                onChanged: (value) => formNotifier.updateFieldValue('showOnlineStatus', value),
                contentPadding: EdgeInsets.zero,
              ),
              SwitchListTile(
                title: const Text('Allow Search Engines'),
                subtitle: const Text('Let search engines index your profile'),
                value: formState.values['allowSearchEngines'] ?? false,
                onChanged: (value) => formNotifier.updateFieldValue('allowSearchEngines', value),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download),
                label: const Text('Download My Data'),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Billing Section
          _buildSection(
            key: 'billing',
            title: 'Billing & Subscription',
            description: 'Manage your subscription and payment methods',
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(Icons.credit_card),
                  title: const Text('Current Plan'),
                  subtitle: const Text('Pro Plan - \$9.99/month'),
                  trailing: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Change Plan'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.payment),
                  title: const Text('Payment Method'),
                  subtitle: const Text('•••• •••• •••• 4242'),
                  trailing: TextButton(
                    onPressed: () {},
                    child: const Text('Update'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.receipt),
                label: const Text('View Billing History'),
              ),
            ],
          ),
          
          const SizedBox(height: 48),
          
          // Save Button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => formNotifier.resetForm(),
                child: const Text('Discard Changes'),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                onPressed: formState.isSubmitting
                    ? null
                    : () async {
                        await formNotifier.submitForm((values) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Settings saved successfully!'),
                              backgroundColor: Colors.green,
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
                    : const Icon(Icons.save),
                label: Text(formState.isSubmitting ? 'Saving...' : 'Save Changes'),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildSection({
    required String key,
    required String title,
    required String description,
    required List<Widget> children,
  }) {
    return Container(
      key: _sectionKeys[key],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
          const SizedBox(height: 24),
          ...children,
        ],
      ),
    );
  }
  
  void _navigateToSection(String key) {
    setState(() {
      _activeSection = key;
    });
    
    // Scroll to section
    final targetKey = _sectionKeys[key];
    if (targetKey?.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey!.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}