import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData getLightTheme() {
    return ThemeData(
      //
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent, // Icon: Color(0xff005B50)
      ),

      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          minimumSize: WidgetStatePropertyAll(Size.fromHeight(50)),
          textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 15)),
          backgroundColor: WidgetStatePropertyAll(Color(0xff005B50)),
          surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16)))),
        ),
      ),

      outlinedButtonTheme: const OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll(Size.fromHeight(50)),
          textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 15)),
          foregroundColor: WidgetStatePropertyAll(Colors.blueGrey),
          side: WidgetStatePropertyAll(BorderSide(color: Colors.blueGrey)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16)))),
        ),
      ),

      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(fontSize: 14, color: Color(0xffACA7A7)),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff005B50)), borderRadius: BorderRadius.all(Radius.circular(16))),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff005B50)), borderRadius: BorderRadius.all(Radius.circular(16))),
      ),

      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Color(0xff005B50)),
          textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ),
      ),

      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.white,
        contentTextStyle: TextStyle(fontSize: 12, color: Colors.blueGrey),
      ),
    );
  }
}
