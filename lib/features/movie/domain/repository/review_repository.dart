import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/domain/entities/review.dart';

abstract class ReviewRepository{
  Future<DataState<List<Review>>> getReviewsByMovieId(int movieId);

  Future<DataState> addNewReview(Review review);

  Future<DataState> updateReview(int? rating, String? comment, int reviewId);


  Future<DataState> deleteReview(int reviewId);
}