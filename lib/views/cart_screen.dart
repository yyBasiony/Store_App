import 'package:flutter/material.dart';
import 'package:store_app_api/services/cart_services.dart';
import '../models/cart_item_model.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();
  List<CartItemModel> _cartItems = [];
  bool _isLoading = true;

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

  void _removeItem(int cartItemId) async {
    bool success = await _cartService.removeFromCart(cartItemId);
    if (success) {
      setState(() {
        _cartItems.removeWhere((item) => item.id == cartItemId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            "تم حذف المنتج من السلة",
            style: TextStyle(fontSize: 12, color: Colors.blueGrey),
          ),
        ),
      );
    }
  }

  void _decreaseQuantity(int index) async {
    int cartItemId = _cartItems[index].id;
    int currentQuantity = _cartItems[index].quantity;

    if (currentQuantity > 1) {
      int newQuantity = currentQuantity - 1;
      bool success =
          await _cartService.addToCart(_cartItems[index].productId, -1);
      if (success && mounted) {
        setState(() {
          _cartItems[index] = _cartItems[index].copyWith(quantity: newQuantity);
        });
      }
    } else {
      bool removed = await _cartService.removeFromCart(cartItemId);
      if (removed && mounted) {
        setState(() {
          _cartItems.removeAt(index);
        });
      }
    }
  }

  void _updateQuantity(int index, int change) async {
    int newQuantity = _cartItems[index].quantity + change;
    if (newQuantity > 0) {
      bool success =
          await _cartService.addToCart(_cartItems[index].productId, change);
      if (success) {
        setState(() {
          _cartItems[index] = _cartItems[index].copyWith(quantity: newQuantity);
        });
      }
    } else {
      _removeItem(_cartItems[index].id);
    }
  }

  double _calculateTotalPrice() {
    return _cartItems.fold(
        0, (sum, item) => sum + (item.quantity * item.price));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xff005B50)),
        title:
            Text("ٍسلة المشتريات", style: TextStyle(color: Color(0xff005B50))),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _cartItems.isEmpty
              ? Center(child: Text("🛒 السلة فارغة"))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _cartItems.length,
                        itemBuilder: (context, index) {
                          var item = _cartItems[index];
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
                                    errorBuilder:
                                        (context, error, stackTrace) => Icon(
                                            Icons.image_not_supported,
                                            color: Colors.grey),
                                  ),
                                ),
                                title: Text(item.name,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black)),
                                subtitle: Text("الكمية: ${item.quantity}",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.blueGrey)),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove_circle_outline,
                                          color: Colors.red),
                                      onPressed: () =>
                                          _updateQuantity(index, -1),
                                    ),
                                    Text('${item.quantity}',
                                        style: TextStyle(fontSize: 16)),
                                    IconButton(
                                      icon: Icon(Icons.add_circle_outline,
                                          color: Colors.green),
                                      onPressed: () =>
                                          _updateQuantity(index, 1),
                                    ),
                                  ],
                                ),
                              ),
                              if (index < _cartItems.length - 1)
                                Divider(
                                    color: Color(0xff005B50), thickness: 1.5),
                            ],
                          );
                        },
                      ),
                    ),
                    Divider(color: Color(0xff005B50), thickness: 1.5),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "الإجمالي: \$${_calculateTotalPrice().toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              bool success = await _cartService.checkoutCart();
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.white,
                                    content: Text(
                                      "تم تنفيذ الطلب بنجاح",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.blueGrey),
                                    ),
                                  ),
                                );
                                setState(() {
                                  _cartItems.clear();
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.white,
                                    content: Text(
                                      "!فشل في تنفيذ الطلب",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.blueGrey),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text("إتمام الطلب",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 15),
                              backgroundColor: Color(0xff005B50),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
