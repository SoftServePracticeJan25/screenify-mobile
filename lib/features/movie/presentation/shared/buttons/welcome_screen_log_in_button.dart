import 'package:flutter/material.dart';

class WelcomeScreenLogInButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;

  const WelcomeScreenLogInButton({
    required this.onPressed,
    required this.text,
    super.key,
  });

  @override
  State<WelcomeScreenLogInButton> createState() =>
      _WelcomeScreenLogInButtonState();
}

class _WelcomeScreenLogInButtonState extends State<WelcomeScreenLogInButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      // Change when pressed
      onTapUp: (_) => setState(() => _isPressed = false),
      // Revert when released
      onTapCancel: () => setState(() => _isPressed = false),
      // Revert on cancel
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        // Smooth transition
        curve: Curves.easeInOut,
        width: 240,
        height: 72,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          border: Border.all(
            width: 2,
            color:
                _isPressed ? const Color(0xFFFAB33F) : const Color(0xFFFFFFFF),
          ),
        ),
        child: Center(
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return _isPressed
                  ? const LinearGradient(
                      colors: [
                        Color(0xFFFAB33F),
                        Color(0xFCFACF39),
                        Color(0xFFF9EB32),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds)
                  : const LinearGradient(
                      colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds);
            },
            child: Text(
              widget.text,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
