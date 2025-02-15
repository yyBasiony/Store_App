import 'package:flutter/material.dart';

import '../models/cart_item_model.dart';

class CartItemTile extends StatelessWidget {
  final CartItemModel item;
  final Function(int) onUpdateQuantity;

  CartItemTile({required this.item, required this.onUpdateQuantity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.image_not_supported, color: Colors.grey),
            ),
          ),
          title: Text(item.name,
              style: TextStyle(fontSize: 15, color: Colors.black)),
          subtitle: Text("الكمية: ${item.quantity}",
              style: TextStyle(fontSize: 12, color: Colors.blueGrey)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                  onPressed: () => onUpdateQuantity(-1)),
              Text('${item.quantity}', style: TextStyle(fontSize: 16)),
              IconButton(
                  icon: Icon(Icons.add_circle_outline, color: Colors.green),
                  onPressed: () => onUpdateQuantity(1)),
            ],
          ),
        ),
        Divider(color: Color(0xff005B50), thickness: 1.5),
      ],
    );
  }
}
