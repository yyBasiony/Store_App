import 'package:flutter/material.dart';

import '../models/orders_model.dart';
import '../services/order_services.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrderService _orderService = OrderService();
  List<OrderModel> _orders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    try {
      var response = await _orderService.getOrders();
      if (!mounted) return;

      setState(() {
        _orders = response
            .map<OrderModel>((json) => OrderModel.fromJson(json))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      print("! خطأ في تحميل الطلبات: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xff005B50)),
        title: Text("الطلبات", style: TextStyle(color: Color(0xff005B50))),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _orders.isEmpty
              ? Center(child: Text("!!! لا يوجد طلبات بعد"))
              : ListView.builder(
                  itemCount: _orders.length,
                  itemBuilder: (context, index) {
                    var order = _orders[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        leading: Image.network(
                          order.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey),
                        ),
                        title: Text(order.name,
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                        subtitle: Text(
                            "الكمية: ${order.quantity}     السعر: \$${order.price.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 12, color: Colors.blueGrey)),
                        trailing: Text(
                          order.createdAt,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
