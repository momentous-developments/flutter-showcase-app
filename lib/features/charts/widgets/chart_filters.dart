import 'package:flutter/material.dart';
import '../models/chart_models.dart';

/// Chart filters widget
class ChartFilters extends StatefulWidget {
  final List<ChartFilter> filters;
  final Function(ChartFilter) onFilterChanged;
  final VoidCallback? onReset;
  final bool showAsChips;

  const ChartFilters({
    super.key,
    required this.filters,
    required this.onFilterChanged,
    this.onReset,
    this.showAsChips = false,
  });

  @override
  State<ChartFilters> createState() => _ChartFiltersState();
}

class _ChartFiltersState extends State<ChartFilters> {
  @override
  Widget build(BuildContext context) {
    if (widget.showAsChips) {
      return _buildChipFilters();
    }
    return _buildDropdownFilters();
  }

  Widget _buildChipFilters() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.filters.map((filter) {
        switch (filter.type) {
          case ChartFilterType.category:
          case ChartFilterType.multiSelect:
            return _buildChipFilter(filter);
          default:
            return const SizedBox.shrink();
        }
      }).toList(),
    );
  }

  Widget _buildChipFilter(ChartFilter filter) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (filter.options == null || filter.options!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 4),
          child: Text(
            filter.name,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Wrap(
          spacing: 8,
          children: filter.options!.map((option) {
            final isSelected = filter.type == ChartFilterType.multiSelect
                ? (filter.value as List?)?.contains(option) ?? false
                : filter.value == option;

            return FilterChip(
              label: Text(option.toString()),
              selected: isSelected,
              onSelected: (selected) {
                if (filter.type == ChartFilterType.multiSelect) {
                  final currentValues = List.from(filter.value as List? ?? []);
                  if (selected) {
                    currentValues.add(option);
                  } else {
                    currentValues.remove(option);
                  }
                  widget.onFilterChanged(ChartFilter(
                    name: filter.name,
                    type: filter.type,
                    value: currentValues,
                    options: filter.options,
                  ));
                } else {
                  widget.onFilterChanged(ChartFilter(
                    name: filter.name,
                    type: filter.type,
                    value: selected ? option : null,
                    options: filter.options,
                  ));
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDropdownFilters() {
    return Row(
      children: [
        ...widget.filters.map((filter) {
          switch (filter.type) {
            case ChartFilterType.dateRange:
              return Expanded(child: _buildDateRangeFilter(filter));
            case ChartFilterType.category:
              return Expanded(child: _buildDropdownFilter(filter));
            case ChartFilterType.numeric:
              return Expanded(child: _buildNumericFilter(filter));
            case ChartFilterType.boolean:
              return _buildBooleanFilter(filter);
            case ChartFilterType.multiSelect:
              return Expanded(child: _buildMultiSelectFilter(filter));
          }
        }),
        if (widget.onReset != null) ...[
          const SizedBox(width: 8),
          IconButton(
            onPressed: widget.onReset,
            icon: const Icon(Icons.clear),
            tooltip: 'Reset filters',
          ),
        ],
      ],
    );
  }

  Widget _buildDateRangeFilter(ChartFilter filter) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () async {
          final DateTimeRange? picked = await showDateRangePicker(
            context: context,
            firstDate: DateTime(2020),
            lastDate: DateTime.now().add(const Duration(days: 365)),
            initialDateRange: filter.value as DateTimeRange?,
            builder: (context, child) {
              return Theme(
                data: theme.copyWith(
                  colorScheme: colorScheme,
                ),
                child: child!,
              );
            },
          );

          if (picked != null) {
            widget.onFilterChanged(ChartFilter(
              name: filter.name,
              type: filter.type,
              value: picked,
              options: filter.options,
            ));
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.outline),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.date_range, size: 16, color: colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _formatDateRange(filter.value as DateTimeRange?),
                  style: theme.textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.arrow_drop_down, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownFilter(ChartFilter filter) {
    if (filter.options == null || filter.options!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: DropdownButtonFormField<dynamic>(
        value: filter.value,
        decoration: InputDecoration(
          labelText: filter.name,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        items: [
          DropdownMenuItem(
            value: null,
            child: Text('All ${filter.name}'),
          ),
          ...filter.options!.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option.toString()),
            );
          }),
        ],
        onChanged: (value) {
          widget.onFilterChanged(ChartFilter(
            name: filter.name,
            type: filter.type,
            value: value,
            options: filter.options,
          ));
        },
      ),
    );
  }

  Widget _buildNumericFilter(ChartFilter filter) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
        decoration: InputDecoration(
          labelText: filter.name,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          final numValue = double.tryParse(value);
          if (numValue != null) {
            widget.onFilterChanged(ChartFilter(
              name: filter.name,
              type: filter.type,
              value: numValue,
              options: filter.options,
            ));
          }
        },
      ),
    );
  }

  Widget _buildBooleanFilter(ChartFilter filter) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Text(filter.name),
          const SizedBox(width: 8),
          Switch(
            value: filter.value as bool? ?? false,
            onChanged: (value) {
              widget.onFilterChanged(ChartFilter(
                name: filter.name,
                type: filter.type,
                value: value,
                options: filter.options,
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMultiSelectFilter(ChartFilter filter) {
    final theme = Theme.of(context);
    final selectedValues = filter.value as List? ?? [];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () {
          _showMultiSelectDialog(filter);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outline),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedValues.isEmpty
                      ? 'Select ${filter.name}'
                      : '${selectedValues.length} selected',
                  style: theme.textTheme.bodySmall,
                ),
              ),
              const Icon(Icons.arrow_drop_down, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _showMultiSelectDialog(ChartFilter filter) {
    showDialog(
      context: context,
      builder: (context) {
        return _MultiSelectDialog(
          title: filter.name,
          options: filter.options ?? [],
          selectedValues: List.from(filter.value as List? ?? []),
          onConfirm: (values) {
            widget.onFilterChanged(ChartFilter(
              name: filter.name,
              type: filter.type,
              value: values,
              options: filter.options,
            ));
          },
        );
      },
    );
  }

  String _formatDateRange(DateTimeRange? range) {
    if (range == null) return 'Select date range';
    
    final start = '${range.start.day}/${range.start.month}/${range.start.year}';
    final end = '${range.end.day}/${range.end.month}/${range.end.year}';
    return '$start - $end';
  }
}

/// Multi-select dialog
class _MultiSelectDialog extends StatefulWidget {
  final String title;
  final List<dynamic> options;
  final List<dynamic> selectedValues;
  final Function(List<dynamic>) onConfirm;

  const _MultiSelectDialog({
    required this.title,
    required this.options,
    required this.selectedValues,
    required this.onConfirm,
  });

  @override
  State<_MultiSelectDialog> createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<_MultiSelectDialog> {
  late List<dynamic> _selectedValues;

  @override
  void initState() {
    super.initState();
    _selectedValues = List.from(widget.selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select ${widget.title}'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.options.length,
          itemBuilder: (context, index) {
            final option = widget.options[index];
            final isSelected = _selectedValues.contains(option);

            return CheckboxListTile(
              title: Text(option.toString()),
              value: isSelected,
              onChanged: (selected) {
                setState(() {
                  if (selected ?? false) {
                    _selectedValues.add(option);
                  } else {
                    _selectedValues.remove(option);
                  }
                });
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            widget.onConfirm(_selectedValues);
            Navigator.of(context).pop();
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}