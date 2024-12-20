import 'package:flutter/material.dart';
import '../models/prodect_model.dart';
import '../services/all_catgory.dart';
import '../services/all_prodect.dart';
import '../widget/category_chip.dart';
import '../widget/products_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> _categoriesFuture;
  late Future<List<ProdectModel>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = Allcategory().getAllcategory();
    _productsFuture = ApiService().getAllProdect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Store App"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<List<dynamic>>(
            future: _categoriesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No Categories Available"));
              } else {
                return SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return CategoryChip(category: snapshot.data![index]);
                    },
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ProductsGrid(productsFuture: _productsFuture),
          ),
        ],
      ),
    );
  }
}
