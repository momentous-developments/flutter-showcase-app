import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ecommerce_models.dart';
import '../providers/ecommerce_providers.dart';
import 'price_display.dart';

/// Widget for displaying cart items with quantity controls
class CartItemWidget extends ConsumerStatefulWidget {
  const CartItemWidget({
    super.key,
    required this.cartItem,
    this.onQuantityChanged,
    this.onRemove,
    this.onSaveForLater,
    this.showSaveForLater = true,
    this.isEditable = true,
  });

  final CartItem cartItem;
  final ValueChanged<int>? onQuantityChanged;
  final VoidCallback? onRemove;
  final VoidCallback? onSaveForLater;
  final bool showSaveForLater;
  final bool isEditable;

  @override
  ConsumerState<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends ConsumerState<CartItemWidget> {
  late TextEditingController _quantityController;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(
      text: widget.cartItem.quantity.toString(),
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  void _updateQuantity(int newQuantity) {
    if (_isUpdating || newQuantity == widget.cartItem.quantity) return;

    setState(() {
      _isUpdating = true;
    });

    final cartNotifier = ref.read(shoppingCartProvider.notifier);
    
    if (newQuantity <= 0) {
      _removeItem();
    } else {
      cartNotifier.updateItemQuantity(widget.cartItem, newQuantity);
      _quantityController.text = newQuantity.toString();
      widget.onQuantityChanged?.call(newQuantity);
    }

    setState(() {
      _isUpdating = false;
    });
  }

  void _removeItem() {
    final cartNotifier = ref.read(shoppingCartProvider.notifier);
    cartNotifier.removeItem(widget.cartItem);
    widget.onRemove?.call();
  }

  void _onQuantityFieldChanged(String value) {
    final newQuantity = int.tryParse(value);
    if (newQuantity != null && newQuantity != widget.cartItem.quantity) {
      _updateQuantity(newQuantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = widget.cartItem.product;
    final isOutOfStock = !widget.cartItem.isInStock;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: theme.colorScheme.surfaceContainerHighest,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: product.images.isNotEmpty
                    ? Image.network(
                        product.images.first,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildImagePlaceholder(theme);
                        },
                      )
                    : _buildImagePlaceholder(theme),
              ),
            ),

            const SizedBox(width: 12),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name and Brand
                  if (product.brand != null) ...[
                    Text(
                      product.brand!,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                  
                  Text(
                    product.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Selected Variants
                  if (widget.cartItem.selectedVariants.isNotEmpty) ...[
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: widget.cartItem.selectedVariants.entries
                          .map((entry) => _buildVariantChip(entry, theme))
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                  ],

                  // Stock Status
                  if (isOutOfStock) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Out of Stock',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onErrorContainer,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],

                  // Price and Quantity Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PriceDisplay(
                            price: widget.cartItem.unitPrice,
                            size: PriceDisplaySize.medium,
                          ),
                          if (widget.cartItem.quantity > 1)
                            Text(
                              'Total: ',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          if (widget.cartItem.quantity > 1)
                            PriceDisplay(
                              price: widget.cartItem.totalPrice,
                              size: PriceDisplaySize.small,
                              color: theme.colorScheme.primary,
                            ),
                        ],
                      ),

                      // Quantity Controls
                      if (widget.isEditable) _buildQuantityControls(theme),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Action Buttons
                  Row(
                    children: [
                      // Remove Button
                      if (widget.isEditable)
                        TextButton.icon(
                          onPressed: _isUpdating ? null : _removeItem,
                          icon: const Icon(Icons.delete_outline, size: 16),
                          label: const Text('Remove'),
                          style: TextButton.styleFrom(
                            foregroundColor: theme.colorScheme.error,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),

                      // Save for Later Button
                      if (widget.showSaveForLater && widget.isEditable) ...[
                        const SizedBox(width: 8),
                        TextButton.icon(
                          onPressed: widget.onSaveForLater,
                          icon: const Icon(Icons.bookmark_outline, size: 16),
                          label: const Text('Save for Later'),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            color: theme.colorScheme.onSurfaceVariant,
            size: 24,
          ),
          const SizedBox(height: 2),
          Text(
            'No Image',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVariantChip(MapEntry<String, ProductVariant> entry, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '${entry.key}: ${entry.value.value}',
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildQuantityControls(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrease Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _isUpdating 
                  ? null 
                  : () => _updateQuantity(widget.cartItem.quantity - 1),
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
              child: Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                child: Icon(
                  Icons.remove,
                  size: 16,
                  color: _isUpdating 
                      ? theme.colorScheme.onSurface.withOpacity(0.3)
                      : theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),

          // Quantity Input
          Container(
            width: 50,
            height: 32,
            decoration: BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(color: theme.colorScheme.outline),
              ),
            ),
            child: TextFormField(
              controller: _quantityController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: theme.textTheme.bodySmall,
              onFieldSubmitted: _onQuantityFieldChanged,
              onTapOutside: (_) => _onQuantityFieldChanged(_quantityController.text),
              enabled: !_isUpdating,
            ),
          ),

          // Increase Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _isUpdating 
                  ? null 
                  : () => _updateQuantity(widget.cartItem.quantity + 1),
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
              child: Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                child: Icon(
                  Icons.add,
                  size: 16,
                  color: _isUpdating 
                      ? theme.colorScheme.onSurface.withOpacity(0.3)
                      : theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Simplified cart item for order summary
class CartItemSummary extends StatelessWidget {
  const CartItemSummary({
    super.key,
    required this.cartItem,
    this.showImage = true,
  });

  final CartItem cartItem;
  final bool showImage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = cartItem.product;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Product Image
          if (showImage) ...[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: theme.colorScheme.surfaceContainerHighest,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: product.images.isNotEmpty
                    ? Image.network(
                        product.images.first,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.image_outlined,
                            color: theme.colorScheme.onSurfaceVariant,
                          );
                        },
                      )
                    : Icon(
                        Icons.image_outlined,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
              ),
            ),
            const SizedBox(width: 12),
          ],

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                if (cartItem.selectedVariants.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    cartItem.selectedVariants.entries
                        .map((e) => '${e.key}: ${e.value.value}')
                        .join(', '),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],

                const SizedBox(height: 2),
                Text(
                  'Qty: ${cartItem.quantity}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Price
          PriceDisplay(
            price: cartItem.totalPrice,
            size: PriceDisplaySize.medium,
          ),
        ],
      ),
    );
  }
}

/// Quantity selector widget
class QuantitySelector extends StatefulWidget {
  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onQuantityChanged,
    this.min = 1,
    this.max = 99,
    this.size = QuantitySelectorSize.medium,
  });

  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final int min;
  final int max;
  final QuantitySelectorSize size;

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

enum QuantitySelectorSize { small, medium, large }

class _QuantitySelectorState extends State<QuantitySelector> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.quantity.toString());
  }

  @override
  void didUpdateWidget(QuantitySelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.quantity != widget.quantity) {
      _controller.text = widget.quantity.toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateQuantity(int newQuantity) {
    final clampedQuantity = newQuantity.clamp(widget.min, widget.max);
    if (clampedQuantity != widget.quantity) {
      widget.onQuantityChanged(clampedQuantity);
    }
  }

  double _getSize() {
    switch (widget.size) {
      case QuantitySelectorSize.small:
        return 28;
      case QuantitySelectorSize.medium:
        return 32;
      case QuantitySelectorSize.large:
        return 40;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case QuantitySelectorSize.small:
        return 14;
      case QuantitySelectorSize.medium:
        return 16;
      case QuantitySelectorSize.large:
        return 18;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = _getSize();
    final iconSize = _getIconSize();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrease Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.quantity > widget.min
                  ? () => _updateQuantity(widget.quantity - 1)
                  : null,
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
              child: Container(
                width: size,
                height: size,
                alignment: Alignment.center,
                child: Icon(
                  Icons.remove,
                  size: iconSize,
                  color: widget.quantity > widget.min
                      ? theme.colorScheme.onSurface
                      : theme.colorScheme.onSurface.withOpacity(0.3),
                ),
              ),
            ),
          ),

          // Quantity Input
          Container(
            width: size + 10,
            height: size,
            decoration: BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(color: theme.colorScheme.outline),
              ),
            ),
            child: TextFormField(
              controller: _controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: theme.textTheme.bodySmall,
              onFieldSubmitted: (value) {
                final newQuantity = int.tryParse(value) ?? widget.quantity;
                _updateQuantity(newQuantity);
              },
            ),
          ),

          // Increase Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.quantity < widget.max
                  ? () => _updateQuantity(widget.quantity + 1)
                  : null,
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
              child: Container(
                width: size,
                height: size,
                alignment: Alignment.center,
                child: Icon(
                  Icons.add,
                  size: iconSize,
                  color: widget.quantity < widget.max
                      ? theme.colorScheme.onSurface
                      : theme.colorScheme.onSurface.withOpacity(0.3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}