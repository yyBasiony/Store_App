import 'package:flutter/material.dart';
import '../models/orders_model.dart';
import '../services/order_services.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/order_list.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: "الطلبات"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _orders.isEmpty
              ? const Center(child: Text("!!! لا يوجد طلبات بعد"))
              : OrdersList(orders: _orders),
    );
  }
}
