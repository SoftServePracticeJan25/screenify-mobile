import 'package:equatable/equatable.dart';

class UserInfoModel extends Equatable {
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final int reviewCount;
  final int transactionCount;

  const UserInfoModel({
    required this.id,
    required this.username,
    required this.email,
    required this.photoUrl,
    required this.reviewCount,
    required this.transactionCount,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      photoUrl: json["photoUrl"] as String,
      reviewCount: json["reviewCount"] as int,
      transactionCount: json['transactionCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'photoUrl': photoUrl,
      'reviewCount': reviewCount,
      'transactionCount': transactionCount,
    };
  }

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        photoUrl,
        reviewCount,
        transactionCount,
      ];
}
