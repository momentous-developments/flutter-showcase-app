import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum PriceDisplaySize { small, medium, large }

/// Widget for displaying product prices with optional discounts
class PriceDisplay extends StatelessWidget {
  const PriceDisplay({
    super.key,
    required this.price,
    this.originalPrice,
    this.currency = 'USD',
    this.size = PriceDisplaySize.medium,
    this.color,
    this.originalPriceColor,
    this.showCurrency = true,
    this.alignment = MainAxisAlignment.start,
  });

  final double price;
  final double? originalPrice;
  final String currency;
  final PriceDisplaySize size;
  final Color? color;
  final Color? originalPriceColor;
  final bool showCurrency;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasDiscount = originalPrice != null && originalPrice! > price;
    
    final TextStyle priceStyle = _getPriceStyle(theme);
    final TextStyle originalPriceStyle = _getOriginalPriceStyle(theme);

    return Row(
      mainAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Current price
        Text(
          _formatPrice(price),
          style: priceStyle.copyWith(
            color: color ?? (hasDiscount ? theme.colorScheme.error : theme.colorScheme.onSurface),
            fontWeight: FontWeight.w700,
          ),
        ),
        
        // Original price (strikethrough)
        if (hasDiscount) ...[
          const SizedBox(width: 8),
          Text(
            _formatPrice(originalPrice!),
            style: originalPriceStyle.copyWith(
              color: originalPriceColor ?? theme.colorScheme.onSurfaceVariant,
              decoration: TextDecoration.lineThrough,
              decorationColor: originalPriceColor ?? theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }

  TextStyle _getPriceStyle(ThemeData theme) {
    switch (size) {
      case PriceDisplaySize.small:
        return theme.textTheme.bodySmall ?? const TextStyle(fontSize: 12);
      case PriceDisplaySize.medium:
        return theme.textTheme.titleSmall ?? const TextStyle(fontSize: 14);
      case PriceDisplaySize.large:
        return theme.textTheme.titleLarge ?? const TextStyle(fontSize: 22);
    }
  }

  TextStyle _getOriginalPriceStyle(ThemeData theme) {
    switch (size) {
      case PriceDisplaySize.small:
        return theme.textTheme.labelSmall ?? const TextStyle(fontSize: 10);
      case PriceDisplaySize.medium:
        return theme.textTheme.labelMedium ?? const TextStyle(fontSize: 12);
      case PriceDisplaySize.large:
        return theme.textTheme.titleMedium ?? const TextStyle(fontSize: 16);
    }
  }

  String _formatPrice(double price) {
    final formatter = NumberFormat.currency(
      symbol: showCurrency ? _getCurrencySymbol() : '',
      decimalDigits: price.truncateToDouble() == price ? 0 : 2,
    );
    return formatter.format(price);
  }

  String _getCurrencySymbol() {
    switch (currency.toUpperCase()) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      case 'CAD':
        return 'C\$';
      case 'AUD':
        return 'A\$';
      default:
        return '\$';
    }
  }
}

/// Widget for displaying price range
class PriceRangeDisplay extends StatelessWidget {
  const PriceRangeDisplay({
    super.key,
    required this.minPrice,
    required this.maxPrice,
    this.currency = 'USD',
    this.size = PriceDisplaySize.medium,
    this.color,
    this.showCurrency = true,
  });

  final double minPrice;
  final double maxPrice;
  final String currency;
  final PriceDisplaySize size;
  final Color? color;
  final bool showCurrency;

  @override
  Widget build(BuildContext context) {
    if (minPrice == maxPrice) {
      return PriceDisplay(
        price: minPrice,
        currency: currency,
        size: size,
        color: color,
        showCurrency: showCurrency,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PriceDisplay(
          price: minPrice,
          currency: currency,
          size: size,
          color: color,
          showCurrency: showCurrency,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            '-',
            style: _getTextStyle(Theme.of(context)),
          ),
        ),
        PriceDisplay(
          price: maxPrice,
          currency: currency,
          size: size,
          color: color,
          showCurrency: showCurrency,
        ),
      ],
    );
  }

  TextStyle _getTextStyle(ThemeData theme) {
    switch (size) {
      case PriceDisplaySize.small:
        return theme.textTheme.bodySmall ?? const TextStyle(fontSize: 12);
      case PriceDisplaySize.medium:
        return theme.textTheme.titleSmall ?? const TextStyle(fontSize: 14);
      case PriceDisplaySize.large:
        return theme.textTheme.titleLarge ?? const TextStyle(fontSize: 22);
    }
  }
}

/// Widget for displaying discount information
class DiscountBadge extends StatelessWidget {
  const DiscountBadge({
    super.key,
    required this.originalPrice,
    required this.discountedPrice,
    this.isPercentage = true,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 4.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
  });

  final double originalPrice;
  final double discountedPrice;
  final bool isPercentage;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final discount = originalPrice - discountedPrice;
    
    if (discount <= 0) {
      return const SizedBox.shrink();
    }

    final discountText = isPercentage
        ? '-${((discount / originalPrice) * 100).round()}%'
        : '-\$${discount.toStringAsFixed(2)}';

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.error,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        discountText,
        style: theme.textTheme.labelSmall?.copyWith(
          color: textColor ?? theme.colorScheme.onError,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Widget for displaying savings information
class SavingsDisplay extends StatelessWidget {
  const SavingsDisplay({
    super.key,
    required this.originalPrice,
    required this.discountedPrice,
    this.currency = 'USD',
    this.showPercentage = true,
    this.showAmount = true,
    this.color,
  });

  final double originalPrice;
  final double discountedPrice;
  final String currency;
  final bool showPercentage;
  final bool showAmount;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final savings = originalPrice - discountedPrice;
    
    if (savings <= 0) {
      return const SizedBox.shrink();
    }

    final percentage = ((savings / originalPrice) * 100).round();
    final formatter = NumberFormat.currency(
      symbol: _getCurrencySymbol(),
      decimalDigits: savings.truncateToDouble() == savings ? 0 : 2,
    );

    final List<String> parts = [];
    if (showAmount) {
      parts.add('Save ${formatter.format(savings)}');
    }
    if (showPercentage) {
      parts.add('($percentage% off)');
    }

    return Text(
      parts.join(' '),
      style: theme.textTheme.bodySmall?.copyWith(
        color: color ?? theme.colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  String _getCurrencySymbol() {
    switch (currency.toUpperCase()) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      case 'CAD':
        return 'C\$';
      case 'AUD':
        return 'A\$';
      default:
        return '\$';
    }
  }
}

/// Widget for cart price breakdown
class PriceBreakdown extends StatelessWidget {
  const PriceBreakdown({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.total,
    this.discount,
    this.currency = 'USD',
    this.showItemCount,
  });

  final double subtotal;
  final double shipping;
  final double tax;
  final double total;
  final double? discount;
  final String currency;
  final int? showItemCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showItemCount != null)
          _buildRow(
            'Items (${showItemCount})',
            subtotal,
            theme.textTheme.bodyMedium,
          ),
        
        if (showItemCount == null)
          _buildRow(
            'Subtotal',
            subtotal,
            theme.textTheme.bodyMedium,
          ),
        
        if (discount != null && discount! > 0)
          _buildRow(
            'Discount',
            -discount!,
            theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        
        _buildRow(
          'Shipping',
          shipping,
          theme.textTheme.bodyMedium,
        ),
        
        _buildRow(
          'Tax',
          tax,
          theme.textTheme.bodyMedium,
        ),
        
        const Divider(),
        
        _buildRow(
          'Total',
          total,
          theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String label, double amount, TextStyle? style) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          PriceDisplay(
            price: amount,
            currency: currency,
            size: PriceDisplaySize.medium,
            color: style?.color,
          ),
        ],
      ),
    );
  }
}