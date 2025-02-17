import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/core/usecase/usecase.dart';
import 'package:screenify/features/movie/domain/repository/review_repository.dart';

class DeleteReviewUseCase
    implements UseCase<Future<DataState>, DeleteReviewUseCaseParam> {
  final ReviewRepository reviewRepository;

  const DeleteReviewUseCase({required this.reviewRepository});

  @override
  Future<DataState> call({required DeleteReviewUseCaseParam param}) async {
    return await reviewRepository.deleteReview(param.reviewId);
  }
}

interface class DeleteReviewUseCaseParam {
  final int reviewId;

  const DeleteReviewUseCaseParam({required this.reviewId});
}
