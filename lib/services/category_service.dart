import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store_app_api/models/prodect_model.dart';


class CategoryService {
  Future<List<ProdectModel>> getCategoryProdects(
      {required String category_name}) async {
    http.Response response = await http.get(
        Uri.parse('https://fakestoreapi.com/products/category/$category_name'));
    List<dynamic> data = jsonDecode(response.body);
    List<ProdectModel> productsList = [];
    for (int i = 0; i < data.length; i++) {
      productsList.add(ProdectModel.fromJson(data[i]));
    }
    return productsList;
  }
}
