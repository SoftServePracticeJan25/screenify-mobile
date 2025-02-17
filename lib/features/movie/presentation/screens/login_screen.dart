import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:screenify/config/constants/app_colors.dart';
import 'package:screenify/config/constants/app_images.dart';
import 'package:screenify/features/movie/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isHiddenPassword = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailed) {
          print(state.message);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is AuthLoaded) {
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
                                  height: 100,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.logIn,
                                  style:
                                      Theme.of(context).textTheme.displaySmall!,
                                ),
                                const SizedBox(
                                  height: 20,
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
                                  height: 20,
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
                              LoginEvent(
                                username: _usernameController.text,
                                password: _passwordController.text,
                              ),
                            );
                      },
                      child: Text(AppLocalizations.of(context)!.logIn),
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
