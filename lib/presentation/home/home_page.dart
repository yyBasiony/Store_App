import 'package:flutter/material.dart';
import 'package:store_app_api/views/category_screen.dart';
import 'package:store_app_api/presentation/home/widgets/home_content.dart';
import 'package:store_app_api/views/cart_screen.dart';
import 'package:store_app_api/presentation/home/widgets/product_search_delagate.dart';
import 'package:store_app_api/presentation/home/widgets/custom_drawer.dart';
import 'package:store_app_api/presentation/home/widgets/custom_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeContent(),
    const CategoryScreen(),
    const CartScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: _selectedIndex == 0
            ? AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: const IconThemeData(color: Color(0xff005B50)),
                actions: [
                    IconButton(
                      icon: const Icon(Icons.search,
                          color: Color(0xff005B50), size: 45),
                      onPressed: () {
                        showSearch(
                            context: context,
                            delegate: ProductSearchDelegate());
                      },
                    )
                  ])
            : null,
        drawer: _selectedIndex == 0 ? const CustomDrawer() : null,
        body: _screens[_selectedIndex],
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ));
  }
}
