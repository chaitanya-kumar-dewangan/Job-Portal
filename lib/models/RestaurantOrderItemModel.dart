class RestaurantOrderItem {
  final String id;
  final String orderId;
  final String productId;
  final int quantity;
  final double price;

  RestaurantOrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
  });

  // Factory method to create a RestaurantOrderItem instance from a map (e.g., from a database or API response)
  factory RestaurantOrderItem.fromMap(Map<String, dynamic> map) {
    return RestaurantOrderItem(
      id: map['id'] ?? '',
      orderId: map['order_id'] ?? '',
      productId: map['product_id'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
    );
  }

  // Method to convert the RestaurantOrderItem instance into a map (e.g., for inserting into a database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'quantity': quantity,
      'price': price,
    };
  }
}
