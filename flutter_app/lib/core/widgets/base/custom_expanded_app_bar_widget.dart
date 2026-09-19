import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/core/helpers/route_helper.dart';
import 'package:flutter_sixvalley_ecommerce/core/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/core/constants/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/core/constants/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/core/constants/images.dart';
import 'package:flutter_sixvalley_ecommerce/core/widgets/base/not_loggedin_widget.dart';
import 'package:provider/provider.dart';

class CustomExpandedAppBarWidget extends StatelessWidget {
  final String? title;
  final Widget child;
  final Widget? bottomChild;
  final bool isGuestCheck;
  const CustomExpandedAppBarWidget({super.key, required this.title, required this.child, this.bottomChild, this.isGuestCheck = false});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthController>(context, listen: false).isLoggedIn();

    return Scaffold(
      floatingActionButton: isGuestCheck ? isGuestMode ? null : bottomChild : bottomChild,
      body: Stack(children: [

        // Background
        Image.asset(
          Images.morePageHeader, height: 150, fit: BoxFit.fill, width: MediaQuery.of(context).size.width,
          color: Provider.of<ThemeController>(context).darkTheme ? Colors.black : Theme.of(context).primaryColor,
        ),

        Positioned(
          top: 40,
          left: Dimensions.paddingSizeSmall,
          right: Dimensions.paddingSizeSmall,
          child: Row(children: [
            CupertinoNavigationBarBackButton(color: Colors.white, onPressed: () {
              Provider.of<SplashController>(context, listen: false).setFromSetting(false);
              Navigator.pop(context);
            } ),
            Text(title!, style: titilliumRegular.copyWith(fontSize: 20, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
          ]),
        ),

        Container(
          margin: const EdgeInsets.only(top: 130),
          decoration: BoxDecoration(
            color: Provider.of<ThemeController>(context).darkTheme ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),

          ///todo: need to check
          child: isGuestCheck ? isGuestMode ? const NotLoggedInWidget(fromPage: RouterHelper.settingsScreen) : child : child,
        ),

      ]),
    );
  }
}
