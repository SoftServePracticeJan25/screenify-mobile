import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/core/usecase/usecase.dart';
import 'package:screenify/features/movie/domain/entities/movie.dart';
import 'package:screenify/features/movie/domain/repository/movie_repository.dart';

class GetRecommendedMoviesUseCase
    implements
        UseCase<Future<DataState<List<Movie>>>,
            GetRecommendedMoviesUseCaseParam> {
  final MovieRepository movieRepository;

  const GetRecommendedMoviesUseCase({required this.movieRepository});

  @override
  Future<DataState<List<Movie>>> call(
      {required GetRecommendedMoviesUseCaseParam param}) {
    return movieRepository.getRecommendedMovies();
  }
}

interface class GetRecommendedMoviesUseCaseParam {}
