import 'package:flutter/material.dart';
import 'package:screenify/config/constants/app_colors.dart';

class AppInputDecorationTheme {
  const AppInputDecorationTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    contentPadding: EdgeInsets.zero,
    prefixIconColor: WidgetStateColor.resolveWith(
      (states) {
        if (states.contains(WidgetState.focused)) {
          return AppColors.whiteColor;
        }
        return AppColors.white80;
      },
    ),
    focusColor: AppColors.whiteColor,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(45),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.white80,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(45),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.whiteColor,
      ),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    contentPadding: EdgeInsets.zero,
    prefixIconColor: WidgetStateColor.resolveWith(
      (states) {
        if (states.contains(WidgetState.focused)) {
          return AppColors.whiteColor;
        }
        return AppColors.white80;
      },
    ),
    focusColor: AppColors.whiteColor,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(45),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.white80,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(45),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.whiteColor,
      ),
    ),
  );
}
