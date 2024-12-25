import 'package:flutter/material.dart';
import '../views/category_prodects_screen.dart';

class CategoryChip extends StatelessWidget {
  final String category;
  const CategoryChip({Key? key, required this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        CategoryProductsScreen(categoryName: category))),
            child: Chip(label: Text(category))));
  }
}
