import 'package:flutter/material.dart';
import 'package:store_app_api/presentation/auth/register/register_screen.dart';
import 'package:store_app_api/views/login_screen.dart';
import '../onboarding/onboarding_screen.dart';
import '../welcome_screen.dart';

class AppRoutes {
  static const String onboardingScreen = "/onboardingScreen";
  static const String welcomeScreen = "/welcomeScreen";
  static const String registerScreen = "/registerScreen";
  static const String loginScreen = "/loginScreen";

  static Map<String, WidgetBuilder> routes = {
    onboardingScreen: (context) => const OnboardingScreen(),
    welcomeScreen: (context) => const WelcomeScreen(),
    registerScreen: (context) => RegisterScreen(),
    loginScreen: (context) => LoginScreen(),
  };
}
