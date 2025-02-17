import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/core/usecase/usecase.dart';
import 'package:screenify/features/movie/domain/entities/review.dart';
import 'package:screenify/features/movie/domain/repository/review_repository.dart';

class GetReviewsByMovieIdUseCase
    implements
        UseCase<Future<DataState<List<Review>>>,
            GetReviewsByMovieIdUseCaseParam> {
  final ReviewRepository reviewRepository;

  GetReviewsByMovieIdUseCase({required this.reviewRepository});

  @override
  Future<DataState<List<Review>>> call({
    required GetReviewsByMovieIdUseCaseParam param,
  }) async {
    return await reviewRepository.getReviewsByMovieId(param.movieId);
  }
}

interface class GetReviewsByMovieIdUseCaseParam {
  final int movieId;

  GetReviewsByMovieIdUseCaseParam({required this.movieId});
}
