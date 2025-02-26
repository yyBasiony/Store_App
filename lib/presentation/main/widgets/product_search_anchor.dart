import 'package:flutter/material.dart';

import '../../../services/product_services.dart';
import '../category/widgets/product_details_page.dart';

class ProductSearchAnchor extends StatelessWidget {
  const ProductSearchAnchor({super.key});
  static final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (_, controller) => IconButton(icon: const Icon(Icons.search), onPressed: () => controller.openView()),
      suggestionsBuilder: (context, controller) async {
        if (controller.text.isEmpty) return [];

        List<dynamic> allProducts = await _productService.getAllProducts();
        List<dynamic> filteredProducts =
            allProducts.where((product) => product['name'].toLowerCase().contains(controller.text.toLowerCase())).toList();

        return filteredProducts.map((product) {
          return ListTile(
            title: Text(product['name']),
            subtitle: Text("\$${product['price']}"),
            leading: Image.network(product['image'], width: 50, height: 50, fit: BoxFit.cover),
            onTap: () {
              controller.closeView("");
              Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsPage(productId: product['id'])));
            },
          );
        }).toList();
      },
    );
  }
}
