import 'package:flutter/material.dart';
import '../models/product_details_model.dart';
import '../services/cart_services.dart';
import '../services/product_services.dart';
import '../widgets/product_details_view.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
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
        backgroundColor: Colors.white,
        content: Text(
          success ? "تم إضافة المنتج إلى السلة" : "فشل في إضافة المنتج!",
          style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
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
          style:
              const TextStyle(color: Color(0xff005B50), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xff005B50)),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _productDetails == null
              ? const Center(child: Text("تعذر تحميل المنتج"))
              : ProductDetailsView(
                  productDetails: _productDetails!,
                  isAdding: _isAdding,
                  onAddToCart: _addToCart,
                ),
    );
  }
}
