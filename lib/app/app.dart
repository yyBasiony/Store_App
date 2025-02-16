import 'package:flutter/material.dart';

import '../presentation/resources/app_theme.dart';
import '../presentation/welcome_screen.dart';

class ShopeApp extends StatelessWidget {
  const ShopeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WelcomeScreen(),
      theme: AppTheme.getLightTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
