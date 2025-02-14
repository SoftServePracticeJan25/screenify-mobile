import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:screenify/config/theme/app_theme.dart';
import 'package:screenify/core/injection/dependency_injection.dart';
import 'package:screenify/features/movie/presentation/blocs/app_bloc/app_bloc.dart';
import 'package:screenify/features/movie/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:screenify/features/movie/presentation/blocs/movie_bloc/movie_bloc.dart';
import 'package:screenify/features/movie/presentation/screens/home_screen_wrapper.dart';
import 'package:screenify/features/movie/presentation/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  injectDependencies();
  runApp(const Screenify());
}

class Screenify extends StatelessWidget {
  const Screenify({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (_) => AppBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc()..add(const CheckEvent()),
        ),
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc(),
        ),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: state.locale,
            darkTheme: AppTheme.dark,
            theme: AppTheme.light,
            themeMode: state.themeMode,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              if (locale != null && locale.languageCode == 'uk') {
                context.read<AppBloc>().add(const ChangeLocaleEvent('uk'));
                return const Locale('uk');
              } else {
                context.read<AppBloc>().add(const ChangeLocaleEvent('en'));
                return const Locale('en');
              }
            },
            home: BlocConsumer<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoaded) {
                  return const HomeScreenWrapper();
                } else {
                  return const WelcomeScreen();
                }
              },
              listener: (context, state) async {
                if (state is AuthFailed) {
                  print(state.message);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state is AuthLoading) {
                  await showDialog(
                    context: context,
                    builder: (_) {
                      return const CircularProgressIndicator.adaptive();
                    },
                  );
                } else {
                  if (Navigator.of(context).canPop()) {
                    Navigator.pop(context);
                  }
                }
              },
            ),
          );
        },
      ),
    );
  }
}
