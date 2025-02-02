import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  final String email;
  final String photoUrl;
  final String username;
  final String id;
  final int reviewCount;
  final int transactionCount;

  const UserInfo({
    required this.transactionCount,
    required this.reviewCount,
    required this.email,
    required this.photoUrl,
    required this.username,
    required this.id,
  });

  @override
  List<Object?> get props => [
        email,
        photoUrl,
        username,
        id,
        reviewCount,
        transactionCount,
      ];
}
