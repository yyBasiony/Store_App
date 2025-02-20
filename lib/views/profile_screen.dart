import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String firstName = "", lastName = "", email = "", phone = "";

  @override
  void initState() => {super.initState(), _loadUserData()};

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('first_name') ?? "الاسم الأول";
      lastName = prefs.getString('last_name') ?? "اسم العائلة";
      email = prefs.getString('user_email') ?? "example@email.com";
      phone = prefs.getString('phone') ?? "+0000000000";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("الملف الشخصي")),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Column(
            spacing: 10,
            children: [
              const CircleAvatar(
                radius: 75,
                backgroundColor: Color(0xff005B50),
                child: CircleAvatar(radius: 70, backgroundImage: AssetImage("assets/profile.jpg")),
              ),
              Text("$firstName $lastName", style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          ProfileTextField(label: "الاسم الأول", value: firstName),
          ProfileTextField(label: "اسم العائلة", value: lastName),
          ProfileTextField(label: "البريد الإلكتروني", value: email),
          ProfileTextField(label: "رقم الهاتف", value: phone),
        ],
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final String label, value;
  const ProfileTextField({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          hintText: value,
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
