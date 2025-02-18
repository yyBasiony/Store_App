import 'package:flutter/material.dart';
import 'package:store_app_api/views/home_screen.dart';

import '../auth/login/login_screen.dart';
import '../auth/register/register_screen.dart';
import '../onboarding/onboarding_screen.dart';
import '../welcome_screen.dart';

class AppRoutes {
  static const String homeScreen = "/home";
  static const String loginScreen = "/login";
  static const String welcomeScreen = "/welcome";
  static const String registerScreen = "/register";
  static const String onboardingScreen = "/onboarding";

  static Map<String, WidgetBuilder> routes = {
    homeScreen: (_) => const HomeScreen(),
    loginScreen: (_) => const LoginScreen(),
    welcomeScreen: (_) => const WelcomeScreen(),
    registerScreen: (_) => const RegisterScreen(),
    onboardingScreen: (_) => const OnboardingScreen(),
  };
}
