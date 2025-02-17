import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:screenify/config/constants/app_colors.dart';
import 'package:screenify/features/movie/domain/entities/review.dart';
import 'package:screenify/features/movie/domain/entities/user_info.dart';
import 'package:screenify/features/movie/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:screenify/features/movie/presentation/blocs/review_bloc/review_bloc.dart';
import 'package:screenify/features/movie/presentation/shared/review_list_tile_dialog.dart';

class ReviewListTileWidget extends StatelessWidget {
  final UserInfo userInfo;
  final Review review;

  const ReviewListTileWidget({
    required this.userInfo,
    required this.review,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        final reviewBloc = context.read<ReviewBloc>();
        final res = await showDialog<Map<String, dynamic>?>(
          context: context,
          builder: (context) {
            return ReviewListTileDialog(
              userInfo: userInfo,
              review: review,
            );
          },
        );
        if (res == null) return;
        reviewBloc.add(
          UpdateReviewEvent(
            reviewId: review.id,
            comment: res['comment'],
            rating: res['rating'],
          ),
        );
      },
      leading: CircleAvatar(
        backgroundImage:
            review.photoUrl.isEmpty ? null : NetworkImage(review.photoUrl),
      ),
      title: Text(review.madeBy),
      titleTextStyle: Theme.of(context).textTheme.bodySmall,
      subtitleTextStyle: Theme.of(context).textTheme.titleSmall,
      subtitle: Text(review.comment),
      trailing: RatingBar(
        ignoreGestures: true,
        itemCount: 5,
        maxRating: 5,
        initialRating: review.rating.toDouble(),
        minRating: 0,
        itemSize: 12,
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
            Platform.isIOS ? CupertinoIcons.star : Icons.star_border_outlined,
            color: AppColors.yellow,
          ),
        ),
        onRatingUpdate: (_) {},
      ),
    );
  }
}
