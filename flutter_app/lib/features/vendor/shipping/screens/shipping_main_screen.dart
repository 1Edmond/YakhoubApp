import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multishop_tchad/features/vendor/shipping/widgets/product_wise_shipping_widget.dart';
import 'package:multishop_tchad/core/localization/language_constrants.dart';
import 'package:multishop_tchad/features/vendor/shipping/controllers/shipping_controller.dart';
import 'package:multishop_tchad/core/widgets/base/vendor_custom_app_bar_widget.dart';
import 'package:multishop_tchad/features/vendor/settings/screens/order_wise_shipping_list_screen.dart';
import 'package:multishop_tchad/features/vendor/shipping/screens/category_wise_shipping_screen.dart';

class ShippingMainScreen extends StatelessWidget {
  const ShippingMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarWidget(title: getTranslated('shipping_method', context),),
        body: Consumer<ShippingController>(
          builder: (context, shippingProvider,_) {
            return shippingProvider.selectedShippingTypeIndex == 0?
            const CategoryWiseShippingScreen():
            shippingProvider.selectedShippingTypeIndex == 1?
            const OrderWiseShippingScreen():
            const ProductWiseShippingWidget();
          }
        ));
  }
}
