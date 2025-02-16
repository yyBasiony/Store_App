import 'package:flutter/material.dart';
import 'onboarding/onboarding_screen.dart';

class ShopeApp extends StatelessWidget {
  const ShopeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen(),
    );
  }
}
