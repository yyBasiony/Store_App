import 'package:flutter/material.dart';
import '../models/product_details_model.dart';
import '../services/cart_services.dart';
import '../services/prodcut_services.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  ProductDetailsScreen({required this.productId});
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
        var productDetails = ProductDetailsModel.fromJson(response);
        setState(() {
          _productDetails = productDetails;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          _productDetails?.name ?? "تفاصيل المنتج",
          style:
              TextStyle(color: Color(0xff005B50), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xff005B50)),
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _productDetails == null
              ? Center(child: Text("تعذر تحميل المنتج"))
              : Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
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
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              _productDetails!.name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              _productDetails!.description,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${_productDetails!.price.toStringAsFixed(2)} \$",
                              style: TextStyle(
                                fontSize: 22,
                                color: Color(0xff64C3BF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() => _isAdding = true);
                                  bool success = await _cartService.addToCart(
                                      widget.productId, 1);
                                  setState(() => _isAdding = false);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.white,
                                      content: Text(
                                        success
                                            ? "تم إضافة المنتج إلى السلة"
                                            : "فشل في إضافة المنتج!",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff6c7376),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: _isAdding
                                    ? CircularProgressIndicator(
                                        color: Color(0xff6c7376))
                                    : Text("إضافة إلى السلة 🛒",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}
