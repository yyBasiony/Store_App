import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../models/product_details_model.dart';
import '../../../../services/product_services.dart';
import '../../../resources/app_theme.dart';
import 'product_details_page.dart';

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getLightTheme().scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(widget.categoryName, style: AppTheme.getLightTheme().appBarTheme.titleTextStyle),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xff005B50)))
          : products.isNotEmpty
              ? _buildGridViewWidget(products)
              : const Center(
                  child: Text(
                    " لا توجد منتجات متاحة",
                    style: TextStyle(color: Color(0xff005B50), fontSize: 18),
                  ),
                ),
    );
  }

  Widget _buildGridViewWidget(List<ProductDetailsModel> products) {
    return GridView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: .75,
      ),
      itemBuilder: (_, index) {
        var product = products[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProductDetailsPage(productId: product.id)),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff005B50), width: 2),
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [BoxShadow(blurRadius: 5, offset: Offset(0, 3), color: Colors.black12)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(product.imageUrl),
                        fit: BoxFit.cover,
                      ),
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
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff005B50),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${product.price} \$",
                        style: const TextStyle(fontSize: 14, color: Color(0xff009688)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
