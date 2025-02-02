import 'package:equatable/equatable.dart';

class RegisterRequest extends Equatable {
  final String username;
  final String email;
  final String password;

  const RegisterRequest({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password, email];
}
