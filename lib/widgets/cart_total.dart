import 'package:flutter/material.dart';

class CartTotal extends StatelessWidget {
  final double totalPrice;
  final VoidCallback onCheckout;

  const CartTotal({super.key, required this.totalPrice, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            "الإجمالي: \$${totalPrice.toStringAsFixed(2)}",
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onCheckout,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              backgroundColor: const Color(0xff005B50),
            ),
            child: const Text("إتمام الطلب",
                style: TextStyle(fontSize: 15, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
