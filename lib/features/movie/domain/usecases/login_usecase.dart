import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/core/usecase/usecase.dart';
import 'package:screenify/features/movie/domain/entities/auth_response.dart';
import 'package:screenify/features/movie/domain/entities/login_request.dart';
import 'package:screenify/features/movie/domain/repository/auth_repository.dart';

class LoginUseCase
    implements UseCase<Future<DataState<AuthResponse>>, LoginUseCaseParam> {
  final AuthRepository authRepository;

  const LoginUseCase({required this.authRepository});

  @override
  Future<DataState<AuthResponse>> call({
    required LoginUseCaseParam param,
  }) async {
    return await authRepository.login(
      LoginRequest(
        username: param.username,
        password: param.password,
      ),
    );
  }
}

interface class LoginUseCaseParam {
  final String username;
  final String password;

  const LoginUseCaseParam({required this.username, required this.password});
}
