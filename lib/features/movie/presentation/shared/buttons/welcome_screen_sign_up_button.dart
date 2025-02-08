import 'package:flutter/material.dart';

class WelcomeScreenSignUpButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;

  const WelcomeScreenSignUpButton({
    required this.onPressed,
    required this.text,
    super.key,
  });

  @override
  State<WelcomeScreenSignUpButton> createState() =>
      _WelcomeScreenSignUpButtonState();
}

class _WelcomeScreenSignUpButtonState extends State<WelcomeScreenSignUpButton> {
  List<Color> _gradientColors = [Colors.white, Colors.white]; // Default

  void _changeGradient(bool isPressed) {
    setState(() {
      _gradientColors = isPressed
          ? [
              const Color(0xFFFAB33F),
              const Color(0xFCFACF39),
              const Color(0xFFF9EB32),
            ]
          : [
              const Color(0xFFFFFFFF),
              const Color(0xFFFFFFFF),
            ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _changeGradient(true),
      onTapUp: (_) => _changeGradient(false),
      onTapCancel: () => _changeGradient(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        // Smooth transition
        curve: Curves.easeInOut,
        width: 240,
        height: 72,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          boxShadow: [
            const BoxShadow(
              color: Colors.white,
              offset: Offset(0, 1),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
          gradient: LinearGradient(
            colors: _gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(45),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: const Color(0xFF0C056D),
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
          ),
        ),
      ),
    );
  }
}
