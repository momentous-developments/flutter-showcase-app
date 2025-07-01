import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/layouts/module_layout.dart';
import 'views/product_list.dart';
import 'views/shopping_cart.dart';
import 'widgets/product_card.dart';
import 'providers/ecommerce_providers.dart';

/// Main e-commerce page with dashboard overview
class EcommercePage extends ConsumerStatefulWidget {
  const EcommercePage({super.key});

  @override
  ConsumerState<EcommercePage> createState() => _EcommercePageState();
}

class _EcommercePageState extends ConsumerState<EcommercePage> {
  @override
  void initState() {
    super.initState();
    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(featuredProductsProvider);
      ref.read(categoriesProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final featuredProducts = ref.watch(featuredProductsProvider);
    final categories = ref.watch(categoriesProvider);
    final cartItemCount = ref.watch(cartItemCountProvider);

    return ModuleLayout(
      title: 'E-commerce',
      subtitle: 'Complete online shopping platform',
      actions: [
        // Cart icon with badge
        MiniCart(),
        const SizedBox(width: 8),
        // Menu button for additional options
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            switch (value) {
              case 'products':
                _navigateToProducts();
                break;
              case 'cart':
                _navigateToCart();
                break;
              case 'orders':
                _navigateToOrders();
                break;
              case 'wishlist':
                _navigateToWishlist();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'products',
              child: ListTile(
                leading: Icon(Icons.shopping_bag),
                title: Text('All Products'),
                dense: true,
              ),
            ),
            PopupMenuItem(
              value: 'cart',
              child: ListTile(
                leading: Badge(
                  isLabelVisible: cartItemCount > 0,
                  label: Text(cartItemCount.toString()),
                  child: const Icon(Icons.shopping_cart),
                ),
                title: const Text('Shopping Cart'),
                dense: true,
              ),
            ),
            const PopupMenuItem(
              value: 'orders',
              child: ListTile(
                leading: Icon(Icons.receipt_long),
                title: Text('My Orders'),
                dense: true,
              ),
            ),
            const PopupMenuItem(
              value: 'wishlist',
              child: ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Wishlist'),
                dense: true,
              ),
            ),
          ],
        ),
      ],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section
            _buildWelcomeSection(),
            
            const SizedBox(height: 32),
            
            // Quick actions
            _buildQuickActions(),
            
            const SizedBox(height: 32),
            
            // Categories section
            _buildCategoriesSection(categories),
            
            const SizedBox(height: 32),
            
            // Featured products section
            _buildFeaturedProductsSection(featuredProducts),
            
            const SizedBox(height: 32),
            
            // Stats section
            _buildStatsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Our Store',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Discover amazing products at great prices. Shop with confidence and enjoy fast shipping.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onPrimary.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.tonal(
                  onPressed: _navigateToProducts,
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.onPrimary,
                    foregroundColor: theme.colorScheme.primary,
                  ),
                  child: const Text('Start Shopping'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Icon(
            Icons.shopping_bag,
            size: 80,
            color: theme.colorScheme.onPrimary.withOpacity(0.7),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildActionCard(
              icon: Icons.shopping_bag,
              title: 'Browse Products',
              subtitle: 'Explore our catalog',
              onTap: _navigateToProducts,
            ),
            _buildActionCard(
              icon: Icons.shopping_cart,
              title: 'Shopping Cart',
              subtitle: 'Review your items',
              onTap: _navigateToCart,
            ),
            _buildActionCard(
              icon: Icons.favorite,
              title: 'Wishlist',
              subtitle: 'Your saved items',
              onTap: _navigateToWishlist,
            ),
            _buildActionCard(
              icon: Icons.receipt_long,
              title: 'Order History',
              subtitle: 'Track your orders',
              onTap: _navigateToOrders,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(AsyncValue<List<dynamic>> categories) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Shop by Category',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: _navigateToProducts,
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        categories.when(
          data: (categoryList) {
            return SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  final category = categoryList[index];
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 16),
                    child: Card(
                      child: InkWell(
                        onTap: () => _navigateToProductsWithCategory(category.name),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _getCategoryIcon(category.name),
                                size: 32,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                category.name,
                                style: theme.textTheme.labelMedium,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Text('Error loading categories: $error'),
        ),
      ],
    );
  }

  Widget _buildFeaturedProductsSection(AsyncValue<List<dynamic>> featuredProducts) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Products',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: _navigateToProducts,
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        featuredProducts.when(
          data: (productList) {
            return SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productList.length.clamp(0, 10),
                itemBuilder: (context, index) {
                  final product = productList[index];
                  return SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ProductCard(
                        product: product,
                        onTap: () => _navigateToProductDetails(product.id),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Text('Error loading products: $error'),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    final theme = Theme.of(context);
    final cart = ref.watch(shoppingCartProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Shopping Stats',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 32,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cart.itemCount.toString(),
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Text(
                        'Items in Cart',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(
                        Icons.attach_money,
                        size: 32,
                        color: theme.colorScheme.secondary,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${cart.total.toStringAsFixed(2)}',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      Text(
                        'Cart Total',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'electronics':
        return Icons.devices;
      case 'clothing':
      case 'fashion':
        return Icons.checkroom;
      case 'home':
      case 'furniture':
        return Icons.home;
      case 'books':
        return Icons.book;
      case 'sports':
        return Icons.sports;
      case 'toys':
        return Icons.toys;
      case 'beauty':
        return Icons.face;
      case 'automotive':
        return Icons.directions_car;
      case 'office':
        return Icons.business_center;
      case 'shoes':
        return Icons.hiking;
      case 'accessories':
        return Icons.watch;
      default:
        return Icons.category;
    }
  }

  void _navigateToProducts() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ProductListView(),
      ),
    );
  }

  void _navigateToProductsWithCategory(String category) {
    // Set category filter and navigate
    ref.read(productFiltersProvider.notifier).updateCategory(category);
    _navigateToProducts();
  }

  void _navigateToProductDetails(int productId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigate to product $productId details')),
    );
  }

  void _navigateToCart() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ShoppingCartView(),
      ),
    );
  }

  void _navigateToOrders() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to orders')),
    );
  }

  void _navigateToWishlist() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to wishlist')),
    );
  }
}