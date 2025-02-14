part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object> get props => [];
}

final class AuthLoading extends AuthState {
  const AuthLoading();

  @override
  List<Object?> get props => [];
}

final class AuthFailed extends AuthState {
  final String message;

  const AuthFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

final class AuthLoaded extends AuthState {
  final UserInfo userInfo;

  const AuthLoaded({required this.userInfo});

  AuthLoaded copyWith({UserInfo? userInfo}) {
    return AuthLoaded(userInfo: userInfo ?? this.userInfo);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthLoaded && other.userInfo == userInfo);

  @override
  int get hashCode => Object.hashAll([userInfo]);

  @override
  List<Object?> get props => [userInfo];
}
