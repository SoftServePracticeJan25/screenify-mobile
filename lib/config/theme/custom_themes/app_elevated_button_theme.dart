import 'package:flutter/material.dart';
import 'package:screenify/config/constants/app_colors.dart';

class AppElevatedButtonTheme {
  const AppElevatedButtonTheme._();

  static ElevatedButtonThemeData lightElevatedButtonTheme =
  ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: const WidgetStatePropertyAll(AppColors.whiteColor),
      fixedSize: const WidgetStatePropertyAll(
        Size(293, 56),
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.lightButtonPressedColor;
          }
          return  AppColors.lightPurple80;
        },
      ),
    ),
  );

  static ElevatedButtonThemeData darkElevatedButtonTheme =
      ElevatedButtonThemeData(

    style: ButtonStyle(
      enableFeedback: true,
      foregroundColor: const WidgetStatePropertyAll(AppColors.darkBlue),
      fixedSize: const WidgetStatePropertyAll(
        Size(293, 56),
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.darkButtonPressedColor;
          }
          return AppColors.whiteColor;
        },
      ),
    ),
  );
}
