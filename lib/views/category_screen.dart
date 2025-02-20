import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../services/product_services.dart';
import 'products_list_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isLoading = true;
  List<CategoryModel> categories = [];
  final ProductService _productService = ProductService();

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      var response = await _productService.getCategories();
      setState(() {
        categories = response.map<CategoryModel>((json) => CategoryModel.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      print("خطأ: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("التصنيفات")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  var category = categories[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => ProductsListPage(categoryId: category.id, categoryName: category.name))),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 2))],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              height: 150,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              imageUrl: category.imageUrl,
                              errorWidget: (context, url, error) => Image.asset("assets/handle-error.jpg", fit: BoxFit.cover),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 150,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: [Color.fromRGBO(0, 0, 0, .2), Color.fromRGBO(0, 0, 0, .6)],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 20,
                            bottom: 20,
                            child: Text(category.name, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                          const Positioned(right: 20, bottom: 20, child: Icon(size: 20, Icons.arrow_forward_ios, color: Color(0xff64C3BF))),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
