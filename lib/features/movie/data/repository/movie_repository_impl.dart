import 'dart:convert';

import 'package:http/http.dart';
import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/data/mappers/movie_mapper.dart';
import 'package:screenify/features/movie/data/models/movie_model.dart';
import 'package:screenify/features/movie/data/services/secure_storage_service.dart';
import 'package:screenify/features/movie/domain/entities/movie.dart';
import 'package:screenify/features/movie/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final Client client;

  const MovieRepositoryImpl({required this.client});

  static const String _baseUrl = String.fromEnvironment('BASE_URL');
  final _movieUrl = '$_baseUrl/api/movies';

  @override
  Future<DataState<List<Movie>>> getAllMovies() async {
    try {
      final url = Uri.parse(_movieUrl);
      final response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        return DataSuccess(
          MovieModel.fromJsonList(jsonData)
              .map((e) => MovieMapper.toEntity(e))
              .toList(),
        );
      } else {
        return DataFailure(response.reasonPhrase ?? "Unknown error");
      }
    } catch (e) {
      return DataFailure(e.toString());
    }
  }

  @override
  Future<DataState<List<Movie>>> getRecommendedMovies() async {

    try {
      final service = SecureStorageService();
      final token = await service.readToken();
      final url = Uri.parse("$_movieUrl/recommended");
      final response = await client.get(

        url,
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        return DataSuccess(
          MovieModel.fromJsonList(jsonData)
              .map((e) => MovieMapper.toEntity(e))
              .toList(),
        );
      } else {
        return DataFailure(response.reasonPhrase ?? "Unknown error");
      }
    } catch (e) {
      return DataFailure(e.toString());
    }
  }
}
