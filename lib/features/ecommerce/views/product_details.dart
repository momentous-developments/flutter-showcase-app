import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/layouts/module_layout.dart';
import '../../../core/utils/responsive.dart';
import '../models/ecommerce_models.dart';
import '../providers/ecommerce_providers.dart';
import '../widgets/product_gallery.dart';
import '../widgets/rating_stars.dart';
import '../widgets/price_display.dart';
import '../widgets/cart_item.dart';
import '../widgets/product_card.dart';

/// Product details view with gallery, specifications, and reviews
class ProductDetailsView extends ConsumerStatefulWidget {
  const ProductDetailsView({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  ConsumerState<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends ConsumerState<ProductDetailsView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final Map<String, ProductVariant> _selectedVariants = {};
  int _selectedQuantity = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onVariantSelected(String type, ProductVariant variant) {
    setState(() {
      _selectedVariants[type] = variant;
    });
  }

  void _addToCart(Product product) {
    final cartNotifier = ref.read(shoppingCartProvider.notifier);
    cartNotifier.addItem(
      product,
      quantity: _selectedQuantity,
      selectedVariants: _selectedVariants,
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart'),
        action: SnackBarAction(
          label: 'VIEW CART',
          onPressed: () {
            // Navigate to cart
          },
        ),
      ),
    );
  }

  void _toggleWishlist(Product product) {
    final currentCustomer = ref.read(currentCustomerProvider);
    if (currentCustomer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login to use wishlist')),
      );
      return;
    }

    final wishlistNotifier = ref.read(wishlistProvider.notifier);
    final isInWishlist = ref.read(isInWishlistProvider(product.id));
    
    if (isInWishlist) {
      wishlistNotifier.removeFromWishlist(currentCustomer.id, product.id);
    } else {
      wishlistNotifier.addToWishlist(currentCustomer.id, product.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(productProvider(widget.productId));
    final reviewsAsync = ref.watch(productReviewsProvider(widget.productId));
    final recommendationsAsync = ref.watch(recommendationsProvider({
      'productId': widget.productId,
      'customerId': ref.watch(currentCustomerProvider)?.id,
    }));

    return productAsync.when(
      data: (product) => _buildProductDetails(product, reviewsAsync, recommendationsAsync),
      loading: () => _buildLoadingView(),
      error: (error, stackTrace) => _buildErrorView(error),
    );
  }

  Widget _buildProductDetails(
    Product product,
    AsyncValue<List<ProductReview>> reviewsAsync,
    AsyncValue<List<Product>> recommendationsAsync,
  ) {
    final isInWishlist = ref.watch(isInWishlistProvider(product.id));

    return ModuleLayout(
      title: product.name,
      subtitle: product.brand,
      actions: [
        IconButton(
          onPressed: () => _toggleWishlist(product),
          icon: Icon(
            isInWishlist ? Icons.favorite : Icons.favorite_outline,
          ),
          color: isInWishlist ? Theme.of(context).colorScheme.error : null,
          tooltip: isInWishlist ? 'Remove from wishlist' : 'Add to wishlist',
        ),
        IconButton(
          onPressed: () => _shareProduct(product),
          icon: const Icon(Icons.share),
          tooltip: 'Share product',
        ),
      ],
      body: ResponsiveLayoutBuilder(
        builder: (context, info) {
          if (info.isDesktop) {
            return _buildDesktopLayout(product, reviewsAsync, recommendationsAsync);
          } else {
            return _buildMobileLayout(product, reviewsAsync, recommendationsAsync);
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout(
    Product product,
    AsyncValue<List<ProductReview>> reviewsAsync,
    AsyncValue<List<Product>> recommendationsAsync,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Gallery
        Expanded(
          flex: 2,
          child: ProductGallery(
            images: product.images,
            height: 500,
          ),
        ),
        
        const SizedBox(width: 24),
        
        // Right side - Details
        Expanded(
          flex: 1,
          child: _buildProductInfo(product, reviewsAsync, recommendationsAsync),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(
    Product product,
    AsyncValue<List<ProductReview>> reviewsAsync,
    AsyncValue<List<Product>> recommendationsAsync,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Gallery
          ProductGallery(
            images: product.images,
            height: 300,
          ),
          
          const SizedBox(height: 16),
          
          // Product Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildProductInfo(product, reviewsAsync, recommendationsAsync),
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfo(
    Product product,
    AsyncValue<List<ProductReview>> reviewsAsync,
    AsyncValue<List<Product>> recommendationsAsync,
  ) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product badges
        if (product.isNew || (product.discount != null && product.discount!.isActive))
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (product.isNew)
                Chip(
                  label: const Text('NEW'),
                  backgroundColor: theme.colorScheme.tertiary,
                  labelStyle: TextStyle(color: theme.colorScheme.onTertiary),
                ),
              if (product.discount != null && product.discount!.isActive)
                Chip(
                  label: Text(
                    product.discount!.type == DiscountType.percentage
                        ? '${product.discount!.value.round()}% OFF'
                        : '\$${product.discount!.value} OFF',
                  ),
                  backgroundColor: theme.colorScheme.error,
                  labelStyle: TextStyle(color: theme.colorScheme.onError),
                ),
            ],
          ),
        
        if (product.isNew || (product.discount != null && product.discount!.isActive))
          const SizedBox(height: 16),
        
        // Price
        PriceDisplay(
          price: product.finalPrice,
          originalPrice: product.discount != null ? product.price : null,
          size: PriceDisplaySize.large,
        ),
        
        const SizedBox(height: 8),
        
        // Rating
        if (product.reviewCount > 0)
          RatingDisplay(
            rating: product.rating,
            reviewCount: product.reviewCount,
          ),
        
        const SizedBox(height: 16),
        
        // Stock status
        Row(
          children: [
            Icon(
              product.isInStock ? Icons.check_circle : Icons.cancel,
              color: product.isInStock ? Colors.green : Colors.red,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              product.isInStock ? 'In Stock' : 'Out of Stock',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: product.isInStock ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (product.isInStock && product.stock <= 10) ...[
              const SizedBox(width: 8),
              Text(
                '(Only ${product.stock} left)',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Product variants
        if (product.variants.isNotEmpty) ...[
          _buildVariantSelector(product),
          const SizedBox(height: 24),
        ],
        
        // Quantity selector
        Row(
          children: [
            Text(
              'Quantity:',
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(width: 16),
            QuantitySelector(
              quantity: _selectedQuantity,
              onQuantityChanged: (quantity) => setState(() {
                _selectedQuantity = quantity;
              }),
              max: product.stock,
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Action buttons
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: product.isInStock ? () => _addToCart(product) : null,
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Add to Cart'),
              ),
            ),
            const SizedBox(width: 12),
            FilledButton.tonal(
              onPressed: product.isInStock ? () => _buyNow(product) : null,
              child: const Text('Buy Now'),
            ),
          ],
        ),
        
        const SizedBox(height: 32),
        
        // Tabs for description, specifications, and reviews
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Description'),
            Tab(text: 'Specifications'),
            Tab(text: 'Reviews'),
          ],
        ),
        
        SizedBox(
          height: 400,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildDescriptionTab(product),
              _buildSpecificationsTab(product),
              _buildReviewsTab(reviewsAsync),
            ],
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Recommendations
        _buildRecommendations(recommendationsAsync),
      ],
    );
  }

  Widget _buildVariantSelector(Product product) {
    final theme = Theme.of(context);
    final variantTypes = product.variants
        .map((v) => v.type)
        .toSet()
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: variantTypes.map((type) {
        final variants = product.variants.where((v) => v.type == type).toList();
        final selectedVariant = _selectedVariants[type];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type.toUpperCase(),
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: variants.map((variant) {
                final isSelected = selectedVariant == variant;
                return FilterChip(
                  label: Text(variant.value),
                  selected: isSelected,
                  onSelected: variant.isInStock
                      ? (selected) {
                          if (selected) {
                            _onVariantSelected(type, variant);
                          }
                        }
                      : null,
                  backgroundColor: variant.isInStock
                      ? null
                      : theme.colorScheme.surfaceContainerHighest,
                  labelStyle: TextStyle(
                    color: variant.isInStock
                        ? null
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildDescriptionTab(Product product) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Text(
        product.description,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildSpecificationsTab(Product product) {
    if (product.specifications.isEmpty) {
      return const Center(
        child: Text('No specifications available'),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: product.specifications.entries.map((entry) {
        return ListTile(
          title: Text(entry.key),
          trailing: Text(entry.value),
          dense: true,
        );
      }).toList(),
    );
  }

  Widget _buildReviewsTab(AsyncValue<List<ProductReview>> reviewsAsync) {
    return reviewsAsync.when(
      data: (reviews) {
        if (reviews.isEmpty) {
          return const Center(
            child: Text('No reviews yet'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return _buildReviewItem(review);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error loading reviews: $error')),
    );
  }

  Widget _buildReviewItem(ProductReview review) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: review.customerAvatar != null
                      ? NetworkImage(review.customerAvatar!)
                      : null,
                  child: review.customerAvatar == null
                      ? Text(review.customerName?.substring(0, 1) ?? 'U')
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.customerName ?? 'Anonymous',
                        style: theme.textTheme.titleSmall,
                      ),
                      Row(
                        children: [
                          RatingStars(rating: review.rating.toDouble(), size: 12),
                          const SizedBox(width: 8),
                          Text(
                            review.createdAt.toString().split(' ')[0],
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          if (review.verified) ...[
                            const SizedBox(width: 8),
                            Icon(
                              Icons.verified,
                              size: 12,
                              color: theme.colorScheme.primary,
                            ),
                            Text(
                              'Verified',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.primary,
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
            const SizedBox(height: 12),
            if (review.title.isNotEmpty) ...[
              Text(
                review.title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
            ],
            Text(
              review.comment,
              style: theme.textTheme.bodyMedium,
            ),
            if (review.images.isNotEmpty) ...[
              const SizedBox(height: 12),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: review.images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.only(right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          review.images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
            if (review.reply != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.store,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          review.reply!.authorName ?? 'Store',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      review.reply!.comment,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendations(AsyncValue<List<Product>> recommendationsAsync) {
    return recommendationsAsync.when(
      data: (recommendations) {
        if (recommendations.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You might also like',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recommendations.length,
                itemBuilder: (context, index) {
                  final product = recommendations[index];
                  return SizedBox(
                    width: 200,
                    child: ProductCard(
                      product: product,
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsView(
                            productId: product.id,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, _) => const SizedBox.shrink(),
    );
  }

  Widget _buildLoadingView() {
    return const ModuleLayout(
      title: 'Loading...',
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorView(Object error) {
    return ModuleLayout(
      title: 'Error',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Product not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  void _buyNow(Product product) {
    // Add to cart and navigate to checkout
    _addToCart(product);
    // Navigate to checkout
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Redirecting to checkout...')),
    );
  }

  void _shareProduct(Product product) {
    // Implement product sharing
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Share ${product.name}')),
    );
  }
}