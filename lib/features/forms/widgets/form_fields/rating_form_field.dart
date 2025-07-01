import 'package:flutter/material.dart';
import '../../models/form_models.dart';

class RatingFormField extends StatelessWidget {
  final FormFieldModel field;
  final double? value;
  final String? error;
  final Function(double) onChanged;
  
  const RatingFormField({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    final maxRating = (field.options?.max ?? 5).toInt();
    final allowHalf = (field.options?.step ?? 1) == 0.5;
    final currentRating = value ?? 0;
    
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
          const SizedBox(height: 12),
        ],
        
        Row(
          children: [
            // Star rating
            ...List.generate(maxRating, (index) {
              final starValue = index + 1.0;
              final isFullStar = currentRating >= starValue;
              final isHalfStar = allowHalf && 
                  currentRating >= starValue - 0.5 && 
                  currentRating < starValue;
              
              return GestureDetector(
                onTap: field.disabled
                    ? null
                    : () => onChanged(starValue),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Icon(
                    isFullStar
                        ? Icons.star
                        : isHalfStar
                            ? Icons.star_half
                            : Icons.star_border,
                    color: Theme.of(context).colorScheme.primary,
                    size: 32,
                  ),
                ),
              );
            }),
            
            const SizedBox(width: 16),
            
            // Rating value
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                currentRating.toStringAsFixed(allowHalf ? 1 : 0),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            ),
            
            // Clear button
            if (currentRating > 0 && !field.disabled) ...[
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.clear, size: 20),
                onPressed: () => onChanged(0),
                splashRadius: 20,
                tooltip: 'Clear rating',
              ),
            ],
          ],
        ),
        
        if (field.helperText != null) ...[
          const SizedBox(height: 8),
          Text(
            field.helperText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        
        if (error != null) ...[
          const SizedBox(height: 8),
          Text(
            error!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
}

class EmojiRatingFormField extends StatelessWidget {
  final FormFieldModel field;
  final int? value;
  final String? error;
  final Function(int) onChanged;
  
  static const List<String> _defaultEmojis = ['😡', '😕', '😐', '😊', '😍'];
  static const List<String> _defaultLabels = [
    'Very Poor',
    'Poor',
    'Average',
    'Good',
    'Excellent'
  ];
  
  const EmojiRatingFormField({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    final emojis = (field.metadata?['emojis'] as List<String>?) ?? _defaultEmojis;
    final labels = (field.metadata?['labels'] as List<String>?) ?? _defaultLabels;
    
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
          const SizedBox(height: 12),
        ],
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(emojis.length, (index) {
            final isSelected = value == index;
            
            return InkWell(
              onTap: field.disabled
                  ? null
                  : () => onChanged(index),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primaryContainer
                      : null,
                  borderRadius: BorderRadius.circular(8),
                  border: isSelected
                      ? Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        )
                      : null,
                ),
                child: Column(
                  children: [
                    Text(
                      emojis[index],
                      style: TextStyle(
                        fontSize: isSelected ? 40 : 32,
                      ),
                    ),
                    if (isSelected && index < labels.length) ...[
                      const SizedBox(height: 4),
                      Text(
                        labels[index],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
        
        if (field.helperText != null) ...[
          const SizedBox(height: 8),
          Text(
            field.helperText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        
        if (error != null) ...[
          const SizedBox(height: 8),
          Text(
            error!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
}

class ThumbRatingFormField extends StatelessWidget {
  final FormFieldModel field;
  final bool? value;
  final String? error;
  final Function(bool?) onChanged;
  
  const ThumbRatingFormField({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 12),
        ],
        
        Row(
          children: [
            // Thumbs up
            _buildThumbButton(
              icon: Icons.thumb_up,
              isSelected: value == true,
              color: Colors.green,
              onTap: field.disabled
                  ? null
                  : () => onChanged(value == true ? null : true),
            ),
            
            const SizedBox(width: 16),
            
            // Thumbs down
            _buildThumbButton(
              icon: Icons.thumb_down,
              isSelected: value == false,
              color: Colors.red,
              onTap: field.disabled
                  ? null
                  : () => onChanged(value == false ? null : false),
            ),
          ],
        ),
        
        if (field.helperText != null) ...[
          const SizedBox(height: 8),
          Text(
            field.helperText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        
        if (error != null) ...[
          const SizedBox(height: 8),
          Text(
            error!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
  
  Widget _buildThumbButton({
    required IconData icon,
    required bool isSelected,
    required Color color,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : null,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? color : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Icon(
          icon,
          size: 32,
          color: isSelected ? color : Colors.grey,
        ),
      ),
    );
  }
}