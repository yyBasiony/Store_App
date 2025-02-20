import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
        BottomNavigationBarItem(icon: Icon(Icons.category), label: 'التصنيفات'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), label: 'السلة'),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: const Color(0xff005B50),
      onTap: onItemTapped,
    );
  }
}
