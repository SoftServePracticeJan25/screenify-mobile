import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/domain/entities/room.dart';

abstract class RoomRepository {
  Future<DataState<Room>> getById(int id);
}
