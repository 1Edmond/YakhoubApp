import 'package:flutter/material.dart';
import 'package:multishop_tchad/features/customer/cart/controllers/cart_controller.dart';
import 'package:multishop_tchad/features/shared/notification/controllers/notification_controller.dart';
import 'package:multishop_tchad/core/helpers/responsive_helper.dart';
import 'package:multishop_tchad/core/helpers/route_helper.dart';
import 'package:multishop_tchad/core/constants/custom_themes.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:multishop_tchad/core/constants/images.dart';
import 'package:provider/provider.dart';

class CartHomePageWidget extends StatelessWidget {
  const CartHomePageWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(children: [


        Consumer<NotificationController>(
          builder: (context, notificationProvider, _) {
            return IconButton(onPressed: () => RouterHelper.getNotificationRoute(action: RouteAction.push),
              icon: Stack(clipBehavior: Clip.none, children: [
                Image.asset(Images.notification, height: Dimensions.iconSizeDefault,
                    width: Dimensions.iconSizeDefault, color: Theme.of(context).textTheme.bodyMedium?.color),

                Positioned(top: -4, right: -4,
                  child: CircleAvatar(radius: ResponsiveHelper.isTab(context)? 10 : 7, backgroundColor: Theme.of(context).colorScheme.error,
                    child: Text(notificationProvider.notificationModel?.newNotificationItem.toString() ?? '0',
                        style: titilliumSemiBold.copyWith(color:  Theme.of(context).colorScheme.secondaryContainer,
                            fontSize: Dimensions.fontSizeExtraSmall))))]));}),


        Padding(padding: const EdgeInsets.only(right: 12.0),
          child: IconButton(onPressed: () => RouterHelper.getCartScreenRoute(action: RouteAction.push),
            icon: Stack(clipBehavior: Clip.none, children: [

              Image.asset(Images.cartArrowDownImage, height: Dimensions.iconSizeDefault,
                  width: Dimensions.iconSizeDefault, color: Theme.of(context).textTheme.bodyMedium?.color),

              Positioned(top: -4, right: -4,
                child: Consumer<CartController>(builder: (context, cart, child) {
                  return CircleAvatar(radius: ResponsiveHelper.isTab(context)? 10 :  7, backgroundColor: Theme.of(context).colorScheme.error,
                    child: Text(cart.cartList.length.toString(),
                        style: titilliumSemiBold.copyWith(color:  Theme.of(context).colorScheme.secondaryContainer,
                            fontSize: Dimensions.fontSizeExtraSmall)));})),
            ]),
          ),
        ),
      ],
    );
  }
}
