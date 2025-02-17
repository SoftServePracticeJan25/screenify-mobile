import 'package:equatable/equatable.dart';

class RoomModel extends Equatable {
  final int roomId;
  final String name;
  final int seatsAmount;
  final String cinemaType;

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      roomId: json['id'],
      name: json['name'],
      seatsAmount: json['seatsAmount'],
      cinemaType: json['cinemaTypeName'],
    );

  }

  const RoomModel({
    required this.roomId,
    required this.name,
    required this.seatsAmount,
    required this.cinemaType,
  });

  @override
  List<Object?> get props => [roomId, name, seatsAmount, cinemaType];
}
