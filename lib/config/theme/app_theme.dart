import 'package:flutter/material.dart';
import 'package:screenify/config/theme/custom_themes/app_text_theme.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    textTheme: AppTextTheme.lightTextTheme,
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0C056D),
    textTheme: AppTextTheme.darkTextTheme,
  );
}
