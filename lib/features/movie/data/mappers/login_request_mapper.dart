import 'package:screenify/features/movie/data/models/login_request_model.dart';
import 'package:screenify/features/movie/domain/entities/login_request.dart';

class LoginRequestMapper {
  static LoginRequest toEntity(LoginRequestModel model) {
    return LoginRequest(
      username: model.username,
      password: model.password,
    );
  }

  static LoginRequestModel toModel(LoginRequest entity) {
    return LoginRequestModel(
      username: entity.username,
      password: entity.password,
    );
  }
}
