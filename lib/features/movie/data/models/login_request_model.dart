import 'package:equatable/equatable.dart';

class LoginRequestModel extends Equatable {
  final String username;
  final String password;

  const LoginRequestModel({required this.username, required this.password});

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      username: json['userName'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': username,
      'password': password,
    };
  }

  @override
  List<Object?> get props => [username, password];
}
