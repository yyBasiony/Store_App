import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_services.dart';
import 'login_screen.dart';

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
        " الزقازيق",
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
          SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                "تم التسجيل بنجاح",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blueGrey,
                ),
              )),
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
                _buildTextField('الاسم الأول', controller: firstNameController),
                const SizedBox(height: 8),
                _buildTextField('اسم العائلة', controller: lastNameController),
                const SizedBox(height: 8),
                _buildTextField('البريد الإلكتروني',
                    isEmail: true, controller: emailController),
                const SizedBox(height: 8),
                _buildTextField('رقم الهاتف',
                    isPhone: true, controller: phoneController),
                const SizedBox(height: 8),
                _buildPasswordField('كلمة المرور',
                    controller: passwordController,
                    obscureText: _obscurePassword1, toggleObscure: () {
                  setState(() {
                    _obscurePassword1 = !_obscurePassword1;
                  });
                }),
                const SizedBox(height: 8),
                _buildPasswordField('تأكيد كلمة المرور',
                    controller: confirmPasswordController,
                    obscureText: _obscurePassword2, toggleObscure: () {
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
                const Text(
                  'أو سجل باستخدام جوجل',
                  style: TextStyle(color: Colors.black54, fontSize: 11),
                ),
                const SizedBox(height: 6),
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
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: const Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff005B50),
                        ),
                      ),
                    ),
                    const Text(
                      "هل لديك حساب بالفعل؟",
                      style: TextStyle(fontSize: 10, color: Colors.red),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label,
      {bool isEmail = false,
      bool isPhone = false,
      required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      textDirection: TextDirection.rtl,
      keyboardType: isEmail
          ? TextInputType.emailAddress
          : isPhone
              ? TextInputType.phone
              : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label مطلوب';
        }
        if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'الرجاء إدخال بريد إلكتروني صحيح';
        }
        if (isPhone && value.length != 11) {
          return 'الرجاء إدخال رقم هاتف صحيح';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(String label,
      {required TextEditingController controller,
      required bool obscureText,
      required VoidCallback toggleObscure}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: toggleObscure,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
