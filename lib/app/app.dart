import 'package:flutter/material.dart';

import '../presentation/onboarding/onboarding_screen.dart';
import '../presentation/resources/app_theme.dart';

class ShopeApp extends StatelessWidget {
  const ShopeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen(),
      theme: AppTheme.getLightTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
