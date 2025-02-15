class OrderModel {
  final int productId;
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;
  final String createdAt;

  OrderModel({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      productId: (json['product_id'] is int)
          ? json['product_id']
          : int.tryParse(json['product_id'].toString()) ?? 0,
      name: json['name'] ?? " null ",
      imageUrl: json['image'] ?? "https://via.placeholder.com/150",
      price: (json['price'] is double)
          ? json['price']
          : double.tryParse(json['price'].toString()) ?? 0.0,
      quantity: (json['quantity'] is int)
          ? json['quantity']
          : int.tryParse(json['quantity'].toString()) ?? 1,
      createdAt: json['created_at'] ?? "  null",
    );
  }
}
