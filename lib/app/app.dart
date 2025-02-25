import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../presentation/resources/app_routes.dart';
import '../presentation/resources/app_theme.dart';

class ShopeApp extends StatelessWidget {
  const ShopeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.getLightTheme(),
      debugShowCheckedModeBanner: false,
      //

      routes: AppRoutes.routes,
      initialRoute: AppRoutes.onboardingScreen,


      locale: const Locale('en'),
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
    );
  }
}
