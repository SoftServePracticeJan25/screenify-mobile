import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:screenify/config/constants/app_colors.dart';
import 'package:screenify/features/movie/domain/entities/movie.dart';
import 'package:screenify/features/movie/domain/entities/review.dart';
import 'package:screenify/features/movie/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNewReviewDialog extends StatefulWidget {
  final Movie movie;

  const AddNewReviewDialog({required this.movie, super.key});

  @override
  State<AddNewReviewDialog> createState() => _AddNewReviewDialogState();
}

class _AddNewReviewDialogState extends State<AddNewReviewDialog> {
  final TextEditingController _commentController = TextEditingController();
  int initialRating= 0;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = (context.read<AuthBloc>().state as AuthLoaded).userInfo;


    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.addReview,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RatingBar(
                itemCount: 5,
                maxRating: 5,
                minRating: 0,
                itemSize: 24,
                initialRating: initialRating.toDouble(),
                ratingWidget: RatingWidget(
                  full: Icon(
                    Platform.isIOS ? CupertinoIcons.star_fill : Icons.star,
                    color: AppColors.yellow,
                  ),
                  half: Icon(
                    Platform.isIOS
                        ? CupertinoIcons.star_lefthalf_fill
                        : Icons.star_half,
                    color: AppColors.yellow,
                  ),
                  empty: Icon(
                    Platform.isIOS
                        ? CupertinoIcons.star
                        : Icons.star_border_outlined,
                    color: AppColors.yellow,
                  ),
                ),
                onRatingUpdate: (value) {
                  setState(() {
                    initialRating = value.toInt();
                  });
                },
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(
                  20,
                ),
              ),
              controller: _commentController,
              maxLines: 3,
            ),
            TextButton(
              onPressed: () {
                if (_commentController.text.isEmpty) return;
                Navigator.pop(
                  context,
                  Review(
                    id: 0,
                    rating: initialRating,
                    comment: _commentController.text,
                    createdAt: DateTime.now(),
                    movieId: widget.movie.id,
                    madeBy: userInfo.username,
                    photoUrl: userInfo.photoUrl,
                    appUserId: userInfo.id,
                  ),
                );
              },
              child: Text(
                AppLocalizations.of(context)!.submitReview,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
