import 'package:flutter/material.dart';

abstract class AuthController {
  final formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {};
  AuthController(List<String> fields) {
    for (String field in fields) {
      controllers[field] = TextEditingController();
    }
  }
  String getFieldValue(String field) => controllers[field]?.text ?? '';
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
  }

  Future<bool> authenticate();
}
