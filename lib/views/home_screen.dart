import 'package:flutter/material.dart';
import 'package:store_app_api/views/category_screen.dart';
import 'package:store_app_api/views/conacte_us_screen.dart';
import 'package:store_app_api/views/home_content.dart';
import 'package:store_app_api/views/order_screen.dart';
import 'package:store_app_api/views/product_search_delagate.dart';
import 'logout_page.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeContent(),
    CategoryScreen(),
    CartScreen(),
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
              iconTheme: IconThemeData(color: Color(0xff005B50)),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Color(0xff005B50),
                    size: 45,
                  ),
                  onPressed: () {
                    showSearch(
                        context: context, delegate: ProductSearchDelegate());
                  },
                ),
              ],
            )
          : null,
      drawer: _selectedIndex == 0 ? _buildDrawer() : null,
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildDrawer() {
    return Align(
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: 0.65,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: 140),
              Container(
                height: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/onbord3.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildDrawerItem(Icons.person, "الملف الشخصي", ProfileScreen()),
              _buildDrawerItem(Icons.shopping_bag, "طلباتي", OrdersScreen()),
              _buildDrawerItem(
                  Icons.contact_mail, "اتصل بنا", ContactUsScreen()),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 30,
                ),
                title: Text("تسجيل الخروج"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogoutPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, Widget screen) {
    return ListTile(
      leading: Icon(
        icon,
        color: Color(0xff005B50),
        size: 30,
      ),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
        BottomNavigationBarItem(icon: Icon(Icons.category), label: 'التصنيفات'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), label: 'السلة'),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0xff005B50),
      onTap: _onItemTapped,
    );
  }
}
