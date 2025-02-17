import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:screenify/config/constants/app_lottie_animations.dart';

class ScreenifyProgressIndicator extends StatelessWidget {
  const ScreenifyProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(AppLottieAnimations.progressIndicator2x));
  }
}
