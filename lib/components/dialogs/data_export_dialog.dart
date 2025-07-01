import 'package:flutter/material.dart';
import 'widgets/form_dialog.dart';

/// Dialog for exporting data in various formats
class DataExportDialog extends StatefulWidget {
  const DataExportDialog({
    super.key,
    this.onExport,
    this.onCancel,
  });

  final Function(String format, List<String> fields)? onExport;
  final VoidCallback? onCancel;

  @override
  State<DataExportDialog> createState() => _DataExportDialogState();
}

class _DataExportDialogState extends State<DataExportDialog> {
  String _format = 'csv';
  final List<String> _availableFields = ['Name', 'Email', 'Phone', 'Role', 'Department'];
  final List<String> _selectedFields = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedFields.addAll(_availableFields);
  }

  @override
  Widget build(BuildContext context) {
    return FormDialog(
      title: 'Export Data',
      subtitle: 'Choose format and fields to export',
      submitText: 'Export',
      cancelText: 'Cancel',
      isLoading: _isLoading,
      canSubmit: _selectedFields.isNotEmpty,
      onSubmit: _handleExport,
      onCancel: widget.onCancel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Export Format', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: ['csv', 'json', 'xlsx'].map((format) {
              return ChoiceChip(
                label: Text(format.toUpperCase()),
                selected: _format == format,
                onSelected: (selected) => setState(() => _format = format),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Text('Select Fields', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ..._availableFields.map((field) {
            return CheckboxListTile(
              title: Text(field),
              value: _selectedFields.contains(field),
              onChanged: (checked) {
                setState(() {
                  if (checked == true) {
                    _selectedFields.add(field);
                  } else {
                    _selectedFields.remove(field);
                  }
                });
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  void _handleExport() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    
    widget.onExport?.call(_format, _selectedFields);
    if (mounted) Navigator.of(context).pop();
  }
}