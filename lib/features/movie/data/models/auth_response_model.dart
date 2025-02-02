import 'package:equatable/equatable.dart';

class AuthResponseModel extends Equatable {
  final String accessToken;
  final String refreshToken;

  const AuthResponseModel({
    required this.refreshToken,
    required this.accessToken,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      refreshToken: json['refreshToken'],
      accessToken: json['accessToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refreshToken': refreshToken,
      'accessToken': accessToken,
    };
  }

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
