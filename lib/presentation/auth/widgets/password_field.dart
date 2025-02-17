import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final VoidCallback toggleObscure;
  const PasswordField({
    Key? key,
    required this.controller,
    required this.label,
    required this.obscureText,
    required this.toggleObscure,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        cursorColor: Colors.black,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            labelText: widget.label,
            labelStyle: const TextStyle(fontSize: 14, color: Color(0xffACA7A7)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            suffixIcon: IconButton(
              icon: Icon(
                  widget.obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey),
              onPressed: widget.toggleObscure,
            )));
  }
}
