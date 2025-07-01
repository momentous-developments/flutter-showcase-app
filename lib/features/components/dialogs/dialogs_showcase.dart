import 'package:flutter/material.dart';
import '../../../components/dialogs/index.dart';

/// Showcase for all dialog components
class DialogsShowcase extends StatefulWidget {
  const DialogsShowcase({super.key});

  @override
  State<DialogsShowcase> createState() => _DialogsShowcaseState();
}

class _DialogsShowcaseState extends State<DialogsShowcase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dialog Components'),
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Core Dialogs',
              description: 'Essential dialog components for common use cases',
              dialogs: [
                DialogItem(
                  title: 'Address Dialog',
                  description: 'Add or edit address information',
                  onTap: () => _showAddressDialog(),
                ),
                DialogItem(
                  title: 'Billing Card Dialog',
                  description: 'Manage payment card information',
                  onTap: () => _showBillingCardDialog(),
                ),
                DialogItem(
                  title: 'Confirmation Dialog',
                  description: 'Confirm user actions',
                  onTap: () => _showConfirmationDialog(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Wizard Dialogs',
              description: 'Multi-step processes and guided workflows',
              dialogs: [
                DialogItem(
                  title: 'Create App Dialog',
                  description: 'Multi-step app creation wizard',
                  onTap: () => _showCreateAppDialog(),
                ),
                DialogItem(
                  title: 'Two-Factor Auth Dialog',
                  description: 'Setup 2FA security',
                  onTap: () => _showTwoFactorAuthDialog(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Form Dialogs',
              description: 'Data entry and editing dialogs',
              dialogs: [
                DialogItem(
                  title: 'Edit User Info Dialog',
                  description: 'Edit user profile information',
                  onTap: () => _showEditUserInfoDialog(),
                ),
                DialogItem(
                  title: 'Payment Method Dialog',
                  description: 'Configure payment methods',
                  onTap: () => _showPaymentMethodDialog(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Selection Dialogs',
              description: 'Choose from options and manage selections',
              dialogs: [
                DialogItem(
                  title: 'Pricing Dialog',
                  description: 'Select subscription plans',
                  onTap: () => _showPricingDialog(),
                ),
                DialogItem(
                  title: 'Payment Providers Dialog',
                  description: 'Choose payment processor',
                  onTap: () => _showPaymentProvidersDialog(),
                ),
                DialogItem(
                  title: 'Permission Dialog',
                  description: 'Manage user permissions',
                  onTap: () => _showPermissionDialog(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Advanced Dialogs',
              description: 'Complex data management dialogs',
              dialogs: [
                DialogItem(
                  title: 'User List Dialog',
                  description: 'Select users from list',
                  onTap: () => _showUserListDialog(),
                ),
                DialogItem(
                  title: 'Role Management Dialog',
                  description: 'Assign user roles',
                  onTap: () => _showRoleManagementDialog(),
                ),
                DialogItem(
                  title: 'Notification Settings Dialog',
                  description: 'Configure notifications',
                  onTap: () => _showNotificationSettingsDialog(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Utility Dialogs',
              description: 'Special purpose and configuration dialogs',
              dialogs: [
                DialogItem(
                  title: 'Data Export Dialog',
                  description: 'Export data in various formats',
                  onTap: () => _showDataExportDialog(),
                ),
                DialogItem(
                  title: 'Theme Customization Dialog',
                  description: 'Customize app appearance',
                  onTap: () => _showThemeCustomizationDialog(),
                ),
                DialogItem(
                  title: 'Search Filters Dialog',
                  description: 'Advanced search options',
                  onTap: () => _showSearchFiltersDialog(),
                ),
                DialogItem(
                  title: 'Loading Dialog',
                  description: 'Show loading state',
                  onTap: () => _showLoadingDialog(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Action Dialogs',
              description: 'Perform operations and manage content',
              dialogs: [
                DialogItem(
                  title: 'Bulk Actions Dialog',
                  description: 'Perform bulk operations',
                  onTap: () => _showBulkActionsDialog(),
                ),
                DialogItem(
                  title: 'Calendar Event Dialog',
                  description: 'Create calendar events',
                  onTap: () => _showCalendarEventDialog(),
                ),
                DialogItem(
                  title: 'File Upload Dialog',
                  description: 'Upload files with progress',
                  onTap: () => _showFileUploadDialog(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Specialized Dialogs',
              description: 'Task-specific and feature dialogs',
              dialogs: [
                DialogItem(
                  title: 'Image Cropper Dialog',
                  description: 'Crop and edit images',
                  onTap: () => _showImageCropperDialog(),
                ),
                DialogItem(
                  title: 'Quick Settings Dialog',
                  description: 'Fast access to settings',
                  onTap: () => _showQuickSettingsDialog(),
                ),
                DialogItem(
                  title: 'Help & Support Dialog',
                  description: 'Get help and contact support',
                  onTap: () => _showHelpSupportDialog(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Additional Dialogs',
              description: 'Marketing and engagement dialogs',
              dialogs: [
                DialogItem(
                  title: 'Refer & Earn Dialog',
                  description: 'Referral program information',
                  onTap: () => _showReferEarnDialog(),
                ),
                DialogItem(
                  title: 'Share Project Dialog',
                  description: 'Share with team members',
                  onTap: () => _showShareProjectDialog(),
                ),
                DialogItem(
                  title: 'Upgrade Plan Dialog',
                  description: 'Upgrade subscription plan',
                  onTap: () => _showUpgradePlanDialog(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String description,
    required List<DialogItem> dialogs,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        ...dialogs.map((dialog) => _buildDialogCard(dialog)).toList(),
      ],
    );
  }

  Widget _buildDialogCard(DialogItem dialog) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 0,
        color: colorScheme.surfaceVariant,
        child: ListTile(
          title: Text(
            dialog.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(dialog.description),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: dialog.onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _showAddressDialog() {
    showDialog(
      context: context,
      builder: (context) => AddressDialog(
        onSave: (data) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Address saved: ${data.firstName} ${data.lastName}',
              ),
            ),
          );
        },
      ),
    );
  }

  void _showBillingCardDialog() {
    showDialog(
      context: context,
      builder: (context) => BillingCardDialog(
        onSave: (data) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Card saved: ${data.cardholderName}',
              ),
            ),
          );
        },
      ),
    );
  }

  void _showConfirmationDialog() {
    ConfirmationDialog.show(
      context,
      type: ConfirmationType.deleteAccount,
      onConfirm: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account deleted')),
        );
      },
    );
  }

  void _showCreateAppDialog() {
    showDialog(
      context: context,
      builder: (context) => CreateAppDialog(
        onComplete: (data) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('App created: ${data.name}'),
            ),
          );
        },
      ),
    );
  }

  void _showTwoFactorAuthDialog() {
    showDialog(
      context: context,
      builder: (context) => TwoFactorAuthDialog(
        onComplete: (data) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('2FA enabled: ${data.method}'),
            ),
          );
        },
      ),
    );
  }

  void _showEditUserInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => EditUserInfoDialog(
        userData: const UserInfoData(
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          role: 'Developer',
          department: 'Engineering',
        ),
        onSave: (data) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User updated: ${data.firstName} ${data.lastName}'),
            ),
          );
        },
      ),
    );
  }

  void _showPaymentMethodDialog() {
    showDialog(
      context: context,
      builder: (context) => PaymentMethodDialog(
        onSave: (data) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payment method saved: ${data.type}'),
            ),
          );
        },
      ),
    );
  }

  void _showLoadingDialog() {
    LoadingDialog.show(
      context,
      message: 'Processing your request...',
      canCancel: true,
    );

    // Auto-hide after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        LoadingDialog.hide(context);
      }
    });
  }

  // Selection Dialogs
  void _showPricingDialog() {
    showDialog(
      context: context,
      builder: (context) => PricingDialog(
        currentPlan: 'basic',
        onPlanSelected: (plan) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected plan: ${plan.name}')),
          );
        },
      ),
    );
  }

  void _showPaymentProvidersDialog() {
    showDialog(
      context: context,
      builder: (context) => PaymentProvidersDialog(
        onSelect: (provider) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected provider: $provider')),
          );
        },
      ),
    );
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => PermissionDialog(
        onSave: (permissions) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Updated ${permissions.length} permissions')),
          );
        },
      ),
    );
  }

  // Advanced Dialogs
  void _showUserListDialog() {
    showDialog(
      context: context,
      builder: (context) => UserListDialog(
        multiSelect: true,
        onSelect: (users) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected ${users.length} user(s)')),
          );
        },
      ),
    );
  }

  void _showRoleManagementDialog() {
    showDialog(
      context: context,
      builder: (context) => RoleManagementDialog(
        currentRole: 'viewer',
        onRoleChanged: (roleId) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Role changed to: $roleId')),
          );
        },
      ),
    );
  }

  void _showNotificationSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => NotificationSettingsDialog(
        onSave: (settings) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Notification settings saved')),
          );
        },
      ),
    );
  }

  // Utility Dialogs
  void _showDataExportDialog() {
    showDialog(
      context: context,
      builder: (context) => DataExportDialog(
        onExport: (format, fields) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Exporting ${fields.length} fields as $format')),
          );
        },
      ),
    );
  }

  void _showThemeCustomizationDialog() {
    showDialog(
      context: context,
      builder: (context) => ThemeCustomizationDialog(
        onThemeChanged: (themeSettings) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Theme settings applied')),
          );
        },
      ),
    );
  }

  void _showSearchFiltersDialog() {
    showDialog(
      context: context,
      builder: (context) => SearchFiltersDialog(
        onApply: (filters) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Applied ${filters.length} filters')),
          );
        },
      ),
    );
  }

  // Action Dialogs
  void _showBulkActionsDialog() {
    showDialog(
      context: context,
      builder: (context) => BulkActionsDialog(
        itemCount: 15,
        onAction: (action) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Performed action: $action')),
          );
        },
      ),
    );
  }

  void _showCalendarEventDialog() {
    showDialog(
      context: context,
      builder: (context) => CalendarEventDialog(
        onSave: (eventData) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Event created: ${eventData.title}')),
          );
        },
      ),
    );
  }

  void _showFileUploadDialog() {
    showDialog(
      context: context,
      builder: (context) => FileUploadDialog(
        onUpload: (filePaths) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Uploaded ${filePaths.length} file(s)')),
          );
        },
      ),
    );
  }

  // Specialized Dialogs
  void _showImageCropperDialog() {
    showDialog(
      context: context,
      builder: (context) => ImageCropperDialog(
        imagePath: 'sample_image.jpg',
        onCrop: (croppedPath) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image cropped: $croppedPath')),
          );
        },
      ),
    );
  }

  void _showQuickSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => QuickSettingsDialog(
        onSettingsChanged: (settings) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Quick settings applied')),
          );
        },
      ),
    );
  }

  void _showHelpSupportDialog() {
    showDialog(
      context: context,
      builder: (context) => HelpSupportDialog(
        onContactSupport: (type, message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Support message sent: $type')),
          );
        },
      ),
    );
  }

  // Additional Dialogs
  void _showReferEarnDialog() {
    showDialog(
      context: context,
      builder: (context) => const ReferEarnDialog(),
    );
  }

  void _showShareProjectDialog() {
    showDialog(
      context: context,
      builder: (context) => ShareProjectDialog(
        projectName: 'My Project',
        onShare: (emails, permission) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Shared with ${emails.length} people as $permission'),
            ),
          );
        },
      ),
    );
  }

  void _showUpgradePlanDialog() {
    showDialog(
      context: context,
      builder: (context) => UpgradePlanDialog(
        currentPlan: 'basic',
        onUpgrade: (planId) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Upgraded to: $planId')),
          );
        },
      ),
    );
  }
}

class DialogItem {
  final String title;
  final String description;
  final VoidCallback onTap;

  const DialogItem({
    required this.title,
    required this.description,
    required this.onTap,
  });
}