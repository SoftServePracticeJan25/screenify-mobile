import 'package:equatable/equatable.dart';
import 'package:screenify/features/movie/domain/entities/movie_actor.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final Duration duration;
  final String posterUrl;
  final List<String> genders;
  final List<MovieActor> actors;

  const Movie({
    required this.id,
    required this.title,
    required this.duration,
    required this.posterUrl,
    required this.genders,
    required this.actors,
  });

  @override
  List<Object?> get props =>
      [id, title, duration, posterUrl, genders, actors];
}
