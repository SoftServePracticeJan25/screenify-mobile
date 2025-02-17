part of 'review_bloc.dart';

sealed class ReviewEvent extends Equatable {
  const ReviewEvent();
}

class GetReviewsByMovieIdEvent extends ReviewEvent {
  final int movieId;

  const GetReviewsByMovieIdEvent({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}

class UpdateReviewEvent extends ReviewEvent {
  final int? rating;
  final String? comment;
  final int reviewId;

  const UpdateReviewEvent({required this.reviewId, this.rating, this.comment});

  @override
  List<Object?> get props => [rating, comment, reviewId];
}

class AddNewReviewEvent extends ReviewEvent {
  final Review review;

  const AddNewReviewEvent({required this.review});

  @override
  List<Object?> get props => [review];
}

class DeleteReviewEvent extends ReviewEvent {
  final int reviewId;

  const DeleteReviewEvent({required this.reviewId});

  @override
  List<Object?> get props => [];
}
