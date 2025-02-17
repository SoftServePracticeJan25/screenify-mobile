import 'dart:convert';

import 'package:http/http.dart';
import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/data/mappers/review_mapper.dart';
import 'package:screenify/features/movie/data/models/review_model.dart';
import 'package:screenify/features/movie/data/services/secure_storage_service.dart';
import 'package:screenify/features/movie/domain/entities/review.dart';
import 'package:screenify/features/movie/domain/repository/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final Client client;

  const ReviewRepositoryImpl({required this.client});

  static const String _baseUrl = String.fromEnvironment('BASE_URL');
  final String _reviewUrl = "$_baseUrl/api/review";

  @override
  Future<DataState> addNewReview(Review review) async {
    try {
      final service = SecureStorageService();
      final token = await service.readToken();
      final url = Uri.parse(_reviewUrl);
      final response = await client.post(
        url,
        body: json.encode(
          ReviewMapper.toModel(review).toJson(),
        ),
        headers: {
          "Authorization": "Bearer ${token!}",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        return const DataSuccess(null);
      } else if (response.statusCode == 400) {
        final message = response.body;
        return DataFailure(message);
      } else {
        return DataFailure(response.reasonPhrase ?? "Unknown error");
      }
    } catch (e) {
      return DataFailure(e.toString());
    }
  }

  @override
  Future<DataState<List<Review>>> getReviewsByMovieId(int movieId) async {
    try {
      final url = Uri.parse(_reviewUrl).replace(
        queryParameters: {
          'movieId': movieId.toString(),
        },
      );
      final response = await client.get(url);
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        final reviewList =
            ReviewModel.fromJsonList(jsonDecode(response.body) as List<dynamic>)
                .map((e) => ReviewMapper.toEntity(e))
                .toList();
        return DataSuccess(reviewList);
      } else {
        return DataFailure(response.reasonPhrase ?? "Unknown error");
      }
    } catch (e) {
      return DataFailure(e.toString());
    }
  }

  @override
  Future<DataState> updateReview(
    int? rating,
    String? comment,
    int reviewId,
  ) async {
    try {
      final service = SecureStorageService();
      final token = await service.readToken();
      final url = Uri.parse("$_reviewUrl/$reviewId");
      final Map<String, dynamic> body = {};
      if (rating != null) body["rating"] = rating;
      if (comment != null) body["comment"] = comment;
      final response = await client.put(
        url,
        headers: {
          "Authorization": "Bearer ${token!}",
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        return const DataSuccess(null);
      } else {
        return DataFailure(response.reasonPhrase ?? "Unknown error");
      }
    } catch (e) {
      return DataFailure(e.toString());
    }
  }

  @override
  Future<DataState> deleteReview(int reviewId) async {
    try {
      final service = SecureStorageService();
      final token = await service.readToken();
      final url = Uri.parse("$_reviewUrl/$reviewId");
      final response = await client.delete(
        url,
        headers: {
          "Authorization": "Bearer ${token!}",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 204) {
        return const DataSuccess(null);
      } else {
        return DataFailure(response.reasonPhrase ?? "Unknown error");
      }
    } catch (e) {
      return DataFailure(e.toString());
    }
  }
}
