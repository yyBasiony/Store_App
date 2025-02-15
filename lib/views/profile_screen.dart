import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
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
        iconTheme: IconThemeData(color: Color(0xff005B50)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xff005B50)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("الملف الشخصي", style: TextStyle(color: Color(0xff005B50))),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Column(
            children: [
              CircleAvatar(
                radius: 75,
                backgroundColor: Color(0xff005B50),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage("assets/profile.jpg"),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "$firstName $lastName",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
          SizedBox(height: 10),
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

  ProfileTextField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: value,
              hintStyle: TextStyle(color: Colors.grey.shade600),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
