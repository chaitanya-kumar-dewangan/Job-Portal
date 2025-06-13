// class RestaurantCartProducts {
//   final String id;
//   final String userId;
//   final String productId;
//   final int quantity;
//   final double pricePerUnit;
//   final DateTime addedAt;
//
//   RestaurantCartProducts({
//      required this.id,
//     required this.userId,
//     required this.productId,
//     required this.quantity,
//     required this.pricePerUnit,
//     required this.addedAt,
//   });
//
//   factory RestaurantCartProducts.fromMap(Map<String, dynamic> map) {
//     return RestaurantCartProducts(
//       id: map['id'],
//       userId: map['user_id'],
//       productId: map['product_id'],
//       quantity: map['quantity'],
//       pricePerUnit: (map['price_per_unit'] as num).toDouble(),
//       addedAt: DateTime.parse(map['added_at']),
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'product_id': productId,
//       'quantity': quantity,
//       'price_per_unit': pricePerUnit,
//       'added_at': addedAt.toIso8601String(),
//     };
//   }
// }



class RestaurantCartProducts {
  final String? id;
  final String userId;
  final String productId;
  final int quantity;
  final double pricePerUnit;
  final DateTime addedAt;

  RestaurantCartProducts({
    this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.pricePerUnit,
    required this.addedAt,
  });

  factory RestaurantCartProducts.fromMap(Map<String, dynamic> map) {
    return RestaurantCartProducts(
      id: map['id'],
      userId: map['user_id'],
      productId: map['product_id'],
      quantity: map['quantity'],
      pricePerUnit: (map['price_per_unit'] as num).toDouble(),
      addedAt: DateTime.parse(map['added_at']),
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity,
      'price_per_unit': pricePerUnit,
      'added_at': addedAt.toIso8601String(),
    };

    if (id != null) {
      map['id'] = id as Object;
    }

    return map;
  }
}
