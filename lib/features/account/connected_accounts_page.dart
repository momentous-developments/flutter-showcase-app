import 'package:flutter/material.dart';

class ConnectedAccountsPage extends StatefulWidget {
  const ConnectedAccountsPage({super.key});

  @override
  State<ConnectedAccountsPage> createState() => _ConnectedAccountsPageState();
}

class _ConnectedAccountsPageState extends State<ConnectedAccountsPage> {
  final List<ConnectedAccount> _accounts = [
    ConnectedAccount(provider: 'Google', email: 'john@gmail.com', isConnected: true),
    ConnectedAccount(provider: 'GitHub', email: 'john@github.com', isConnected: true),
    ConnectedAccount(provider: 'Facebook', email: '', isConnected: false),
    ConnectedAccount(provider: 'LinkedIn', email: '', isConnected: false),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Connected Accounts')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Social Accounts', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Connect your social accounts for easier login and sharing.',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ..._accounts.map((account) => Card(
            child: ListTile(
              leading: Icon(_getProviderIcon(account.provider)),
              title: Text(account.provider),
              subtitle: account.isConnected ? Text(account.email) : const Text('Not connected'),
              trailing: account.isConnected
                ? TextButton(
                    onPressed: () => _disconnectAccount(account),
                    child: const Text('Disconnect'),
                  )
                : FilledButton(
                    onPressed: () => _connectAccount(account),
                    child: const Text('Connect'),
                  ),
            ),
          )),
        ],
      ),
    );
  }

  IconData _getProviderIcon(String provider) {
    switch (provider) {
      case 'Google': return Icons.g_mobiledata;
      case 'GitHub': return Icons.code;
      case 'Facebook': return Icons.facebook;
      case 'LinkedIn': return Icons.business;
      default: return Icons.link;
    }
  }

  void _connectAccount(ConnectedAccount account) {
    setState(() {
      account.isConnected = true;
      account.email = 'john@${account.provider.toLowerCase()}.com';
    });
  }

  void _disconnectAccount(ConnectedAccount account) {
    setState(() {
      account.isConnected = false;
      account.email = '';
    });
  }
}

class ConnectedAccount {
  final String provider;
  String email;
  bool isConnected;

  ConnectedAccount({required this.provider, required this.email, required this.isConnected});
}