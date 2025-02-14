import 'package:flutter/material.dart';
import 'package:screenify/config/constants/app_colors.dart';

class AppInputDecorationTheme {
  const AppInputDecorationTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    contentPadding: EdgeInsets.zero,
    prefixIconColor: WidgetStateColor.resolveWith(
      (states) {
        if (states.contains(WidgetState.focused)) {
          return AppColors.darkBlue;
        }
        return AppColors.lightPurple80;
      },
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(45),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.lightPurple80,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(45),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.darkBlue,
      ),
    ),
    focusColor: AppColors.darkBlue,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(45),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.lightPurple80,
      ),
    ),
    suffixIconColor: WidgetStateColor.resolveWith(
          (states) {
        if (states.contains(WidgetState.focused)) {
          return AppColors.darkBlue;
        }
        return AppColors.lightPurple80;
      },
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(45),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.darkBlue,
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
    suffixIconColor: WidgetStateColor.resolveWith(
      (states) {
        if (states.contains(WidgetState.focused)) {
          return AppColors.whiteColor;
        }
        return AppColors.white80;
      },
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(45),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.whiteColor,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(45),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.whiteColor,
      ),
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
