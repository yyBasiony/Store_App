import 'package:flutter/material.dart';
import 'package:store_app_api/presentation/home/home_page.dart';

import '../../views/logout_page.dart';
import '../../views/product_details_screen.dart';
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
  static const String logoutPage = "/logoutPage";

  static Map<String, WidgetBuilder> routes = {
    homeScreen: (_) => const HomePage(),
    loginScreen: (_) => const LoginScreen(),
    welcomeScreen: (_) => const WelcomeScreen(),
    registerScreen: (_) => const RegisterScreen(),
    onboardingScreen: (_) => const OnboardingScreen(),
    logoutPage: (_) => const LogoutPage(),
  };
}
