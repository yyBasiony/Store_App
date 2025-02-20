import 'package:flutter/material.dart';
import '../services/auth_services.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  String email = "yasmine@gmail.com";
  final AuthService _authService = AuthService();

  @override
  void initState() => {super.initState(), _loadUserEmail()};

  Future<void> _loadUserEmail() async {
    final userEmail = await _authService.getUserEmail();
    setState(() {
      email = userEmail ?? "user@example.com";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تسجيل الخروج")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 75,
              backgroundColor: Color(0xff005B50),
              child: CircleAvatar(radius: 70, backgroundImage: AssetImage("assets/profile.jpg")),
            ),
            const SizedBox(height: 20),
            Text(email, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _authService.logout(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
              child: const Text("تسجيل الخروج", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
