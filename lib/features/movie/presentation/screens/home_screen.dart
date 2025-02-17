import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenify/config/constants/app_colors.dart';
import 'package:screenify/config/constants/app_images.dart';
import 'package:screenify/features/movie/presentation/blocs/movie_bloc/movie_bloc.dart';
import 'package:screenify/features/movie/presentation/screens/movie_details_screen.dart';
import 'package:screenify/features/movie/presentation/shared/screenify_progress_indicator.dart';

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
            print(state.message);
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
            final genders =
                state.movies.expand((movie) => movie.genders).toSet().toList();
            return ListView.builder(
              itemCount: genders.length,
              itemBuilder: (context, index) {
                final gender = genders[index];
                final genderMovies = state.movies
                    .where((movie) => movie.genders.contains(gender))
                    .toList();
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height / 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gender,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: AppColors.yellow),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: genderMovies.length,
                            itemBuilder: (context, index) {
                              final genderMovie = genderMovies[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => MovieDetailsScreen(
                                          movies: genderMovies,
                                          movieIndex: index,
                                        ),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(45),
                                  child: Container(
                                    height:
                                        MediaQuery.sizeOf(context).height / 5,
                                    width:
                                        MediaQuery.sizeOf(context).width / 3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(45),
                                      image: genderMovie.posterUrl.isNotEmpty
                                          ? DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                genderMovie.posterUrl,
                                              ),
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
              },
            );
          } else {
            return Container(
              color: Colors.transparent,
            );
          }
        },
      ),
    );
  }
}
