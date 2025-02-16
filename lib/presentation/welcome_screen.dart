import 'package:flutter/material.dart';

import '../views/login_screen.dart';
import '../views/register_screen.dart';
import 'resources/app_assets.dart';

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
          _buildRegisterButton(context),
          const SizedBox(height: 20),
          _buildLoginButton(context),
        ],
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      child: const Text('إنشاء حساب'),
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => RegisterScreen())),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return OutlinedButton(
      child: const Text('تسجيل الدخول'),
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => LoginScreen())),
    );
  }
}
