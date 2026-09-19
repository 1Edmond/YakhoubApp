import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/core/helpers/route_helper.dart';
import 'package:flutter_sixvalley_ecommerce/core/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/coupon/controllers/coupon_controller.dart';
import 'package:flutter_sixvalley_ecommerce/core/constants/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/core/constants/images.dart';
import 'package:flutter_sixvalley_ecommerce/core/widgets/base/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/core/widgets/base/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/core/widgets/base/not_loggedin_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/coupon/widgets/coupon_item_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order/widgets/order_shimmer_widget.dart';
import 'package:provider/provider.dart';

class CouponList extends StatefulWidget {
  const CouponList({super.key});

  @override
  State<CouponList> createState() => _CouponListState();
}

class _CouponListState extends State<CouponList> {
  @override
  void initState() {
    if(Provider.of<AuthController>(context, listen: false).isLoggedIn()){
      Provider.of<CouponController>(context, listen: false).getCouponList(context, 1);
      if(Provider.of<ProfileController>(context, listen: false).userInfoModel == null) {
        Provider.of<ProfileController>(context, listen: false).getUserInfo(context);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('coupons', context)),
      body: Provider.of<AuthController>(context, listen: false).isLoggedIn()?

      Consumer<CouponController>(
        builder: (context, couponProvider,_) {
          return couponProvider.couponList != null ? couponProvider.couponList!.isNotEmpty ?
          Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: couponProvider.couponList!.length,
              itemBuilder: (context, index)=> CouponItemWidget(coupons: couponProvider.couponList![index])
            )) :
          const NoInternetOrDataScreenWidget(isNoInternet: false,
            icon: Images.noCoupon, message: 'no_coupon_available') : const OrderShimmerWidget();
        }
      ): NotLoggedInWidget(
        fromPage: RouterHelper.couponListScreen,
        onLoginSuccess: (){
          RouterHelper.getCouponListScreenRoute(action: RouteAction.pushReplacement);
        }
      ),
    );
  }
}
