import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ecommerce_models.dart';
import '../providers/ecommerce_providers.dart';
import 'rating_stars.dart';
import 'price_display.dart';

/// Product card widget for displaying products in grid/list
class ProductCard extends ConsumerStatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
    this.showAddToCart = true,
    this.showWishlist = true,
    this.isGridView = true,
  });

  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final bool showAddToCart;
  final bool showWishlist;
  final bool isGridView;

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  bool get isInWishlist {
    final currentCustomer = ref.read(currentCustomerProvider);
    if (currentCustomer == null) return false;
    
    final wishlist = ref.watch(wishlistProvider);
    return wishlist.asData?.value.any((item) =>
      item.customerId == currentCustomer.id && item.productId == widget.product.id) ?? false;
  }

  void _addToCart() {
    final cartNotifier = ref.read(shoppingCartProvider.notifier);
    cartNotifier.addItem(widget.product);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.product.name} added to cart'),
        action: SnackBarAction(
          label: 'VIEW CART',
          onPressed: () {
            // Navigate to cart
          },
        ),
      ),
    );
    
    widget.onAddToCart?.call();
  }

  void _toggleWishlist() {
    final currentCustomer = ref.read(currentCustomerProvider);
    if (currentCustomer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login to use wishlist')),
      );
      return;
    }

    final wishlistNotifier = ref.read(wishlistProvider.notifier);
    final isInWishlist = ref.read(isInWishlistProvider(widget.product.id));
    
    if (isInWishlist) {
      wishlistNotifier.removeFromWishlist(currentCustomer.id, widget.product.id);
    } else {
      wishlistNotifier.addToWishlist(currentCustomer.id, widget.product.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isInWishlist = ref.watch(isInWishlistProvider(widget.product.id));
    
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) => _onHover(true),
            onExit: (_) => _onHover(false),
            child: GestureDetector(
              onTap: widget.onTap,
              child: Card(
                elevation: _isHovered ? 8 : 2,
                shadowColor: theme.colorScheme.shadow.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: widget.isGridView ? _buildGridCard() : _buildListCard(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridCard() {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  color: theme.colorScheme.surfaceContainerHighest,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: widget.product.images.isNotEmpty
                      ? Image.network(
                          widget.product.images.first,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildImagePlaceholder();
                          },
                        )
                      : _buildImagePlaceholder(),
                ),
              ),
              
              // Product badges
              Positioned(
                top: 8,
                left: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.product.isNew) _buildBadge('NEW', theme.colorScheme.tertiary),
                    if (widget.product.discount != null && widget.product.discount!.isActive) 
                      const SizedBox(height: 4),
                    if (widget.product.discount != null && widget.product.discount!.isActive)
                      _buildBadge(
                        widget.product.discount!.type == DiscountType.percentage
                            ? '-${widget.product.discount!.value.round()}%'
                            : '-\$${widget.product.discount!.value}',
                        theme.colorScheme.error,
                      ),
                  ],
                ),
              ),
              
              // Wishlist button
              if (widget.showWishlist)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _toggleWishlist,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isInWishlist ? Icons.favorite : Icons.favorite_outline,
                          size: 18,
                          color: isInWishlist ? theme.colorScheme.error : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
              
              // Stock status
              if (!widget.product.isInStock)
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
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
                ),
            ],
          ),
        ),
        
        // Product Info
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand
                if (widget.product.brand != null)
                  Text(
                    widget.product.brand!,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                
                // Product Name
                Text(
                  widget.product.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 4),
                
                // Rating
                if (widget.product.reviewCount > 0)
                  Row(
                    children: [
                      RatingStars(
                        rating: widget.product.rating,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${widget.product.reviewCount})',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                
                const Spacer(),
                
                // Price and Add to Cart
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: PriceDisplay(
                        price: widget.product.finalPrice,
                        originalPrice: widget.product.discount != null 
                            ? widget.product.price 
                            : null,
                        size: PriceDisplaySize.medium,
                      ),
                    ),
                    
                    if (widget.showAddToCart && widget.product.isInStock)
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _addToCart,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add_shopping_cart,
                              size: 16,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListCard() {
    final theme = Theme.of(context);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image
        SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                  color: theme.colorScheme.surfaceContainerHighest,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                  child: widget.product.images.isNotEmpty
                      ? Image.network(
                          widget.product.images.first,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildImagePlaceholder();
                          },
                        )
                      : _buildImagePlaceholder(),
                ),
              ),
              
              // Wishlist button
              if (widget.showWishlist)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _toggleWishlist,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isInWishlist ? Icons.favorite : Icons.favorite_outline,
                          size: 16,
                          color: isInWishlist ? theme.colorScheme.error : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        
        // Product Info
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand and badges
                Row(
                  children: [
                    if (widget.product.brand != null)
                      Expanded(
                        child: Text(
                          widget.product.brand!,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    
                    if (widget.product.isNew)
                      _buildBadge('NEW', theme.colorScheme.tertiary),
                    
                    if (widget.product.discount != null && widget.product.discount!.isActive) ...[
                      const SizedBox(width: 4),
                      _buildBadge(
                        widget.product.discount!.type == DiscountType.percentage
                            ? '-${widget.product.discount!.value.round()}%'
                            : '-\$${widget.product.discount!.value}',
                        theme.colorScheme.error,
                      ),
                    ],
                  ],
                ),
                
                const SizedBox(height: 4),
                
                // Product Name
                Text(
                  widget.product.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 4),
                
                // Description
                Text(
                  widget.product.description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 8),
                
                // Rating and stock
                Row(
                  children: [
                    if (widget.product.reviewCount > 0) ...[
                      RatingStars(
                        rating: widget.product.rating,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${widget.product.reviewCount})',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                    
                    if (!widget.product.isInStock)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // Price and Add to Cart
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriceDisplay(
                      price: widget.product.finalPrice,
                      originalPrice: widget.product.discount != null 
                          ? widget.product.price 
                          : null,
                      size: PriceDisplaySize.large,
                    ),
                    
                    if (widget.showAddToCart && widget.product.isInStock)
                      FilledButton.icon(
                        onPressed: _addToCart,
                        icon: const Icon(Icons.add_shopping_cart, size: 16),
                        label: const Text('Add to Cart'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePlaceholder() {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: theme.colorScheme.surfaceContainerHighest,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: 32,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 4),
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

  Widget _buildBadge(String text, Color color) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.surface,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}