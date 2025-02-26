import 'package:flutter/material.dart';

import '../../../../services/cart_services.dart';
import '../../../../services/product_services.dart';

class ProductDetailsPage extends StatefulWidget {
  final int productId;
  const ProductDetailsPage({super.key, required this.productId});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool _isAdding = false;

  final CartService _cartService = CartService();
  final ProductService _productService = ProductService();

  Future<void> _addToCart() async {
    setState(() => _isAdding = true);
    bool success = await _cartService.addToCart(widget.productId, 1);
    setState(() => _isAdding = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success ? "تم إضافة المنتج إلى السلة" : "فشل في إضافة المنتج!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildProductDetailsView(),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text("تفاصيل المنتج")),
    );
  }

  Widget _buildProductDetailsView() {
    return Center(
      child: FutureBuilder(
        future: _productService.getProductDetails(widget.productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text("تعذر تحميل المنتج");
          } else {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: const Color(0xff005B50), width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Image.network(height: 250, fit: BoxFit.cover, width: double.infinity, snapshot.data!.imageUrl),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      snapshot.data!.name,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    Text(snapshot.data!.description, style: const TextStyle(fontSize: 16, color: Colors.black54)),
                    const SizedBox(height: 10),
                    Text(
                      "\$${snapshot.data!.price.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 22, color: Color(0xff64C3BF), fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _addToCart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff6c7376),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                        child: _isAdding
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("إضافة إلى السلة 🛒", style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
