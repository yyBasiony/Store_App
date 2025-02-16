import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_app_api/app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));

  runApp(const ShopeApp());
}
