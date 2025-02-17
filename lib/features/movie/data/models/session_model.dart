import 'package:equatable/equatable.dart';

class SessionModel extends Equatable {
  final String id;
  final String startTime;
  final double price;
  final int movieId;
  final String roomName;
  final int roomId;

  const SessionModel({
    required this.id,
    required this.startTime,
    required this.price,
    required this.movieId,
    required this.roomName,
    required this.roomId,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'] as String,
      startTime: json['startTime'],
      price: json['price'],
      movieId: json['movieId'],
      roomName: json['roomName'] ?? "",
      roomId: json['roomId'],
    );
  }

  static List<SessionModel> fromJsonList(List<dynamic> json) {
    return json.map((e) => SessionModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'price': price,
      'movieId': movieId,
      'roomName': roomName,
      'roomId': roomId,
    };
  }

  @override
  List<Object?> get props => [startTime, price, movieId, roomName, roomId];
}
