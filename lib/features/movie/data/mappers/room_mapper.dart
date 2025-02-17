import 'package:screenify/features/movie/data/models/room_model.dart';
import 'package:screenify/features/movie/domain/entities/room.dart';

class RoomMapper {
  const RoomMapper._();

  static Room toEntity(RoomModel model) {
    return Room(
      roomId: model.roomId,
      name: model.name,
      seatsAmount: model.seatsAmount,
      cinemaType: model.cinemaType,
    );
  }

  static RoomModel toModel(Room entity) {
    return RoomModel(
      roomId: entity.roomId,
      name: entity.name,
      seatsAmount: entity.seatsAmount,
      cinemaType: entity.cinemaType,
    );
  }
}
