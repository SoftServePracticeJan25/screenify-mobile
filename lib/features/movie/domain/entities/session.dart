import 'package:equatable/equatable.dart';

class Session extends Equatable {
  final int id;
  final DateTime startTime;
  final double price;
  final int movieId;
  final String roomName;
  final int roomId;

  const Session({
    required this.id,
    required this.startTime,
    required this.price,
    required this.movieId,
    required this.roomName,
    required this.roomId,
  });

  @override
  List<Object?> get props => [startTime, price, movieId, roomName, roomId];
}
