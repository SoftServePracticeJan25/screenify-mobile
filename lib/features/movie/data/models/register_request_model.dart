import 'package:equatable/equatable.dart';

class RegisterRequestModel extends Equatable {
  final String username;
  final String email;
  final String password;

  const RegisterRequestModel({
    required this.username,
    required this.password,
    required this.email,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    return RegisterRequestModel(
      email: json['email'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'password': password,
    };
  }

  @override
  List<Object?> get props => [username, password];
}
