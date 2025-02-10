import 'package:flutter/material.dart';
import 'package:screenify/config/constants/app_colors.dart';

class AppBottomNavigationBarTheme {
  AppBottomNavigationBarTheme._();

  static BottomNavigationBarThemeData lightBottomNavigationTheme =
      const BottomNavigationBarThemeData(
    elevation: 8.0,
    backgroundColor:  AppColors.whiteColor,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  );
  static BottomNavigationBarThemeData darkBottomNavigationTheme =
      const BottomNavigationBarThemeData(
    selectedItemColor: AppColors.yellow,
    unselectedItemColor: AppColors.yellow,
    elevation: 8.0,
    backgroundColor: AppColors.darkBlue,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  );
}
