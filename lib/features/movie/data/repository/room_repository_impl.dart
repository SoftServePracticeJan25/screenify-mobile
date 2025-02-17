import 'dart:convert';

import 'package:http/http.dart';
import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/data/mappers/room_mapper.dart';
import 'package:screenify/features/movie/data/models/room_model.dart';
import 'package:screenify/features/movie/data/services/secure_storage_service.dart';
import 'package:screenify/features/movie/domain/entities/room.dart';
import 'package:screenify/features/movie/domain/repository/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final Client client;

  static const String _baseUrl = String.fromEnvironment('BASE_URL');
  final String _roomUrl = '$_baseUrl/api/rooms';

  const RoomRepositoryImpl({required this.client});

  @override
  Future<DataState<Room>> getById(int id) async {
    try {
      final service = SecureStorageService();
      final token = await service.readToken();
      final url = Uri.parse("$_roomUrl/$id");
      final response = await client.get(
            url,
            headers: {
              "Authorization": "Bearer ${token!}",
              "Content-Type": "application/json",
            },
          );
      if (response.statusCode >= 200 && response.statusCode <= 300) {
            final room = RoomMapper.toEntity(
              RoomModel.fromJson(
                jsonDecode(response.body) as Map<String, dynamic>,
              ),
            );
            return DataSuccess(room);
          } else{
            return DataFailure(response.reasonPhrase??"Unknown error");
          }
    } catch (e) {
      return DataFailure(e.toString());
    }
  }
}
