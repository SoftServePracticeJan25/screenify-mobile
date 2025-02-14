import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/core/usecase/usecase.dart';
import 'package:screenify/features/movie/domain/entities/movie.dart';
import 'package:screenify/features/movie/domain/repository/movie_repository.dart';

class GetAllMoviesUseCase
    implements
        UseCase<Future<DataState<List<Movie>>>, GetAllMoviesUseCaseParam> {

  final MovieRepository movieRepository;
  const GetAllMoviesUseCase({required this.movieRepository});
  @override
  Future<DataState<List<Movie>>> call({required param}) {
    return movieRepository.getAllMovies();
  }}

interface class GetAllMoviesUseCaseParam {}
