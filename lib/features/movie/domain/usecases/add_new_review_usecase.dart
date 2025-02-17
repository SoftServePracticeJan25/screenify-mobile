import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/core/usecase/usecase.dart';
import 'package:screenify/features/movie/domain/entities/review.dart';
import 'package:screenify/features/movie/domain/repository/review_repository.dart';

class AddNewReviewUseCase
    implements UseCase<Future<DataState>, AddNewReviewUseCaseParam> {
  final ReviewRepository reviewRepository;

  AddNewReviewUseCase({required this.reviewRepository});

  @override
  Future<DataState> call({required AddNewReviewUseCaseParam param}) async {
    return await reviewRepository.addNewReview(param.review);
  }
}

interface class AddNewReviewUseCaseParam {
  final Review review;

  AddNewReviewUseCaseParam({required this.review});
}
