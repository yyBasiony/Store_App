import 'package:flutter/material.dart';
import 'resources/app_assets.dart';
import 'resources/app_routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('!مرحبًا',
              style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff005B50),
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text('!اكتشف الأشياء التي تحبها',
              style: TextStyle(fontSize: 12, color: Colors.black)),
          const SizedBox(height: 30),
          AspectRatio(
              aspectRatio: 5 / 4, child: Image.asset(AppAssets.welcome)),
          const SizedBox(height: 30),
          ElevatedButton(
              child: const Text('إنشاء حساب'),
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.registerScreen)),
          const SizedBox(height: 20),
          OutlinedButton(
              child: const Text('تسجيل الدخول'),
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.loginScreen)),
        ],
      ),
    );
  }
}
