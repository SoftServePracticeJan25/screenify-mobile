part of 'room_bloc.dart';

sealed class RoomEvent extends Equatable {
  const RoomEvent();
}

class GetRoomByIdEvent extends RoomEvent {
  final int roomId;

  const GetRoomByIdEvent({required this.roomId});

  @override
  List<Object?> get props => [roomId];
}
