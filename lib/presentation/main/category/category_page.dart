import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/category_model.dart';
import '../../../services/product_services.dart';
import '../../resources/app_assets.dart';
import 'widgets/products_list_page.dart';

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
  void initState() => {super.initState(), fetchCategories()};

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
                itemBuilder: (_, index) {
                  var category = categories[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => ProductsListPage(categoryId: category.id, categoryName: category.name))),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(0, 2))],
                      ),
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(0, 2))],
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(category.imageUrl),
                                fit: BoxFit.cover,
                                onError: (error, stackTrace) => const AssetImage(AppAssets.handelErrors))),
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(category.name, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                            const Icon(Icons.arrow_forward_ios, size: 20, color: Color(0xff64C3BF)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
