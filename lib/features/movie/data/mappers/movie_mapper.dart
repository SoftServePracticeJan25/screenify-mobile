import 'package:screenify/features/movie/data/mappers/movie_actor_mapper.dart';
import 'package:screenify/features/movie/data/models/movie_model.dart';
import 'package:screenify/features/movie/domain/entities/movie.dart';

class MovieMapper {
  const MovieMapper._();

  static Movie toEntity(MovieModel model) {
    return Movie(
      id: model.id,
      title: model.title,
      duration: Duration(minutes: model.durationInMinutes),
      posterUrl: model.posterUrl,
      genders: model.genders,
      actors: model.actors.map((e) => MovieActorMapper.toEntity(e)).toList(),
    );
  }

  static MovieModel toModel(Movie entity) {
    return MovieModel(
      id: entity.id,
      title: entity.title,
      durationInMinutes: entity.duration.inMinutes,
      posterUrl: entity.posterUrl,
      genders: entity.genders,
      actors: entity.actors.map((e) => MovieActorMapper.toModel(e)).toList(),
    );
  }
}
