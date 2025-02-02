import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/core/usecase/usecase.dart';
import 'package:screenify/features/movie/domain/entities/auth_response.dart';
import 'package:screenify/features/movie/domain/repository/auth_repository.dart';

class RefreshTokenUseCase
    implements
        UseCase<Future<DataState<AuthResponse>>, RefreshTokenUseCaseParam> {
  final AuthRepository authRepository;

  const RefreshTokenUseCase({required this.authRepository});

  @override
  Future<DataState<AuthResponse>> call({
    required RefreshTokenUseCaseParam param,
  }) async {
    return await authRepository.refreshToken(param.refreshToken);
  }
}

interface class RefreshTokenUseCaseParam {
  final String refreshToken;

  const RefreshTokenUseCaseParam({required this.refreshToken});
}
