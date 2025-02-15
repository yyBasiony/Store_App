import 'package:flutter/material.dart';
import '../services/prodcut_services.dart';
import 'product_details_page.dart';

class ProductSearchDelegate extends SearchDelegate {
  final ProductService _productService = ProductService();
  List<dynamic> _allProducts = [];

  ProductSearchDelegate() : super(searchFieldLabel: "بحث") {
    _fetchProducts();
  }

  void _fetchProducts() async {
    _allProducts = await _productService.getAllProducts();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildProductList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildProductList(context);
  }

  Widget _buildProductList(BuildContext context) {
    List<dynamic> filteredProducts = _allProducts
        .where((product) =>
            product['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        var product = filteredProducts[index];
        return ListTile(
          leading: Image.network(
            product['image'],
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(product['name']),
          subtitle: Text(
            "\$${(product['price'])}",
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                    productId: product['id']), // ✅ الحل هنا
              ),
            );
          },
        );
      },
    );
  }
}
