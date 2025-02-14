import 'package:screenify/features/movie/data/mappers/actor_mapper.dart';
import 'package:screenify/features/movie/data/models/movie_actor_model.dart';
import 'package:screenify/features/movie/domain/entities/movie_actor.dart';

class MovieActorMapper {
  const MovieActorMapper._();

  static MovieActor toEntity(MovieActorModel model) {
    return MovieActor(
      actor: ActorMapper.toEntity(model.actorModel),
      roleName: model.roleName,
      characterName: model.characterName,
    );
  }

  static MovieActorModel toModel(MovieActor entity) {
    return MovieActorModel(
      actorModel: ActorMapper.toModel(entity.actor),
      roleName: entity.roleName,
      characterName: entity.characterName,
    );
  }
}
