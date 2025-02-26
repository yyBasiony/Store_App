import 'package:flutter/material.dart';

import '../resources/app_constants.dart';
import 'cart/cart_page.dart';
import 'category/category_page.dart';
import 'home/home_page.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  static const List<Widget> _pages = [HomePage(), CategoryPage(), CartPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      //
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: [for (var item in AppConstants.bottomNavBarData) BottomNavigationBarItem(icon: Icon(item.icon), label: item.label)],
      ),
    );
  }
}
