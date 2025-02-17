import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/domain/entities/movie.dart';
import 'package:screenify/features/movie/domain/repository/movie_repository.dart';
import 'package:screenify/features/movie/domain/usecases/get_all_movies_usecase.dart';
import 'package:screenify/features/movie/domain/usecases/get_recommended_movies_usecase.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository _movieRepository = GetIt.I<MovieRepository>();

  MovieBloc() : super(const MovieInitial()) {
    on<GetAllMoviesEvent>(_onGetAllMovies);
  }

  FutureOr<void> _onGetAllMovies(
    GetAllMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(const MovieLoading());
    final responseAll = await GetAllMoviesUseCase(
        movieRepository: _movieRepository)(param: GetAllMoviesUseCaseParam());
    final responseRecommended =
        await GetRecommendedMoviesUseCase(movieRepository: _movieRepository)(
      param: GetRecommendedMoviesUseCaseParam(),
    );

    if (responseAll is DataSuccess && responseRecommended is DataSuccess) {
      emit(
        MovieLoaded(
          movies: responseAll.data!,
          recommendedMovies: responseRecommended.data!,
        ),
      );
    } else if (responseAll is DataFailure &&
        responseRecommended is DataSuccess) {
      emit(
        MovieFailed(
          message: responseAll.message ?? "Unknown responseAll error",
        ),
      );
    } else if (responseRecommended is DataFailure &&
        responseAll is DataSuccess) {
      emit(
        MovieFailed(
          message: responseRecommended.message ??
              "Unknown responseRecommended error",
        ),
      );
    } else {
      emit(const MovieFailed(message: "Error with both requests"));
    }
  }
}
