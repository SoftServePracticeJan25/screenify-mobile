import 'package:flutter/material.dart';
import 'package:screenify/config/constants/app_images.dart';
import 'package:screenify/features/movie/domain/entities/movie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:screenify/features/movie/presentation/screens/movie_description_screen.dart';
import 'package:screenify/features/movie/presentation/screens/session_screen.dart';

String formatDuration(Duration duration) {
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);

  if (hours > 0) {
    return '${hours}h ${minutes}m';
  } else {
    return '${minutes}m';
  }
}

class MovieDetailsScreen extends StatefulWidget {
  final List<Movie> movies;
  final int movieIndex;

  const MovieDetailsScreen({
    required this.movies,
    required this.movieIndex,
    super.key,
  });

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late PageController _controller;
  late ValueNotifier<int> _currentPageNotifier;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: 0.8,
      initialPage: widget.movieIndex,
    );
    _currentPageNotifier = ValueNotifier(widget.movieIndex);

    _controller.addListener(() {
      int newPage = _controller.page?.round() ?? widget.movieIndex;
      if (_currentPageNotifier.value != newPage) {
        _currentPageNotifier.value = newPage;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Container(
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
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: widget.movies.length,
                    controller: _controller,
                    itemBuilder: (context, index) {
                      final movie = widget.movies[index];
                      return ListenableBuilder(
                        listenable: _controller,
                        builder: (context, child) {
                          double factor = 1;
                          if (_controller.position.hasContentDimensions) {
                            factor = 1 - (_controller.page! - index).abs();
                          }
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              MovieDescriptionScreen(
                                            movie: movie,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.sizeOf(context).height /
                                                  2 +
                                              (factor * 30),
                                      width: MediaQuery.sizeOf(context).width /
                                          1.2,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFF9747FF),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(45),
                                        image: movie.posterUrl.isNotEmpty
                                            ? DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  movie.posterUrl,
                                                ),
                                              )
                                            : null,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    overflow: TextOverflow.fade,
                                    maxLines: 2,
                                    movie.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                    textAlign: TextAlign.center,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        movie.genders.join("/"),
                                      ),
                                      Text(
                                        formatDuration(movie.duration),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                ValueListenableBuilder<int>(
                  valueListenable: _currentPageNotifier,
                  builder: (context, currentPage, child) {
                    return OutlinedButton(
                      onPressed: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SessionScreen(
                              movie: widget.movies[currentPage],
                            ),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.buyTicket,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
