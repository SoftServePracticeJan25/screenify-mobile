import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/core/usecase/usecase.dart';
import 'package:screenify/features/movie/domain/entities/session.dart';
import 'package:screenify/features/movie/domain/repository/session_repository.dart';

class GetSessionsByMovieIdUseCase
    implements
        UseCase<Future<DataState<List<Session>>>,
            GetSessionsByMovieIdUseCaseParam> {
  final SessionRepository sessionRepository;

  const GetSessionsByMovieIdUseCase({required this.sessionRepository});

  @override
  Future<DataState<List<Session>>> call({
    required GetSessionsByMovieIdUseCaseParam param,
  }) async {
    return await sessionRepository.getSessionsByMovieId(param.movieId);
  }
}

interface class GetSessionsByMovieIdUseCaseParam {
  final int movieId;

  GetSessionsByMovieIdUseCaseParam({required this.movieId});
}
