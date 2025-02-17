import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/domain/entities/review.dart';
import 'package:screenify/features/movie/domain/repository/review_repository.dart';
import 'package:screenify/features/movie/domain/usecases/add_new_review_usecase.dart';
import 'package:screenify/features/movie/domain/usecases/delete_review_usecase.dart';
import 'package:screenify/features/movie/domain/usecases/get_reviews_by_movie_id_usecase.dart';
import 'package:screenify/features/movie/domain/usecases/update_review_usecase.dart';

part 'review_event.dart';

part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository _reviewRepository = GetIt.I<ReviewRepository>();

  ReviewBloc() : super(const ReviewInitial()) {
    on<GetReviewsByMovieIdEvent>(_onGetReviewsByMovie);
    on<UpdateReviewEvent>(_onUpdateReview);
    on<AddNewReviewEvent>(_onAddNewReview);
    on<DeleteReviewEvent>(_onDeleteReview);
  }

  FutureOr<void> _onDeleteReview(
    DeleteReviewEvent event,
    Emitter<ReviewState> emit,
  ) async {
    final reviewsList = (state as ReviewLoaded).reviews;
    emit(const ReviewLoading());
    final useCase = DeleteReviewUseCase(reviewRepository: _reviewRepository);
    final response = await useCase(
      param: DeleteReviewUseCaseParam(reviewId: event.reviewId),
    );
    if (response is DataFailure) {
      emit(ReviewFailed(message: response.message ?? "Unknown bloc message"));
      emit(ReviewLoaded(reviews: reviewsList));
    } else {
      final updatedList =
          reviewsList.where((e) => e.id != event.reviewId).toList();
      emit(ReviewLoaded(reviews: updatedList));
    }
  }

  FutureOr<void> _onAddNewReview(
    AddNewReviewEvent event,
    Emitter<ReviewState> emit,
  ) async {
    final useCase = AddNewReviewUseCase(reviewRepository: _reviewRepository);
    final response =
        await useCase(param: AddNewReviewUseCaseParam(review: event.review));
    if (response is DataFailure) {
      emit(ReviewFailed(message: response.message ?? "Unknown bloc message"));
    }
    add(GetReviewsByMovieIdEvent(movieId: event.review.movieId));
  }

  FutureOr<void> _onGetReviewsByMovie(
    GetReviewsByMovieIdEvent event,
    Emitter<ReviewState> emit,
  ) async {
    emit(const ReviewLoading());
    final useCase =
        GetReviewsByMovieIdUseCase(reviewRepository: _reviewRepository);
    final response = await useCase(
      param: GetReviewsByMovieIdUseCaseParam(movieId: event.movieId),
    );
    if (response is DataSuccess) {
      emit(ReviewLoaded(reviews: response.data!));
    } else {
      emit(ReviewFailed(message: response.message ?? "Unknown bloc error"));
    }
  }

  FutureOr<void> _onUpdateReview(
    UpdateReviewEvent event,
    Emitter<ReviewState> emit,
  ) async {
    final reviewsList = (state as ReviewLoaded).reviews;
    final useCase = UpdateReviewUseCase(reviewRepository: _reviewRepository);
    final response = await useCase(
      param: UpdateReviewUseCaseParam(
        reviewId: event.reviewId,
        comment: event.comment,
        rating: event.rating,
      ),
    );
    if (response is DataSuccess) {
      final updatedReviews = reviewsList.map((review) {
        if (review.id == event.reviewId) {
          return Review(
            id: review.id,
            rating: event.rating ?? review.rating,
            comment: event.comment ?? review.comment,
            createdAt: review.createdAt,
            movieId: review.movieId,
            madeBy: review.madeBy,
            photoUrl: review.photoUrl,
            appUserId: review.appUserId,
          );
        }
        return review;
      }).toList();
      emit(ReviewLoaded(reviews: updatedReviews));
    } else {
      emit(ReviewFailed(message: response.message ?? "Unknown bloc error"));
      emit(ReviewLoaded(reviews: reviewsList));
    }
  }
}
