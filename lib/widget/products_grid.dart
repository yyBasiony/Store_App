import 'package:flutter/material.dart';
import '../models/prodect_model.dart';
import '../widget/product_card.dart';

class ProductsGrid extends StatelessWidget {
  final Future<List<ProdectModel>> productsFuture;

  const ProductsGrid({Key? key, required this.productsFuture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProdectModel>>(
      future: productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No Products Found"));
        } else {
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ProductCard(product: snapshot.data![index]);
            },
          );
        }
      },
    );
  }
}
