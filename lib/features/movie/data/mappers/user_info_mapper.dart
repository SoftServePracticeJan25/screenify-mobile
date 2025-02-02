import 'package:screenify/features/movie/data/models/user_info_model.dart';
import 'package:screenify/features/movie/domain/entities/user_info.dart';

class UserInfoMapper {
  static UserInfo toEntity(UserInfoModel model) {
    return UserInfo(
      transactionCount: model.transactionCount,
      reviewCount: model.reviewCount,
      email: model.email,
      photoUrl: model.photoUrl,
      username: model.username,
      id: model.id,
    );
  }

  static UserInfoModel toModel(UserInfo entity) {
    return UserInfoModel(
      id: entity.id,
      username: entity.username,
      email: entity.email,
      photoUrl: entity.photoUrl,
      reviewCount: entity.reviewCount,
      transactionCount: entity.transactionCount,
    );
  }
}
