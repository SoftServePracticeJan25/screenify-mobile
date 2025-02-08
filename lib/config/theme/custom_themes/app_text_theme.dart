import 'package:flutter/material.dart';

class AppTextTheme {
  const AppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    labelLarge:
        const TextStyle().copyWith(fontSize: 24, fontWeight: FontWeight.w500),
    displaySmall: const TextStyle().copyWith(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF0C056D),
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
    labelLarge:
        const TextStyle().copyWith(fontSize: 24, fontWeight: FontWeight.w500),
    displaySmall: const TextStyle().copyWith(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: const Color(0xCCFFFFFF),
    ),
  );
}
