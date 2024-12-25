import 'package:flutter/material.dart';
import '../models/prodect_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProdectModel product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(product.title),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Image.network(
                    product.image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                  Text(product.title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('\$${product.price}',
                      style:
                          const TextStyle(fontSize: 20, color: Colors.green)),
                  const SizedBox(height: 16),
                  Text(product.description,
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 16),
                  Row(children: [
                    const Icon(Icons.star, color: Colors.amber),
                    Text(
                        '${product.rating.rate} (${product.rating.count} reviews)'),
                  ])
                ]))));
  }
}
