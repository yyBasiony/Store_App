import 'package:flutter/material.dart';
import 'package:store_app_api/presentation/home/widgets/proudect_card.dart';
import '../../../services/prodcut_services.dart';

class NewArrivals extends StatelessWidget {
  final ProductService productService;
  const NewArrivals({super.key, required this.productService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: productService.getNewArrivals(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("لا توجد منتجات متاحة"));
          }
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("المنتجات الجديدة",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                SizedBox(
                    height: 140,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var product = snapshot.data![index];
                          return ProductCard(
                              product: product, isNewArrival: true);
                        }))
              ]);
        });
  }
}
