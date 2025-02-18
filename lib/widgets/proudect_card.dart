import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final dynamic product;
  final bool isNewArrival;
  const ProductCard({super.key, required this.product, this.isNewArrival = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(0, 2))
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: product['image'],
              width: double.infinity,
              height: 140,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) =>
                  Image.asset("assets/handle-error.jpg", fit: BoxFit.cover),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 40,
            child: Text(
              product['name'],
              style: TextStyle(
                color: isNewArrival ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 20,
            child: Text(
              "\$${product['price']}",
              style: const TextStyle(
                  color: Color(0xff64C3BF),
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
