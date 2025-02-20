import 'package:flutter/material.dart';

import '../../../services/product_services.dart';
import '../../../views/product_details_screen.dart';

class ProductSearchDelegate extends SearchDelegate {
  List<dynamic> _allProducts = [];
  final ProductService _productService = ProductService();

  ProductSearchDelegate() : super(searchFieldLabel: "بحث") {
    _fetchProducts();
  }

  void _fetchProducts() async => _allProducts = await _productService.getAllProducts();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = "", icon: const Icon(Icons.clear))];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildProductList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildProductList();
  }

  Widget _buildProductList() {
    List<dynamic> filteredProducts = _allProducts.where((product) => product['name'].toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        var product = filteredProducts[index];
        
        return ListTile(
          title: Text(product['name']),
          subtitle: Text("\$${(product['price'])}"),
          leading: Image.network(width: 50, height: 50, product['image'], fit: BoxFit.cover),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsScreen(productId: product['id']))),
        );
      },
    );
  }
}
