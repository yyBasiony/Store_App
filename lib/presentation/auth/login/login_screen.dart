import 'package:flutter/material.dart';

import '../../resources/app_assets.dart';
import '../../resources/app_routes.dart';
import '../widgets/custom_auth_with_google.dart';
import '../widgets/text_field.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final _controller = LoginController();

  @override
  void dispose() => {_controller.dispose(), super.dispose()};

  void _login() async {
    setState(() => _isLoading = true);
    final isSucceeded = await _controller.authenticate();
    setState(() => _isLoading = false);

    if (mounted) {
      if (isSucceeded) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم تسجيل الدخول بنجاح")));
        Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("فشل تسجيل الدخول"))); // response["message"] ??
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Welcome", style: TextStyle(fontSize: 20, color: Color(0xff005B50), fontWeight: FontWeight.bold)), // '!مرحبًا بعودتك'
                const Text("Login", style: TextStyle(fontSize: 12, color: Color(0xffACA7A7))), // 'تسجيل الدخول'
                const SizedBox(height: 20),
                Image.asset(AppAssets.welcome, height: 140),
                const SizedBox(height: 20),
                CustomTextField(label: "Email", controller: _controller), // 'البريد الإلكتروني'
                const SizedBox(height: 8),
                CustomTextField(label: "Password", controller: _controller), // 'كلمة المرور'
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  // 'هل نسيت كلمة المرور؟'
                  child: TextButton(onPressed: () {}, child: const Text("Forgot Password?")),
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("Login")), // 'تسجيل الدخول'
                const SizedBox(height: 8),
                // "ليس لديك حساب؟", 'سجل الآن'
                const CustomAuthWithGoogle(buttonText: "Register", questionText: "Don't have an account?", routeName: AppRoutes.registerScreen),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
