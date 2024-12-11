import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store_app_api/models/prodect_model.dart';

class ApiService {
  Future<List<ProdectModel>> getAllProdect() async {
    http.Response response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    List<dynamic> data = jsonDecode(response.body);
    List<ProdectModel> productsList = [];
    for (int i = 0; i < data.length; i++) {
      productsList.add(ProdectModel.fromJson(data[i]));
    }
    return productsList;
  }
}
