import 'package:equatable/equatable.dart';

class TicketModel extends Equatable {
  final int id;
  final int seatNum;
  final int transactionId;
  final int sessionId;
  final String userId;
  final String transactionTime;
  final String startTime;
  final int duration;
  final int movieId;
  final String title;
  final double price;
  final String roomName;
  final String posterUrl;

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      posterUrl: json['posterUrl'],
      id: json['id'],
      seatNum: json['seatNum'],
      transactionId: json['transactionId'],
      sessionId: json['sessionId'],
      userId: json['userId'],
      duration: json['duration'],
      transactionTime: json['transactionTime'],
      startTime: json['startTime'],
      movieId: json['movieId'],
      title: json['title'],
      price: json['price'],
      roomName: json['roomName'],
    );
  }

  const TicketModel({
    required this.posterUrl,
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

  static List<TicketModel> toJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => TicketModel.fromJson(e)).toList();
  }

  @override
  List<Object?> get props => [
        id,
        seatNum,
        transactionId,
        sessionId,
        userId,
        movieId,
        posterUrl,
        title,
        price,
        roomName,
        duration,
        startTime,
        transactionTime,
      ];
}
