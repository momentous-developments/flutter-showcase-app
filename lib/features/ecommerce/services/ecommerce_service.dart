import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/services/api_service.dart';
import '../models/ecommerce_models.dart';

/// Service for e-commerce API operations
class EcommerceService {
  static const String _baseUrl = 'http://localhost:8000/api/ecommerce';
  
  /// Get all products with optional filtering
  Future<List<Product>> getProducts({
    String? category,
    String? search,
    double? minPrice,
    double? maxPrice,
    int? limit,
    int? offset,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, String>{};
      
      if (category != null) queryParams['category'] = category;
      if (search != null) queryParams['search'] = search;
      if (minPrice != null) queryParams['min_price'] = minPrice.toString();
      if (maxPrice != null) queryParams['max_price'] = maxPrice.toString();
      if (limit != null) queryParams['limit'] = limit.toString();
      if (offset != null) queryParams['offset'] = offset.toString();
      if (sortBy != null) queryParams['sort_by'] = sortBy;
      if (sortOrder != null) queryParams['sort_order'] = sortOrder;
      
      final uri = Uri.parse('$_baseUrl/products').replace(queryParameters: queryParams);
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final products = jsonData['products'] as List;
        return products.map((product) => Product.fromJson(product)).toList();
      } else {
        throw ApiException('Failed to fetch products: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error fetching products: $e');
    }
  }

  /// Get product by ID
  Future<Product> getProduct(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products/$id'));
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Product.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw ApiException('Product not found');
      } else {
        throw ApiException('Failed to fetch product: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error fetching product: $e');
    }
  }

  /// Get featured products
  Future<List<Product>> getFeaturedProducts({int limit = 10}) async {
    try {
      final uri = Uri.parse('$_baseUrl/products/featured')
          .replace(queryParameters: {'limit': limit.toString()});
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final products = jsonData['products'] as List;
        return products.map((product) => Product.fromJson(product)).toList();
      } else {
        throw ApiException('Failed to fetch featured products: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error fetching featured products: $e');
    }
  }

  /// Get product categories
  Future<List<ProductCategory>> getCategories() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/categories'));
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final categories = jsonData['categories'] as List;
        return categories.map((category) => ProductCategory.fromJson(category)).toList();
      } else {
        throw ApiException('Failed to fetch categories: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error fetching categories: $e');
    }
  }

  /// Get product reviews
  Future<List<ProductReview>> getProductReviews(int productId, {int limit = 20, int offset = 0}) async {
    try {
      final uri = Uri.parse('$_baseUrl/products/$productId/reviews')
          .replace(queryParameters: {
            'limit': limit.toString(),
            'offset': offset.toString(),
          });
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final reviews = jsonData['reviews'] as List;
        return reviews.map((review) => ProductReview.fromJson(review)).toList();
      } else {
        throw ApiException('Failed to fetch reviews: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error fetching reviews: $e');
    }
  }

  /// Add product review
  Future<ProductReview> addProductReview({
    required int productId,
    required int customerId,
    required int rating,
    required String title,
    required String comment,
    List<String> images = const [],
  }) async {
    try {
      final reviewData = {
        'productId': productId,
        'customerId': customerId,
        'rating': rating,
        'title': title,
        'comment': comment,
        'images': images,
      };
      
      final response = await http.post(
        Uri.parse('$_baseUrl/products/$productId/reviews'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(reviewData),
      );
      
      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        return ProductReview.fromJson(jsonData);
      } else {
        throw ApiException('Failed to add review: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error adding review: $e');
    }
  }

  /// Get customer orders
  Future<List<Order>> getCustomerOrders(int customerId, {int limit = 20, int offset = 0}) async {
    try {
      final uri = Uri.parse('$_baseUrl/customers/$customerId/orders')
          .replace(queryParameters: {
            'limit': limit.toString(),
            'offset': offset.toString(),
          });
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final orders = jsonData['orders'] as List;
        return orders.map((order) => Order.fromJson(order)).toList();
      } else {
        throw ApiException('Failed to fetch orders: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error fetching orders: $e');
    }
  }

  /// Get order by ID
  Future<Order> getOrder(int orderId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/orders/$orderId'));
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Order.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw ApiException('Order not found');
      } else {
        throw ApiException('Failed to fetch order: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error fetching order: $e');
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
      final orderData = {
        'customerId': customerId,
        'items': items.map((item) => {
          'productId': item.product.id,
          'productName': item.product.name,
          'quantity': item.quantity,
          'unitPrice': item.unitPrice,
          'productImage': item.product.images.isNotEmpty ? item.product.images.first : null,
          'selectedVariants': item.selectedVariants.map(
            (key, variant) => MapEntry(key, variant.value),
          ),
        }).toList(),
        'shippingAddress': shippingAddress.toJson(),
        'billingAddress': (billingAddress ?? shippingAddress).toJson(),
        'paymentMethod': paymentMethod.toJson(),
        'notes': notes,
      };
      
      final response = await http.post(
        Uri.parse('$_baseUrl/orders'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(orderData),
      );
      
      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        return Order.fromJson(jsonData);
      } else {
        throw ApiException('Failed to create order: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error creating order: $e');
    }
  }

  /// Update order status
  Future<Order> updateOrderStatus(int orderId, OrderStatus status) async {
    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl/orders/$orderId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'status': status.name}),
      );
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Order.fromJson(jsonData);
      } else {
        throw ApiException('Failed to update order: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error updating order: $e');
    }
  }

  /// Cancel order
  Future<Order> cancelOrder(int orderId, String reason) async {
    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl/orders/$orderId/cancel'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'reason': reason}),
      );
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Order.fromJson(jsonData);
      } else {
        throw ApiException('Failed to cancel order: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error cancelling order: $e');
    }
  }

  /// Get customers
  Future<List<Customer>> getCustomers({int limit = 20, int offset = 0, String? search}) async {
    try {
      final queryParams = <String, String>{
        'limit': limit.toString(),
        'offset': offset.toString(),
      };
      if (search != null) queryParams['search'] = search;
      
      final uri = Uri.parse('$_baseUrl/customers')
          .replace(queryParameters: queryParams);
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final customers = jsonData['customers'] as List;
        return customers.map((customer) => Customer.fromJson(customer)).toList();
      } else {
        throw ApiException('Failed to fetch customers: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error fetching customers: $e');
    }
  }

  /// Get customer by ID
  Future<Customer> getCustomer(int customerId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/customers/$customerId'));
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Customer.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw ApiException('Customer not found');
      } else {
        throw ApiException('Failed to fetch customer: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error fetching customer: $e');
    }
  }

  /// Create customer
  Future<Customer> createCustomer({
    required String email,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    try {
      final customerData = {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
      };
      
      final response = await http.post(
        Uri.parse('$_baseUrl/customers'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(customerData),
      );
      
      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        return Customer.fromJson(jsonData);
      } else {
        throw ApiException('Failed to create customer: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error creating customer: $e');
    }
  }

  /// Update customer
  Future<Customer> updateCustomer(int customerId, Map<String, dynamic> updates) async {
    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl/customers/$customerId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updates),
      );
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Customer.fromJson(jsonData);
      } else {
        throw ApiException('Failed to update customer: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error updating customer: $e');
    }
  }

  /// Get customer wishlist
  Future<List<WishlistItem>> getCustomerWishlist(int customerId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/customers/$customerId/wishlist'));
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final wishlistItems = jsonData['items'] as List;
        return wishlistItems.map((item) => WishlistItem.fromJson(item)).toList();
      } else {
        throw ApiException('Failed to fetch wishlist: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error fetching wishlist: $e');
    }
  }

  /// Add to wishlist
  Future<WishlistItem> addToWishlist(int customerId, int productId) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/customers/$customerId/wishlist'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'productId': productId}),
      );
      
      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        return WishlistItem.fromJson(jsonData);
      } else {
        throw ApiException('Failed to add to wishlist: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error adding to wishlist: $e');
    }
  }

  /// Remove from wishlist
  Future<void> removeFromWishlist(int customerId, int productId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/customers/$customerId/wishlist/$productId'),
      );
      
      if (response.statusCode != 204) {
        throw ApiException('Failed to remove from wishlist: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error removing from wishlist: $e');
    }
  }

  /// Get reviews
  Future<List<ProductReview>> getReviews({
    int limit = 20,
    int offset = 0,
    ReviewStatus? status,
    int? productId,
  }) async {
    try {
      final queryParams = <String, String>{
        'limit': limit.toString(),
        'offset': offset.toString(),
      };
      if (status != null) queryParams['status'] = status.name;
      if (productId != null) queryParams['product_id'] = productId.toString();
      
      final uri = Uri.parse('$_baseUrl/reviews')
          .replace(queryParameters: queryParams);
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final reviews = jsonData['reviews'] as List;
        return reviews.map((review) => ProductReview.fromJson(review)).toList();
      } else {
        throw ApiException('Failed to fetch reviews: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error fetching reviews: $e');
    }
  }

  /// Update review status
  Future<ProductReview> updateReviewStatus(int reviewId, ReviewStatus status) async {
    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl/reviews/$reviewId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'status': status.name}),
      );
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ProductReview.fromJson(jsonData);
      } else {
        throw ApiException('Failed to update review: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error updating review: $e');
    }
  }

  /// Reply to review
  Future<ProductReview> replyToReview(int reviewId, String comment, String authorName) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/reviews/$reviewId/reply'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'comment': comment,
          'authorName': authorName,
        }),
      );
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ProductReview.fromJson(jsonData);
      } else {
        throw ApiException('Failed to reply to review: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error replying to review: $e');
    }
  }

  /// Get analytics data
  Future<Map<String, dynamic>> getAnalytics({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (startDate != null) queryParams['start_date'] = startDate.toIso8601String();
      if (endDate != null) queryParams['end_date'] = endDate.toIso8601String();
      
      final uri = Uri.parse('$_baseUrl/analytics')
          .replace(queryParameters: queryParams);
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ApiException('Failed to fetch analytics: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error fetching analytics: $e');
    }
  }

  /// Search products
  Future<List<Product>> searchProducts(String query, {
    int limit = 20,
    int offset = 0,
    String? category,
    double? minPrice,
    double? maxPrice,
  }) async {
    try {
      final queryParams = <String, String>{
        'q': query,
        'limit': limit.toString(),
        'offset': offset.toString(),
      };
      if (category != null) queryParams['category'] = category;
      if (minPrice != null) queryParams['min_price'] = minPrice.toString();
      if (maxPrice != null) queryParams['max_price'] = maxPrice.toString();
      
      final uri = Uri.parse('$_baseUrl/search')
          .replace(queryParameters: queryParams);
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final products = jsonData['products'] as List;
        return products.map((product) => Product.fromJson(product)).toList();
      } else {
        throw ApiException('Failed to search products: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error searching products: $e');
    }
  }

  /// Get product recommendations
  Future<List<Product>> getRecommendations({
    int? productId,
    int? customerId,
    int limit = 10,
  }) async {
    try {
      final queryParams = <String, String>{
        'limit': limit.toString(),
      };
      if (productId != null) queryParams['product_id'] = productId.toString();
      if (customerId != null) queryParams['customer_id'] = customerId.toString();
      
      final uri = Uri.parse('$_baseUrl/recommendations')
          .replace(queryParameters: queryParams);
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final products = jsonData['products'] as List;
        return products.map((product) => Product.fromJson(product)).toList();
      } else {
        throw ApiException('Failed to fetch recommendations: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error fetching recommendations: $e');
    }
  }

  /// Save cart to server
  Future<void> saveCart(int customerId, ShoppingCart cart) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/customers/$customerId/cart'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(cart.toJson()),
      );
      
      if (response.statusCode != 200) {
        throw ApiException('Failed to save cart: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error saving cart: $e');
    }
  }

  /// Load cart from server
  Future<ShoppingCart> loadCart(int customerId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/customers/$customerId/cart'));
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ShoppingCart.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        return const ShoppingCart(); // Empty cart
      } else {
        throw ApiException('Failed to load cart: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error loading cart: $e');
    }
  }

  /// Apply coupon code
  Future<Map<String, dynamic>> applyCoupon(String couponCode, double cartTotal) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/coupons/validate'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'code': couponCode,
          'cartTotal': cartTotal,
        }),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ApiException('Failed to apply coupon: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error applying coupon: $e');
    }
  }

  /// Calculate shipping cost
  Future<double> calculateShipping(Address address, List<CartItem> items) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/shipping/calculate'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'address': address.toJson(),
          'items': items.map((item) => item.toJson()).toList(),
        }),
      );
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return (jsonData['shippingCost'] ?? 0.0).toDouble();
      } else {
        throw ApiException('Failed to calculate shipping: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error calculating shipping: $e');
    }
  }
}

/// Exception thrown when API operations fail
class ApiException implements Exception {
  final String message;
  
  const ApiException(this.message);
  
  @override
  String toString() => 'ApiException: $message';
}