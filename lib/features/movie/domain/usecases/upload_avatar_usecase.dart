import 'package:image_picker/image_picker.dart';
import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/core/usecase/usecase.dart';
import 'package:screenify/features/movie/domain/entities/user_info.dart';
import 'package:screenify/features/movie/domain/repository/auth_repository.dart';

class UploadAvatarUseCase
    implements UseCase<Future<DataState<UserInfo>>, UploadAvatarUseCaseParam> {
  final AuthRepository authRepository;

  UploadAvatarUseCase({required this.authRepository});

  @override
  Future<DataState<UserInfo>> call(
      {required UploadAvatarUseCaseParam param}) async {
    return await authRepository.uploadAvatar(param.file);
  }
}

interface class UploadAvatarUseCaseParam {
  final XFile file;

  UploadAvatarUseCaseParam({required this.file});
}
