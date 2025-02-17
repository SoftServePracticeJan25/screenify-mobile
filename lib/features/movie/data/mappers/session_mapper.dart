import 'package:screenify/features/movie/data/models/session_model.dart';
import 'package:screenify/features/movie/domain/entities/session.dart';

class SessionMapper {
  const SessionMapper._();

  static Session toEntity(SessionModel model) {
    return Session(
      id: int.parse(model.id),
      startTime: DateTime.parse(model.startTime),
      price: model.price,
      movieId: model.movieId,
      roomName: model.roomName,
      roomId: model.roomId,
    );
  }

  static SessionModel toModel(Session entity) {
    return SessionModel(
      id: entity.id.toString(),
      startTime: entity.startTime.toIso8601String(),
      price: entity.price,
      movieId: entity.movieId,
      roomName: entity.roomName,
      roomId: entity.roomId,
    );
  }
}
