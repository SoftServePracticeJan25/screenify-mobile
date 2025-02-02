import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/domain/entities/auth_response.dart';
import 'package:screenify/features/movie/domain/entities/login_request.dart';
import 'package:screenify/features/movie/domain/entities/register_request.dart';
import 'package:screenify/features/movie/domain/entities/user_info.dart';

abstract class AuthRepository {
  Future<DataState<AuthResponse>> login(LoginRequest loginRequest);

  Future<DataState<AuthResponse>> register(RegisterRequest registerRequest);

  Future<DataState<AuthResponse>> refreshToken(String refreshToken);

  Future<DataState<UserInfo>> getUserInfo(String refreshToken);
}
