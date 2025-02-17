import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenify/config/constants/app_colors.dart';
import 'package:screenify/features/movie/domain/entities/movie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:screenify/features/movie/domain/entities/movie_actor.dart';
import 'package:screenify/features/movie/domain/entities/review.dart';
import 'package:screenify/features/movie/presentation/blocs/review_bloc/review_bloc.dart';
import 'package:screenify/features/movie/presentation/screens/movie_details_screen.dart';
import 'package:screenify/features/movie/presentation/shared/add_new_review_dialog.dart';
import 'package:screenify/features/movie/presentation/shared/review_list_widget.dart';

class MovieDescriptionScreen extends StatelessWidget {
  final Movie movie;

  const MovieDescriptionScreen({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(movie.posterUrl),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                  ),
                ),
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              movie.title,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontFamily: "Roboto", color: AppColors.yellow),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                textAlign: TextAlign.start,
                AppLocalizations.of(context)!.genders,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                movie.genders.join(" • "),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                textAlign: TextAlign.start,
                AppLocalizations.of(context)!.duration,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                formatDuration(movie.duration),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                textAlign: TextAlign.start,
                AppLocalizations.of(context)!.cast,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            for (MovieActor actor in movie.actors)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        actor.characterName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),

                    Expanded(
                      child: Text(
                        actor.actor.actorName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    AppLocalizations.of(context)!.reviews,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  IconButton(
                    tooltip: AppLocalizations.of(context)!.addReview,
                    onPressed: () async {
                      final reviewBloc = context.read<ReviewBloc>();
                      final res = await showDialog<Review>(
                        context: context,
                        builder: (context) {
                          return AddNewReviewDialog(
                            movie: movie,
                          );
                        },
                      );

                      if (res == null) return;
                      reviewBloc.add(AddNewReviewEvent(review: res));
                    },
                    icon: Icon(
                      Platform.isIOS ? CupertinoIcons.add : Icons.add,
                    ),
                  ),
                ],
              ),
            ),
            ReviewListWidget(movie: movie),
          ],
        ),
      ),
    );
  }
}
