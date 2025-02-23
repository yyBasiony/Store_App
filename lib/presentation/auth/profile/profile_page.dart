import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/app_assets.dart';
import '../base/validation.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      firstNameController.text = prefs.getString('first_name') ?? "الاسم الأول";
      lastNameController.text = prefs.getString('last_name') ?? "اسم العائلة";
      emailController.text = prefs.getString('user_email') ?? "example@email.com";
      phoneController.text = prefs.getString('phone') ?? "+0000000000";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("الملف الشخصي")),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 30),
            Column(
              children: [
                const CircleAvatar(
                  radius: 75,
                  backgroundColor: Color(0xff005B50),
                  child: CircleAvatar(radius: 70, backgroundImage: AssetImage(AppAssets.profile)),
                ),
                Text(
                  "${firstNameController.text} ${lastNameController.text}",
                  style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildProfileTextField(label: "FirstName", controller: firstNameController),
            _buildProfileTextField(label: "LastName", controller: lastNameController),
            _buildProfileTextField(label: "Email", controller: emailController),
            _buildProfileTextField(label: "Phone", controller: phoneController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('valid')),
                  );
                }
              },
              child: const Text("Confirm"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTextField({
    required String label,
    required TextEditingController controller,
  }) {
    final validation = Validation.fromLabel(label);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextFormField(
        controller: controller,
        validator: (value) => validation.validateAll(value),
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: TextStyle(color: Colors.grey.shade600),
          labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400)),
        ),
      ),
    );
  }
}
