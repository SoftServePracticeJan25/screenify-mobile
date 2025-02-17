part of 'review_bloc.dart';

sealed class ReviewState extends Equatable {
  const ReviewState();
}

final class ReviewInitial extends ReviewState {
  const ReviewInitial();

  @override
  List<Object> get props => [];
}

final class ReviewLoading extends ReviewState {
  const ReviewLoading();

  @override
  List<Object?> get props => [];
}

final class ReviewFailed extends ReviewState {
  final String message;

  const ReviewFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

final class ReviewLoaded extends ReviewState {
  final List<Review> reviews;

  const ReviewLoaded({required this.reviews});

  @override
  List<Object?> get props => [reviews];
}
