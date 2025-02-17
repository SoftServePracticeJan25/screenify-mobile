import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/data/services/secure_storage_service.dart';
import 'package:screenify/features/movie/domain/entities/login_request.dart';
import 'package:screenify/features/movie/domain/entities/register_request.dart';
import 'package:screenify/features/movie/domain/entities/user_info.dart';
import 'package:screenify/features/movie/domain/repository/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SecureStorageService _secureStorageService =
      GetIt.I<SecureStorageService>();
  final AuthRepository _authRepository = GetIt.I<AuthRepository>();

  AuthBloc() : super(const AuthInitial()) {
    on<UploadAvatarEvent>(_onAvatarUploaded);
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
    emit(const AuthLoading());
    await _secureStorageService.deleteTokens();
    emit(const AuthInitial());
  }

  FutureOr<void> _onChecked(CheckEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final String? token = await _secureStorageService.readToken();
    final String? refreshToken = await _secureStorageService.readRefreshToken();
    if (token != null && refreshToken != null) {
      try {
        add(RefreshTokenEvent(refreshToken: refreshToken));
      } catch (e) {
        await _secureStorageService.deleteTokens();
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
      final authResponse = await _authRepository.register(
        RegisterRequest(
          username: event.username,
          email: event.email,
          password: event.password,
        ),
      );
      if (authResponse is DataSuccess) {
        final authData = authResponse.data!;
        _secureStorageService
          ..writeToken(authData.accessToken)
          ..writeRefreshToken(authData.refreshToken);
        final userInfo = await _authRepository.getUserInfo(authData.accessToken);
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
      final authResponse = await _authRepository.login(
        LoginRequest(username: event.username, password: event.password),
      );
      if (authResponse is DataSuccess) {
        final authData = authResponse.data!;
        _secureStorageService
          ..writeToken(authData.accessToken)
          ..writeRefreshToken(authData.refreshToken);

        final userInfo = await _authRepository.getUserInfo(authData.accessToken);
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
          await _authRepository.refreshToken(event.refreshToken);
      if (authResponse is DataSuccess) {
        final authData = authResponse.data!;
        _secureStorageService
          ..writeToken(authData.accessToken)
          ..writeRefreshToken(authData.refreshToken);
        final userInfo = await _authRepository.getUserInfo(authData.accessToken);
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

  FutureOr<void> _onAvatarUploaded(
    UploadAvatarEvent event,
    Emitter<AuthState> emit,
  ) async {
    final userInfo = await _authRepository.uploadAvatar(event.file);
    if (userInfo is DataSuccess) {
      emit(AuthLoaded(userInfo: userInfo.data!));
    }
  }
}
