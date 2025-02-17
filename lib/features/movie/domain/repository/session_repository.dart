import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/domain/entities/session.dart';

abstract class SessionRepository {
  Future<DataState<List<Session>>> getSessionsByMovieId(int movieId);
}
