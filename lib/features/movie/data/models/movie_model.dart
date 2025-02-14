import 'package:equatable/equatable.dart';
import 'package:screenify/features/movie/data/models/movie_actor_model.dart';

class MovieModel extends Equatable {
  final int id;
  final String title;
  final int durationInMinutes;
  final String posterUrl;
  final List<String> genders;
  final List<MovieActorModel> actors;

  const MovieModel({
    required this.id,
    required this.title,
    required this.durationInMinutes,
    required this.posterUrl,
    required this.genders,
    required this.actors,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as int,
      title: json['title'] as String,
      durationInMinutes: json['duration'] as int,
      posterUrl: json['posterUrl'] as String,
      genders: (json['genres'] as List<dynamic>?)
              ?.map((genre) => genre['name'] as String)
              .toList() ??
          [],
      actors: (json['actors'] as List<dynamic>?)
              ?.map((actor) => MovieActorModel.fromJson(actor))
              .toList() ??
          [],
    );
  }

  static List<MovieModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MovieModel.fromJson(json)).toList();
  }

  @override
  List<Object?> get props => [
        id,
        title,
        durationInMinutes,
        posterUrl,
        genders,
        actors,
      ];
}
