import 'package:flutter/material.dart';
import 'widgets/base_dialog.dart';
import 'widgets/dialog_footer.dart';

/// Dialog for help and support options
class HelpSupportDialog extends StatefulWidget {
  const HelpSupportDialog({
    super.key,
    this.onContactSupport,
    this.onCancel,
  });

  final Function(String type, String message)? onContactSupport;
  final VoidCallback? onCancel;

  @override
  State<HelpSupportDialog> createState() => _HelpSupportDialogState();
}

class _HelpSupportDialogState extends State<HelpSupportDialog> {
  String _selectedCategory = 'general';
  String _message = '';
  bool _isLoading = false;

  final List<Map<String, dynamic>> _categories = [
    {'id': 'general', 'name': 'General Question', 'icon': Icons.help},
    {'id': 'technical', 'name': 'Technical Issue', 'icon': Icons.bug_report},
    {'id': 'billing', 'name': 'Billing', 'icon': Icons.payment},
    {'id': 'feature', 'name': 'Feature Request', 'icon': Icons.lightbulb},
  ];

  final List<Map<String, dynamic>> _quickHelp = [
    {'title': 'Getting Started Guide', 'icon': Icons.play_arrow},
    {'title': 'Frequently Asked Questions', 'icon': Icons.question_answer},
    {'title': 'Video Tutorials', 'icon': Icons.video_library},
    {'title': 'Documentation', 'icon': Icons.book},
  ];

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Help & Support',
      subtitle: 'Get help or contact our support team',
      size: DialogSize.medium,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuickHelpSection(),
            const SizedBox(height: 24),
            _buildContactSupportSection(),
          ],
        ),
      ),
      actions: [
        DialogActionButton.outlined(
          text: 'Close',
          onPressed: widget.onCancel ?? () => Navigator.of(context).pop(),
        ),
        DialogActionButton.primary(
          text: 'Send Message',
          onPressed: _message.isNotEmpty && !_isLoading ? _handleContactSupport : null,
          isLoading: _isLoading,
        ),
      ],
    );
  }

  Widget _buildQuickHelpSection() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Help',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _quickHelp.length,
          itemBuilder: (context, index) {
            final item = _quickHelp[index];
            return Material(
              color: colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () => _openHelpResource(item['title']),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Icon(
                        item['icon'],
                        size: 20,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item['title'],
                          style: theme.textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildContactSupportSection() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Support',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Category',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _categories.map((category) {
            return ChoiceChip(
              avatar: Icon(
                category['icon'],
                size: 16,
              ),
              label: Text(category['name']),
              selected: _selectedCategory == category['id'],
              onSelected: (selected) {
                if (selected) {
                  setState(() => _selectedCategory = category['id']);
                }
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        Text(
          'Message',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Describe your issue or question...',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => setState(() => _message = value),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                Icons.schedule,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                'We typically respond within 24 hours',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _openHelpResource(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening: $title')),
    );
  }

  void _handleContactSupport() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

    widget.onContactSupport?.call(_selectedCategory, _message);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Support message sent successfully')),
      );
      Navigator.of(context).pop();
    }
  }
}