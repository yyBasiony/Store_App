import 'package:flutter/material.dart';
import 'package:store_app_api/services/cart_services.dart';
import '../models/cart_item_model.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/cart_total.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isLoading = true;
  List<CartItemModel> _cartItems = [];
  final CartService _cartService = CartService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadCartItems();
  }

  void _loadCartItems() async {
    setState(() => _isLoading = true);
    List<dynamic> items = await _cartService.getCartItems();
    setState(() {
      _cartItems = items.map((item) => CartItemModel.fromJson(item)).toList();
      _isLoading = false;
    });
  }

  void _updateQuantity(int index, int change) async {
    int newQuantity = _cartItems[index].quantity + change;
    if (newQuantity > 0) {
      bool success = await _cartService.addToCart(_cartItems[index].productId, change);
      if (success) {
        setState(() {
          _cartItems[index] = _cartItems[index].copyWith(quantity: newQuantity);
        });
      }
    } else {
      _removeItem(_cartItems[index].id);
    }
  }

  void _removeItem(int cartItemId) async {
    bool success = await _cartService.removeFromCart(cartItemId);
    if (success) {
      setState(() {
        _cartItems.removeWhere((item) => item.id == cartItemId);
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم حذف المنتج من السلة")));
    }
  }

  double _calculateTotalPrice() => _cartItems.fold(0, (sum, item) => sum + (item.quantity * item.price));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ٍسلة المشتريات")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _cartItems.isEmpty
              ? const Center(child: Text("🛒 السلة فارغة"))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _cartItems.length,
                        itemBuilder: (context, index) => CartItemTile(
                          item: _cartItems[index],
                          onUpdateQuantity: (change) => _updateQuantity(index, change),
                        ),
                      ),
                    ),
                    CartTotal(totalPrice: _calculateTotalPrice(), onCheckout: _checkout),
                  ],
                ),
    );
  }

  void _checkout() async {
    bool success = await _cartService.checkoutCart();
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم تنفيذ الطلب بنجاح")));
      setState(() => _cartItems.clear());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("!فشل في تنفيذ الطلب")));
    }
  }
}
