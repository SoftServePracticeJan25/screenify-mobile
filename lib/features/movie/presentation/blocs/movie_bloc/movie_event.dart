part of 'movie_bloc.dart';

sealed class MovieEvent extends Equatable {
  const MovieEvent();
}

class GetAllMoviesEvent extends MovieEvent{
  const GetAllMoviesEvent();

  @override
  List<Object?> get props => [];
}

class GetRecommendedMoviesEvent extends MovieEvent{
  const GetRecommendedMoviesEvent();

  @override
  List<Object?> get props => [];
}
