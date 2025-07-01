import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/layouts/module_layout.dart';
import '../../../core/utils/responsive.dart';
import '../models/ecommerce_models.dart';
import '../providers/ecommerce_providers.dart';
import '../widgets/cart_item.dart';
import '../widgets/price_display.dart';

/// Shopping cart view with item management and checkout
class ShoppingCartView extends ConsumerStatefulWidget {
  const ShoppingCartView({super.key});

  @override
  ConsumerState<ShoppingCartView> createState() => _ShoppingCartViewState();
}

class _ShoppingCartViewState extends ConsumerState<ShoppingCartView> {
  final TextEditingController _couponController = TextEditingController();
  bool _isApplyingCoupon = false;

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  void _proceedToCheckout() {
    final cart = ref.read(shoppingCartProvider);
    
    if (cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your cart is empty')),
      );
      return;
    }

    if (cart.hasOutOfStockItems) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please remove out of stock items before checkout'),
        ),
      );
      return;
    }

    // Navigate to checkout
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Proceeding to checkout...')),
    );
  }

  void _continueShopping() {
    Navigator.of(context).pop();
  }

  void _clearCart() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Are you sure you want to remove all items from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(shoppingCartProvider.notifier).clearCart();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cart cleared')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _saveForLater(CartItem item) {
    // Remove from cart and save for later
    ref.read(shoppingCartProvider.notifier).removeItem(item);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.product.name} saved for later')),
    );
  }

  Future<void> _applyCoupon() async {
    if (_couponController.text.trim().isEmpty) return;

    setState(() {
      _isApplyingCoupon = true;
    });

    try {
      final cartNotifier = ref.read(shoppingCartProvider.notifier);
      await cartNotifier.applyCoupon(_couponController.text.trim());
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Coupon applied successfully')),
      );
      
      _couponController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to apply coupon: $e')),
      );
    } finally {
      setState(() {
        _isApplyingCoupon = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(shoppingCartProvider);
    final cartItemCount = ref.watch(cartItemCountProvider);

    return ModuleLayout(
      title: 'Shopping Cart',
      subtitle: cartItemCount > 0 ? '$cartItemCount items' : 'Empty cart',
      actions: [
        if (cart.items.isNotEmpty) ...[
          TextButton.icon(
            onPressed: _clearCart,
            icon: const Icon(Icons.clear_all),
            label: const Text('Clear Cart'),
          ),
          const SizedBox(width: 8),
        ],
        IconButton(
          onPressed: _continueShopping,
          icon: const Icon(Icons.shopping_bag_outlined),
          tooltip: 'Continue Shopping',
        ),
      ],
      body: cart.isEmpty ? _buildEmptyCart() : _buildCartContent(cart),
    );
  }

  Widget _buildEmptyCart() {
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 120,
            color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
          ),
          const SizedBox(height: 24),
          Text(
            'Your cart is empty',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Add some items to get started',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: _continueShopping,
            icon: const Icon(Icons.shopping_bag),
            label: const Text('Start Shopping'),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent(ShoppingCart cart) {
    return ResponsiveLayoutBuilder(
      builder: (context, info) {
        if (info.isDesktop) {
          return _buildDesktopLayout(cart);
        } else {
          return _buildMobileLayout(cart);
        }
      },
    );
  }

  Widget _buildDesktopLayout(ShoppingCart cart) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cart items (left side)
        Expanded(
          flex: 2,
          child: _buildCartItems(cart),
        ),
        
        const SizedBox(width: 24),
        
        // Order summary (right side)
        SizedBox(
          width: 350,
          child: _buildOrderSummary(cart),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(ShoppingCart cart) {
    return Column(
      children: [
        // Cart items
        Expanded(
          child: _buildCartItems(cart),
        ),
        
        // Order summary (sticky bottom)
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: _buildOrderSummary(cart, isMobile: true),
          ),
        ),
      ],
    );
  }

  Widget _buildCartItems(ShoppingCart cart) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Items in Cart (${cart.itemCount})',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (cart.hasOutOfStockItems)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Out of stock items',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                  ),
                ),
              ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Cart items list
        Expanded(
          child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final item = cart.items[index];
              return CartItemWidget(
                cartItem: item,
                onSaveForLater: () => _saveForLater(item),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary(ShoppingCart cart, {bool isMobile = false}) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: isMobile ? 0 : null,
      color: isMobile ? Colors.transparent : null,
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 0 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isMobile) ...[
              Text(
                'Order Summary',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // Price breakdown
            PriceBreakdown(
              subtotal: cart.subtotal,
              shipping: cart.shippingCost,
              tax: cart.taxAmount,
              total: cart.total,
              showItemCount: cart.itemCount,
            ),
            
            const SizedBox(height: 16),
            
            // Coupon section
            if (!isMobile) _buildCouponSection(),
            
            const SizedBox(height: 16),
            
            // Checkout button
            FilledButton(
              onPressed: cart.isEmpty || cart.hasOutOfStockItems 
                  ? null 
                  : _proceedToCheckout,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock_outline),
                    const SizedBox(width: 8),
                    const Text('Secure Checkout'),
                    if (!isMobile) ...[
                      const SizedBox(width: 8),
                      Text(
                        '• \$${cart.total.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Continue shopping
            OutlinedButton(
              onPressed: _continueShopping,
              child: const Text('Continue Shopping'),
            ),
            
            if (!isMobile) ...[
              const SizedBox(height: 24),
              
              // Security badges
              _buildSecurityBadges(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCouponSection() {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Promo Code',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _couponController,
                decoration: const InputDecoration(
                  hintText: 'Enter code',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                enabled: !_isApplyingCoupon,
              ),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: _isApplyingCoupon ? null : _applyCoupon,
              child: _isApplyingCoupon 
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Apply'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecurityBadges() {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(
                  Icons.security,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 4),
                Text(
                  'Secure',
                  style: theme.textTheme.labelSmall,
                ),
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.local_shipping,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 4),
                Text(
                  'Fast Shipping',
                  style: theme.textTheme.labelSmall,
                ),
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.replay,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 4),
                Text(
                  'Easy Returns',
                  style: theme.textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Your information is protected with industry-standard encryption',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Mini cart widget for showing in app bar or drawer
class MiniCart extends ConsumerWidget {
  const MiniCart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(shoppingCartProvider);
    final cartItemCount = ref.watch(cartItemCountProvider);
    final theme = Theme.of(context);

    return IconButton(
      onPressed: () {
        // Navigate to cart
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ShoppingCartView(),
          ),
        );
      },
      icon: Badge(
        isLabelVisible: cartItemCount > 0,
        label: Text(cartItemCount.toString()),
        child: const Icon(Icons.shopping_cart_outlined),
      ),
      tooltip: 'Shopping Cart (${cartItemCount})',
    );
  }
}

/// Cart drawer for quick access
class CartDrawer extends ConsumerWidget {
  const CartDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(shoppingCartProvider);
    final theme = Theme.of(context);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: theme.colorScheme.onPrimary,
                  size: 32,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Shopping Cart',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${cart.itemCount} items',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onPrimary.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          if (cart.isEmpty)
            const Expanded(
              child: Center(
                child: Text('Your cart is empty'),
              ),
            )
          else ...[
            // Cart items
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final item = cart.items[index];
                  return CartItemSummary(cartItem: item);
                },
              ),
            ),
            
            // Bottom actions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: theme.dividerColor),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      PriceDisplay(
                        price: cart.total,
                        size: PriceDisplaySize.medium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ShoppingCartView(),
                              ),
                            );
                          },
                          child: const Text('View Cart'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FilledButton(
                          onPressed: cart.hasOutOfStockItems
                              ? null
                              : () {
                                  Navigator.of(context).pop();
                                  // Navigate to checkout
                                },
                          child: const Text('Checkout'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}