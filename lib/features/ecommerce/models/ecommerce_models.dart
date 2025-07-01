import 'package:flutter/foundation.dart';

/// Product model representing an e-commerce product
@immutable
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.images,
    this.brand,
    this.sku,
    this.stock = 0,
    this.isActive = true,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.tags = const [],
    this.variants = const [],
    this.specifications = const {},
    this.discount,
    this.isNew = false,
    this.isFeatured = false,
  });

  final int id;
  final String name;
  final String category;
  final double price;
  final String description;
  final List<String> images;
  final String? brand;
  final String? sku;
  final int stock;
  final bool isActive;
  final double rating;
  final int reviewCount;
  final List<String> tags;
  final List<ProductVariant> variants;
  final Map<String, String> specifications;
  final ProductDiscount? discount;
  final bool isNew;
  final bool isFeatured;

  bool get isInStock => stock > 0;
  
  double get finalPrice {
    if (discount == null) return price;
    switch (discount!.type) {
      case DiscountType.percentage:
        return price * (1 - discount!.value / 100);
      case DiscountType.fixed:
        return (price - discount!.value).clamp(0, double.infinity);
    }
  }

  double get discountAmount => price - finalPrice;

  Product copyWith({
    int? id,
    String? name,
    String? category,
    double? price,
    String? description,
    List<String>? images,
    String? brand,
    String? sku,
    int? stock,
    bool? isActive,
    double? rating,
    int? reviewCount,
    List<String>? tags,
    List<ProductVariant>? variants,
    Map<String, String>? specifications,
    ProductDiscount? discount,
    bool? isNew,
    bool? isFeatured,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      description: description ?? this.description,
      images: images ?? this.images,
      brand: brand ?? this.brand,
      sku: sku ?? this.sku,
      stock: stock ?? this.stock,
      isActive: isActive ?? this.isActive,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      tags: tags ?? this.tags,
      variants: variants ?? this.variants,
      specifications: specifications ?? this.specifications,
      discount: discount ?? this.discount,
      isNew: isNew ?? this.isNew,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'description': description,
      'images': images,
      'brand': brand,
      'sku': sku,
      'stock': stock,
      'isActive': isActive,
      'rating': rating,
      'reviewCount': reviewCount,
      'tags': tags,
      'variants': variants.map((v) => v.toJson()).toList(),
      'specifications': specifications,
      'discount': discount?.toJson(),
      'isNew': isNew,
      'isFeatured': isFeatured,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? json['productName'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] is String) 
          ? double.parse(json['price'].toString().replaceAll(RegExp(r'[^\d.]'), ''))
          : (json['price'] ?? 0.0).toDouble(),
      description: json['description'] ?? json['productBrand'] ?? '',
      images: List<String>.from(json['images'] ?? [json['image']].where((e) => e != null)),
      brand: json['brand'],
      sku: json['sku']?.toString(),
      stock: json['stock'] is bool ? (json['stock'] ? 100 : 0) : (json['qty'] ?? 0),
      isActive: json['isActive'] ?? (json['status'] == 'Published'),
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      variants: (json['variants'] as List<dynamic>?)
          ?.map((v) => ProductVariant.fromJson(v))
          .toList() ?? [],
      specifications: Map<String, String>.from(json['specifications'] ?? {}),
      discount: json['discount'] != null ? ProductDiscount.fromJson(json['discount']) : null,
      isNew: json['isNew'] ?? false,
      isFeatured: json['isFeatured'] ?? false,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Product(id: $id, name: $name, price: $price)';
}

/// Product variant (size, color, etc.)
@immutable
class ProductVariant {
  const ProductVariant({
    required this.id,
    required this.type,
    required this.value,
    required this.priceModifier,
    this.stock = 0,
    this.sku,
    this.image,
  });

  final String id;
  final String type; // 'size', 'color', etc.
  final String value;
  final double priceModifier;
  final int stock;
  final String? sku;
  final String? image;

  bool get isInStock => stock > 0;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'value': value,
      'priceModifier': priceModifier,
      'stock': stock,
      'sku': sku,
      'image': image,
    };
  }

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      value: json['value'] ?? '',
      priceModifier: (json['priceModifier'] ?? 0.0).toDouble(),
      stock: json['stock'] ?? 0,
      sku: json['sku'],
      image: json['image'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductVariant && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Product discount information
@immutable
class ProductDiscount {
  const ProductDiscount({
    required this.type,
    required this.value,
    this.startDate,
    this.endDate,
    this.label,
  });

  final DiscountType type;
  final double value;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? label;

  bool get isActive {
    final now = DateTime.now();
    return (startDate == null || now.isAfter(startDate!)) &&
           (endDate == null || now.isBefore(endDate!));
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'value': value,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'label': label,
    };
  }

  factory ProductDiscount.fromJson(Map<String, dynamic> json) {
    return ProductDiscount(
      type: DiscountType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => DiscountType.percentage,
      ),
      value: (json['value'] ?? 0.0).toDouble(),
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      label: json['label'],
    );
  }
}

enum DiscountType { percentage, fixed }

/// Shopping cart item
@immutable
class CartItem {
  const CartItem({
    required this.product,
    required this.quantity,
    this.selectedVariants = const {},
  });

  final Product product;
  final int quantity;
  final Map<String, ProductVariant> selectedVariants; // variant type -> selected variant

  double get unitPrice {
    var price = product.finalPrice;
    for (final variant in selectedVariants.values) {
      price += variant.priceModifier;
    }
    return price;
  }

  double get totalPrice => unitPrice * quantity;

  bool get isInStock {
    if (selectedVariants.isEmpty) {
      return product.isInStock && product.stock >= quantity;
    }
    
    // Check if all selected variants have enough stock
    for (final variant in selectedVariants.values) {
      if (!variant.isInStock || variant.stock < quantity) {
        return false;
      }
    }
    return true;
  }

  CartItem copyWith({
    Product? product,
    int? quantity,
    Map<String, ProductVariant>? selectedVariants,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedVariants: selectedVariants ?? this.selectedVariants,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'selectedVariants': selectedVariants.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'] ?? 1,
      selectedVariants: (json['selectedVariants'] as Map<String, dynamic>?)
          ?.map(
            (key, value) => MapEntry(key, ProductVariant.fromJson(value)),
          ) ?? {},
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem && 
           other.product == product && 
           mapEquals(other.selectedVariants, selectedVariants);
  }

  @override
  int get hashCode => Object.hash(product, selectedVariants);

  @override
  String toString() => 'CartItem(product: ${product.name}, quantity: $quantity)';
}

/// Shopping cart
@immutable
class ShoppingCart {
  const ShoppingCart({
    this.items = const [],
    this.couponCode,
    this.shippingCost = 0.0,
    this.taxRate = 0.0,
  });

  final List<CartItem> items;
  final String? couponCode;
  final double shippingCost;
  final double taxRate;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
  
  double get subtotal => items.fold(0.0, (sum, item) => sum + item.totalPrice);
  
  double get taxAmount => subtotal * taxRate;
  
  double get total => subtotal + shippingCost + taxAmount;

  bool get isEmpty => items.isEmpty;
  
  bool get hasOutOfStockItems => items.any((item) => !item.isInStock);

  ShoppingCart copyWith({
    List<CartItem>? items,
    String? couponCode,
    double? shippingCost,
    double? taxRate,
  }) {
    return ShoppingCart(
      items: items ?? this.items,
      couponCode: couponCode ?? this.couponCode,
      shippingCost: shippingCost ?? this.shippingCost,
      taxRate: taxRate ?? this.taxRate,
    );
  }

  ShoppingCart addItem(CartItem item) {
    final existingIndex = items.indexWhere(
      (cartItem) => cartItem.product == item.product && 
                   mapEquals(cartItem.selectedVariants, item.selectedVariants),
    );

    if (existingIndex >= 0) {
      final updatedItems = List<CartItem>.from(items);
      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
        quantity: updatedItems[existingIndex].quantity + item.quantity,
      );
      return copyWith(items: updatedItems);
    } else {
      return copyWith(items: [...items, item]);
    }
  }

  ShoppingCart removeItem(CartItem item) {
    return copyWith(
      items: items.where((cartItem) => cartItem != item).toList(),
    );
  }

  ShoppingCart updateItemQuantity(CartItem item, int quantity) {
    if (quantity <= 0) {
      return removeItem(item);
    }

    final updatedItems = items.map((cartItem) {
      if (cartItem == item) {
        return cartItem.copyWith(quantity: quantity);
      }
      return cartItem;
    }).toList();

    return copyWith(items: updatedItems);
  }

  ShoppingCart clearCart() {
    return const ShoppingCart();
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'couponCode': couponCode,
      'shippingCost': shippingCost,
      'taxRate': taxRate,
    };
  }

  factory ShoppingCart.fromJson(Map<String, dynamic> json) {
    return ShoppingCart(
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => CartItem.fromJson(item))
          .toList() ?? [],
      couponCode: json['couponCode'],
      shippingCost: (json['shippingCost'] ?? 0.0).toDouble(),
      taxRate: (json['taxRate'] ?? 0.0).toDouble(),
    );
  }
}

/// Customer model
@immutable
class Customer {
  const Customer({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.customerId,
    this.phone,
    this.avatar,
    this.dateJoined,
    this.isActive = true,
    this.addresses = const [],
    this.paymentMethods = const [],
    this.totalOrders = 0,
    this.totalSpent = 0.0,
    this.country,
    this.countryCode,
  });

  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String? customerId;
  final String? phone;
  final String? avatar;
  final DateTime? dateJoined;
  final bool isActive;
  final List<Address> addresses;
  final List<PaymentMethod> paymentMethods;
  final int totalOrders;
  final double totalSpent;
  final String? country;
  final String? countryCode;

  String get fullName => '$firstName $lastName';
  String get displayName => fullName.trim().isEmpty ? email : fullName;

  Customer copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? customerId,
    String? phone,
    String? avatar,
    DateTime? dateJoined,
    bool? isActive,
    List<Address>? addresses,
    List<PaymentMethod>? paymentMethods,
    int? totalOrders,
    double? totalSpent,
    String? country,
    String? countryCode,
  }) {
    return Customer(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      customerId: customerId ?? this.customerId,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      dateJoined: dateJoined ?? this.dateJoined,
      isActive: isActive ?? this.isActive,
      addresses: addresses ?? this.addresses,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      totalOrders: totalOrders ?? this.totalOrders,
      totalSpent: totalSpent ?? this.totalSpent,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'customerId': customerId,
      'phone': phone,
      'avatar': avatar,
      'dateJoined': dateJoined?.toIso8601String(),
      'isActive': isActive,
      'addresses': addresses.map((addr) => addr.toJson()).toList(),
      'paymentMethods': paymentMethods.map((pm) => pm.toJson()).toList(),
      'totalOrders': totalOrders,
      'totalSpent': totalSpent,
      'country': country,
      'countryCode': countryCode,
    };
  }

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      customerId: json['customerId'],
      phone: json['phone'] ?? json['contact'],
      avatar: json['avatar'],
      dateJoined: json['dateJoined'] != null ? DateTime.parse(json['dateJoined']) : null,
      isActive: json['isActive'] ?? true,
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((addr) => Address.fromJson(addr))
          .toList() ?? [],
      paymentMethods: (json['paymentMethods'] as List<dynamic>?)
          ?.map((pm) => PaymentMethod.fromJson(pm))
          .toList() ?? [],
      totalOrders: json['totalOrders'] ?? json['order'] ?? 0,
      totalSpent: (json['totalSpent'] ?? 0.0).toDouble(),
      country: json['country'],
      countryCode: json['countryCode'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Customer && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Customer(id: $id, name: $fullName, email: $email)';
}

/// Customer address
@immutable
class Address {
  const Address({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.company,
    this.phone,
    this.isDefault = false,
    this.type = AddressType.shipping,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String? company;
  final String? phone;
  final bool isDefault;
  final AddressType type;

  String get fullName => '$firstName $lastName';
  
  String get fullAddress => [
    if (company?.isNotEmpty == true) company,
    street,
    '$city, $state $postalCode',
    country,
  ].join('\n');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'company': company,
      'phone': phone,
      'isDefault': isDefault,
      'type': type.name,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postalCode: json['postalCode'] ?? '',
      country: json['country'] ?? '',
      company: json['company'],
      phone: json['phone'],
      isDefault: json['isDefault'] ?? false,
      type: AddressType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => AddressType.shipping,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Address && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

enum AddressType { shipping, billing }

/// Payment method
@immutable
class PaymentMethod {
  const PaymentMethod({
    required this.id,
    required this.type,
    required this.displayName,
    this.isDefault = false,
    this.cardLast4,
    this.cardBrand,
    this.expiryMonth,
    this.expiryYear,
    this.billingAddress,
  });

  final String id;
  final PaymentType type;
  final String displayName;
  final bool isDefault;
  final String? cardLast4;
  final String? cardBrand;
  final int? expiryMonth;
  final int? expiryYear;
  final Address? billingAddress;

  bool get isExpired {
    if (expiryMonth == null || expiryYear == null) return false;
    final now = DateTime.now();
    final expiry = DateTime(expiryYear!, expiryMonth!);
    return now.isAfter(expiry);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'displayName': displayName,
      'isDefault': isDefault,
      'cardLast4': cardLast4,
      'cardBrand': cardBrand,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
      'billingAddress': billingAddress?.toJson(),
    };
  }

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'] ?? '',
      type: PaymentType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => PaymentType.card,
      ),
      displayName: json['displayName'] ?? '',
      isDefault: json['isDefault'] ?? false,
      cardLast4: json['cardLast4'],
      cardBrand: json['cardBrand'],
      expiryMonth: json['expiryMonth'],
      expiryYear: json['expiryYear'],
      billingAddress: json['billingAddress'] != null
          ? Address.fromJson(json['billingAddress'])
          : null,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaymentMethod && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

enum PaymentType { card, paypal, applePay, googlePay, bankTransfer }

/// Order model
@immutable
class Order {
  const Order({
    required this.id,
    required this.orderNumber,
    required this.customerId,
    required this.items,
    required this.status,
    required this.createdAt,
    this.customer,
    this.shippingAddress,
    this.billingAddress,
    this.paymentMethod,
    this.subtotal = 0.0,
    this.shippingCost = 0.0,
    this.taxAmount = 0.0,
    this.total = 0.0,
    this.notes,
    this.trackingNumber,
    this.estimatedDelivery,
    this.deliveredAt,
    this.updatedAt,
  });

  final int id;
  final String orderNumber;
  final int customerId;
  final List<OrderItem> items;
  final OrderStatus status;
  final DateTime createdAt;
  final Customer? customer;
  final Address? shippingAddress;
  final Address? billingAddress;
  final PaymentMethod? paymentMethod;
  final double subtotal;
  final double shippingCost;
  final double taxAmount;
  final double total;
  final String? notes;
  final String? trackingNumber;
  final DateTime? estimatedDelivery;
  final DateTime? deliveredAt;
  final DateTime? updatedAt;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  bool get canBeCancelled => status == OrderStatus.pending || status == OrderStatus.processing;
  bool get isDelivered => status == OrderStatus.delivered;
  bool get isCancelled => status == OrderStatus.cancelled;

  Order copyWith({
    int? id,
    String? orderNumber,
    int? customerId,
    List<OrderItem>? items,
    OrderStatus? status,
    DateTime? createdAt,
    Customer? customer,
    Address? shippingAddress,
    Address? billingAddress,
    PaymentMethod? paymentMethod,
    double? subtotal,
    double? shippingCost,
    double? taxAmount,
    double? total,
    String? notes,
    String? trackingNumber,
    DateTime? estimatedDelivery,
    DateTime? deliveredAt,
    DateTime? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      customerId: customerId ?? this.customerId,
      items: items ?? this.items,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      customer: customer ?? this.customer,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      billingAddress: billingAddress ?? this.billingAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      subtotal: subtotal ?? this.subtotal,
      shippingCost: shippingCost ?? this.shippingCost,
      taxAmount: taxAmount ?? this.taxAmount,
      total: total ?? this.total,
      notes: notes ?? this.notes,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      estimatedDelivery: estimatedDelivery ?? this.estimatedDelivery,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'customerId': customerId,
      'items': items.map((item) => item.toJson()).toList(),
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'customer': customer?.toJson(),
      'shippingAddress': shippingAddress?.toJson(),
      'billingAddress': billingAddress?.toJson(),
      'paymentMethod': paymentMethod?.toJson(),
      'subtotal': subtotal,
      'shippingCost': shippingCost,
      'taxAmount': taxAmount,
      'total': total,
      'notes': notes,
      'trackingNumber': trackingNumber,
      'estimatedDelivery': estimatedDelivery?.toIso8601String(),
      'deliveredAt': deliveredAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      orderNumber: json['orderNumber'] ?? json['order'] ?? '',
      customerId: json['customerId'] ?? 0,
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => OrderItem.fromJson(item))
          .toList() ?? [],
      status: OrderStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'])
          : (json['date'] != null ? DateTime.parse(json['date']) : DateTime.now()),
      customer: json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      shippingAddress: json['shippingAddress'] != null 
          ? Address.fromJson(json['shippingAddress']) : null,
      billingAddress: json['billingAddress'] != null 
          ? Address.fromJson(json['billingAddress']) : null,
      paymentMethod: json['paymentMethod'] != null 
          ? PaymentMethod.fromJson(json['paymentMethod']) : null,
      subtotal: (json['subtotal'] ?? 0.0).toDouble(),
      shippingCost: (json['shippingCost'] ?? 0.0).toDouble(),
      taxAmount: (json['taxAmount'] ?? 0.0).toDouble(),
      total: (json['total'] ?? json['payment'] ?? json['spent'] ?? 0.0).toDouble(),
      notes: json['notes'],
      trackingNumber: json['trackingNumber'],
      estimatedDelivery: json['estimatedDelivery'] != null 
          ? DateTime.parse(json['estimatedDelivery']) : null,
      deliveredAt: json['deliveredAt'] != null 
          ? DateTime.parse(json['deliveredAt']) : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Order && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Order(id: $id, number: $orderNumber, status: $status)';
}

/// Order item
@immutable
class OrderItem {
  const OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    this.productImage,
    this.selectedVariants = const {},
  });

  final int productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final String? productImage;
  final Map<String, String> selectedVariants; // variant type -> value

  double get totalPrice => unitPrice * quantity;

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'productImage': productImage,
      'selectedVariants': selectedVariants,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'] ?? 0,
      productName: json['productName'] ?? '',
      quantity: json['quantity'] ?? 1,
      unitPrice: (json['unitPrice'] ?? 0.0).toDouble(),
      productImage: json['productImage'],
      selectedVariants: Map<String, String>.from(json['selectedVariants'] ?? {}),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OrderItem && 
           other.productId == productId && 
           mapEquals(other.selectedVariants, selectedVariants);
  }

  @override
  int get hashCode => Object.hash(productId, selectedVariants);
}

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
  refunded
}

/// Product review
@immutable
class ProductReview {
  const ProductReview({
    required this.id,
    required this.productId,
    required this.customerId,
    required this.rating,
    required this.title,
    required this.comment,
    required this.createdAt,
    this.customerName,
    this.customerAvatar,
    this.verified = false,
    this.helpful = 0,
    this.images = const [],
    this.reply,
    this.status = ReviewStatus.approved,
  });

  final int id;
  final int productId;
  final int customerId;
  final int rating; // 1-5
  final String title;
  final String comment;
  final DateTime createdAt;
  final String? customerName;
  final String? customerAvatar;
  final bool verified; // verified purchase
  final int helpful; // helpful votes
  final List<String> images;
  final ReviewReply? reply;
  final ReviewStatus status;

  bool get isPositive => rating >= 4;
  bool get isNegative => rating <= 2;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'customerId': customerId,
      'rating': rating,
      'title': title,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
      'customerName': customerName,
      'customerAvatar': customerAvatar,
      'verified': verified,
      'helpful': helpful,
      'images': images,
      'reply': reply?.toJson(),
      'status': status.name,
    };
  }

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      id: json['id'] ?? 0,
      productId: json['productId'] ?? 0,
      customerId: json['customerId'] ?? 0,
      rating: json['rating'] is double ? (json['rating'] as double).round() : (json['rating'] ?? 5),
      title: json['title'] ?? json['head'] ?? '',
      comment: json['comment'] ?? json['para'] ?? '',
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'])
          : (json['date'] != null ? DateTime.parse(json['date']) : DateTime.now()),
      customerName: json['customerName'] ?? json['reviewer'],
      customerAvatar: json['customerAvatar'] ?? json['avatar'],
      verified: json['verified'] ?? false,
      helpful: json['helpful'] ?? 0,
      images: List<String>.from(json['images'] ?? []),
      reply: json['reply'] != null ? ReviewReply.fromJson(json['reply']) : null,
      status: ReviewStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ReviewStatus.approved,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductReview && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Review reply from merchant
@immutable
class ReviewReply {
  const ReviewReply({
    required this.comment,
    required this.createdAt,
    this.authorName,
  });

  final String comment;
  final DateTime createdAt;
  final String? authorName;

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
      'authorName': authorName,
    };
  }

  factory ReviewReply.fromJson(Map<String, dynamic> json) {
    return ReviewReply(
      comment: json['comment'] ?? '',
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      authorName: json['authorName'],
    );
  }
}

enum ReviewStatus { pending, approved, rejected }

/// Wishlist item
@immutable
class WishlistItem {
  const WishlistItem({
    required this.id,
    required this.productId,
    required this.customerId,
    required this.addedAt,
    this.product,
  });

  final int id;
  final int productId;
  final int customerId;
  final DateTime addedAt;
  final Product? product;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'customerId': customerId,
      'addedAt': addedAt.toIso8601String(),
      'product': product?.toJson(),
    };
  }

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['id'] ?? 0,
      productId: json['productId'] ?? 0,
      customerId: json['customerId'] ?? 0,
      addedAt: json['addedAt'] != null 
          ? DateTime.parse(json['addedAt'])
          : DateTime.now(),
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WishlistItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Product category
@immutable
class ProductCategory {
  const ProductCategory({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.image,
    this.parentId,
    this.children = const [],
    this.productCount = 0,
    this.isActive = true,
  });

  final int id;
  final String name;
  final String slug;
  final String? description;
  final String? image;
  final int? parentId;
  final List<ProductCategory> children;
  final int productCount;
  final bool isActive;

  bool get hasChildren => children.isNotEmpty;
  bool get isRoot => parentId == null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'image': image,
      'parentId': parentId,
      'children': children.map((child) => child.toJson()).toList(),
      'productCount': productCount,
      'isActive': isActive,
    };
  }

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'],
      image: json['image'],
      parentId: json['parentId'],
      children: (json['children'] as List<dynamic>?)
          ?.map((child) => ProductCategory.fromJson(child))
          .toList() ?? [],
      productCount: json['productCount'] ?? 0,
      isActive: json['isActive'] ?? true,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductCategory && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}