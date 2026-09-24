import 'package:flutter/material.dart';
import 'package:multishop_tchad/features/vault/review/domain/models/review_model.dart';
import 'package:multishop_tchad/core/localization/language_constrants.dart';
import 'package:multishop_tchad/core/constants/custom_themes.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:multishop_tchad/core/widgets/base/custom_app_bar_widget.dart';
import 'package:multishop_tchad/features/vault/review/widgets/review_widget.dart';

class ReviewScreen extends StatelessWidget {
  final List<ReviewModel>? reviewList;
  const ReviewScreen({super.key, this.reviewList});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        CustomAppBar(title: getTranslated('reviews', context)),

        Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Text('${getTranslated('reviews', context)!}(${reviewList!.length})', style: robotoBold)),

        Expanded(child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          itemCount: reviewList?.length,
          itemBuilder: (context, index) {
            return Container(margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              color: Theme.of(context).highlightColor,
              child: ReviewWidget(reviewModel: reviewList![index]));
          },
        )),

      ]),
    );
  }
}
