import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final VoidCallback toggleObscure;
  final TextEditingController controller;
  const PasswordField({super.key, required this.label, required this.controller, required this.obscureText, required this.toggleObscure});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      controller: widget.controller,
      obscureText: widget.obscureText,
      style: const TextStyle(fontSize: 14, color: Colors.black),
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: IconButton(
          onPressed: widget.toggleObscure,
          icon: Icon(widget.obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
        ),
      ),
    );
  }
}
