import 'package:flutter/material.dart';

class CustomAuthWithGoogle extends StatelessWidget {
  final String buttonText;
  final String questionText;
  final String routeName;

  const CustomAuthWithGoogle({
    Key? key,
    required this.buttonText,
    required this.questionText,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'أو سجل الدخول باستخدام جوجل',
          style: TextStyle(color: Colors.black54, fontSize: 11),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            side: const BorderSide(color: Colors.blueGrey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'المتابعة باستخدام جوجل',
            style: TextStyle(color: Colors.blueGrey),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pushNamed(context, routeName),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff005B50),
                ),
              ),
            ),
            Text(
              questionText,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
