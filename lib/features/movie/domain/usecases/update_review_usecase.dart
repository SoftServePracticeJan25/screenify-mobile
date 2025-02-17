import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/core/usecase/usecase.dart';
import 'package:screenify/features/movie/domain/repository/review_repository.dart';

class UpdateReviewUseCase
    implements UseCase<Future<DataState>, UpdateReviewUseCaseParam> {
  final ReviewRepository reviewRepository;

  UpdateReviewUseCase({required this.reviewRepository});

  @override
  Future<DataState> call({required UpdateReviewUseCaseParam param}) async {
    return await reviewRepository.updateReview(
      param.rating,
      param.comment,
      param.reviewId,
    );
  }
}

interface class UpdateReviewUseCaseParam {
  final int? rating;
  final String? comment;
  final int reviewId;

  UpdateReviewUseCaseParam({
    required this.reviewId,
    this.rating,
    this.comment,
  });
}
