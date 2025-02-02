import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/core/usecase/usecase.dart';
import 'package:screenify/features/movie/domain/entities/auth_response.dart';
import 'package:screenify/features/movie/domain/entities/register_request.dart';
import 'package:screenify/features/movie/domain/repository/auth_repository.dart';

class LoginUseCase
    implements UseCase<Future<DataState<AuthResponse>>, RegisterUseCaseParam> {
  final AuthRepository authRepository;

  const LoginUseCase({required this.authRepository});

  @override
  Future<DataState<AuthResponse>> call({
    required RegisterUseCaseParam param,
  }) async {
    return await authRepository.register(
      RegisterRequest(
        email: param.email,
        username: param.username,
        password: param.password,
      ),
    );
  }
}

interface class RegisterUseCaseParam {
  final String username;
  final String password;
  final String email;

  const RegisterUseCaseParam({
    required this.username,
    required this.password,
    required this.email,
  });
}
