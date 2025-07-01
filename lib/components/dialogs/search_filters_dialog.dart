import 'package:flutter/material.dart';
import 'widgets/form_dialog.dart';

/// Dialog for advanced search filters
class SearchFiltersDialog extends StatefulWidget {
  const SearchFiltersDialog({
    super.key,
    this.initialFilters,
    this.onApply,
    this.onCancel,
  });

  final Map<String, dynamic>? initialFilters;
  final Function(Map<String, dynamic>)? onApply;
  final VoidCallback? onCancel;

  @override
  State<SearchFiltersDialog> createState() => _SearchFiltersDialogState();
}

class _SearchFiltersDialogState extends State<SearchFiltersDialog> {
  final Map<String, dynamic> _filters = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _filters.addAll(widget.initialFilters ?? {});
  }

  @override
  Widget build(BuildContext context) {
    return FormDialog(
      title: 'Search Filters',
      subtitle: 'Refine your search results',
      submitText: 'Apply Filters',
      cancelText: 'Cancel',
      isLoading: _isLoading,
      canSubmit: true,
      onSubmit: _handleApply,
      onCancel: widget.onCancel,
      child: Column(
        children: [
          DialogFormField(
            label: 'Date Range',
            hint: 'Select date range',
            value: _filters['dateRange']?.toString() ?? '',
            onChanged: (value) => _filters['dateRange'] = value,
          ),
          DialogDropdownField<String>(
            label: 'Category',
            value: _filters['category'],
            items: ['All', 'Documents', 'Images', 'Videos'].map((cat) {
              return DropdownMenuItem(value: cat, child: Text(cat));
            }).toList(),
            onChanged: (value) => _filters['category'] = value,
          ),
          Row(
            children: [
              Expanded(
                child: DialogFormField(
                  label: 'Min Size (MB)',
                  hint: '0',
                  keyboardType: TextInputType.number,
                  value: _filters['minSize']?.toString() ?? '',
                  onChanged: (value) => _filters['minSize'] = value,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DialogFormField(
                  label: 'Max Size (MB)',
                  hint: '100',
                  keyboardType: TextInputType.number,
                  value: _filters['maxSize']?.toString() ?? '',
                  onChanged: (value) => _filters['maxSize'] = value,
                ),
              ),
            ],
          ),
          CheckboxListTile(
            title: const Text('Include archived'),
            value: _filters['includeArchived'] ?? false,
            onChanged: (value) => setState(() => _filters['includeArchived'] = value),
          ),
        ],
      ),
    );
  }

  void _handleApply() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _isLoading = false);
    
    widget.onApply?.call(_filters);
    if (mounted) Navigator.of(context).pop();
  }
}