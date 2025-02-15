class CategoryModel {
  final int id;
  final String name;
  final String imageUrl;

  CategoryModel({required this.id, required this.name, required this.imageUrl});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '  null',
      imageUrl: json['image'] ?? 'https://via.placeholder.com/150',
    );
  }
}
