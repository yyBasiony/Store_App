import 'package:flutter/material.dart';

import '../../../models/orders_model.dart';
import '../../../services/order_services.dart';
import '../../../widgets/order_list.dart';

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
              : OrdersList(orders: _orders),
    );
  }
}
