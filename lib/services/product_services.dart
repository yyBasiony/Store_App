import 'api_services.dart';

class ProductService {
  final ApiService _apiService = ApiService();

  Future<List<dynamic>> getNewArrivals() async {
    return await _apiService.fetchData("/new_arrival_products");
  }

  Future<List<dynamic>> getCategories() async {
    return await _apiService.fetchData("/categories");
  }

  Future<List<dynamic>> getCategoryProducts(int categoryId) async {
    return await _apiService.fetchData("/categories/$categoryId/products");
  }

  Future<Map<String, dynamic>?> getProductDetails(int productId) async {
    return await _apiService.fetchSingleData("/products/$productId/show");
  }

  Future<List<dynamic>> getAllProducts() async {
    return await _apiService.fetchData("/products");
  }
}
