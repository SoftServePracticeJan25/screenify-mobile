import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/data/mappers/auth_response_mapper.dart';
import 'package:screenify/features/movie/data/mappers/login_request_mapper.dart';
import 'package:screenify/features/movie/data/mappers/register_request_mapper.dart';
import 'package:screenify/features/movie/data/mappers/user_info_mapper.dart';
import 'package:screenify/features/movie/data/models/auth_error_model.dart';
import 'package:screenify/features/movie/data/models/auth_response_model.dart';
import 'package:screenify/features/movie/data/models/user_info_model.dart';
import 'package:screenify/features/movie/data/services/secure_storage_service.dart';
import 'package:screenify/features/movie/domain/entities/auth_response.dart';
import 'package:screenify/features/movie/domain/entities/login_request.dart';
import 'package:screenify/features/movie/domain/entities/register_request.dart';
import 'package:screenify/features/movie/domain/entities/user_info.dart';
import 'package:screenify/features/movie/domain/repository/auth_repository.dart';
import "package:http_parser/http_parser.dart" show MediaType;


class AuthRepositoryImpl implements AuthRepository {
  final Client client;

  const AuthRepositoryImpl({required this.client});

  static const String _baseUrl = String.fromEnvironment('BASE_URL');
  final _authUrl = '$_baseUrl/api/account';

  @override
  Future<DataState<AuthResponse>> login(LoginRequest loginRequest) async {
    try {
      final response = await client.post(
        Uri.parse("$_authUrl/login"),
        body: jsonEncode(
          LoginRequestMapper.toModel(loginRequest).toJson(),
        ),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return DataSuccess(
          AuthResponseMapper.toEntity(AuthResponseModel.fromJson(jsonData)),
        );
      } else if (response.statusCode == 401) {
        return DataFailure(AuthErrorModel.fromJson(response.body).error);
      } else {
        return DataFailure(response.reasonPhrase ?? "Unknown error");
      }
    } catch (e) {
      return DataFailure(e.toString());
    }
  }

  @override
  Future<DataState<AuthResponse>> refreshToken(String refreshToken) async {
    try {
      final response = await client.post(
        Uri.parse("$_authUrl/refresh-token"),
        body: jsonEncode(
          {
            'refreshToken': refreshToken,
          },
        ),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return DataSuccess(
          AuthResponseMapper.toEntity(AuthResponseModel.fromJson(jsonData)),
        );
      } else {
        return DataFailure(response.reasonPhrase ?? "Unknown error");
      }
    } catch (e) {
      return DataFailure(e.toString());
    }
  }

  @override
  Future<DataState<AuthResponse>> register(
    RegisterRequest registerRequest,
  ) async {
    try {
      final response = await client.post(
        Uri.parse("$_authUrl/register"),
        body: jsonEncode(
          RegisterRequestMapper.toModel(registerRequest).toJson(),
        ),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return DataSuccess(
          AuthResponseMapper.toEntity(AuthResponseModel.fromJson(jsonData)),
        );
      } else if (response.statusCode == 400) {
        return DataFailure(AuthErrorModel.fromJson(response.body).error);
      } else {
        return DataFailure(response.reasonPhrase ?? "Unknown error");
      }
    } catch (e) {
      return DataFailure(e.toString());
    }
  }

  @override
  Future<DataState<UserInfo>> getUserInfo(String refreshToken) async {
    try {
      final response = await client.get(
        Uri.parse('$_authUrl/user-info'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $refreshToken',
        },
      );
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        return DataSuccess(
          UserInfoMapper.toEntity(
            UserInfoModel.fromJson(jsonDecode(response.body)),
          ),
        );
      } else {
        return DataFailure(response.reasonPhrase ?? "Unknown error");
      }
    } catch (e) {
      return DataFailure(e.toString());
    }
  }

  @override
  Future<DataState<UserInfo>> uploadAvatar(XFile file) async {
    try {
      final url = Uri.parse("$_baseUrl/api/user/upload-avatar");
      final service = SecureStorageService();
      final token = await service.readToken();
      MultipartRequest request = MultipartRequest(
        "POST",
        url,
      );
      final Uint8List bytes = await file.readAsBytes();
      final myFile = MultipartFile(
        "file",
        ByteStream.fromBytes(bytes),
        bytes.length,
        filename: file.name,
        contentType: MediaType("image", "png"),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(myFile);
      final responses = await request.send();
      if (responses.statusCode >= 200 && responses.statusCode <= 300) {
        final response = await Response.fromStream(responses);
        return DataSuccess(
          UserInfoMapper.toEntity(
            UserInfoModel.fromJson(jsonDecode(response.body)),
          ),
        );
      } else {
        return DataFailure(responses.reasonPhrase ?? "Unknown error");
      }
    } catch (e) {
      return DataFailure(e.toString());
    }
  }
}
