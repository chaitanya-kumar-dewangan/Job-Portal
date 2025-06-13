class Order {
  final String id;
  final String userId;
  final String orderType;
  final double totalAmount;
  final String paymentStatus;
  final String orderStatus;
  final String paymentMethod;
  final String address;
  final String placedAt;
  final String updatedAt;
  final String sellerId;

  Order({
    required this.id,
    required this.userId,
    required this.orderType,
    required this.totalAmount,
    required this.paymentStatus,
    required this.orderStatus,
    required this.paymentMethod,
    required this.address,
    required this.placedAt,
    required this.updatedAt,
    required this.sellerId,
  });

  // Factory method to create an Order instance from a map (e.g., from a database or API response)
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? '',
      userId: map['user_id'] ?? '',
      orderType: map['order_type'] ?? '',
      totalAmount: map['total_amount']?.toDouble() ?? 0.0,
      paymentStatus: map['payment_status'] ?? '',
      orderStatus: map['order_status'] ?? '',
      paymentMethod: map['payment_method'] ?? '',
      address: map['address'] ?? '',
      placedAt: map['placed_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      sellerId: map['seller_id'] ?? '',
    );
  }

  // Method to convert the Order instance into a map (e.g., for inserting into a database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'order_type': orderType,
      'total_amount': totalAmount,
      'payment_status': paymentStatus,
      'order_status': orderStatus,
      'payment_method': paymentMethod,
      'address': address,
      'placed_at': placedAt,
      'updated_at': updatedAt,
      'seller_id': sellerId,
    };
  }
}
