part of 'session_bloc.dart';

sealed class SessionEvent extends Equatable {
  const SessionEvent();
}

class GetSessionsByMovieIdEvent extends SessionEvent {
  final int movieId;

  const GetSessionsByMovieIdEvent({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}
