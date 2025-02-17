import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenify/config/constants/app_colors.dart';
import 'package:screenify/config/constants/app_images.dart';
import 'package:screenify/features/movie/domain/entities/movie.dart';
import 'package:screenify/features/movie/presentation/blocs/movie_bloc/movie_bloc.dart';
import 'package:screenify/features/movie/presentation/screens/movie_details_screen.dart';
import 'package:screenify/features/movie/presentation/shared/screenify_progress_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? AppImages.mainBackgroundDark
                : AppImages.mainBackgroundLight,
          ),
        ),
      ),
      child: BlocConsumer<MovieBloc, MovieState>(
        listener: (context, state) async {
          if (state is MovieFailed) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is MovieLoading) {
            await showDialog(
              context: context,
              builder: (_) {
                return const ScreenifyProgressIndicator();
              },
            );
          } else {
            if (Navigator.of(context).canPop()) {
              Navigator.pop(context);
            }
          }
        },
        builder: (context, state) {
          if (state is MovieLoaded) {
            final recommendedMovies = state.recommendedMovies;
            final genders =
                state.movies.expand((movie) => movie.genders).toSet().toList();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  // 🔹 Recommended Movies Section (Only If Not Empty)
                  if (recommendedMovies.isNotEmpty)
                    _buildMovieRow(
                      context,
                      title: AppLocalizations.of(context)!.recommended,
                      movies: recommendedMovies,
                    ),

                  // 🔹 Movie Sections by Gender
                  ...genders.map((gender) {
                    final genderMovies = state.movies
                        .where((movie) => movie.genders.contains(gender))
                        .toList();
                    return _buildMovieRow(
                      context,
                      title: gender,
                      movies: genderMovies,
                    );
                  }),
                ],
              ),
            );
          } else {
            return Container(color: Colors.transparent);
          }
        },
      ),
    );
  }

  // 🔹 Extracted Function to Build a Movie Row
  Widget _buildMovieRow(
    BuildContext context, {
    required String title,
    required List<Movie> movies,
  }) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: AppColors.yellow),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => MovieDetailsScreen(
                              movies: movies,
                              movieIndex: index,
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(45),
                      child: Container(
                        height: MediaQuery.sizeOf(context).height / 5,
                        width: MediaQuery.sizeOf(context).width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                          image: movie.posterUrl.isNotEmpty
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(movie.posterUrl),
                                )
                              : null,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
