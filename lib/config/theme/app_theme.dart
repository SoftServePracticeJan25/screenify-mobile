import 'package:flutter/material.dart';
import 'package:screenify/config/constants/app_colors.dart';
import 'package:screenify/config/theme/custom_themes/app_bottom_navigation_bar_theme.dart';
import 'package:screenify/config/theme/custom_themes/app_elevated_button_theme.dart';
import 'package:screenify/config/theme/custom_themes/app_input_decoration_theme.dart';
import 'package:screenify/config/theme/custom_themes/app_outlined_button_theme.dart';
import 'package:screenify/config/theme/custom_themes/app_text_theme.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light = ThemeData(
    fontFamily: "Roboto",
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.whiteColor,
    shadowColor: AppColors.darkBlue,
    textTheme: AppTextTheme.lightTextTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.lightOutlinedButtonTheme,
    bottomNavigationBarTheme:
        AppBottomNavigationBarTheme.lightBottomNavigationTheme,
    inputDecorationTheme: AppInputDecorationTheme.lightInputDecorationTheme,
  );

  static ThemeData dark = ThemeData(
    fontFamily: "Roboto",
    brightness: Brightness.dark,
    shadowColor: AppColors.whiteColor,
    scaffoldBackgroundColor: AppColors.darkBlue,
    textTheme: AppTextTheme.darkTextTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.darkOutlinedButtonTheme,
    bottomNavigationBarTheme:
        AppBottomNavigationBarTheme.darkBottomNavigationTheme,
    inputDecorationTheme: AppInputDecorationTheme.darkInputDecorationTheme,
  );
}
