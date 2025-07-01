import 'package:flutter/material.dart';
import '../../models/form_models.dart';

class ColorFormField extends StatelessWidget {
  final FormFieldModel field;
  final Color? value;
  final String? error;
  final Function(Color) onChanged;
  
  const ColorFormField({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    final currentColor = value ?? Theme.of(context).colorScheme.primary;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (field.label != null) ...[
          Row(
            children: [
              Text(
                field.label!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (field.required) ...[
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
        
        InkWell(
          onTap: field.disabled ? null : () => _showColorPicker(context, currentColor),
          borderRadius: BorderRadius.circular(4),
          child: InputDecorator(
            decoration: InputDecoration(
              hintText: field.placeholder ?? 'Select color',
              helperText: field.helperText,
              errorText: error,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              filled: field.disabled,
              fillColor: field.disabled
                  ? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5)
                  : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: currentColor,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _colorToHex(currentColor),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        'RGB: ${currentColor.red}, ${currentColor.green}, ${currentColor.blue}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.palette),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Future<void> _showColorPicker(BuildContext context, Color initialColor) async {
    final result = await showDialog<Color>(
      context: context,
      builder: (context) => _ColorPickerDialog(
        initialColor: initialColor,
        title: field.label ?? 'Select Color',
      ),
    );
    
    if (result != null) {
      onChanged(result);
    }
  }
  
  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }
}

class _ColorPickerDialog extends StatefulWidget {
  final Color initialColor;
  final String title;
  
  const _ColorPickerDialog({
    required this.initialColor,
    required this.title,
  });
  
  @override
  State<_ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<_ColorPickerDialog> {
  late Color _selectedColor;
  late TextEditingController _hexController;
  
  static const List<Color> _presetColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ];
  
  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;
    _hexController = TextEditingController(
      text: _colorToHex(_selectedColor).substring(1),
    );
  }
  
  @override
  void dispose() {
    _hexController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Color preview
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: _selectedColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Preset colors
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _presetColors.map((color) {
                return InkWell(
                  onTap: () => _updateColor(color),
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: _selectedColor == color
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outline,
                        width: _selectedColor == color ? 3 : 1,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 16),
            
            // RGB Sliders
            _buildColorSlider(
              label: 'Red',
              value: _selectedColor.red.toDouble(),
              color: Colors.red,
              onChanged: (value) {
                _updateColor(Color.fromARGB(
                  _selectedColor.alpha,
                  value.round(),
                  _selectedColor.green,
                  _selectedColor.blue,
                ));
              },
            ),
            
            const SizedBox(height: 8),
            
            _buildColorSlider(
              label: 'Green',
              value: _selectedColor.green.toDouble(),
              color: Colors.green,
              onChanged: (value) {
                _updateColor(Color.fromARGB(
                  _selectedColor.alpha,
                  _selectedColor.red,
                  value.round(),
                  _selectedColor.blue,
                ));
              },
            ),
            
            const SizedBox(height: 8),
            
            _buildColorSlider(
              label: 'Blue',
              value: _selectedColor.blue.toDouble(),
              color: Colors.blue,
              onChanged: (value) {
                _updateColor(Color.fromARGB(
                  _selectedColor.alpha,
                  _selectedColor.red,
                  _selectedColor.green,
                  value.round(),
                ));
              },
            ),
            
            const SizedBox(height: 16),
            
            // Hex input
            TextField(
              controller: _hexController,
              decoration: const InputDecoration(
                labelText: 'Hex Code',
                prefixText: '#',
                border: OutlineInputBorder(),
              ),
              maxLength: 6,
              onChanged: (value) {
                if (value.length == 6) {
                  final color = _hexToColor(value);
                  if (color != null) {
                    _updateColor(color);
                  }
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_selectedColor),
          child: const Text('Select'),
        ),
      ],
    );
  }
  
  Widget _buildColorSlider({
    required String label,
    required double value,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              activeTrackColor: color,
              thumbColor: color,
              inactiveTrackColor: color.withOpacity(0.3),
            ),
            child: Slider(
              value: value,
              min: 0,
              max: 255,
              onChanged: onChanged,
            ),
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            value.round().toString(),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
  
  void _updateColor(Color color) {
    setState(() {
      _selectedColor = color;
      _hexController.text = _colorToHex(color).substring(1);
    });
  }
  
  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }
  
  Color? _hexToColor(String hex) {
    try {
      return Color(int.parse('FF$hex', radix: 16));
    } catch (e) {
      return null;
    }
  }
}