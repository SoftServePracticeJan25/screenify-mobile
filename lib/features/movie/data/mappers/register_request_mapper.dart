import 'package:screenify/features/movie/data/models/register_request_model.dart';
import 'package:screenify/features/movie/domain/entities/register_request.dart';

class RegisterRequestMapper {
  static RegisterRequest toEntity(RegisterRequestModel model) {
    return RegisterRequest(
      username: model.username,
      email: model.email,
      password: model.password,
    );
  }

  static RegisterRequestModel toModel(RegisterRequest entity) {
    return RegisterRequestModel(
      username: entity.username,
      password: entity.password,
      email: entity.email,
    );
  }
}
