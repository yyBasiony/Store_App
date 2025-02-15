import 'package:store_app_api/services/api_services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CartService {
  final ApiService _apiService = ApiService();

  Future<bool> addToCart(int productId, int quantity) async {
    String? token = await _apiService.getToken();
    if (token == null) {
      print(" Token not available!");
      return false;
    }

    final response = await http.post(
      Uri.parse("${ApiService.baseUrl}/carts/add"),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "product_id": productId,
        "quantity": quantity.toString(),
        "token": token,
      }),
    );

    print(" API Response: ${response.body}");

    return response.statusCode == 200;
  }
  // Future<List<dynamic>> getCartItems() async {
  //   final response = await http.get(
  //     Uri.parse("$_baseUrl/cart?token=$token"),
  //     headers: {
  //       "Accept": "application/json",
  //       "Authorization": "Bearer $token",
  //     },
  //   );

  //   print(" API Response (Cart Load): ${response.body}");

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);

  //     if (data['state'] == true && data.containsKey('data')) {
  //       return data['data'].values.toList();
  //     }
  //   }
  //   return [];
  // }
  Future<List<dynamic>> getCartItems() async {
    String? token = await _apiService.getToken();
    if (token == null) {
      print(" Token not available!");
      return [];
    }

    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/cart?token=$token"),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print(" API Response (Cart Load): ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['state'] == true && data.containsKey('data')) {
        return List<dynamic>.from(data['data']);
      }
    }
    return [];
  }

  Future<bool> removeFromCart(int cartItemId) async {
    String? token = await _apiService.getToken();
    if (token == null) {
      print(" Token not available!");
      return false;
    }

    final response = await http.get(
      Uri.parse(
          "${ApiService.baseUrl}/carts/$cartItemId/remove?token=$token&id=$cartItemId"),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("🗑 API Response (Remove Item): ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['state'] == true;
    }
    return false;
  }

  Future<bool> checkoutCart() async {
    String? token = await _apiService.getToken();
    if (token == null) {
      print(" Token not available!");
      return false;
    }

    List<dynamic> cartItems = await getCartItems();
    if (cartItems.isEmpty) {
      print("cart empty");
      return false;
    }

    List<int> productIds = cartItems.map((item) => item["id"] as int).toList();

    final response = await http.post(
      Uri.parse("${ApiService.baseUrl}/carts/checkout"),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "product_ids": productIds,
        "token": token,
      }),
    );

    print(" Checkout Response: ${response.body}");

    return response.statusCode == 200;
  }
}
