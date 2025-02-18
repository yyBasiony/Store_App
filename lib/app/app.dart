import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../presentation/resources/app_routes.dart';
import '../presentation/resources/app_theme.dart';

class ShopeApp extends StatelessWidget {
  const ShopeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('ar'),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routes: AppRoutes.routes,
      theme: AppTheme.getLightTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.registerScreen,
    );
  }
}
