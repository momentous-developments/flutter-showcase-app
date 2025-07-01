import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_models.dart';
import '../providers/chat_providers.dart';

class ChatSettingsView extends ConsumerStatefulWidget {
  const ChatSettingsView({super.key});

  @override
  ConsumerState<ChatSettingsView> createState() => _ChatSettingsViewState();
}

class _ChatSettingsViewState extends ConsumerState<ChatSettingsView> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(chatSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Settings'),
      ),
      body: ListView(
        children: [
          _buildNotificationSettings(settings),
          _buildChatSettings(settings),
          _buildPrivacySettings(settings),
          _buildStorageSettings(settings),
          _buildAccountActions(),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings(ChatSettings settings) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Notifications',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SwitchListTile(
            title: const Text('Enable Notifications'),
            subtitle: const Text('Receive push notifications for new messages'),
            value: settings.notificationsEnabled,
            onChanged: (value) => _updateSettings(
              settings.copyWith(notificationsEnabled: value),
            ),
          ),
          SwitchListTile(
            title: const Text('Sound'),
            subtitle: const Text('Play sound for new messages'),
            value: settings.soundEnabled,
            onChanged: settings.notificationsEnabled
                ? (value) => _updateSettings(
                      settings.copyWith(soundEnabled: value),
                    )
                : null,
          ),
          SwitchListTile(
            title: const Text('Vibration'),
            subtitle: const Text('Vibrate for new messages'),
            value: settings.vibrationEnabled,
            onChanged: settings.notificationsEnabled
                ? (value) => _updateSettings(
                      settings.copyWith(vibrationEnabled: value),
                    )
                : null,
          ),
          ListTile(
            title: const Text('Notification Schedule'),
            subtitle: const Text('Customize notification times'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _showNotificationSchedule,
          ),
        ],
      ),
    );
  }

  Widget _buildChatSettings(ChatSettings settings) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Chat Appearance',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text('Theme'),
            subtitle: Text(_getThemeName(settings.theme)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showThemeSelector(settings),
          ),
          ListTile(
            title: const Text('Bubble Style'),
            subtitle: Text(_getBubbleStyleName(settings.bubbleStyle)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showBubbleStyleSelector(settings),
          ),
          ListTile(
            title: const Text('Font Size'),
            subtitle: Text('${settings.fontSize.toInt()}px'),
            trailing: SizedBox(
              width: 100,
              child: Slider(
                value: settings.fontSize,
                min: 10,
                max: 24,
                divisions: 14,
                onChanged: (value) => _updateSettings(
                  settings.copyWith(fontSize: value),
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: Text(_getLanguageName(settings.language)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLanguageSelector(settings),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySettings(ChatSettings settings) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Privacy',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SwitchListTile(
            title: const Text('Show Online Status'),
            subtitle: const Text('Let others see when you\'re online'),
            value: settings.showOnlineStatus,
            onChanged: (value) => _updateSettings(
              settings.copyWith(showOnlineStatus: value),
            ),
          ),
          SwitchListTile(
            title: const Text('Read Receipts'),
            subtitle: const Text('Let others see when you\'ve read their messages'),
            value: settings.showReadReceipts,
            onChanged: (value) => _updateSettings(
              settings.copyWith(showReadReceipts: value),
            ),
          ),
          ListTile(
            title: const Text('Blocked Users'),
            subtitle: const Text('Manage blocked contacts'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _showBlockedUsers,
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.open_in_new),
            onTap: _openPrivacyPolicy,
          ),
        ],
      ),
    );
  }

  Widget _buildStorageSettings(ChatSettings settings) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Storage & Data',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SwitchListTile(
            title: const Text('Auto-delete Messages'),
            subtitle: Text(settings.autoDeleteMessages
                ? 'Messages deleted after ${settings.autoDeleteDays} days'
                : 'Messages are kept indefinitely'),
            value: settings.autoDeleteMessages,
            onChanged: (value) => _updateSettings(
              settings.copyWith(autoDeleteMessages: value),
            ),
          ),
          if (settings.autoDeleteMessages)
            ListTile(
              title: const Text('Auto-delete Duration'),
              subtitle: Text('${settings.autoDeleteDays} days'),
              trailing: SizedBox(
                width: 100,
                child: DropdownButton<int>(
                  value: settings.autoDeleteDays,
                  isExpanded: true,
                  items: [7, 30, 90, 365].map((days) {
                    return DropdownMenuItem(
                      value: days,
                      child: Text('$days days'),
                    );
                  }).toList(),
                  onChanged: (value) => _updateSettings(
                    settings.copyWith(autoDeleteDays: value ?? 30),
                  ),
                ),
              ),
            ),
          ListTile(
            title: const Text('Storage Usage'),
            subtitle: const Text('1.2 GB used'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _showStorageUsage,
          ),
          ListTile(
            title: const Text('Export Chat History'),
            subtitle: const Text('Download your chat data'),
            trailing: const Icon(Icons.download),
            onTap: _exportChatHistory,
          ),
          ListTile(
            title: const Text('Clear All Chats'),
            subtitle: const Text('Delete all conversations'),
            trailing: const Icon(Icons.delete, color: Colors.red),
            onTap: _clearAllChats,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountActions() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Account',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text('Change Phone Number'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _changePhoneNumber,
          ),
          ListTile(
            title: const Text('Two-Factor Authentication'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _setupTwoFactor,
          ),
          ListTile(
            title: const Text('Request Account Info'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _requestAccountInfo,
          ),
          ListTile(
            title: const Text('Delete My Account'),
            trailing: const Icon(Icons.warning, color: Colors.red),
            onTap: _deleteAccount,
          ),
        ],
      ),
    );
  }

  void _updateSettings(ChatSettings newSettings) {
    ref.read(chatSettingsProvider.notifier).state = newSettings;
    // TODO: Save to backend
  }

  String _getThemeName(ChatTheme theme) {
    switch (theme) {
      case ChatTheme.material:
        return 'Material Design';
      case ChatTheme.ios:
        return 'iOS Style';
      case ChatTheme.whatsapp:
        return 'WhatsApp Style';
      case ChatTheme.telegram:
        return 'Telegram Style';
      case ChatTheme.discord:
        return 'Discord Style';
      case ChatTheme.custom:
        return 'Custom';
    }
  }

  String _getBubbleStyleName(ChatBubbleStyle style) {
    switch (style) {
      case ChatBubbleStyle.modern:
        return 'Modern';
      case ChatBubbleStyle.classic:
        return 'Classic';
      case ChatBubbleStyle.minimal:
        return 'Minimal';
      case ChatBubbleStyle.rounded:
        return 'Rounded';
      case ChatBubbleStyle.square:
        return 'Square';
    }
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'es':
        return 'Spanish';
      case 'fr':
        return 'French';
      case 'de':
        return 'German';
      case 'it':
        return 'Italian';
      case 'pt':
        return 'Portuguese';
      case 'ru':
        return 'Russian';
      case 'zh':
        return 'Chinese';
      case 'ja':
        return 'Japanese';
      case 'ko':
        return 'Korean';
      default:
        return 'English';
    }
  }

  void _showThemeSelector(ChatSettings settings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ChatTheme.values.map((theme) {
            return RadioListTile<ChatTheme>(
              title: Text(_getThemeName(theme)),
              value: theme,
              groupValue: settings.theme,
              onChanged: (value) {
                Navigator.pop(context);
                if (value != null) {
                  _updateSettings(settings.copyWith(theme: value));
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showBubbleStyleSelector(ChatSettings settings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Bubble Style'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ChatBubbleStyle.values.map((style) {
            return RadioListTile<ChatBubbleStyle>(
              title: Text(_getBubbleStyleName(style)),
              value: style,
              groupValue: settings.bubbleStyle,
              onChanged: (value) {
                Navigator.pop(context);
                if (value != null) {
                  _updateSettings(settings.copyWith(bubbleStyle: value));
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showLanguageSelector(ChatSettings settings) {
    final languages = ['en', 'es', 'fr', 'de', 'it', 'pt', 'ru', 'zh', 'ja', 'ko'];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView(
            children: languages.map((lang) {
              return RadioListTile<String>(
                title: Text(_getLanguageName(lang)),
                value: lang,
                groupValue: settings.language,
                onChanged: (value) {
                  Navigator.pop(context);
                  if (value != null) {
                    _updateSettings(settings.copyWith(language: value));
                  }
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _showNotificationSchedule() {
    // TODO: Show notification schedule settings
  }

  void _showBlockedUsers() {
    // TODO: Show blocked users list
  }

  void _openPrivacyPolicy() {
    // TODO: Open privacy policy
  }

  void _showStorageUsage() {
    // TODO: Show storage usage details
  }

  void _exportChatHistory() {
    // TODO: Export chat history
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exporting chat history...')),
    );
  }

  void _clearAllChats() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Chats'),
        content: const Text(
          'This will permanently delete all your conversations and cannot be undone. Are you sure?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Clear all chats
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All chats cleared')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  void _changePhoneNumber() {
    // TODO: Change phone number flow
  }

  void _setupTwoFactor() {
    // TODO: Two-factor authentication setup
  }

  void _requestAccountInfo() {
    // TODO: Request account information
  }

  void _deleteAccount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This will permanently delete your account and all data. This action cannot be undone. Are you absolutely sure?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _confirmDeleteAccount();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Final Confirmation'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Type "DELETE" to confirm account deletion:'),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Type DELETE here',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Delete account
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account deletion requested')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }
}