import 'package:flutter/material.dart';

import '../../resources/app_routes.dart';
import '../widgets/custom_auth_with_google.dart';
import '../widgets/custom_text_field.dart';
import 'register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;
  final _controller = RegisterController();

  @override
  void dispose() => {_controller.dispose(), super.dispose()};

  void _register() async {
    setState(() => _isLoading = true);
    final isSucceeded = await _controller.authenticate();
    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isSucceeded ? "تم التسجيل بنجاح" : "فشل التسجيل")));
      if (isSucceeded) {
        Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _controller.formKey,
          child: Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Register", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff005B50))),
              const SizedBox(height: 4),
              CustomTextField(label: "FirstName", controller: _controller),
              CustomTextField(label: "LastName", controller: _controller),
              CustomTextField(label: "Email", controller: _controller),
              CustomTextField(label: "Phone", controller: _controller),
              CustomTextField(label: "Password", controller: _controller),
              CustomTextField(label: "Confirm Password", controller: _controller),
              ElevatedButton(
                onPressed: _isLoading ? null : _register,
                child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("Register"),
              ),
              const CustomAuthWithGoogle(buttonText: "Login", routeName: AppRoutes.loginScreen, questionText: "Already have an account?")
            ],
          ),
        ),
      ),
    );
  }
}
