import 'package:flutter/material.dart';

import '../auth/contact_us/contact_us_screen.dart';
import '../auth/logout/logout_screen.dart';
import '../main/category/orders_screen.dart';
import '../auth/profile/profile_screen.dart';
import '../auth/login/login_screen.dart';
import '../auth/register/register_screen.dart';
import '../main/main_view.dart';
import '../onboarding/onboarding_screen.dart';
import '../welcome_screen.dart';

class AppRoutes {
  static const String mainView = "/home";
  static const String loginScreen = "/login";
  static const String logoutScreen = "/logout";
  static const String ordersScreen = "/orders";
  static const String welcomeScreen = "/welcome";
  static const String profileScreen = "/profile";
  static const String registerScreen = "/register";
  static const String contactUsScreen = "/contact-us";
  static const String onboardingScreen = "/onboarding";

  static Route generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case mainView:
        return MaterialPageRoute(builder: (_) => const MainView());

      case onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      // Auth
      case welcomeScreen:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case ordersScreen:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case logoutScreen:
        return MaterialPageRoute(builder: (_) => const LogoutScreen());
      case profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case contactUsScreen:
        return MaterialPageRoute(builder: (_) => const ContactUsScreen());

      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text("No Route Found"))));
    }
  }
}
