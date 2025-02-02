import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  AppBloc()
      : super(
          const AppState(
            connectivityResult: [],
            themeMode: ThemeMode.system,
            locale: null,
          ),
        ) {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (result) {
        add(ChangeConnectivityResultEvent(result));
      },
    );
    on<ChangeThemeModeEvent>(_onThemeModeChanged);
    on<ChangeLocaleEvent>(_onLocaleChanged);
    on<ChangeConnectivityResultEvent>(_onConnectivityResultChanged);
  }

  FutureOr<void> _onThemeModeChanged(
    ChangeThemeModeEvent event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(themeMode: event.themeMode));
  }

  FutureOr<void> _onConnectivityResultChanged(
    ChangeConnectivityResultEvent event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(connectivityResult: event.connectivityResult));
  }

  FutureOr<void> _onLocaleChanged(
    ChangeLocaleEvent event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(locale: Locale(event.languageCode)));
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
