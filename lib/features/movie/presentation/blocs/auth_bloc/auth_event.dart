part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class RegisterEvent extends AuthEvent {
  final String username;
  final String password;
  final String email;

  const RegisterEvent({
    required this.username,
    required this.password,
    required this.email,
  });

  @override
  List<Object?> get props => [username, password, email];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  const LoginEvent({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}

class RefreshTokenEvent extends AuthEvent {
  final String refreshToken;

  const RefreshTokenEvent({required this.refreshToken});

  @override
  List<Object?> get props => [refreshToken];
}

class CheckEvent extends AuthEvent {
  const CheckEvent();

  @override
  List<Object?> get props => [];
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();

  @override
  List<Object?> get props => [];
}
