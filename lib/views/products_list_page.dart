import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/product_details_model.dart';
import '../services/product_services.dart';
import 'product_details_screen.dart';

class ProductsListPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const ProductsListPage({super.key, required this.categoryId, required this.categoryName});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  bool isLoading = true;
  List<ProductDetailsModel> products = [];
  final ProductService productService = ProductService();

  @override
  void initState() => {fetchProducts(), super.initState()};

  Future<void> fetchProducts() async {
    setState(() => isLoading = true);
    try {
      var response = await productService.getCategoryProducts(widget.categoryId);
      setState(() {
        products = response.map<ProductDetailsModel>((json) => ProductDetailsModel.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      print("خطأ في جلب المنتجات: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xff005B50)),
        title: Text(widget.categoryName, style: const TextStyle(color: Color(0xff005B50), fontWeight: FontWeight.bold)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xff005B50)))
          : products.isNotEmpty
              ? GridView.builder(
                  itemCount: products.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: .75),
                  itemBuilder: (context, index) {
                    var product = products[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsScreen(productId: product.id))),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [BoxShadow(blurRadius: 5, offset: Offset(0, 3), color: Colors.black12)],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  imageUrl: product.imageUrl,
                                  errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(
                                    product.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16, color: Color(0xff005B50), fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${product.price} \$",
                                    style: const TextStyle(fontSize: 14, color: Color(0xff009688), fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: Text("لا توجد منتجات متاحة", style: TextStyle(color: Color(0xff005B50), fontSize: 18))),
    );
  }
}
