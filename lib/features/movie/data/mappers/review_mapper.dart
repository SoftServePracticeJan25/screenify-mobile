import 'package:screenify/features/movie/data/models/review_model.dart';
import 'package:screenify/features/movie/domain/entities/review.dart';

class ReviewMapper {
  const ReviewMapper._();

  static Review toEntity(ReviewModel model) {
    return Review(
      id: model.id,
      rating: model.rating,
      comment: model.comment,
      createdAt: DateTime.parse(model.createdAt),
      movieId: model.movieId,
      madeBy: model.madeBy,
      photoUrl: model.photoUrl,
      appUserId: model.appUserId,
    );
  }

  static ReviewModel toModel(Review entity) {
    return ReviewModel(
      id: entity.id,
      rating: entity.rating,
      comment: entity.comment,
      createdAt: entity.createdAt.toIso8601String(),
      movieId: entity.movieId,
      madeBy: entity.madeBy,
      photoUrl: entity.photoUrl,
      appUserId: entity.appUserId,
    );
  }
}
