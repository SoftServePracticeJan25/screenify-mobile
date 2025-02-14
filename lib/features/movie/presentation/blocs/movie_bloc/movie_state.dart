part of 'movie_bloc.dart';

sealed class MovieState extends Equatable {
  const MovieState();
}

final class MovieInitial extends MovieState {
  const MovieInitial();
  @override
  List<Object> get props => [];
}

final class MovieLoading extends MovieState{

  const MovieLoading();
  @override

  List<Object?> get props => [];

}

final class MovieFailed extends MovieState{
  final String message;

  const MovieFailed({required this.message});
  @override
  List<Object?> get props => [];

}

final class MovieLoaded extends MovieState{
  final List<Movie> movies;
  final List<Movie> recommendedMovies;
  const MovieLoaded({required this.movies, required this.recommendedMovies});

  @override
  List<Object?> get props => [movies, recommendedMovies];
}