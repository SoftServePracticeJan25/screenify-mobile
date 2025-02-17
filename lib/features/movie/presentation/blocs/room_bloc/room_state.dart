part of 'room_bloc.dart';

sealed class RoomState extends Equatable {
  const RoomState();
}

final class RoomInitial extends RoomState {
  const RoomInitial();

  @override
  List<Object> get props => [];
}

final class RoomLoading extends RoomState {
  const RoomLoading();

  @override
  List<Object?> get props => [];
}

final class RoomFailed extends RoomState {
  final String message;

  const RoomFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

final class RoomLoaded extends RoomState {
  final Room room;

  const RoomLoaded({required this.room});

  @override
  List<Object?> get props => [room];
}
