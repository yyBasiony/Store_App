import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_services.dart';
import '../widgets/text_field.dart';
import 'login_screen.dart';
import '../widgets/password_field.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  bool _obscurePassword1 = true;
  bool _obscurePassword2 = true;
  bool _isLoading = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final response = await _authService.register(
        firstNameController.text,
        lastNameController.text,
        phoneController.text,
        "الزقازيق",
        emailController.text,
        passwordController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (response["state"] == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('first_name', firstNameController.text);
        await prefs.setString('last_name', lastNameController.text);
        await prefs.setString('user_email', emailController.text);
        await prefs.setString('phone', phoneController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              "تم التسجيل بنجاح",
              style: TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xff005B50)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'إنشاء حساب جديد',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff005B50),
                  ),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                    label: 'الاسم الأول', controller: firstNameController),
                const SizedBox(height: 8),
                CustomTextField(
                    label: 'اسم العائلة', controller: lastNameController),
                const SizedBox(height: 8),
                CustomTextField(
                    label: 'البريد الإلكتروني',
                    controller: emailController,
                    isEmail: true),
                const SizedBox(height: 8),
                CustomTextField(
                    label: 'رقم الهاتف',
                    controller: phoneController,
                    isPhone: true),
                const SizedBox(height: 8),
                PasswordField(
                    label: 'كلمة المرور',
                    controller: passwordController,
                    obscureText: _obscurePassword1,
                    toggleObscure: () {
                      setState(() {
                        _obscurePassword1 = !_obscurePassword1;
                      });
                    }),
                const SizedBox(height: 8),
                PasswordField(
                    label: 'تأكيد كلمة المرور',
                    controller: confirmPasswordController,
                    obscureText: _obscurePassword2,
                    toggleObscure: () {
                      setState(() {
                        _obscurePassword2 = !_obscurePassword2;
                      });
                    }),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff005B50),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'التسجيل',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
                const SizedBox(height: 8),
                const Text('أو سجل باستخدام جوجل',
                    style: TextStyle(color: Colors.black54, fontSize: 11)),
                const SizedBox(height: 6),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    side: const BorderSide(color: Colors.blueGrey),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('المتابعة باستخدام جوجل',
                      style: TextStyle(color: Colors.blueGrey)),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: const Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff005B50)),
                      ),
                    ),
                    const Text("هل لديك حساب بالفعل؟",
                        style: TextStyle(fontSize: 10, color: Colors.red)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
