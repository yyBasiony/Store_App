import 'package:flutter/material.dart';
import 'package:store_app_api/widgets/proudect_card.dart';
import '../services/prodcut_services.dart';

class NewArrivals extends StatelessWidget {
  final ProductService productService;
  NewArrivals({required this.productService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: productService.getNewArrivals(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("لا توجد منتجات متاحة"));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("المنتجات الجديدة",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var product = snapshot.data![index];
                  return ProductCard(product: product, isNewArrival: true);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
