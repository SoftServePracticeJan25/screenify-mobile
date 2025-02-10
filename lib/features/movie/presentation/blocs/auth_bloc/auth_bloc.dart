import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/data/services/secure_storage_service.dart';
import 'package:screenify/features/movie/domain/entities/login_request.dart';
import 'package:screenify/features/movie/domain/entities/register_request.dart';
import 'package:screenify/features/movie/domain/entities/user_info.dart';
import 'package:screenify/features/movie/domain/repository/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SecureStorageService secureStorageService =
      GetIt.I<SecureStorageService>();
  final AuthRepository authRepository = GetIt.I<AuthRepository>();

  AuthBloc() : super(const AuthInitial()) {
    on<CheckEvent>(_onChecked);
    on<RegisterEvent>(_onRegistered);
    on<LoginEvent>(_onLoggedIn);
    on<RefreshTokenEvent>(_onTokenRefreshed);
    on<LogoutEvent>(_onLoggedOut);
  }

  FutureOr<void> _onLoggedOut(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await secureStorageService.deleteTokens();
    emit(const AuthInitial());
  }

  FutureOr<void> _onChecked(CheckEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final String? token = await secureStorageService.readToken();
    final String? refreshToken = await secureStorageService.readRefreshToken();
    if (token != null && refreshToken != null) {
      try {
        add(RefreshTokenEvent(refreshToken: refreshToken));
      } catch (e) {
        await secureStorageService.deleteTokens();
        emit(const AuthInitial());
      }
    } else {
      emit(const AuthInitial());
    }
  }

  FutureOr<void> _onRegistered(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final authResponse = await authRepository.register(
        RegisterRequest(
          username: event.username,
          email: event.email,
          password: event.password,
        ),
      );
      if (authResponse is DataSuccess) {
        final authData = authResponse.data!;
        secureStorageService
          ..writeToken(authData.accessToken)
          ..writeRefreshToken(authData.refreshToken);
        final userInfo =
            await authRepository.getUserInfo(authData.accessToken);
        if (userInfo is DataSuccess) {
          emit(AuthLoaded(userInfo: userInfo.data!));
        } else {
          emit(AuthFailed(message: (userInfo as DataFailure).message!));
        }
      } else {
        emit(AuthFailed(message: (authResponse as DataFailure).message!));
      }
    } catch (e) {
      AuthFailed(message: e.toString());
    }
  }

  FutureOr<void> _onLoggedIn(LoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      final authResponse = await authRepository.login(
        LoginRequest(username: event.username, password: event.password),
      );
      if (authResponse is DataSuccess) {
        final authData = authResponse.data!;
        secureStorageService
          ..writeToken(authData.accessToken)
          ..writeRefreshToken(authData.refreshToken);

        final userInfo =
            await authRepository.getUserInfo(authData.accessToken);
        if (userInfo is DataSuccess) {
          emit(AuthLoaded(userInfo: userInfo.data!));
        } else {
          emit(AuthFailed(message: (userInfo as DataFailure).message!));
        }
      } else {
        emit(AuthFailed(message: (authResponse as DataFailure).message!));
      }
    } catch (e) {
      emit(AuthFailed(message: e.toString()));
    }
  }

  FutureOr<void> _onTokenRefreshed(
    RefreshTokenEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final authResponse =
          await authRepository.refreshToken(event.refreshToken);
      if (authResponse is DataSuccess) {
        final authData = authResponse.data!;
        secureStorageService
          ..writeToken(authData.accessToken)
          ..writeRefreshToken(authData.refreshToken);
        final userInfo =
            await authRepository.getUserInfo(authData.accessToken);
        if (userInfo is DataSuccess) {
          emit(AuthLoaded(userInfo: userInfo.data!));
        } else {
          emit(AuthFailed(message: (userInfo as DataFailure).message!));
        }
      } else {
        emit(AuthFailed(message: (authResponse as DataFailure).message!));
      }
    } catch (e) {
      emit(AuthFailed(message: e.toString()));
    }
  }
}
