import 'package:flutter/material.dart';
import '../models/prodect_model.dart';
import '../services/category_service.dart';
import '../widget/products_grid.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String categoryName;

  const CategoryProductsScreen({Key? key, required this.categoryName})
      : super(key: key);

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  late Future<List<ProdectModel>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = CategoryService()
        .getCategoryProdects(category_name: widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: ProductsGrid(productsFuture: _productsFuture),
    );
  }
}
