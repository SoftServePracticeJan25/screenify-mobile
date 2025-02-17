import 'package:flutter/material.dart';
import 'package:screenify/config/constants/app_colors.dart';
import 'package:screenify/config/constants/app_images.dart';
import 'package:screenify/config/theme/custom_themes/app_elevated_button_theme.dart';
import 'package:screenify/config/theme/custom_themes/app_outlined_button_theme.dart';
import 'package:screenify/features/movie/presentation/screens/login_screen.dart';
import 'package:screenify/features/movie/presentation/screens/register_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AppImages.welcomeScreenBackground),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              Image.asset(
                AppImages.bigLogo,
                height: MediaQuery.sizeOf(context).height / 5,
                width: MediaQuery.sizeOf(context).height / 5,
              ),
              const SizedBox(height: 3),
              Text(
                style: Theme.of(context).textTheme.displayLarge,
                "screenify",
              ),
              const SizedBox(height: 9),
              Text(
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: AppColors.whiteColor),
                AppLocalizations.of(context)!.welcomeScreenSlogan,
              ),
              const Spacer(),
              ElevatedButton(
                style: AppElevatedButtonTheme.darkElevatedButtonTheme.style,
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const RegisterScreen(),
                    ),
                  );
                },
                child:  Text(AppLocalizations.of(context)!.signUp),
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                style: AppOutlinedButtonTheme.darkOutlinedButtonTheme.style,
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                  );
                },
                child: Text(AppLocalizations.of(context)!.logIn),
              ),
              const SizedBox(height: 34),
            ],
          ),
        ),
      ),
    );
  }
}
