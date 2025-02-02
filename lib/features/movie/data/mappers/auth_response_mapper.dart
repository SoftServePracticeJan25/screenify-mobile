import 'package:screenify/features/movie/data/models/auth_response_model.dart';
import 'package:screenify/features/movie/domain/entities/auth_response.dart';

class AuthResponseMapper {
  static AuthResponse toEntity(AuthResponseModel model) {
    return AuthResponse(
      accessToken: model.accessToken,
      refreshToken: model.refreshToken,
    );
  }

  static AuthResponseModel toModel(AuthResponse entity) {
    return AuthResponseModel(
      refreshToken: entity.refreshToken,
      accessToken: entity.accessToken,
    );
  }
}
