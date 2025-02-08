import 'package:flutter/material.dart';

class AppElevatedButtonTheme {
  static final ButtonStyle welcomeScreen = ButtonStyle(
    foregroundColor: const WidgetStatePropertyAll(Colors.blue),
    fixedSize: const WidgetStatePropertyAll(
      Size(240, 72),
    ),
    backgroundColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.yellow;
        }
        return Colors.white;
      },
    ),
  );
}
