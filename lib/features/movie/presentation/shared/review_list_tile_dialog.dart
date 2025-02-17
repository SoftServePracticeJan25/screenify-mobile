import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:screenify/config/constants/app_colors.dart';
import 'package:screenify/features/movie/domain/entities/review.dart';
import 'package:screenify/features/movie/domain/entities/user_info.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:screenify/features/movie/presentation/blocs/review_bloc/review_bloc.dart';

class ReviewListTileDialog extends StatefulWidget {
  final UserInfo userInfo;
  final Review review;

  const ReviewListTileDialog({
    required this.userInfo,
    required this.review,
    super.key,
  });

  @override
  State<ReviewListTileDialog> createState() => _ReviewListTileDialogState();
}

class _ReviewListTileDialogState extends State<ReviewListTileDialog> {
  late TextEditingController _commentController;
  bool isEditableText = false;
  late String initialText;
  late int initialRating;

  @override
  void initState() {
    super.initState();
    initialRating = widget.review.rating;
    initialText = widget.review.comment;
    _commentController = TextEditingController(text: widget.review.comment);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Widget editableText() {
    if (isEditableText) {
      return TextField(
        autofocus: true,
        controller: _commentController,
        onSubmitted: (newValue) {
          setState(() {
            initialText = newValue;
            isEditableText = false;
          });
        },
      );
    } else {
      return InkWell(
        onTap: () {
          setState(() {
            isEditableText = true;
          });
        },
        child: Text(
          initialText,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.review.madeBy,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RatingBar(
                itemCount: 5,
                maxRating: 5,
                initialRating: initialRating.toDouble(),
                minRating: 0,
                itemSize: 24,
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
            widget.review.appUserId == widget.userInfo.id
                ? editableText()
                : Text(
                    widget.review.comment,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
            if (widget.review.appUserId == widget.userInfo.id)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<ReviewBloc>().add(
                            DeleteReviewEvent(reviewId: widget.review.id),
                          );
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Platform.isIOS ? CupertinoIcons.delete : Icons.delete,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      final Map<String, dynamic> newReview = {};
                      if (initialRating != widget.review.rating) {
                        newReview['rating'] = initialRating;
                      }
                      if (initialText != widget.review.comment) {
                        newReview['comment'] = initialText;
                      }
                      Navigator.of(context).pop(newReview);
                    },
                    child: Text(AppLocalizations.of(context)!.updateReview),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
