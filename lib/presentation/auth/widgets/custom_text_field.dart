import 'package:flutter/material.dart';

import '../base/controller.dart';
import '../base/validation.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final AuthController controller;
  const CustomTextField({super.key, required this.label, required this.controller});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;
  late Validation _validation;
  late final TextEditingController _controller;

  bool get _isPassword => widget.label.toLowerCase().contains("password");

  TextInputType get _keyboardType => widget.label.toLowerCase().contains("email")
      ? TextInputType.emailAddress
      : widget.label.toLowerCase().contains("phone")
          ? TextInputType.phone
          : TextInputType.text;

  IconButton _buildObscureEye() {
    return IconButton(
      onPressed: () => setState(() => _isObscured = !_isObscured),
      icon: Icon(_isObscured ? Icons.visibility_off_rounded : Icons.visibility_rounded),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller.controllers[widget.label]!;
  }

  @override
  Widget build(BuildContext context) {
    _validation = Validation.fromLabel(widget.label, password: widget.controller.controllers["Password"]!.text);

    return TextFormField(
      controller: _controller,
      keyboardType: _keyboardType,
      validator: _validation.validateAll,
      cursorColor: const Color(0xff005B50),
      obscureText: _isPassword ? _isObscured : false,
      style: const TextStyle(fontSize: 14, color: Colors.black),
      decoration: InputDecoration(errorMaxLines: 2, labelText: widget.label, suffixIcon: _isPassword ? _buildObscureEye() : null),
    );
  }
}