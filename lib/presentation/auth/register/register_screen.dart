import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/auth_services.dart';
import '../../resources/app_routes.dart';
import '../widgets/custom_auth_with_google.dart';
import '../widgets/password_field.dart';
import '../widgets/text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;
  bool _obscurePassword1 = true;
  bool _obscurePassword2 = true;
  final _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final response = await _authService.register(
        firstNameController.text,
        lastNameController.text,
        phoneController.text,
        "الزقازيق",
        emailController.text,
        passwordController.text,
      );
      setState(() => _isLoading = false);
      if (response["state"] == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('first_name', firstNameController.text);
        await prefs.setString('last_name', lastNameController.text);
        await prefs.setString('user_email', emailController.text);
        await prefs.setString('phone', phoneController.text);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم التسجيل بنجاح")));
        Navigator.pushNamed(context, AppRoutes.loginScreen);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('إنشاء حساب جديد', style: TextStyle(fontSize: 20, color: Color(0xff005B50), fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                // CustomTextField(label: 'الاسم الأول', controller: firstNameController),
                // const SizedBox(height: 8),
                // CustomTextField(label: 'اسم العائلة', controller: lastNameController),
                // const SizedBox(height: 8),
                // CustomTextField(label: 'البريد الإلكتروني', controller: emailController),
                // const SizedBox(height: 8),
                // CustomTextField(label: 'رقم الهاتف', controller: phoneController),
                const SizedBox(height: 8),
                PasswordField(
                  label: 'كلمة المرور',
                  controller: passwordController,
                  obscureText: _obscurePassword1,
                  toggleObscure: () => setState(() => _obscurePassword1 = !_obscurePassword1),
                ),
                const SizedBox(height: 8),
                PasswordField(
                  label: 'تأكيد كلمة المرور',
                  obscureText: _obscurePassword2,
                  controller: confirmPasswordController,
                  toggleObscure: () => setState(() => _obscurePassword2 = !_obscurePassword2),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                    onPressed: _register, child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('التسجيل')),
                const SizedBox(height: 8),
                const CustomAuthWithGoogle(buttonText: 'سجل الدخول', questionText: "هل لديك حساب بالفعل؟", routeName: AppRoutes.loginScreen),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
