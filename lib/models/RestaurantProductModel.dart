class RestaurantProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? discountedPrice;
  final double? discountPercentage;
  final List<String> imageUrls;
  final bool isAvailable;
  final List<String> ingredients;
  final double? cgst;
  final double? sgst;
  final double? final_price;
  final double? tax_amount;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrls,
    required this.isAvailable,
    required this.ingredients,
    required this.description,
    this.discountedPrice,
    this.discountPercentage,
    this.cgst,
    this.sgst,
    required this.final_price,
    required this.tax_amount


  });

  factory RestaurantProductModel.fromMap(Map<String, dynamic> map) {
    return RestaurantProductModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      discountedPrice: (map['discounted_price'] as num?)?.toDouble(),
      discountPercentage: (map['discount_percentage'] as num?)?.toDouble(),
      imageUrls: List<String>.from(map['image_urls'] ?? []),
      isAvailable: map['is_available'] as bool? ?? true,
      ingredients: List<String>.from(map['ingredients'] ?? []),
      cgst: (map['cgst'] as num?)?.toDouble(),
      sgst: (map['sgst'] as num?)?.toDouble(),
      final_price: (map['final_price'] as num?)?.toDouble(),
      tax_amount: (map['tax_amount'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'discounted_price': discountedPrice,
      'discount_percentage': discountPercentage,
      'image_urls': imageUrls,
      'is_available': isAvailable,
      'ingredients': ingredients,
      'cgst': cgst,
      'sgst': sgst,
      'final_price': final_price,
      'tax_amount': tax_amount,
    };
  }
}
