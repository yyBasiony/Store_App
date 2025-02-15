import 'package:store_app_api/services/api_services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderService {
  final ApiService _apiService = ApiService();

  Future<List<dynamic>> getOrders() async {
    String? token = await _apiService.getToken();
    if (token == null || token.isEmpty) return [];

    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/orders?token=$token"),
      headers: {"Accept": "application/json"},
    );

    print(" Orders Response: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['data'] != null && data['data']['order'] != null) {
        List<dynamic> orders = data['data']['order'];

        Map<int, dynamic> orderMap = {};

        for (var order in orders) {
          int productId = order["product_id"];
          if (orderMap.containsKey(productId)) {
            orderMap[productId]["quantity"] +=
                int.tryParse(order["quantity"].toString()) ?? 0;
          } else {
            orderMap[productId] = Map<String, dynamic>.from(order);
          }
        }

        return orderMap.values.toList();
      }
    }
    return [];
  }
}
