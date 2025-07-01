import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Showcase of all Material 3 input components
class InputsShowcase extends StatefulWidget {
  const InputsShowcase({super.key});

  @override
  State<InputsShowcase> createState() => _InputsShowcaseState();
}

class _InputsShowcaseState extends State<InputsShowcase> {
  final _formKey = GlobalKey<FormState>();
  String _textValue = '';
  bool _switchValue = false;
  bool _checkboxValue = false;
  int _radioValue = 0;
  double _sliderValue = 50;
  RangeValues _rangeValues = const RangeValues(20, 80);
  Set<String> _chipSelection = {'Flutter'};
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Components'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSection('Text Fields', [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Standard Text Field',
                  hintText: 'Enter some text',
                ),
                onChanged: (value) => setState(() => _textValue = value),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Outlined Text Field',
                  hintText: 'With helper text',
                  helperText: 'Helper text provides additional context',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Text Field with Icon',
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: Icon(Icons.visibility),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Error State',
                  errorText: 'This field has an error',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                enabled: false,
                decoration: const InputDecoration(
                  labelText: 'Disabled Field',
                  hintText: 'Cannot edit this',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Multiline Text Field',
                  hintText: 'Enter multiple lines of text',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ]),
            _buildSection('Specialized Fields', [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  prefixText: '+1 ',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixIcon: Icon(Icons.attach_money),
                  suffixText: 'USD',
                ),
              ),
            ]),
            _buildSection('Selection Controls', [
              SwitchListTile(
                title: const Text('Switch'),
                subtitle: const Text('Toggle this switch on or off'),
                value: _switchValue,
                onChanged: (value) => setState(() => _switchValue = value),
              ),
              CheckboxListTile(
                title: const Text('Checkbox'),
                subtitle: const Text('Check or uncheck this box'),
                value: _checkboxValue,
                onChanged: (value) => setState(() => _checkboxValue = value ?? false),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const Divider(),
              const Text('Radio Buttons', style: TextStyle(fontSize: 16)),
              RadioListTile<int>(
                title: const Text('Option 1'),
                value: 0,
                groupValue: _radioValue,
                onChanged: (value) => setState(() => _radioValue = value ?? 0),
              ),
              RadioListTile<int>(
                title: const Text('Option 2'),
                value: 1,
                groupValue: _radioValue,
                onChanged: (value) => setState(() => _radioValue = value ?? 0),
              ),
              RadioListTile<int>(
                title: const Text('Option 3'),
                value: 2,
                groupValue: _radioValue,
                onChanged: (value) => setState(() => _radioValue = value ?? 0),
              ),
            ]),
            _buildSection('Sliders', [
              Text('Slider Value: ${_sliderValue.round()}'),
              Slider(
                value: _sliderValue,
                min: 0,
                max: 100,
                divisions: 20,
                label: _sliderValue.round().toString(),
                onChanged: (value) => setState(() => _sliderValue = value),
              ),
              const SizedBox(height: 24),
              Text('Range Slider: ${_rangeValues.start.round()} - ${_rangeValues.end.round()}'),
              RangeSlider(
                values: _rangeValues,
                min: 0,
                max: 100,
                divisions: 20,
                labels: RangeLabels(
                  _rangeValues.start.round().toString(),
                  _rangeValues.end.round().toString(),
                ),
                onChanged: (values) => setState(() => _rangeValues = values),
              ),
            ]),
            _buildSection('Chips', [
              Wrap(
                spacing: 8,
                children: [
                  Chip(
                    label: const Text('Basic Chip'),
                    onDeleted: () {},
                  ),
                  const Chip(
                    label: Text('With Avatar'),
                    avatar: CircleAvatar(child: Text('A')),
                  ),
                  ActionChip(
                    label: const Text('Action Chip'),
                    onPressed: () {},
                    avatar: const Icon(Icons.star, size: 18),
                  ),
                  ChoiceChip(
                    label: const Text('Choice Chip'),
                    selected: _chipSelection.contains('Choice'),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _chipSelection.add('Choice');
                        } else {
                          _chipSelection.remove('Choice');
                        }
                      });
                    },
                  ),
                  FilterChip(
                    label: const Text('Filter Chip'),
                    selected: _chipSelection.contains('Filter'),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _chipSelection.add('Filter');
                        } else {
                          _chipSelection.remove('Filter');
                        }
                      });
                    },
                  ),
                  InputChip(
                    label: const Text('Input Chip'),
                    selected: _chipSelection.contains('Input'),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _chipSelection.add('Input');
                        } else {
                          _chipSelection.remove('Input');
                        }
                      });
                    },
                    onDeleted: () {},
                  ),
                ],
              ),
            ]),
            _buildSection('Date & Time Pickers', [
              ListTile(
                title: const Text('Date Picker'),
                subtitle: Text('Selected: ${_selectedDate.toString().split(' ')[0]}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (date != null) {
                    setState(() => _selectedDate = date);
                  }
                },
              ),
              ListTile(
                title: const Text('Time Picker'),
                subtitle: Text('Selected: ${_selectedTime.format(context)}'),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime,
                  );
                  if (time != null) {
                    setState(() => _selectedTime = time);
                  }
                },
              ),
            ]),
            _buildSection('Dropdowns', [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Dropdown',
                  border: OutlineInputBorder(),
                ),
                value: 'Option 1',
                items: const [
                  DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
                  DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
                  DropdownMenuItem(value: 'Option 3', child: Text('Option 3')),
                ],
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              Autocomplete<String>(
                optionsBuilder: (textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'].where((option) {
                    return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                  });
                },
                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      labelText: 'Autocomplete',
                      hintText: 'Type to search fruits',
                      border: OutlineInputBorder(),
                    ),
                  );
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}