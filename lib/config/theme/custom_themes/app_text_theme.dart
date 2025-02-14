import 'package:flutter/material.dart';
import 'package:screenify/config/constants/app_colors.dart';

class AppTextTheme {
  const AppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 30,
      fontFamily: "Roboto",
    ),
    displayLarge: const TextStyle().copyWith(
      fontFamily: "Poppins",
      fontSize: 48,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFFFFFFF),
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    labelLarge:
        const TextStyle().copyWith(fontSize: 24, fontWeight: FontWeight.w500),
    displaySmall: const TextStyle().copyWith(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF0C056D),
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 30,
      fontFamily: "Roboto",
      color: AppColors.whiteColor,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontFamily: "Nunito",
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: AppColors.white80,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontFamily: "Nunito",
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: AppColors.white80,
    ),
    displayLarge: const TextStyle().copyWith(
      fontFamily: "Poppins",
      fontSize: 48,
      fontWeight: FontWeight.w500,
      color: AppColors.whiteColor,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColors.whiteColor,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.whiteColor,
    ),
    labelLarge:
        const TextStyle().copyWith(fontSize: 24, fontWeight: FontWeight.w500),
    labelSmall: const TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: const TextStyle().copyWith(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: AppColors.white80,
    ),
  );
}
