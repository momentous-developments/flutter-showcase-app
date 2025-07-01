import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApiKeysPage extends StatefulWidget {
  const ApiKeysPage({super.key});

  @override
  State<ApiKeysPage> createState() => _ApiKeysPageState();
}

class _ApiKeysPageState extends State<ApiKeysPage> {
  final List<ApiKey> _apiKeys = [
    ApiKey(name: 'Production API', key: 'pk_live_abc123...', createdAt: DateTime.now().subtract(const Duration(days: 30))),
    ApiKey(name: 'Development API', key: 'pk_test_def456...', createdAt: DateTime.now().subtract(const Duration(days: 15))),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('API Keys'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _createNewApiKey,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Text('API Keys', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Use API keys to authenticate requests to our API. Keep your keys secure and never share them publicly.',
                    style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ..._apiKeys.map((apiKey) => Card(
            child: ListTile(
              title: Text(apiKey.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(apiKey.key),
                  Text('Created: ${apiKey.createdAt.toString().split(' ')[0]}', style: theme.textTheme.bodySmall),
                ],
              ),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text('Copy'),
                    onTap: () => Clipboard.setData(ClipboardData(text: apiKey.key)),
                  ),
                  PopupMenuItem(
                    child: const Text('Regenerate'),
                    onTap: () => _regenerateApiKey(apiKey),
                  ),
                  PopupMenuItem(
                    child: const Text('Delete'),
                    onTap: () => _deleteApiKey(apiKey),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  void _createNewApiKey() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New API Key'),
        content: const TextField(
          decoration: InputDecoration(labelText: 'Key Name'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Create')),
        ],
      ),
    );
  }

  void _regenerateApiKey(ApiKey apiKey) {}
  void _deleteApiKey(ApiKey apiKey) {}
}

class ApiKey {
  final String name;
  final String key;
  final DateTime createdAt;

  ApiKey({required this.name, required this.key, required this.createdAt});
}