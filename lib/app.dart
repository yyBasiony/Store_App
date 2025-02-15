import 'package:flutter/material.dart';
import 'views/onboarding.dart';

class ShopeApp extends StatelessWidget {
  const ShopeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Onboarding(),
    );
  }
}
