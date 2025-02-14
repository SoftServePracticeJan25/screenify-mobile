import 'package:screenify/features/movie/data/models/actor_model.dart';
import 'package:screenify/features/movie/domain/entities/actor.dart';

class ActorMapper {
  const ActorMapper._();

  static Actor toEntity(ActorModel model) {
    return Actor(
      actorName: model.actorName,
      bio: model.bio,
      birthdate: model.birthdate,
      photoUrl: model.photoUrl,
    );
  }

  static ActorModel toModel(Actor entity) {
    return ActorModel(
      actorName: entity.actorName,
      bio: entity.bio,
      birthdate: entity.birthdate,
      photoUrl: entity.photoUrl,
    );
  }
}
