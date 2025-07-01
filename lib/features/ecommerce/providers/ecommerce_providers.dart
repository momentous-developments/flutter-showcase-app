import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ecommerce_models.dart';
import '../services/ecommerce_service.dart';

/// E-commerce service provider
final ecommerceServiceProvider = Provider<EcommerceService>((ref) {
  return EcommerceService();
});

/// Products state notifier
class ProductsNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  ProductsNotifier(this._service) : super(const AsyncValue.loading());

  final EcommerceService _service;

  /// Load products with optional filters
  Future<void> loadProducts({
    String? category,
    String? search,
    double? minPrice,
    double? maxPrice,
    int? limit,
    int? offset,
    String? sortBy,
    String? sortOrder,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      final products = await _service.getProducts(
        category: category,
        search: search,
        minPrice: minPrice,
        maxPrice: maxPrice,
        limit: limit,
        offset: offset,
        sortBy: sortBy,
        sortOrder: sortOrder,
      );
      state = AsyncValue.data(products);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Search products
  Future<void> searchProducts(String query, {
    int limit = 20,
    int offset = 0,
    String? category,
    double? minPrice,
    double? maxPrice,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      final products = await _service.searchProducts(
        query,
        limit: limit,
        offset: offset,
        category: category,
        minPrice: minPrice,
        maxPrice: maxPrice,
      );
      state = AsyncValue.data(products);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Refresh products
  Future<void> refresh() async {
    await loadProducts();
  }
}

/// Products provider
final productsProvider = StateNotifierProvider<ProductsNotifier, AsyncValue<List<Product>>>((ref) {
  final service = ref.watch(ecommerceServiceProvider);
  return ProductsNotifier(service);
});

/// Featured products provider
final featuredProductsProvider = FutureProvider<List<Product>>((ref) async {
  final service = ref.watch(ecommerceServiceProvider);
  return service.getFeaturedProducts();
});

/// Product by ID provider
final productProvider = FutureProvider.family<Product, int>((ref, productId) async {
  final service = ref.watch(ecommerceServiceProvider);
  return service.getProduct(productId);
});

/// Product categories provider
final categoriesProvider = FutureProvider<List<ProductCategory>>((ref) async {
  final service = ref.watch(ecommerceServiceProvider);
  return service.getCategories();
});

/// Product reviews provider
final productReviewsProvider = FutureProvider.family<List<ProductReview>, int>((ref, productId) async {
  final service = ref.watch(ecommerceServiceProvider);
  return service.getProductReviews(productId);
});

/// Product recommendations provider
final recommendationsProvider = FutureProvider.family<List<Product>, Map<String, int?>>((ref, params) async {
  final service = ref.watch(ecommerceServiceProvider);
  return service.getRecommendations(
    productId: params['productId'],
    customerId: params['customerId'],
  );
});

/// Shopping cart state notifier
class ShoppingCartNotifier extends StateNotifier<ShoppingCart> {
  ShoppingCartNotifier(this._service) : super(const ShoppingCart());

  final EcommerceService _service;

  /// Add item to cart
  void addItem(Product product, {
    int quantity = 1,
    Map<String, ProductVariant> selectedVariants = const {},
  }) {
    final cartItem = CartItem(
      product: product,
      quantity: quantity,
      selectedVariants: selectedVariants,
    );
    state = state.addItem(cartItem);
  }

  /// Remove item from cart
  void removeItem(CartItem item) {
    state = state.removeItem(item);
  }

  /// Update item quantity
  void updateItemQuantity(CartItem item, int quantity) {
    state = state.updateItemQuantity(item, quantity);
  }

  /// Clear cart
  void clearCart() {
    state = state.clearCart();
  }

  /// Apply coupon
  Future<void> applyCoupon(String couponCode) async {
    try {
      final result = await _service.applyCoupon(couponCode, state.subtotal);
      // Handle coupon application result
      // This would typically update the cart with discount information
    } catch (e) {
      // Handle error
      rethrow;
    }
  }

  /// Calculate shipping
  Future<void> calculateShipping(Address address) async {
    try {
      final shippingCost = await _service.calculateShipping(address, state.items);
      state = state.copyWith(shippingCost: shippingCost);
    } catch (e) {
      // Handle error
      rethrow;
    }
  }

  /// Save cart to server
  Future<void> saveCart(int customerId) async {
    try {
      await _service.saveCart(customerId, state);
    } catch (e) {
      // Handle error
      rethrow;
    }
  }

  /// Load cart from server
  Future<void> loadCart(int customerId) async {
    try {
      final cart = await _service.loadCart(customerId);
      state = cart;
    } catch (e) {
      // Handle error
      rethrow;
    }
  }

  /// Update tax rate
  void updateTaxRate(double taxRate) {
    state = state.copyWith(taxRate: taxRate);
  }
}

/// Shopping cart provider
final shoppingCartProvider = StateNotifierProvider<ShoppingCartNotifier, ShoppingCart>((ref) {
  final service = ref.watch(ecommerceServiceProvider);
  return ShoppingCartNotifier(service);
});

/// Cart item count provider
final cartItemCountProvider = Provider<int>((ref) {
  final cart = ref.watch(shoppingCartProvider);
  return cart.itemCount;
});

/// Cart total provider
final cartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(shoppingCartProvider);
  return cart.total;
});

/// Wishlist state notifier
class WishlistNotifier extends StateNotifier<AsyncValue<List<WishlistItem>>> {
  WishlistNotifier(this._service) : super(const AsyncValue.loading());

  final EcommerceService _service;

  /// Load wishlist for customer
  Future<void> loadWishlist(int customerId) async {
    state = const AsyncValue.loading();
    
    try {
      final wishlist = await _service.getCustomerWishlist(customerId);
      state = AsyncValue.data(wishlist);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Add product to wishlist
  Future<void> addToWishlist(int customerId, int productId) async {
    try {
      await _service.addToWishlist(customerId, productId);
      await loadWishlist(customerId); // Refresh wishlist
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Remove product from wishlist
  Future<void> removeFromWishlist(int customerId, int productId) async {
    try {
      await _service.removeFromWishlist(customerId, productId);
      await loadWishlist(customerId); // Refresh wishlist
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Check if product is in wishlist
  bool isInWishlist(int productId) {
    return state.when(
      data: (items) => items.any((item) => item.productId == productId),
      loading: () => false,
      error: (_, __) => false,
    );
  }
}

/// Wishlist provider
final wishlistProvider = StateNotifierProvider<WishlistNotifier, AsyncValue<List<WishlistItem>>>((ref) {
  final service = ref.watch(ecommerceServiceProvider);
  return WishlistNotifier(service);
});

/// Check if product is in wishlist provider
final isInWishlistProvider = Provider.family<bool, int>((ref, productId) {
  final wishlistNotifier = ref.watch(wishlistProvider.notifier);
  return wishlistNotifier.isInWishlist(productId);
});

/// Orders state notifier
class OrdersNotifier extends StateNotifier<AsyncValue<List<Order>>> {
  OrdersNotifier(this._service) : super(const AsyncValue.loading());

  final EcommerceService _service;

  /// Load orders for customer
  Future<void> loadOrders(int customerId) async {
    state = const AsyncValue.loading();
    
    try {
      final orders = await _service.getCustomerOrders(customerId);
      state = AsyncValue.data(orders);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Create new order
  Future<Order> createOrder({
    required int customerId,
    required List<CartItem> items,
    required Address shippingAddress,
    Address? billingAddress,
    required PaymentMethod paymentMethod,
    String? notes,
  }) async {
    try {
      final order = await _service.createOrder(
        customerId: customerId,
        items: items,
        shippingAddress: shippingAddress,
        billingAddress: billingAddress,
        paymentMethod: paymentMethod,
        notes: notes,
      );
      await loadOrders(customerId); // Refresh orders
      return order;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  /// Cancel order
  Future<void> cancelOrder(int orderId, String reason, int customerId) async {
    try {
      await _service.cancelOrder(orderId, reason);
      await loadOrders(customerId); // Refresh orders
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

/// Orders provider
final ordersProvider = StateNotifierProvider<OrdersNotifier, AsyncValue<List<Order>>>((ref) {
  final service = ref.watch(ecommerceServiceProvider);
  return OrdersNotifier(service);
});

/// Order by ID provider
final orderProvider = FutureProvider.family<Order, int>((ref, orderId) async {
  final service = ref.watch(ecommerceServiceProvider);
  return service.getOrder(orderId);
});

/// Customers state notifier (for admin)
class CustomersNotifier extends StateNotifier<AsyncValue<List<Customer>>> {
  CustomersNotifier(this._service) : super(const AsyncValue.loading());

  final EcommerceService _service;

  /// Load customers
  Future<void> loadCustomers({String? search}) async {
    state = const AsyncValue.loading();
    
    try {
      final customers = await _service.getCustomers(search: search);
      state = AsyncValue.data(customers);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Search customers
  Future<void> searchCustomers(String query) async {
    await loadCustomers(search: query);
  }

  /// Create customer
  Future<void> createCustomer({
    required String email,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    try {
      await _service.createCustomer(
        email: email,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
      );
      await loadCustomers(); // Refresh customers
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  /// Update customer
  Future<void> updateCustomer(int customerId, Map<String, dynamic> updates) async {
    try {
      await _service.updateCustomer(customerId, updates);
      await loadCustomers(); // Refresh customers
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

/// Customers provider (for admin)
final customersProvider = StateNotifierProvider<CustomersNotifier, AsyncValue<List<Customer>>>((ref) {
  final service = ref.watch(ecommerceServiceProvider);
  return CustomersNotifier(service);
});

/// Customer by ID provider
final customerProvider = FutureProvider.family<Customer, int>((ref, customerId) async {
  final service = ref.watch(ecommerceServiceProvider);
  return service.getCustomer(customerId);
});

/// Reviews state notifier (for admin)
class ReviewsNotifier extends StateNotifier<AsyncValue<List<ProductReview>>> {
  ReviewsNotifier(this._service) : super(const AsyncValue.loading());

  final EcommerceService _service;

  /// Load reviews
  Future<void> loadReviews({ReviewStatus? status, int? productId}) async {
    state = const AsyncValue.loading();
    
    try {
      final reviews = await _service.getReviews(status: status, productId: productId);
      state = AsyncValue.data(reviews);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Update review status
  Future<void> updateReviewStatus(int reviewId, ReviewStatus status) async {
    try {
      await _service.updateReviewStatus(reviewId, status);
      await loadReviews(); // Refresh reviews
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  /// Reply to review
  Future<void> replyToReview(int reviewId, String comment, String authorName) async {
    try {
      await _service.replyToReview(reviewId, comment, authorName);
      await loadReviews(); // Refresh reviews
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  /// Add product review
  Future<void> addReview({
    required int productId,
    required int customerId,
    required int rating,
    required String title,
    required String comment,
    List<String> images = const [],
  }) async {
    try {
      await _service.addProductReview(
        productId: productId,
        customerId: customerId,
        rating: rating,
        title: title,
        comment: comment,
        images: images,
      );
      await loadReviews(); // Refresh reviews
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

/// Reviews provider (for admin)
final reviewsProvider = StateNotifierProvider<ReviewsNotifier, AsyncValue<List<ProductReview>>>((ref) {
  final service = ref.watch(ecommerceServiceProvider);
  return ReviewsNotifier(service);
});

/// Current customer provider (would be set based on authentication)
final currentCustomerProvider = StateProvider<Customer?>((ref) => null);

/// E-commerce analytics provider
final analyticsProvider = FutureProvider.family<Map<String, dynamic>, Map<String, DateTime?>>((ref, dateRange) async {
  final service = ref.watch(ecommerceServiceProvider);
  return service.getAnalytics(
    startDate: dateRange['start'],
    endDate: dateRange['end'],
  );
});

/// Product filters state
class ProductFilters {
  const ProductFilters({
    this.category,
    this.minPrice,
    this.maxPrice,
    this.sortBy,
    this.sortOrder,
    this.search,
  });

  final String? category;
  final double? minPrice;
  final double? maxPrice;
  final String? sortBy;
  final String? sortOrder;
  final String? search;

  ProductFilters copyWith({
    String? category,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    String? sortOrder,
    String? search,
  }) {
    return ProductFilters(
      category: category ?? this.category,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      search: search ?? this.search,
    );
  }
}

/// Product filters state notifier
class ProductFiltersNotifier extends StateNotifier<ProductFilters> {
  ProductFiltersNotifier() : super(const ProductFilters());

  void updateCategory(String? category) {
    state = state.copyWith(category: category);
  }

  void updatePriceRange(double? minPrice, double? maxPrice) {
    state = state.copyWith(minPrice: minPrice, maxPrice: maxPrice);
  }

  void updateSort(String? sortBy, String? sortOrder) {
    state = state.copyWith(sortBy: sortBy, sortOrder: sortOrder);
  }

  void updateSearch(String? search) {
    state = state.copyWith(search: search);
  }

  void clearFilters() {
    state = const ProductFilters();
  }
}

/// Product filters provider
final productFiltersProvider = StateNotifierProvider<ProductFiltersNotifier, ProductFilters>((ref) {
  return ProductFiltersNotifier();
});

/// Filtered products provider
final filteredProductsProvider = Provider<AsyncValue<List<Product>>>((ref) {
  final products = ref.watch(productsProvider);
  final filters = ref.watch(productFiltersProvider);

  return products.when(
    data: (products) {
      var filteredProducts = products;

      // Apply category filter
      if (filters.category != null && filters.category!.isNotEmpty) {
        filteredProducts = filteredProducts
            .where((product) => product.category.toLowerCase() == filters.category!.toLowerCase())
            .toList();
      }

      // Apply price range filter
      if (filters.minPrice != null) {
        filteredProducts = filteredProducts
            .where((product) => product.finalPrice >= filters.minPrice!)
            .toList();
      }
      if (filters.maxPrice != null) {
        filteredProducts = filteredProducts
            .where((product) => product.finalPrice <= filters.maxPrice!)
            .toList();
      }

      // Apply search filter
      if (filters.search != null && filters.search!.isNotEmpty) {
        final searchLower = filters.search!.toLowerCase();
        filteredProducts = filteredProducts
            .where((product) =>
                product.name.toLowerCase().contains(searchLower) ||
                product.description.toLowerCase().contains(searchLower) ||
                product.category.toLowerCase().contains(searchLower) ||
                (product.brand?.toLowerCase().contains(searchLower) ?? false))
            .toList();
      }

      // Apply sorting
      if (filters.sortBy != null) {
        switch (filters.sortBy) {
          case 'price':
            filteredProducts.sort((a, b) {
              final comparison = a.finalPrice.compareTo(b.finalPrice);
              return filters.sortOrder == 'desc' ? -comparison : comparison;
            });
            break;
          case 'name':
            filteredProducts.sort((a, b) {
              final comparison = a.name.compareTo(b.name);
              return filters.sortOrder == 'desc' ? -comparison : comparison;
            });
            break;
          case 'rating':
            filteredProducts.sort((a, b) {
              final comparison = a.rating.compareTo(b.rating);
              return filters.sortOrder == 'desc' ? -comparison : comparison;
            });
            break;
          case 'newest':
            filteredProducts.sort((a, b) {
              final aScore = a.isNew ? 1 : 0;
              final bScore = b.isNew ? 1 : 0;
              final comparison = aScore.compareTo(bScore);
              return filters.sortOrder == 'desc' ? -comparison : comparison;
            });
            break;
        }
      }

      return AsyncValue.data(filteredProducts);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

/// Checkout state
class CheckoutState {
  const CheckoutState({
    this.currentStep = 0,
    this.shippingAddress,
    this.billingAddress,
    this.paymentMethod,
    this.notes,
    this.isProcessing = false,
  });

  final int currentStep;
  final Address? shippingAddress;
  final Address? billingAddress;
  final PaymentMethod? paymentMethod;
  final String? notes;
  final bool isProcessing;

  CheckoutState copyWith({
    int? currentStep,
    Address? shippingAddress,
    Address? billingAddress,
    PaymentMethod? paymentMethod,
    String? notes,
    bool? isProcessing,
  }) {
    return CheckoutState(
      currentStep: currentStep ?? this.currentStep,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      billingAddress: billingAddress ?? this.billingAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}

/// Checkout state notifier
class CheckoutNotifier extends StateNotifier<CheckoutState> {
  CheckoutNotifier() : super(const CheckoutState());

  void nextStep() {
    if (state.currentStep < 3) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void setStep(int step) {
    state = state.copyWith(currentStep: step);
  }

  void setShippingAddress(Address address) {
    state = state.copyWith(shippingAddress: address);
  }

  void setBillingAddress(Address address) {
    state = state.copyWith(billingAddress: address);
  }

  void setPaymentMethod(PaymentMethod paymentMethod) {
    state = state.copyWith(paymentMethod: paymentMethod);
  }

  void setNotes(String notes) {
    state = state.copyWith(notes: notes);
  }

  void setProcessing(bool isProcessing) {
    state = state.copyWith(isProcessing: isProcessing);
  }

  void reset() {
    state = const CheckoutState();
  }
}

/// Checkout provider
final checkoutProvider = StateNotifierProvider<CheckoutNotifier, CheckoutState>((ref) {
  return CheckoutNotifier();
});