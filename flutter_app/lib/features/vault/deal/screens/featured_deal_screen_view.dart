import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/core/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/controllers/featured_deal_controller.dart';
import 'package:flutter_sixvalley_ecommerce/core/constants/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/core/widgets/base/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/widgets/featured_deal_list_widget.dart';
import 'package:provider/provider.dart';

class FeaturedDealScreenView extends StatelessWidget {
  const FeaturedDealScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        CustomAppBar(title: getTranslated('featured_deals', context)),
        Expanded(child: RefreshIndicator(backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async => await Provider.of<FeaturedDealController>(context, listen: false).getFeaturedDealList(),
          child: const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: FeaturedDealsListWidget(isHomePage: false))))]));
  }
}
