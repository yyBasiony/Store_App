import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store_app_api/models/prodect_model.dart';

class CategoryService {
  Future<List<ProdectModel>> getCategoryProdects(
      {required String category_name}) async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products/category/$category_name'),
    );

    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => ProdectModel.fromJson(item)).toList();
  }
}
