import 'dart:convert';

import 'package:http/http.dart';
import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/data/mappers/session_mapper.dart';
import 'package:screenify/features/movie/data/models/session_model.dart';
import 'package:screenify/features/movie/data/services/secure_storage_service.dart';
import 'package:screenify/features/movie/domain/entities/session.dart';
import 'package:screenify/features/movie/domain/repository/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  final Client client;

  static const String _baseUrl = String.fromEnvironment('BASE_URL');
  final String _sessionUrl = '$_baseUrl/api/session';

  const SessionRepositoryImpl({required this.client});

  @override
  Future<DataState<List<Session>>> getSessionsByMovieId(int movieId) async {
    try {
      final service = SecureStorageService();
      final token = await service.readToken();
      final url = Uri.parse(_sessionUrl).replace(
        queryParameters: {
          'movieId': movieId.toString(),
        },
      );
      final response = await client.get(
        url,
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        final sessionList = SessionModel.fromJsonList(
          jsonDecode(response.body) as List<dynamic>,
        ).map((e) => SessionMapper.toEntity(e)).toList();
        return DataSuccess(sessionList);
      } else {
        return DataFailure(response.reasonPhrase ?? "Unknown error");
      }
    } catch (e) {
      return DataFailure(e.toString());
    }
  }
}
