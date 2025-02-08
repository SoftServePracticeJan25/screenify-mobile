import 'package:flutter/material.dart';
import 'package:screenify/config/constants/image_path.dart';
import 'package:screenify/config/theme/custom_themes/app_elevated_button_theme.dart';
import 'package:screenify/features/movie/presentation/shared/buttons/welcome_screen_log_in_button.dart';
import 'package:screenify/features/movie/presentation/shared/buttons/welcome_screen_sign_up_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppImages.welcomeScreenBackground),
        ),
      ),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              Image.asset(
                AppImages.appLogo,
                height: MediaQuery.sizeOf(context).height / 5,
                width: MediaQuery.sizeOf(context).height / 5,
              ),
              const SizedBox(height: 3),
              Text(
                style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w600,
                  fontSize: 48, fontFamily: "Poppins",),
                "screenify",
              ),
              const SizedBox(height: 9),
              Text(
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w500,
                  fontSize: 30,fontFamily: "Roboto",),
                "Your pocket ticketing app",
              ),
              const Spacer(),
              WelcomeScreenSignUpButton(onPressed: () {}, text: "Sign up"),
              const SizedBox(height: 30),
              WelcomeScreenLogInButton(onPressed: () {}, text: "Log in"),
              const SizedBox(height: 34),
              Image.asset(AppImages.userCircleLightFilled),
              const SizedBox(height: 34),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
