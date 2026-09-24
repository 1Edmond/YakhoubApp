import 'package:flutter/material.dart';
import 'package:multishop_tchad/core/widgets/base/auction/shimmers/auction_card_shimmer_widget.dart';
import 'package:multishop_tchad/core/widgets/base/product_card_shimmer_widget.dart';
import 'package:multishop_tchad/core/helpers/responsive_helper.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class CategoryContentScreenShimmer extends StatelessWidget {
  final bool isAuction;

  const CategoryContentScreenShimmer({
    super.key,
    this.isAuction = false,
  });

  static const List<double> _imageHeights = [
    150, 120, 160, 110, 140, 130,
    125, 155, 115, 145, 135, 120,
  ];

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = ResponsiveHelper.isTab(context) ? 3 : 2;

    return Shimmer.fromColors(
      baseColor: Theme.of(context).cardColor,
      highlightColor: Colors.grey[300]!,
      enabled: true,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: MasonryGridView.count(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          crossAxisCount: crossAxisCount,
          itemCount: _imageHeights.length,
          itemBuilder: (context, index) {
            final double imageHeight = _imageHeights[index];

            return Container(
              margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              child: isAuction
                  ? AuctionCardShimmerWidget(imageHeight: imageHeight)
                  : ProductCardShimmerWidget(imageHeight: imageHeight),
            );
          },
        ),
      ),
    );
  }
}
