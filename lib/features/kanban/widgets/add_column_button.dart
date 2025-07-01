import 'package:flutter/material.dart';

class AddColumnButton extends StatefulWidget {
  final Function(String) onAdd;
  
  const AddColumnButton({
    super.key,
    required this.onAdd,
  });
  
  @override
  State<AddColumnButton> createState() => _AddColumnButtonState();
}

class _AddColumnButtonState extends State<AddColumnButton> {
  bool _isAdding = false;
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  
  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    if (_isAdding) {
      return Container(
        width: 320,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Enter column title',
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => _addColumn(),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _cancel,
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _addColumn,
                  child: const Text('Add Column'),
                ),
              ],
            ),
          ],
        ),
      );
    }
    
    return SizedBox(
      width: 320,
      child: OutlinedButton.icon(
        onPressed: () {
          setState(() {
            _isAdding = true;
          });
          // Wait for the widget to rebuild then focus
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _focusNode.requestFocus();
          });
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Column'),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
      ),
    );
  }
  
  void _addColumn() {
    final title = _controller.text.trim();
    if (title.isNotEmpty) {
      widget.onAdd(title);
      _cancel();
    }
  }
  
  void _cancel() {
    setState(() {
      _isAdding = false;
      _controller.clear();
    });
  }
}