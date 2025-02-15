import 'package:flutter/material.dart';
import '../services/prodcut_services.dart';
import '../widgets/all_products.dart';
import '../widgets/new_arrivals.dart';

class HomeContent extends StatelessWidget {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NewArrivals(productService: _productService),
          SizedBox(height: 20),
          AllProducts(productService: _productService),
        ],
      ),
    );
  }
}
