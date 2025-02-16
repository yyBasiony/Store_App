import 'package:flutter/material.dart';
import '../models/product_details_model.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductDetailsModel productDetails;
  final bool isAdding;
  final VoidCallback onAddToCart;

  ProductDetailsView({
    required this.productDetails,
    required this.isAdding,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                    productDetails.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  productDetails.name,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                SizedBox(height: 10),
                Text(
                  productDetails.description,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 10),
                Text(
                  "\$${productDetails.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xff64C3BF),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: onAddToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff6c7376),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: isAdding
                        ? CircularProgressIndicator(color: Color(0xff6c7376))
                        : Text("إضافة إلى السلة 🛒",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
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
