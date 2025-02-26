import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_details_model.dart';

class ApiService {
  String? _cachedToken;
  static const String baseUrl = "https://ib.jamalmoallart.com/api/v2";

  Future<String?> getToken() async {
    if (_cachedToken != null) return _cachedToken;

    final prefs = await SharedPreferences.getInstance();
    _cachedToken = prefs.getString('token');

    if (_cachedToken == null || _cachedToken!.isEmpty) {
      print(" Token is missing!");
    }
    return _cachedToken;
  }

  Future<List<dynamic>> fetchData(String endpoint) async {
    String? token = await getToken();
    if (token == null) return [];

    final response = await http.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return decoded.containsKey('data') ? decoded['data'] ?? [] : [];
    }
    return [];
  }

  Future<ProductDetailsModel?> fetchSingleData(String endpoint) async {
    String? token = await getToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['state'] == true ? ProductDetailsModel.fromJson(data['data']) : null;
    }

    return null;
  }

  Future<bool> postData(String endpoint, Map<String, dynamic> body) async {
    String? token = await getToken();
    if (token == null) return false;

    final response = await http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token", "Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    return response.statusCode == 200;
  }
}
