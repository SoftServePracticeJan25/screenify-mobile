part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();
}

class ChangeThemeModeEvent extends AppEvent {
  final ThemeMode themeMode;

  const ChangeThemeModeEvent(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

class ChangeLocaleEvent extends AppEvent {
  final String languageCode;

  const ChangeLocaleEvent(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}

class ChangeConnectivityResultEvent extends AppEvent {
  final List<ConnectivityResult> connectivityResult;

  const ChangeConnectivityResultEvent(this.connectivityResult);

  @override
  List<Object?> get props => [connectivityResult];
}
