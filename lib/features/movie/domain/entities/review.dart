import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final int id;
  final int rating;
  final String comment;
  final DateTime createdAt;
  final int movieId;
  final String madeBy;
  final String photoUrl;
  final String appUserId;

  const Review({
    required this.id,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.movieId,
    required this.madeBy,
    required this.photoUrl,
    required this.appUserId,
  });

  @override
  List<Object?> get props => [
        id,
        rating,
        comment,
        createdAt,
        movieId,
        madeBy,
        photoUrl,
        appUserId,
      ];
}
