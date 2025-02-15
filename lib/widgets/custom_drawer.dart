import 'package:flutter/material.dart';
import 'package:store_app_api/views/order_screen.dart';
import 'package:store_app_api/views/logout_page.dart';
import 'package:store_app_api/views/profile_screen.dart';
import 'package:store_app_api/widgets/drawer_item.dart';

import '../views/conacte_us_screen.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              DrawerItem(
                  icon: Icons.person,
                  title: "الملف الشخصي",
                  screen: ProfileScreen()),
              DrawerItem(
                  icon: Icons.shopping_bag,
                  title: "طلباتي",
                  screen: OrdersScreen()),
              DrawerItem(
                  icon: Icons.contact_mail,
                  title: "اتصل بنا",
                  screen: ContactUsScreen()),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red, size: 30),
                title: Text("تسجيل الخروج"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogoutPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
