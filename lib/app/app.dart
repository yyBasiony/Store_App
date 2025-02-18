import 'package:flutter/material.dart';

import '../presentation/resources/app_routes.dart';
import '../presentation/resources/app_theme.dart';

class ShopeApp extends StatelessWidget {
  const ShopeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRoutes.routes,
      theme: AppTheme.getLightTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.loginScreen,
    );
  }
}
