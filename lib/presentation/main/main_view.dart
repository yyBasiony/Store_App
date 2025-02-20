import 'package:flutter/material.dart';

import '../../views/cart_screen.dart';
import '../../views/category_screen.dart';
import 'widgets/custom_bottom_nav_bar.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/home_content.dart';
import 'widgets/product_search_delagate.dart';

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
      backgroundColor: Colors.grey[100],
      drawer: _selectedIndex == 0 ? const CustomDrawer() : null,
      appBar: _selectedIndex == 0 ? _buildAppBar(context) : null,
      bottomNavigationBar: CustomBottomNavBar(onItemTapped: _onItemTapped, selectedIndex: _selectedIndex),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      actions: [IconButton(icon: const Icon(Icons.search), onPressed: () => showSearch(context: context, delegate: ProductSearchDelegate()))],
    );
  }
}
