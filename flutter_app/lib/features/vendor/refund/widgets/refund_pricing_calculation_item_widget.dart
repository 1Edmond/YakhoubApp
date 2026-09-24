import 'package:flutter/material.dart';
import 'package:multishop_tchad/core/helpers/color_helper.dart';
import 'package:multishop_tchad/core/helpers/price_converter.dart';
import 'package:multishop_tchad/core/localization/language_constrants.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:multishop_tchad/core/constants/styles.dart';

class ProductCalculationItemWidget extends StatelessWidget {
  final String? title;
  final double? price;
  final bool isQ;
  const ProductCalculationItemWidget({super.key, this.title, this.price, this.isQ = false});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      isQ?
      Text('${getTranslated(title, context)} (x 1)',
          style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
              color: ColorHelper.blendColors(Colors.white, Theme.of(context).textTheme.bodyLarge!.color!, 0.7))):
      Text('${getTranslated(title, context)}',
          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
              color: ColorHelper.blendColors(Colors.white, Theme.of(context).textTheme.bodyLarge!.color!, 0.7))),
      const Spacer(),
      Text('-${PriceConverter.convertPrice(context, price)}',
          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
              color: ColorHelper.blendColors(Colors.white, Theme.of(context).textTheme.bodyLarge!.color!, 0.7))),
    ],);
  }
}
