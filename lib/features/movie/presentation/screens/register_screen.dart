import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:screenify/config/constants/app_colors.dart';
import 'package:screenify/config/constants/app_images.dart';
import 'package:screenify/features/movie/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isHiddenPassword = true;
  bool _isHiddenRepeatPassword = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoaded) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          image: DecorationImage(
            image: AssetImage(
              MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? AppImages.authBackgroundDark
                  : AppImages.authBackgroundLight,
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Container(
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
                          height: MediaQuery.sizeOf(context).height / 1.7,
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
                                  height: 50,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .createYourAccount,
                                  style:
                                      Theme.of(context).textTheme.displaySmall!,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.username,
                                ),
                                TextFormField(
                                  autocorrect: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .pleaseEnterTheUsername;
                                    }
                                    return null;
                                  },
                                  onEditingComplete: () {
                                    setState(() {});
                                  },
                                  controller: _usernameController,
                                  style: WidgetStateTextStyle.resolveWith(
                                    (states) {
                                      if (states
                                          .contains(WidgetState.focused)) {
                                        return Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: AppColors.whiteColor,
                                            );
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
                                    hintText:
                                        AppLocalizations.of(context)!.username,
                                    prefixIcon: Icon(
                                      _usernameController.text.isEmpty
                                          ? Bootstrap.person
                                          : Bootstrap.person_check,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.email,
                                ),
                                TextFormField(
                                  autocorrect: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .pleaseEnterTheEmail;
                                    } else if (!RegExp(
                                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                    ).hasMatch(value)) {
                                      return AppLocalizations.of(context)!
                                          .pleaseEnterValidEmail;
                                    }
                                    return null;
                                  },
                                  onEditingComplete: () {
                                    setState(() {});
                                  },
                                  controller: _emailController,
                                  style: WidgetStateTextStyle.resolveWith(
                                    (states) {
                                      if (states
                                          .contains(WidgetState.focused)) {
                                        return Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: AppColors.whiteColor,
                                            );
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
                                    hintText:
                                        AppLocalizations.of(context)!.username,
                                    prefixIcon: const Icon(Bootstrap.envelope),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.password,
                                ),
                                TextFormField(
                                  autocorrect: false,
                                  obscureText: _isHiddenPassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .pleaseEnterThePassword;
                                    } else if (!RegExp(
                                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{12,}$',
                                    ).hasMatch(value)) {
                                      return AppLocalizations.of(context)!
                                          .pleaseEnterValidPassword;
                                    }
                                    return null;
                                  },
                                  controller: _passwordController,
                                  style: WidgetStateTextStyle.resolveWith(
                                    (states) {
                                      if (states
                                          .contains(WidgetState.focused)) {
                                        return Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: AppColors.whiteColor,
                                            );
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
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isHiddenPassword =
                                              !_isHiddenPassword;
                                        });
                                      },
                                      icon: Icon(
                                        _isHiddenPassword
                                            ? Bootstrap.eye_slash
                                            : Bootstrap.eye,
                                      ),
                                    ),
                                    hintText:
                                        AppLocalizations.of(context)!.password,
                                    prefixIcon: const Icon(Bootstrap.key),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.repeatPassword,
                                ),
                                TextFormField(
                                  autocorrect: false,
                                  obscureText: _isHiddenRepeatPassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .pleaseEnterThePassword;
                                    } else if (value !=
                                        _passwordController.text) {
                                      return AppLocalizations.of(context)!
                                          .passwordsDidNotMatch;
                                    }
                                    return null;
                                  },
                                  controller: _repeatPasswordController,
                                  style: WidgetStateTextStyle.resolveWith(
                                    (states) {
                                      if (states
                                          .contains(WidgetState.focused)) {
                                        return Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: AppColors.whiteColor,
                                            );
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
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isHiddenRepeatPassword =
                                              !_isHiddenRepeatPassword;
                                        });
                                      },
                                      icon: Icon(
                                        _isHiddenRepeatPassword
                                            ? Bootstrap.eye_slash
                                            : Bootstrap.eye,
                                      ),
                                    ),
                                    hintText: AppLocalizations.of(context)!
                                        .repeatPassword,
                                    prefixIcon: const Icon(Bootstrap.key_fill),
                                  ),
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
                        if (!_formKey.currentState!.validate()) return;
                        context.read<AuthBloc>().add(
                              RegisterEvent(
                                email: _emailController.text,
                                username: _usernameController.text,
                                password: _passwordController.text,
                              ),
                            );
                      },
                      child: Text(AppLocalizations.of(context)!.signUp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
