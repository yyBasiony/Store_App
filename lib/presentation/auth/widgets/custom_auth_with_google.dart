import 'package:flutter/material.dart';

class CustomAuthWithGoogle extends StatelessWidget {
  final String routeName;
  final String buttonText;
  final String questionText;

  const CustomAuthWithGoogle({super.key, required this.routeName, required this.buttonText, required this.questionText});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        const Text('أو سجل الدخول باستخدام جوجل', style: TextStyle(color: Colors.black54, fontSize: 11)),
        OutlinedButton(onPressed: () {}, child: const Text('المتابعة باستخدام جوجل')),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(questionText, style: const TextStyle(fontSize: 10, color: Colors.red)),
            TextButton(child: Text(buttonText), onPressed: () => Navigator.pushNamed(context, routeName)),
          ],
        ),
      ],
    );
  }
}
