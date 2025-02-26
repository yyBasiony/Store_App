import 'package:flutter/material.dart';

import '../../resources/app_assets.dart';
import '../../resources/app_routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: .65,
      child: Drawer(
        child: Column(
          children: [
            const SizedBox(height: 140),
            AspectRatio(aspectRatio: 4 / 3, child: Image.asset(AppAssets.onboarding3)),
            const SizedBox(height: 20),
            _buildDrawerItem(context, Icons.person, "الملف الشخصي", AppRoutes.profileScreen),
            _buildDrawerItem(context, Icons.shopping_bag, "طلباتي", AppRoutes.ordersScreen),
            _buildDrawerItem(context, Icons.contact_mail, "اتصل بنا", AppRoutes.contactUsScreen),
            ListTile(
              title: const Text("تسجيل الخروج"),
              onTap: () => Navigator.pushNamed(context, AppRoutes.logoutScreen),
              leading: const Icon(Icons.logout, color: Colors.red, size: 30),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      title: Text(title),
      onTap: () => Navigator.popAndPushNamed(context, route),
      leading: Icon(icon, color: const Color(0xff005B50), size: 30),
    );
  }
}
