import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  final int id;
  final int rating;
  final String comment;
  final String createdAt;
  final int movieId;
  final String madeBy;
  final String photoUrl;
  final String appUserId;

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt: json['creationTime'],
      movieId: json['movieId'],
      madeBy: json['madeBy'],
      photoUrl: json['photoUrl'] ?? "",
      appUserId: json['appUserId'],
    );
  }

  static List<ReviewModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((a) => ReviewModel.fromJson(a)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "likes": 0,
      'id': id,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt,
      'movieId': movieId,
      'photoUrl': photoUrl,
      'appUserId': appUserId,
    };
  }

  const ReviewModel({
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
