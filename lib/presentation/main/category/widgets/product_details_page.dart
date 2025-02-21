import 'package:flutter/material.dart';
import 'package:store_app_api/presentation/resources/app_theme.dart';
import '../../../../models/product_details_model.dart';
import '../../../../services/cart_services.dart';
import '../../../../services/product_services.dart';

class ProductDetailsPage extends StatefulWidget {
  final int productId;
  const ProductDetailsPage({super.key, required this.productId});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final CartService _cartService = CartService();
  final ProductService _productService = ProductService();

  bool _isLoading = true;
  bool _isAdding = false;
  ProductDetailsModel? _productDetails;

  @override
  void initState() {
    super.initState();
    _loadProductDetails();
  }

  void _loadProductDetails() async {
    try {
      var response = await _productService.getProductDetails(widget.productId);
      if (response != null) {
        setState(() {
          _productDetails = ProductDetailsModel.fromJson(response);
          _isLoading = false;
        });
      } else {
        throw Exception("المنتج غير موجود");
      }
    } catch (e) {
      print("خطأ أثناء تحميل تفاصيل المنتج: $e");
      setState(() => _isLoading = false);
    }
  }

  Future<void> _addToCart() async {
    setState(() => _isAdding = true);
    bool success = await _cartService.addToCart(widget.productId, 1);
    setState(() => _isAdding = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? "تم إضافة المنتج إلى السلة" : "فشل في إضافة المنتج!",
          style: AppTheme.getLightTheme().snackBarTheme.contentTextStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          _productDetails?.name ?? "تفاصيل المنتج",
          style: const TextStyle(color: Color(0xff005B50), fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Color(0xff005B50)),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _productDetails == null
              ? const Center(child: Text("تعذر تحميل المنتج"))
              : _buildProductDetailsView(),
    );
  }

  Widget _buildProductDetailsView() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff005B50), width: 2), color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      _productDetails!.imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(height: 16),
                Text(
                  _productDetails!.name,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 10),
                Text(
                  _productDetails!.description,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 10),
                Text(
                  "\$${_productDetails!.price.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 22, color: Color(0xff64C3BF), fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _addToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff6c7376),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: _isAdding
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("إضافة إلى السلة 🛒", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
