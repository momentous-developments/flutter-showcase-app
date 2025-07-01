import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

/// Showcase of all Material 3 button components
class ButtonsShowcase extends StatefulWidget {
  const ButtonsShowcase({super.key});

  @override
  State<ButtonsShowcase> createState() => _ButtonsShowcaseState();
}

class _ButtonsShowcaseState extends State<ButtonsShowcase> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Components'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection('Elevated Buttons', [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Elevated'),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('With Icon'),
                ),
                ElevatedButton(
                  onPressed: null,
                  child: const Text('Disabled'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleLoadingPress,
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Loading'),
                ),
              ],
            ),
          ]),
          _buildSection('Filled Buttons', [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                FilledButton(
                  onPressed: () {},
                  child: const Text('Filled'),
                ),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                  label: const Text('Send'),
                ),
                FilledButton.tonal(
                  onPressed: () {},
                  child: const Text('Filled Tonal'),
                ),
                FilledButton.tonal(
                  onPressed: null,
                  child: const Text('Disabled'),
                ),
              ],
            ),
          ]),
          _buildSection('Outlined Buttons', [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Outlined'),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.star),
                  label: const Text('Starred'),
                ),
                OutlinedButton(
                  onPressed: null,
                  child: const Text('Disabled'),
                ),
              ],
            ),
          ]),
          _buildSection('Text Buttons', [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Text'),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Open'),
                ),
                TextButton(
                  onPressed: null,
                  child: const Text('Disabled'),
                ),
              ],
            ),
          ]),
          _buildSection('Icon Buttons', [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                  tooltip: 'Standard',
                ),
                IconButton.filled(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                  tooltip: 'Filled',
                ),
                IconButton.filledTonal(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark),
                  tooltip: 'Filled Tonal',
                ),
                IconButton.outlined(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                  tooltip: 'Outlined',
                ),
                IconButton(
                  onPressed: null,
                  icon: const Icon(Icons.block),
                  tooltip: 'Disabled',
                ),
              ],
            ),
          ]),
          _buildSection('Floating Action Buttons', [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                FloatingActionButton.small(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                  tooltip: 'Small FAB',
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                  tooltip: 'Regular FAB',
                ),
                FloatingActionButton.extended(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  label: const Text('Extended FAB'),
                ),
                FloatingActionButton.large(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                  tooltip: 'Large FAB',
                ),
              ],
            ),
          ]),
          _buildSection('Segmented Buttons', [
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(
                  value: 0,
                  label: Text('Day'),
                  icon: Icon(Icons.calendar_view_day),
                ),
                ButtonSegment(
                  value: 1,
                  label: Text('Week'),
                  icon: Icon(Icons.calendar_view_week),
                ),
                ButtonSegment(
                  value: 2,
                  label: Text('Month'),
                  icon: Icon(Icons.calendar_view_month),
                ),
              ],
              selected: const {1},
              onSelectionChanged: (Set<int> selected) {},
            ),
            const SizedBox(height: 16),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Small')),
                ButtonSegment(value: 1, label: Text('Medium')),
                ButtonSegment(value: 2, label: Text('Large')),
              ],
              selected: const {0, 2},
              multiSelectionEnabled: true,
              onSelectionChanged: (Set<int> selected) {},
            ),
          ]),
          _buildSection('Toggle Buttons', [
            ToggleButtons(
              isSelected: const [true, false, false],
              onPressed: (index) {},
              children: const [
                Icon(Icons.format_bold),
                Icon(Icons.format_italic),
                Icon(Icons.format_underline),
              ],
            ),
            const SizedBox(height: 16),
            ToggleButtons(
              isSelected: const [false, true, false, true],
              onPressed: (index) {},
              borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.ac_unit),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.beach_access),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.cloud),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.wb_sunny),
                ),
              ],
            ),
          ]),
        ],
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

  void _handleLoadingPress() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
}