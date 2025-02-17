import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
  final int id;
  final int seatNum;
  final int transactionId;
  final int sessionId;
  final String userId;
  final DateTime transactionTime;
  final DateTime startTime;
  final Duration duration;
  final int movieId;
  final String title;
  final int price;
  final String roomName;

  const Ticket({
    required this.id,
    required this.seatNum,
    required this.transactionId,
    required this.sessionId,
    required this.userId,
    required this.transactionTime,
    required this.startTime,
    required this.duration,
    required this.movieId,
    required this.title,
    required this.price,
    required this.roomName,
  });

  @override
  List<Object?> get props => [
        id,
        seatNum,
        transactionId,
        sessionId,
        transactionId,
        userId,
        startTime,
        duration,
        transactionTime,
        movieId,
        title,
        price,
        roomName,
      ];
}
