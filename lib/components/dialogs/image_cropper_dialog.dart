import 'package:flutter/material.dart';
import 'widgets/base_dialog.dart';
import 'widgets/dialog_footer.dart';

/// Dialog for cropping images
class ImageCropperDialog extends StatefulWidget {
  const ImageCropperDialog({
    super.key,
    this.imagePath,
    this.onCrop,
    this.onCancel,
  });

  final String? imagePath;
  final Function(String croppedImagePath)? onCrop;
  final VoidCallback? onCancel;

  @override
  State<ImageCropperDialog> createState() => _ImageCropperDialogState();
}

class _ImageCropperDialogState extends State<ImageCropperDialog> {
  double _aspectRatio = 1.0;
  bool _isProcessing = false;

  final List<Map<String, dynamic>> _aspectRatios = [
    {'label': 'Free', 'ratio': 0.0},
    {'label': '1:1', 'ratio': 1.0},
    {'label': '4:3', 'ratio': 4/3},
    {'label': '16:9', 'ratio': 16/9},
  ];

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Crop Image',
      subtitle: 'Adjust the crop area and aspect ratio',
      size: DialogSize.large,
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Theme.of(context).colorScheme.outline),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, size: 64),
                  SizedBox(height: 16),
                  Text('Image cropping area'),
                  Text('Drag corners to adjust crop'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Aspect Ratio:'),
              const SizedBox(width: 16),
              Expanded(
                child: Wrap(
                  spacing: 8,
                  children: _aspectRatios.map((ratio) {
                    return ChoiceChip(
                      label: Text(ratio['label']),
                      selected: _aspectRatio == ratio['ratio'],
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _aspectRatio = ratio['ratio']);
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              IconButton(
                onPressed: _isProcessing ? null : _rotateLeft,
                icon: const Icon(Icons.rotate_left),
                tooltip: 'Rotate Left',
              ),
              IconButton(
                onPressed: _isProcessing ? null : _rotateRight,
                icon: const Icon(Icons.rotate_right),
                tooltip: 'Rotate Right',
              ),
              IconButton(
                onPressed: _isProcessing ? null : _flipHorizontal,
                icon: const Icon(Icons.flip),
                tooltip: 'Flip Horizontal',
              ),
              IconButton(
                onPressed: _isProcessing ? null : _reset,
                icon: const Icon(Icons.refresh),
                tooltip: 'Reset',
              ),
            ],
          ),
        ],
      ),
      actions: [
        DialogActionButton.outlined(
          text: 'Cancel',
          onPressed: _isProcessing ? null : widget.onCancel,
        ),
        DialogActionButton.primary(
          text: 'Crop Image',
          onPressed: _isProcessing ? null : _handleCrop,
          isLoading: _isProcessing,
        ),
      ],
    );
  }

  void _rotateLeft() {
    // Implement rotation logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Rotated left')),
    );
  }

  void _rotateRight() {
    // Implement rotation logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Rotated right')),
    );
  }

  void _flipHorizontal() {
    // Implement flip logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Flipped horizontal')),
    );
  }

  void _reset() {
    // Reset to original
    setState(() => _aspectRatio = 1.0);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reset to original')),
    );
  }

  void _handleCrop() async {
    setState(() => _isProcessing = true);
    
    // Simulate image processing
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() => _isProcessing = false);
    
    widget.onCrop?.call('cropped_image_path.jpg');
    if (mounted) Navigator.of(context).pop();
  }
}