import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _emailNotifications = true;
  bool _pushNotifications = false;
  bool _desktopNotifications = true;
  bool _marketingEmails = false;
  bool _securityAlerts = true;
  bool _productUpdates = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Notification Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Notification Methods', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    secondary: const Icon(Icons.email),
                    title: const Text('Email Notifications'),
                    subtitle: const Text('Receive notifications via email'),
                    value: _emailNotifications,
                    onChanged: (value) => setState(() => _emailNotifications = value),
                  ),
                  SwitchListTile(
                    secondary: const Icon(Icons.phone_android),
                    title: const Text('Push Notifications'),
                    subtitle: const Text('Receive push notifications on mobile'),
                    value: _pushNotifications,
                    onChanged: (value) => setState(() => _pushNotifications = value),
                  ),
                  SwitchListTile(
                    secondary: const Icon(Icons.desktop_windows),
                    title: const Text('Desktop Notifications'),
                    subtitle: const Text('Show notifications on desktop'),
                    value: _desktopNotifications,
                    onChanged: (value) => setState(() => _desktopNotifications = value),
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
                  Text('Notification Types', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Security Alerts'),
                    subtitle: const Text('Important security notifications'),
                    value: _securityAlerts,
                    onChanged: (value) => setState(() => _securityAlerts = value),
                  ),
                  SwitchListTile(
                    title: const Text('Product Updates'),
                    subtitle: const Text('New features and improvements'),
                    value: _productUpdates,
                    onChanged: (value) => setState(() => _productUpdates = value),
                  ),
                  SwitchListTile(
                    title: const Text('Marketing Emails'),
                    subtitle: const Text('Promotional content and offers'),
                    value: _marketingEmails,
                    onChanged: (value) => setState(() => _marketingEmails = value),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}