import 'package:equatable/equatable.dart';

class Room extends Equatable {
  final int roomId;
  final String name;
  final int seatsAmount;
  final String cinemaType;

  const Room({
    required this.roomId,
    required this.name,
    required this.seatsAmount,
    required this.cinemaType,
  });

  @override
  List<Object?> get props => [roomId, name, seatsAmount, cinemaType];
}
