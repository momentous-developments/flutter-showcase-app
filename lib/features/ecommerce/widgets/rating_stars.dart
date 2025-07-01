import 'package:flutter/material.dart';

/// Widget for displaying star ratings
class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 16,
    this.color,
    this.unratedColor,
    this.onRatingChanged,
    this.allowHalfRatings = true,
    this.isInteractive = false,
  });

  final double rating;
  final int maxRating;
  final double size;
  final Color? color;
  final Color? unratedColor;
  final ValueChanged<double>? onRatingChanged;
  final bool allowHalfRatings;
  final bool isInteractive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final starColor = color ?? theme.colorScheme.primary;
    final emptyColor = unratedColor ?? theme.colorScheme.outline;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        return GestureDetector(
          onTap: isInteractive && onRatingChanged != null
              ? () => _handleTap(index + 1)
              : null,
          child: SizedBox(
            width: size,
            height: size,
            child: _buildStar(index, starColor, emptyColor),
          ),
        );
      }),
    );
  }

  void _handleTap(int starIndex) {
    double newRating = starIndex.toDouble();
    if (allowHalfRatings && rating == newRating) {
      // If tapping the same star, make it half
      newRating = starIndex - 0.5;
    }
    onRatingChanged?.call(newRating.clamp(0.0, maxRating.toDouble()));
  }

  Widget _buildStar(int index, Color filledColor, Color emptyColor) {
    final starValue = index + 1;
    final difference = rating - index;

    if (difference >= 1) {
      // Full star
      return Icon(
        Icons.star,
        size: size,
        color: filledColor,
      );
    } else if (difference > 0) {
      // Partial star
      return Stack(
        children: [
          Icon(
            Icons.star,
            size: size,
            color: emptyColor,
          ),
          ClipRect(
            clipper: _StarClipper(difference),
            child: Icon(
              Icons.star,
              size: size,
              color: filledColor,
            ),
          ),
        ],
      );
    } else {
      // Empty star
      return Icon(
        Icons.star_outline,
        size: size,
        color: emptyColor,
      );
    }
  }
}

/// Interactive rating widget for user input
class InteractiveRatingStars extends StatefulWidget {
  const InteractiveRatingStars({
    super.key,
    required this.onRatingChanged,
    this.initialRating = 0,
    this.maxRating = 5,
    this.size = 32,
    this.color,
    this.unratedColor,
    this.allowHalfRatings = true,
  });

  final ValueChanged<double> onRatingChanged;
  final double initialRating;
  final int maxRating;
  final double size;
  final Color? color;
  final Color? unratedColor;
  final bool allowHalfRatings;

  @override
  State<InteractiveRatingStars> createState() => _InteractiveRatingStarsState();
}

class _InteractiveRatingStarsState extends State<InteractiveRatingStars> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return RatingStars(
      rating: _currentRating,
      maxRating: widget.maxRating,
      size: widget.size,
      color: widget.color,
      unratedColor: widget.unratedColor,
      allowHalfRatings: widget.allowHalfRatings,
      isInteractive: true,
      onRatingChanged: (rating) {
        setState(() {
          _currentRating = rating;
        });
        widget.onRatingChanged(rating);
      },
    );
  }
}

/// Rating display with text
class RatingDisplay extends StatelessWidget {
  const RatingDisplay({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.showText = true,
    this.size = 16,
    this.color,
    this.textStyle,
  });

  final double rating;
  final int reviewCount;
  final bool showText;
  final double size;
  final Color? color;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RatingStars(
          rating: rating,
          size: size,
          color: color,
        ),
        if (showText) ...[
          const SizedBox(width: 8),
          Text(
            '${rating.toStringAsFixed(1)} (${_formatReviewCount(reviewCount)})',
            style: textStyle ?? theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }

  String _formatReviewCount(int count) {
    if (count < 1000) return count.toString();
    if (count < 1000000) return '${(count / 1000).toStringAsFixed(1)}K';
    return '${(count / 1000000).toStringAsFixed(1)}M';
  }
}

/// Rating breakdown widget
class RatingBreakdown extends StatelessWidget {
  const RatingBreakdown({
    super.key,
    required this.ratings,
    this.maxRating = 5,
  });

  final Map<int, int> ratings; // rating -> count
  final int maxRating;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalReviews = ratings.values.fold(0, (sum, count) => sum + count);
    
    if (totalReviews == 0) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(maxRating, (index) {
        final starCount = maxRating - index;
        final reviewCount = ratings[starCount] ?? 0;
        final percentage = reviewCount / totalReviews;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Text(
                '$starCount',
                style: theme.textTheme.labelMedium,
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.star,
                size: 12,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: LinearProgressIndicator(
                  value: percentage,
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 30,
                child: Text(
                  reviewCount.toString(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

/// Custom clipper for partial stars
class _StarClipper extends CustomClipper<Rect> {
  _StarClipper(this.percentage);

  final double percentage;

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width * percentage, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return oldClipper is _StarClipper && oldClipper.percentage != percentage;
  }
}