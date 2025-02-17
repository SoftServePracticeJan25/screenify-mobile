import 'package:screenify/features/movie/data/models/ticket_model.dart';
import 'package:screenify/features/movie/domain/entities/ticket.dart';

class TicketMapper {
  const TicketMapper._();

  static Ticket toEntity(TicketModel model) {
    return Ticket(
      id: model.id,
      seatNum: model.seatNum,
      transactionId: model.transactionId,
      sessionId: model.sessionId,
      userId: model.userId,
      transactionTime: DateTime.parse(model.transactionTime),
      startTime: DateTime.parse(model.startTime),
      duration: Duration(minutes: model.duration),
      movieId: model.movieId,
      title: model.title,
      price: model.price.toInt(),
      roomName: model.roomName,
    );
  }

  static TicketModel toModel(Ticket entity) {
    return TicketModel(
      id: entity.id,
      seatNum: entity.seatNum,
      transactionId: entity.transactionId,
      sessionId: entity.sessionId,
      userId: entity.userId,
      transactionTime: entity.transactionTime.toIso8601String(),
      startTime: entity.startTime.toIso8601String(),
      duration: entity.duration.inMinutes,
      movieId: entity.movieId,
      title: entity.title,
      price: entity.price.toDouble(),
      roomName: entity.roomName,
    );
  }
}
