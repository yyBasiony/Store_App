import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData getLightTheme() {
    return ThemeData(
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          minimumSize: WidgetStatePropertyAll(Size.fromHeight(50)),
          textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 15)),
          backgroundColor: WidgetStatePropertyAll(Color(0xff005B50)),
          surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)))),
        ),
      ),
      outlinedButtonTheme: const OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll(Size.fromHeight(50)),
          textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 15)),
          foregroundColor: WidgetStatePropertyAll(Colors.blueGrey),
          side: WidgetStatePropertyAll(BorderSide(color: Colors.blueGrey)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)))),
        ),
      ),
    );
  }
}
