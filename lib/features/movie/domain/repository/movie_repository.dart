import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<DataState<List<Movie>>> getAllMovies();

  Future<DataState<List<Movie>>> getRecommendedMovies();
}
