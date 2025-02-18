import 'package:flutter/material.dart';
import '../models/orders_model.dart';

class OrdersList extends StatelessWidget {
  final List<OrderModel> orders;

  const OrdersList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        var order = orders[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            leading: Image.network(
              order.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
            ),
            title: Text(order.name,
                style: const TextStyle(fontSize: 15, color: Colors.black)),
            subtitle: Text(
                "الكمية: ${order.quantity}     السعر: \$${order.price.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 12, color: Colors.blueGrey)),
            trailing: Text(
              order.createdAt,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}
