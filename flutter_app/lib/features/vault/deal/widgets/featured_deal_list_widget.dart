import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:multishop_tchad/core/widgets/base/product_card_widget.dart';
import 'package:multishop_tchad/features/vault/deal/controllers/featured_deal_controller.dart';
import 'package:multishop_tchad/core/helpers/responsive_helper.dart';
import 'package:multishop_tchad/features/customer/home/widgets/aster_theme/find_what_you_need_shimmer.dart';
import 'package:multishop_tchad/features/vault/deal/widgets/featured_deal_card_widget.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';


class FeaturedDealsListWidget extends StatelessWidget {
  final bool isHomePage;
  const FeaturedDealsListWidget({super.key, this.isHomePage = true});

  @override
  Widget build(BuildContext context) {

    return isHomePage?
    Consumer<FeaturedDealController>(
      builder: (context, featuredDealProvider, child) {
        return featuredDealProvider.featuredDealProductList != null? featuredDealProvider.featuredDealProductList!.isNotEmpty ?
        CarouselSlider.builder(
          options: CarouselOptions(
            aspectRatio: 2.5,
            viewportFraction: 0.86,
            autoPlay: true,
            pauseAutoPlayOnTouch: true,
            pauseAutoPlayOnManualNavigate: true,
            pauseAutoPlayInFiniteScroll: true,
            enlargeFactor: 0.2,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            disableCenter: true,
            onPageChanged: (index, reason) => featuredDealProvider.changeSelectedIndex(index)
          ),
          itemCount: featuredDealProvider.featuredDealProductList?.length,
          itemBuilder: (context, index, _) => FeaturedDealWidget(
            isHomePage: isHomePage,
            product: featuredDealProvider.featuredDealProductList![index],
            isCenterElement: index == featuredDealProvider.featuredDealSelectedIndex,
          ),
        ) : const SizedBox() : const FindWhatYouNeedShimmer();
      }):

    Consumer<FeaturedDealController>(
      builder: (context, featuredDealProvider, _) {
        return RepaintBoundary(
          child: MasonryGridView.count(
            itemCount: featuredDealProvider.featuredDealProductList?.length,
            crossAxisCount: ResponsiveHelper.isTab(context) ? 3 : 2,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeEight),
              child: ProductCardWidget(product: featuredDealProvider.featuredDealProductList![index]),
            ),
          ),
        );
      }
    );
  }
}


