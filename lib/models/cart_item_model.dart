class CartItemModel {
  final int id;
  final int productId;
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;
  CartItemModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as int,
      productId: json['product_id'] as int,
      name: json['name'] ?? " null ",
      imageUrl: json['image'] ?? "https://via.placeholder.com/150",
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      quantity: json['quantity'] as int,
    );
  }

  CartItemModel copyWith({
    int? id,
    int? productId,
    String? name,
    String? imageUrl,
    double? price,
    int? quantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
