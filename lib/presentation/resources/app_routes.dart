import 'package:flutter/material.dart';

import '../../views/contact_us_screen.dart';
import '../../views/logout_page.dart';
import '../../views/orders_screen.dart';
import '../auth/profile/profile_page.dart';
import '../auth/login/login_screen.dart';
import '../auth/register/register_screen.dart';
import '../main/main_view.dart';
import '../onboarding/onboarding_screen.dart';
import '../welcome_screen.dart';

class AppRoutes {
  static const String mainView = "/home";
  static const String loginScreen = "/login";
  static const String ordersScreen = "/orders";
  static const String welcomeScreen = "/welcome";
  static const String profileScreen = "/profile";
  static const String logoutPage = "/logoutPage";
  static const String registerScreen = "/register";
  static const String contactUsScreen = "/contact-us";
  static const String onboardingScreen = "/onboarding";

  static Map<String, WidgetBuilder> routes = {
    mainView: (_) => const MainView(),
    logoutPage: (_) => const LogoutPage(),
    loginScreen: (_) => const LoginScreen(),
    ordersScreen: (_) => const OrdersScreen(),
    profileScreen: (_) => const ProfilePage(),
    welcomeScreen: (_) => const WelcomeScreen(),
    registerScreen: (_) => const RegisterScreen(),
    contactUsScreen: (_) => const ContactUsScreen(),
    onboardingScreen: (_) => const OnboardingScreen(),
  };
}
