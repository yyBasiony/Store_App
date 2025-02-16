import 'package:flutter/material.dart';
import 'package:store_app_api/views/register_screen.dart';
import '../models/user_model.dart';
import '../services/auth_services.dart';
import '../views/home_screen.dart';
import 'text_field.dart';
import 'password_field.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final response = await _authService.login(
        emailController.text.trim(),
        passwordController.text,
      );

      setState(() => _isLoading = false);

      if (response["state"] == true) {
        UserModel userModel = UserModel.fromJson(response["data"]);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              "تم تسجيل الدخول بنجاح",
              style: TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              response["message"] ?? "فشل تسجيل الدخول",
              style: TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '!مرحبًا بعودتك',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff005B50),
            ),
          ),
          const Text(
            'تسجيل الدخول',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xffACA7A7),
            ),
          ),
          const SizedBox(height: 20),
          Image.asset('assets/welcome.png', height: 140),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'البريد الإلكتروني',
            isEmail: true,
            controller: emailController,
          ),
          const SizedBox(height: 8),
          PasswordField(
            controller: passwordController,
            label: 'كلمة المرور',
            obscureText: _obscurePassword,
            toggleObscure: _togglePasswordVisibility,
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'هل نسيت كلمة المرور؟',
                style: TextStyle(color: Color(0xff005B50)),
              ),
            ),
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            onPressed: _isLoading ? null : _login,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff005B50),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: _isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : const Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),
          const SizedBox(height: 8),
          const Text(
            'أو سجل الدخول باستخدام جوجل',
            style: TextStyle(color: Colors.black54, fontSize: 11),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              side: const BorderSide(color: Colors.blueGrey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'المتابعة باستخدام جوجل',
              style: TextStyle(color: Colors.blueGrey),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: const Text(
                    'سجل الآن',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff005B50),
                    ),
                  )),
              const Text(
                "ليس لديك حساب؟",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
