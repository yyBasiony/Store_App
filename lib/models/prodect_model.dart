import 'rate_model.dart';

class ProdectModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final RateModel rating;

  ProdectModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.rating,
  });

  factory ProdectModel.fromJson(Map<String, dynamic> jsonData) {
    return ProdectModel(
      id: jsonData['id'],
      title: jsonData['title'],
      price: (jsonData['price'] as num).toDouble(),
      description: jsonData['description'],
      image: jsonData['image'],
      rating: RateModel.fromJson(jsonData['rating']),
    );
  }
}
