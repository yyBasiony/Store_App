import 'package:flutter/material.dart';
import '../services/auth_services.dart';

class LogoutPage extends StatefulWidget {
  @override
  _LogoutPageState createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  final AuthService _authService = AuthService();
  String email = "yasmine@gmail.com";

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    final userEmail = await _authService.getUserEmail();
    setState(() {
      email = userEmail ?? "user@example.com";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تسجيل الخروج"),
        centerTitle: true,
        backgroundColor: Color(0xff005B50),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 75,
              backgroundColor: Color(0xff005B50),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("assets/profile.jpg"),
              ),
            ),
            SizedBox(height: 20),
            Text(
              email,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _authService.logout(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                "تسجيل الخروج",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
