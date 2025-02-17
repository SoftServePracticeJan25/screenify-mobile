import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenify/config/constants/app_colors.dart';
import 'package:screenify/features/movie/domain/entities/movie.dart';
import 'package:screenify/features/movie/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:screenify/features/movie/presentation/blocs/review_bloc/review_bloc.dart';
import 'package:screenify/features/movie/presentation/shared/review_list_tile_widget.dart';
import 'package:screenify/features/movie/presentation/shared/screenify_progress_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewListWidget extends StatefulWidget {
  final Movie movie;

  const ReviewListWidget({required this.movie, super.key});

  @override
  State<ReviewListWidget> createState() => _ReviewListWidgetState();
}

class _ReviewListWidgetState extends State<ReviewListWidget> {
  @override
  void initState() {
    super.initState();
    context
        .read<ReviewBloc>()
        .add(GetReviewsByMovieIdEvent(movieId: widget.movie.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewBloc, ReviewState>(
      builder: (context, state) {
        if (state is ReviewLoading) {
          return const Padding(
            padding: EdgeInsets.all(32.0),
            child: ScreenifyProgressIndicator(),
          );
        } else if (state is ReviewLoaded) {
          return state.reviews.isNotEmpty
              ? ListView.separated(
                  reverse: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.reviews.length,
                  separatorBuilder: (context, index) {
                    return const Divider(color: AppColors.lightPurple80);
                  },
                  itemBuilder: (context, index) {
                    final userInfo =
                        (context.read<AuthBloc>().state as AuthLoaded).userInfo;
                    final review = state.reviews[index];
                    return ReviewListTileWidget(
                      userInfo: userInfo,
                      review: review,
                    );
                  },
                )
              : Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    AppLocalizations.of(context)!.noReviews,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                );
        } else {
          return const SizedBox.shrink();
        }
      },
      listener: (BuildContext context, ReviewState state) {
        if (state is ReviewFailed) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
    );
  }
}
