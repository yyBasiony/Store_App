import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../presentation/welcome_screen.dart';

class AuthService {
  static const String _baseUrl = "https://ib.jamalmoallart.com/api/v2";

  Future<Map<String, dynamic>> register(String firstName, String lastName,
      String phone, String address, String email, String password) async {
    final url = Uri.parse("$_baseUrl/register");
    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "address": address,
        "email": email,
        "password": password,
      }),
    );

    final responseData = json.decode(response.body);
    if (responseData["state"] == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('first_name', firstName);
      await prefs.setString('last_name', lastName);
      await prefs.setString('user_email', email);
      await prefs.setString('phone', phone);
    }

    return responseData;
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<void> _saveUserData(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
  }

  Future<void> _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
  }

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _addRevokedEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> revokedEmails = prefs.getStringList('revoked_emails') ?? [];
    if (!revokedEmails.contains(email)) {
      revokedEmails.add(email);
      await prefs.setStringList('revoked_emails', revokedEmails);
    }
  }

  Future<bool> _isEmailRevoked(String email) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> revokedEmails = prefs.getStringList('revoked_emails') ?? [];
    return revokedEmails.contains(email);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      bool isRevoked = await _isEmailRevoked(email);
      if (isRevoked) {
        return {
          "state": false,
          "message": ".تم حظر هذا الحساب من تسجيل الدخول. يرجى إنشاء حساب جديد"
        };
      }

      final url = Uri.parse("$_baseUrl/login");
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode({"email": email, "password": password}),
      );

      final responseData = json.decode(response.body);

      if (responseData.containsKey("message")) {}

      if (response.statusCode == 200 && responseData["state"] == true) {
        await _saveToken(responseData["data"]["token"]);
        await _saveUserData(email);
      }

      return responseData;
    } catch (e) {
      return {"state": false, "message": "An error occurred: $e"};
    }
  }

  Future<void> logout(BuildContext context) async {
    final email = await getUserEmail();
    if (email != null) {
      await _addRevokedEmail(email);
    }

    await _clearUserData();
    await _clearToken();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      (route) => false,
    );
  }
}
