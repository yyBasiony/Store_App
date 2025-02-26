import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../services/product_services.dart';
import '../../resources/app_assets.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/product_search_anchor.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(actions: const [ProductSearchAnchor()]),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildNewProducts(), _buildAllProducts()],
        ),
      ),
    );
  }

  Widget _buildNewProducts() {
    return FutureBuilder(
      future: _productService.getNewArrivals(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("لا توجد منتجات متاحة"));
        } else {
          return Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [const Text("المنتجات الجديدة", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), _buildProductList(snapshot)],
          );
        }
      },
    );
  }

  Widget _buildProductList(AsyncSnapshot<List<dynamic>> snapshot) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data!.length,
        itemBuilder: (_, index) => ProductCard(product: snapshot.data![index], isNewArrival: true),
      ),
    );
  }

  Widget _buildAllProducts() {
    return FutureBuilder(
      future: _productService.getAllProducts(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("لا توجد منتجات متاحة"));
        } else {
          return _buildProductsGrid(snapshot);
        }
      },
    );
  }

  Widget _buildProductsGrid(AsyncSnapshot<List<dynamic>> snapshot) {
    return Expanded(
      child: GridView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (_, index) => ProductCard(product: snapshot.data![index]),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: .7),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final dynamic product;
  final bool isNewArrival;
  const ProductCard({super.key, required this.product, this.isNewArrival = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        image: DecorationImage(
          image: CachedNetworkImageProvider(product['image']),
          onError: (_, __) => Image.asset(AppAssets.handelErrors),
        ),
        boxShadow: const [BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(0, 2))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product['name'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isNewArrival ? Colors.white : Colors.black)),
          Text("\$${product['price']}", style: const TextStyle(color: Color(0xff64C3BF), fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
