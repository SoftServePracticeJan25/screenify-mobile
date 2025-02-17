import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/domain/entities/session.dart';
import 'package:screenify/features/movie/domain/repository/session_repository.dart';
import 'package:screenify/features/movie/domain/usecases/get_sessions_by_movie_id_usecase.dart';

part 'session_event.dart';

part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final SessionRepository _sessionRepository = GetIt.I<SessionRepository>();

  SessionBloc() : super(const SessionInitial()) {
    on<GetSessionsByMovieIdEvent>(_onGetSessionsByMovieId);
  }

  FutureOr<void> _onGetSessionsByMovieId(
    GetSessionsByMovieIdEvent event,
    Emitter<SessionState> emit,
  ) async {
    emit(const SessionLoading());
    final useCase =
        GetSessionsByMovieIdUseCase(sessionRepository: _sessionRepository);
    final response = await useCase(
      param: GetSessionsByMovieIdUseCaseParam(movieId: event.movieId),
    );
    if (response is DataSuccess) {
      emit(SessionLoaded(sessions: response.data!));
    } else {
      emit(SessionFailed(message: response.message ?? "Unknown bloc error"));
    }
  }
}
