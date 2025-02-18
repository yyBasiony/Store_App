import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff005B50)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xff005B50)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("الملف الشخصي", style: TextStyle(color: Color(0xff005B50))),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Column(
            children: [
              const CircleAvatar(
                radius: 75,
                backgroundColor: Color(0xff005B50),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage("assets/profile.jpg"),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "$firstName $lastName",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
          const SizedBox(height: 10),
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
  final String label;
  final String value;

  const ProfileTextField({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: value,
              hintStyle: TextStyle(color: Colors.grey.shade600),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
