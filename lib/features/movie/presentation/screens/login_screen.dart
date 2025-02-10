import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:screenify/config/constants/app_colors.dart';
import 'package:screenify/config/constants/app_images.dart';
import 'package:screenify/features/movie/presentation/blocs/auth_bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoaded) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                MediaQuery.of(context).platformBrightness == Brightness.dark
                    ? AppImages.authBackgroundDark
                    : AppImages.authBackgroundLight,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: SafeArea(
            child: Column(
              children: [
                Image.asset(
                  AppImages.middleLogo,
                  height: 150,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 2,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            Text(
                              "Log in",
                              style: Theme.of(context).textTheme.displaySmall!,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Username",
                            ),
                            TextFormField(
                              onEditingComplete: () {
                                setState(() {});
                              },
                              controller: _usernameController,
                              style: WidgetStateTextStyle.resolveWith(
                                (states) {
                                  if (states.contains(WidgetState.focused)) {
                                    return Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: AppColors.whiteColor);
                                  } else {
                                    return Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: AppColors.white80,
                                        );
                                  }
                                },
                              ),
                              decoration: InputDecoration(
                                hintText: "Username",
                                prefixIcon: Icon(
                                  _usernameController.text.isEmpty
                                      ? Bootstrap.person
                                      : Bootstrap.person_check,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Password",
                            ),
                            TextFormField(
                              controller: _passwordController,
                              style: WidgetStateTextStyle.resolveWith(
                                (states) {
                                  if (states.contains(WidgetState.focused)) {
                                    return Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: AppColors.whiteColor);
                                  } else {
                                    return Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: AppColors.white80,
                                        );
                                  }
                                },
                              ),
                              decoration: const InputDecoration(
                                hintText: "Password",
                                prefixIcon: Icon(Bootstrap.key),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height / 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () async {
                    context.read<AuthBloc>().add(
                          LoginEvent(
                            username: _usernameController.text,
                            password: _passwordController.text,
                          ),
                        );
                  },
                  child: const Text("Log in"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
