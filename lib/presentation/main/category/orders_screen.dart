import 'package:flutter/material.dart';
import '../../../models/orders_model.dart';
import '../../../services/order_services.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = true;
  List<OrderModel> _orders = [];
  final OrderService _orderService = OrderService();

  @override
  void initState() => {super.initState(), _loadOrders()};

  Future<void> _loadOrders() async {
    try {
      var response = await _orderService.getOrders();
      if (!mounted) return;

      setState(() {
        _orders = response.map<OrderModel>((json) => OrderModel.fromJson(json)).toList();
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
      appBar: AppBar(title: const Text("الطلبات")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _orders.isEmpty
              ? const Center(child: Text("!!! لا يوجد طلبات بعد"))
              : _buildOrdersList(_orders),
    );
  }

  Widget _buildOrdersList(List<OrderModel> orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        var order = orders[index];
        
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            leading: Image.network(order.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported, size: 50, color: Colors.grey)),
            title: Text(order.name, style: const TextStyle(fontSize: 15, color: Colors.black)),
            subtitle: Text("الكمية: ${order.quantity}     السعر: \$${order.price.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 12, color: Colors.blueGrey)),
            trailing: Text(order.createdAt, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ),
        );
      },
    );
  }
}
