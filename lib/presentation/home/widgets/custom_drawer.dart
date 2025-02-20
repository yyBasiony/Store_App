import 'package:flutter/material.dart';
import 'package:store_app_api/views/order_screen.dart';
import 'package:store_app_api/views/profile_screen.dart';
import 'package:store_app_api/views/conacte_us_screen.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

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
              const SizedBox(height: 140),
              Container(
                height: 140,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.onboarding3),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildDrawerItem(
                  context, Icons.person, "الملف الشخصي", const ProfileScreen()),
              _buildDrawerItem(
                  context, Icons.shopping_bag, "طلباتي", const OrdersScreen()),
              _buildDrawerItem(context, Icons.contact_mail, "اتصل بنا",
                  const ContactUsScreen()),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red, size: 30),
                title: const Text("تسجيل الخروج"),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.logoutPage);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, Widget screen) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xff005B50), size: 30),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen));
      },
    );
  }
}
