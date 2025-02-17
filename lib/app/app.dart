import 'package:flutter/material.dart';
import '../presentation/resources/app_theme.dart';
import '../presentation/resources/app_routes.dart';

class ShopeApp extends StatelessWidget {
  const ShopeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.onboardingScreen,
      routes: AppRoutes.routes,
      theme: AppTheme.getLightTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
