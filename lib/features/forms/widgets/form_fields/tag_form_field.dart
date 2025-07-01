import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/form_models.dart';

class TagFormField extends StatefulWidget {
  final FormFieldModel field;
  final List<TagModel>? value;
  final String? error;
  final Function(List<TagModel>) onChanged;
  
  const TagFormField({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });
  
  @override
  State<TagFormField> createState() => _TagFormFieldState();
}

class _TagFormFieldState extends State<TagFormField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  final List<TagModel> _tags = [];
  List<TagModel> _suggestions = [];
  bool _showSuggestions = false;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChanged);
    
    if (widget.value != null) {
      _tags.addAll(widget.value!);
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
  
  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      setState(() {
        _showSuggestions = false;
      });
    }
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
              // Tags display
              if (_tags.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _tags.map((tag) => _buildTag(tag)).toList(),
                  ),
                ),
              
              // Input field
              if (!widget.field.disabled)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            hintText: widget.field.placeholder ?? 'Add tag...',
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onChanged: _onInputChanged,
                          onSubmitted: _onSubmitted,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'[,;]')),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _controller.text.isNotEmpty
                            ? () => _onSubmitted(_controller.text)
                            : null,
                        splashRadius: 20,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        
        // Suggestions dropdown
        if (_showSuggestions && _suggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 4),
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = _suggestions[index];
                return ListTile(
                  leading: suggestion.icon != null
                      ? Icon(suggestion.icon, size: 20)
                      : null,
                  title: Text(suggestion.label),
                  dense: true,
                  onTap: () => _addTag(suggestion),
                );
              },
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
  
  Widget _buildTag(TagModel tag) {
    return Chip(
      label: Text(tag.label),
      avatar: tag.icon != null
          ? Icon(tag.icon, size: 18)
          : null,
      backgroundColor: tag.color ?? Theme.of(context).colorScheme.secondaryContainer,
      deleteIcon: tag.removable == false ? null : const Icon(Icons.close, size: 18),
      onDeleted: tag.removable == false ? null : () => _removeTag(tag),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
  
  void _onInputChanged(String value) {
    if (value.isEmpty) {
      setState(() {
        _showSuggestions = false;
        _suggestions = [];
      });
      return;
    }
    
    // Generate suggestions (this would normally come from an API or predefined list)
    setState(() {
      _suggestions = _generateSuggestions(value);
      _showSuggestions = _suggestions.isNotEmpty;
    });
  }
  
  void _onSubmitted(String value) {
    if (value.isEmpty) return;
    
    final tag = TagModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      label: value.trim(),
      value: value.trim().toLowerCase(),
      removable: true,
    );
    
    _addTag(tag);
  }
  
  void _addTag(TagModel tag) {
    if (_tags.any((t) => t.value == tag.value)) {
      // Tag already exists
      return;
    }
    
    setState(() {
      _tags.add(tag);
      _controller.clear();
      _showSuggestions = false;
      _suggestions = [];
    });
    
    widget.onChanged(_tags);
  }
  
  void _removeTag(TagModel tag) {
    setState(() {
      _tags.remove(tag);
    });
    
    widget.onChanged(_tags);
  }
  
  List<TagModel> _generateSuggestions(String query) {
    // This is a mock implementation. In a real app, this would:
    // 1. Query an API for suggestions
    // 2. Filter from a predefined list
    // 3. Use autocomplete functionality
    
    final commonTags = [
      'flutter',
      'dart',
      'mobile',
      'web',
      'development',
      'ui',
      'ux',
      'design',
      'programming',
      'technology',
    ];
    
    return commonTags
        .where((tag) => tag.contains(query.toLowerCase()) && 
               !_tags.any((t) => t.value == tag))
        .map((tag) => TagModel(
              id: tag,
              label: tag,
              value: tag,
              removable: true,
            ))
        .take(5)
        .toList();
  }
}

class TagInputFormField extends StatefulWidget {
  final FormFieldModel field;
  final List<String>? value;
  final String? error;
  final Function(List<String>) onChanged;
  
  const TagInputFormField({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });
  
  @override
  State<TagInputFormField> createState() => _TagInputFormFieldState();
}

class _TagInputFormFieldState extends State<TagInputFormField> {
  late TextEditingController _controller;
  final List<String> _tags = [];
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    if (widget.value != null) {
      _tags.addAll(widget.value!);
    }
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
        
        TextField(
          controller: _controller,
          enabled: !widget.field.disabled,
          decoration: InputDecoration(
            hintText: widget.field.placeholder ?? 'Enter tags separated by commas',
            helperText: widget.field.helperText,
            errorText: widget.error,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: IconButton(
              icon: const Icon(Icons.add),
              onPressed: widget.field.disabled ? null : _addTags,
            ),
          ),
          onSubmitted: (_) => _addTags(),
        ),
        
        if (_tags.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _tags.map((tag) {
              return Chip(
                label: Text(tag),
                onDeleted: widget.field.disabled
                    ? null
                    : () {
                        setState(() {
                          _tags.remove(tag);
                        });
                        widget.onChanged(_tags);
                      },
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
  
  void _addTags() {
    final input = _controller.text.trim();
    if (input.isEmpty) return;
    
    final newTags = input
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty && !_tags.contains(tag))
        .toList();
    
    if (newTags.isNotEmpty) {
      setState(() {
        _tags.addAll(newTags);
        _controller.clear();
      });
      widget.onChanged(_tags);
    }
  }
}