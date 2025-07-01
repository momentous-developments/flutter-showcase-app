import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import '../../models/form_models.dart';

class RichTextFormField extends StatefulWidget {
  final FormFieldModel field;
  final RichTextContent? value;
  final String? error;
  final Function(RichTextContent) onChanged;
  
  const RichTextFormField({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });
  
  @override
  State<RichTextFormField> createState() => _RichTextFormFieldState();
}

class _RichTextFormFieldState extends State<RichTextFormField> {
  late QuillController _controller;
  final FocusNode _focusNode = FocusNode();
  
  @override
  void initState() {
    super.initState();
    _controller = QuillController.basic();
    
    // Initialize with existing value if available
    if (widget.value != null) {
      // In a real implementation, you would parse the HTML to Delta
      // For now, we'll just set plain text
      _controller.document = Document()..insert(0, widget.value!.plainText);
    }
    
    // Listen for changes
    _controller.addListener(_onContentChanged);
  }
  
  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
  
  void _onContentChanged() {
    // Get plain text
    final plainText = _controller.document.toPlainText();
    
    // In a real implementation, you would convert Delta to HTML
    final html = '<p>${plainText.replaceAll('\n', '</p><p>')}</p>';
    
    widget.onChanged(RichTextContent(
      html: html,
      plainText: plainText,
    ));
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.field.label != null) ...[
          Row(
            children: [
              Text(
                widget.field.label!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (widget.field.required) ...[
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
        ],
        
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.error != null
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              // Toolbar
              Container(
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: QuillSimpleToolbar(
                  controller: _controller,
                  config: QuillSimpleToolbarConfig(
                    multiRowsDisplay: false,
                  ),
                ),
              ),
              
              // Editor
              Container(
                height: widget.field.options?.maxLines != null
                    ? (widget.field.options!.maxLines! * 20.0)
                    : 200,
                padding: const EdgeInsets.all(16),
                child: QuillEditor.basic(
                  controller: _controller,
                  config: QuillEditorConfig(
                    placeholder: widget.field.placeholder ?? 'Enter text...',
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        if (widget.field.helperText != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.field.helperText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        
        if (widget.error != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.error!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
}

// Simplified Rich Text Editor without external dependencies
class SimpleRichTextFormField extends StatefulWidget {
  final FormFieldModel field;
  final String? value;
  final String? error;
  final Function(String) onChanged;
  
  const SimpleRichTextFormField({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });
  
  @override
  State<SimpleRichTextFormField> createState() => _SimpleRichTextFormFieldState();
}

class _SimpleRichTextFormFieldState extends State<SimpleRichTextFormField> {
  late TextEditingController _controller;
  final Set<_TextFormat> _activeFormats = {};
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.field.label != null) ...[
          Row(
            children: [
              Text(
                widget.field.label!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (widget.field.required) ...[
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
        ],
        
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.error != null
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              // Toolbar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
                child: Row(
                  children: [
                    _buildFormatButton(
                      icon: Icons.format_bold,
                      format: _TextFormat.bold,
                      tooltip: 'Bold',
                    ),
                    _buildFormatButton(
                      icon: Icons.format_italic,
                      format: _TextFormat.italic,
                      tooltip: 'Italic',
                    ),
                    _buildFormatButton(
                      icon: Icons.format_underlined,
                      format: _TextFormat.underline,
                      tooltip: 'Underline',
                    ),
                    const VerticalDivider(width: 16),
                    _buildFormatButton(
                      icon: Icons.format_list_bulleted,
                      format: _TextFormat.bulletList,
                      tooltip: 'Bullet List',
                    ),
                    _buildFormatButton(
                      icon: Icons.format_list_numbered,
                      format: _TextFormat.numberedList,
                      tooltip: 'Numbered List',
                    ),
                    const VerticalDivider(width: 16),
                    _buildFormatButton(
                      icon: Icons.format_quote,
                      format: _TextFormat.quote,
                      tooltip: 'Quote',
                    ),
                    _buildFormatButton(
                      icon: Icons.link,
                      format: _TextFormat.link,
                      tooltip: 'Insert Link',
                    ),
                  ],
                ),
              ),
              
              // Editor
              TextField(
                controller: _controller,
                enabled: !widget.field.disabled,
                readOnly: widget.field.readonly,
                maxLines: widget.field.options?.maxLines ?? 10,
                minLines: widget.field.options?.minLines ?? 5,
                decoration: InputDecoration(
                  hintText: widget.field.placeholder ?? 'Enter text...',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
                onChanged: widget.onChanged,
              ),
            ],
          ),
        ),
        
        if (widget.field.helperText != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.field.helperText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        
        if (widget.error != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.error!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
  
  Widget _buildFormatButton({
    required IconData icon,
    required _TextFormat format,
    required String tooltip,
  }) {
    final isActive = _activeFormats.contains(format);
    
    return IconButton(
      icon: Icon(icon, size: 20),
      tooltip: tooltip,
      isSelected: isActive,
      selectedIcon: Icon(icon, size: 20),
      onPressed: () {
        setState(() {
          if (isActive) {
            _activeFormats.remove(format);
          } else {
            _activeFormats.add(format);
          }
        });
        
        // Apply formatting (simplified - in a real implementation,
        // this would modify the selected text)
        if (format == _TextFormat.link) {
          _showLinkDialog();
        }
      },
    );
  }
  
  void _showLinkDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String url = '';
        return AlertDialog(
          title: const Text('Insert Link'),
          content: TextField(
            decoration: const InputDecoration(
              labelText: 'URL',
              hintText: 'https://example.com',
            ),
            onChanged: (value) => url = value,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                // Insert link at cursor position
                final text = _controller.text;
                final selection = _controller.selection;
                final newText = text.replaceRange(
                  selection.start,
                  selection.end,
                  '[Link]($url)',
                );
                _controller.text = newText;
                widget.onChanged(newText);
                Navigator.of(context).pop();
              },
              child: const Text('Insert'),
            ),
          ],
        );
      },
    );
  }
}

enum _TextFormat {
  bold,
  italic,
  underline,
  bulletList,
  numberedList,
  quote,
  link,
}