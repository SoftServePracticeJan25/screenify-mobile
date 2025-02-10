import 'package:flutter/material.dart';
import 'package:screenify/config/constants/app_colors.dart';

class AppOutlinedButtonTheme {
  const AppOutlinedButtonTheme._();

  static OutlinedButtonThemeData lightOutlinedButtonTheme =
  OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
      fixedSize: const WidgetStatePropertyAll(
        Size(293, 56),
      ),
      side: WidgetStateProperty.resolveWith<BorderSide>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return const BorderSide(
              color: AppColors.darkButtonPressedColor,
              width: 2.0,
            );
          }
          return const BorderSide(color: AppColors.whiteColor, width: 2.0);
        },
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.darkButtonPressedColor;
          }
          return AppColors.whiteColor;
        },
      ),
    ),
  );
  static OutlinedButtonThemeData darkOutlinedButtonTheme =
      OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
      fixedSize: const WidgetStatePropertyAll(
        Size(293, 56),
      ),
      side: WidgetStateProperty.resolveWith<BorderSide>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return const BorderSide(
              color: AppColors.darkButtonPressedColor,
              width: 2.0,
            );
          }
          return const BorderSide(color: AppColors.whiteColor, width: 2.0);
        },
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
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
