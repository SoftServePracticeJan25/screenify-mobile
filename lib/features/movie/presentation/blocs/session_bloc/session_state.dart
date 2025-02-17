part of 'session_bloc.dart';

sealed class SessionState extends Equatable {
  const SessionState();
}

final class SessionInitial extends SessionState {
  const SessionInitial();

  @override
  List<Object> get props => [];
}

final class SessionLoading extends SessionState {
  const SessionLoading();

  @override
  List<Object?> get props => [];
}

final class SessionLoaded extends SessionState {
  final List<Session> sessions;

  const SessionLoaded({required this.sessions});

  @override
  List<Object?> get props => [sessions];
}

final class SessionFailed extends SessionState {
  final String message;

  const SessionFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
