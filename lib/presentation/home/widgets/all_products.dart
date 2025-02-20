import 'package:flutter/material.dart';
import 'package:store_app_api/presentation/home/widgets/proudect_card.dart';
import '../../../services/prodcut_services.dart';

class AllProducts extends StatelessWidget {
  final ProductService productService;
  const AllProducts({super.key, required this.productService});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: productService.getAllProducts(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("لا توجد منتجات متاحة"));
          }
          return Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var product = snapshot.data![index];
                    return ProductCard(product: product, isNewArrival: false);
                  }));
        });
  }
}
