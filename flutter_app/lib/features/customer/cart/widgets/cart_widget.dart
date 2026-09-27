import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multishop_tchad/core/widgets/base/custom_loader_widget.dart';
import 'package:multishop_tchad/features/customer/cart/domain/models/cart_model.dart';
import 'package:multishop_tchad/features/customer/cart/widgets/cart_quantity_button_widget.dart';
import 'package:multishop_tchad/features/customer/cart/widgets/custom_checkbox_widget.dart';
import 'package:multishop_tchad/features/customer/product_details/widgets/min_order_quanty_widget.dart';
import 'package:multishop_tchad/core/helpers/price_converter.dart';
import 'package:multishop_tchad/core/helpers/route_helper.dart';
import 'package:multishop_tchad/core/localization/controllers/localization_controller.dart';
import 'package:multishop_tchad/core/localization/language_constrants.dart';
import 'package:multishop_tchad/features/customer/cart/controllers/cart_controller.dart';
import 'package:multishop_tchad/main.dart';
import 'package:multishop_tchad/core/constants/custom_themes.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:multishop_tchad/core/widgets/base/custom_image_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:multishop_tchad/features/customer/cart/widgets/cart_product_negotiation_bottom_sheet.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatelessWidget {
  final CartModel? cartModel;
  final int index;
  final bool fromCheckout;
  final Color highLightColor;
  final bool isValidate;
  const CartWidget({
    super.key,
    this.cartModel,
    required this.index,
    required this.fromCheckout,
    required this.highLightColor,
    required this.isValidate,
  });

  @override
  Widget build(BuildContext context) {
    bool minOrderQty = (cartModel?.productInfo?.minimumOrderQty ?? 0) > 1 &&
      (cartModel?.quantity == null || (cartModel?.quantity ?? 0)  < (cartModel?.productInfo?.minimumOrderQty ?? 1));
    return Consumer<CartController>(builder: (context, cartProvider, _) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(
          Dimensions.homePagePadding,
          Dimensions.paddingSizeSmall,
          Dimensions.homePagePadding,
          0,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            color: Theme.of(context).cardColor,
          ),
          child: Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
              extentRatio: .25,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (value) {
                    cartProvider.removeFromCartAPI(cartModel?.id, index);
                  },
                  backgroundColor: Theme.of(context).colorScheme.error.withValues(alpha: 0.03),
                  foregroundColor: Theme.of(context).colorScheme.error,
                  icon: CupertinoIcons.delete_solid,
                  label: getTranslated('delete', context),
                ),
              ],
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                color: (highLightColor != Theme.of(context).cardColor && minOrderQty) ? highLightColor : Theme.of(context).colorScheme.tertiaryContainer.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                // cartModel?.isChecked

                border: Border.all(color: (isValidate && (cartModel?.isChecked ?? false) && minOrderQty) ?  Theme.of(context).colorScheme.error : Colors.transparent, width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Checkbox
                  Padding(
                    padding: EdgeInsets.only(
                      top: 0,
                      left: Provider.of<LocalizationController>(context, listen: false).isLtr
                        ? Dimensions.paddingSizeSmall
                        : Dimensions.paddingSizeExtraSmall,
                      right: Provider.of<LocalizationController>(context, listen: false).isLtr
                        ? Dimensions.paddingSizeExtraSmall
                        : Dimensions.paddingSizeSmall,
                    ),
                    child: SizedBox(
                      height: Dimensions.paddingSizeLarge,
                      width: Dimensions.paddingSizeLarge,
                      child: CustomCheckbox(
                        key: UniqueKey(),
                        visualDensity: VisualDensity.compact,
                        fillColor:  WidgetStateProperty.resolveWith<Color>((states) {
                          if (states.contains(WidgetState.selected)) {
                            return Theme.of(context).primaryColor;
                          }
                          if (states.contains(WidgetState.disabled)) {
                            return Theme.of(context).cardColor;
                          }
                          return Theme.of(context).cardColor;
                        }),
                        side: WidgetStateBorderSide.resolveWith(
                            (states) => BorderSide(
                            width: 2,
                            color: (cartModel?.isChecked ?? false) ? Theme.of(context).primaryColor : Theme.of(context).hintColor.withValues(alpha: 0.50),
                          ),
                        ),
                        checkColor: Colors.white,
                        value: cartModel!.isChecked!,
                        onChanged: (bool? value) async {
                          showDialog(
                            context: context,
                            builder: (ctx) => const CustomLoaderWidget(),
                          );
                          await cartProvider.addRemoveCartSelectedItem(
                            [cartModel!.id!],
                            cartModel!.isChecked! ? false : true,
                          );
                          Navigator.of(Get.context!).pop();
                        },
                      ),
                    ),
                  ),

                  // Product details and quantity controls
                  Expanded(child: IntrinsicHeight(child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                            child: _CartProductImageWidget(cartModel: cartModel),
                          ),
                          Expanded(child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall,
                              vertical: Dimensions.paddingSizeSmall,
                            ),
                            child: _CartProductDetailsWidget(
                              cartModel: cartModel,
                              index: index,
                              fromCheckout: fromCheckout,
                            ),
                          )),
                        ]),

                        MinOrderQuantityWidget(minOrderQty: cartModel?.productInfo?.minimumOrderQty ?? 1, currentQty: cartModel?.quantity),
                        const SizedBox(height: Dimensions.paddingSizeSmall),

                      ])),
                      const SizedBox(width: Dimensions.paddingSizeDefault),

                      _CartQuantityControlsWidget(cartModel: cartModel, index: index),
                    ],
                  ))),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}



class _CartQuantityControlsWidget extends StatelessWidget {
  final CartModel? cartModel;
  final int index;
  const _CartQuantityControlsWidget({
    required this.cartModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.04),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(Dimensions.paddingSizeExtraSmall),
          topRight: Radius.circular(Dimensions.paddingSizeExtraSmall),
        ),
      ),
      //width: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cartModel?.increment ?? false ? Padding(
              padding: const EdgeInsets.all(2),
              child: SizedBox(
                width: 13, height: 13,
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 2,
                ),
              ),
            ) : CartQuantityButton(
              index: index,
              isIncrement: true,
              quantity: cartModel?.quantity,
              maxQty: cartModel?.productInfo?.totalCurrentStock ?? cartModel?.maxQuantity ?? 999,
              cartModel: cartModel,
              minimumOrderQuantity: cartModel?.productInfo?.minimumOrderQty ?? cartModel?.minimumOrderQuantity ?? 1,
              digitalProduct: cartModel?.productType == "digital" ? true : false,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraExtraSmall),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeSmall,
                  vertical: Dimensions.paddingSizeExtraSmall,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withValues(alpha: 0.50),
                  borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
                ),
                child: Text(
                  (cartModel?.quantity ?? 1).toString(),
                  style: textBold.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color)
                )
              ),
            ),

            cartModel?.decrement ?? false ? Padding(
              padding: const EdgeInsets.all(2.0),
              child: SizedBox(
                width: 13,
                height: 13,
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 2,
                ),
              ),
            ) : CartQuantityButton(
              isIncrement: false,
              index: index,
              quantity: cartModel?.quantity,
              maxQty: cartModel?.productInfo?.totalCurrentStock ?? cartModel?.maxQuantity ?? 999,
              cartModel: cartModel,
              minimumOrderQuantity: cartModel?.productInfo?.minimumOrderQty ?? cartModel?.minimumOrderQuantity ?? 1,
              digitalProduct: cartModel?.productType == "digital" ? true : false,
            ),
          ],
        ),
      ),
    );
  }
}


class _CartProductDetailsWidget extends StatelessWidget {
  final CartModel? cartModel;
  final int index;
  final bool fromCheckout;
  const _CartProductDetailsWidget({
    required this.cartModel,
    required this.index,
    required this.fromCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(children: [
          Expanded(
            child: InkWell(
              onTap: () {
                RouterHelper.getProductDetailsRoute(action: RouteAction.push, productId: cartModel?.productId, slug: cartModel?.slug);
              },
              child: Text(
                cartModel?.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textMedium.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: (cartModel?.shop != null &&  cartModel?.shop?.vacationStatus != null && cartModel?.shop?.temporaryClose != null && ((cartModel?.shop?.temporaryClose ?? false) || (cartModel?.shop?.vacationStatus ?? false)))
                    ? Theme.of(context).hintColor
                    : Theme.of(context).textTheme.titleMedium?.color,
                ),
              ),
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
        ]),
        // const SizedBox(height: Dimensions.paddingSizeSmall),

        Row(
          children: [
            // Price with discount
            (cartModel?.discount ?? 0) > 0 ? Text(
              PriceConverter.convertPrice(context, cartModel?.price ?? 0),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: titleRegular.copyWith(
                color: Theme.of(context).textTheme.titleMedium?.color,
                decoration: TextDecoration.lineThrough,
                fontSize: Dimensions.fontSizeSmall,
              ),
            ) : const SizedBox(),

            if((cartModel?.discount ?? 0) > 0)
              SizedBox(width: Dimensions.paddingSizeSmall),

            // Discounted price
            Text(
              PriceConverter.convertPrice(
                context,
                cartModel?.price ?? 0,
                discount: cartModel?.discount ?? 0,
                discountType: 'amount',
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textBold.copyWith(
                color: (cartModel?.shop != null && cartModel?.shop?.vacationStatus != null && cartModel?.shop?.temporaryClose != null && ((cartModel?.shop?.temporaryClose ?? false) || (cartModel?.shop?.vacationStatus ?? false)))
                  ? Theme.of(context).hintColor
                  : Theme.of(context).textTheme.bodyMedium?.color,
                fontSize: Dimensions.fontSizeDefault,
              ),
            ),
          ],
        ),



        // Variation
        (cartModel?.variant != null && cartModel!.variant!.isNotEmpty)
            ? Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Row(children: [
            Flexible(child: Text(
              cartModel?.variant ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textRegular.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
            )),
          ]),
        ) : const SizedBox(),
        const SizedBox(width: Dimensions.paddingSizeSmall),

        // Shipping cost
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cartModel?.shippingType != 'order_wise' ? Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Row(
                children: [
                  Text(
                    '${getTranslated('shipping_cost', context)}: ',
                    style: titilliumSemiBold.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: (cartModel?.shop != null && cartModel?.shop?.temporaryClose != null && cartModel?.shop?.vacationStatus != null &&
                          ((cartModel?.shop?.temporaryClose ?? false) ||
                              (cartModel?.shop?.vacationStatus ?? false)))
                          ? Theme.of(context).hintColor
                          : Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  Text(
                    PriceConverter.convertPrice(context, cartModel?.shippingCost ?? 0),
                    style: textRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                ],
              ),
            ) : const SizedBox(),
          ],
        ),

        // Out of stock warning
        if ((cartModel?.quantity ?? 0) > (cartModel?.productInfo?.totalCurrentStock ?? 999) && cartModel?.productType == "physical")
          Text(
            "${getTranslated("out_of_stock", context)}",
            style: textRegular.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: Theme.of(context).colorScheme.error,
            ),
          ),

        // Negotiation Section (only in cart screen, not during checkout)
        if (!fromCheckout && cartModel != null)
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
            child: _CartNegotiationSectionWidget(cartModel: cartModel!, index: index),
          ),

      ],
    );
  }
}

class _CartNegotiationSectionWidget extends StatelessWidget {
  final CartModel cartModel;
  final int index;
  const _CartNegotiationSectionWidget({required this.cartModel, required this.index});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartController>(context, listen: false);
    final status = cartModel.negotiationStatus ?? 'none';

    if (status == 'none' || status.isEmpty) {
      return InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (ctx) => CartProductNegotiationBottomSheet(
              cartModel: cartModel,
              index: index,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            border: Border.all(color: Theme.of(context).primaryColor.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.handshake_outlined, size: 14, color: Theme.of(context).primaryColor),
              const SizedBox(width: 4),
              Text(
                getTranslated('negotiate_price', context) ?? 'Négocier',
                style: textMedium.copyWith(
                  fontSize: Dimensions.fontSizeExtraSmall,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    } else if (status == 'pending') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.amber.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          border: Border.all(color: Colors.amber.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.access_time_rounded, size: 13, color: Colors.amber),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                '${getTranslated('negotiation_pending', context) ?? 'Négociation'}: -${PriceConverter.convertPrice(context, cartModel.negotiationReduction ?? 0)}',
                style: textMedium.copyWith(
                  fontSize: Dimensions.fontSizeExtraSmall,
                  color: Colors.amber[900],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    } else if (status == 'accepted') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          border: Border.all(color: Colors.green.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline, size: 13, color: Colors.green),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                '${getTranslated('negotiation_accepted_badge', context) ?? 'Prix négocié'}: -${PriceConverter.convertPrice(context, cartModel.negotiationReduction ?? 0)}',
                style: textBold.copyWith(
                  fontSize: Dimensions.fontSizeExtraSmall,
                  color: Colors.green[800],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    } else if (status == 'counter_offer') {
      return Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info_outline, size: 13, color: Colors.blue),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    '${getTranslated('counter_offer_from_seller', context) ?? 'Contre-offre'}: -${PriceConverter.convertPrice(context, cartModel.counterOfferAmount ?? 0)}',
                    style: textBold.copyWith(
                      fontSize: Dimensions.fontSizeExtraSmall,
                      color: Colors.blue[900],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    if (cartModel.negotiationId != null) {
                      cartProvider.respondToProductNegotiation(cartModel.negotiationId!, true);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    ),
                    child: Text(
                      getTranslated('accept', context) ?? 'Accepter',
                      style: textMedium.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                InkWell(
                  onTap: () {
                    if (cartModel.negotiationId != null) {
                      cartProvider.respondToProductNegotiation(cartModel.negotiationId!, false);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      border: Border.all(color: Colors.red.withValues(alpha: 0.4)),
                    ),
                    child: Text(
                      getTranslated('refuse', context) ?? 'Refuser',
                      style: textMedium.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (status == 'refused') {
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            ),
            child: Text(
              getTranslated('negotiation_refused_badge', context) ?? 'Refusée',
              style: textRegular.copyWith(
                fontSize: Dimensions.fontSizeExtraSmall,
                color: Colors.red[700],
              ),
            ),
          ),
          if ((cartModel.negotiationRound ?? 1) < 2) ...[
            const SizedBox(width: 6),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (ctx) => CartProductNegotiationBottomSheet(
                    cartModel: cartModel,
                    index: index,
                  ),
                );
              },
              child: Text(
                getTranslated('retry_negotiation', context) ?? 'Réessayer',
                style: textMedium.copyWith(
                  fontSize: Dimensions.fontSizeExtraSmall,
                  color: Theme.of(context).primaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ],
      );
    }

    return const SizedBox();
  }
}

class _CartProductImageWidget extends StatelessWidget {
  final CartModel? cartModel;
  const _CartProductImageWidget({required this.cartModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RouterHelper.getProductDetailsRoute(action: RouteAction.push, productId: cartModel?.productId, slug: cartModel?.slug);
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
              border: Border.all(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.10),
                width: 0.5,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
              child: CustomImageWidget(
                image: '${cartModel?.productInfo?.thumbnailFullUrl?.path}',
                height: 60,
                width: 60,
              ),
            ),
          ),
          if ((cartModel?.isProductAvailable ?? 1) == 0)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                color: Colors.black.withValues(alpha: 0.5),
              ),
              height: 70,
              width: 70,
              child: Center(
                child: Text(
                  "${getTranslated("not_available", context)}",
                  textAlign: TextAlign.center,
                  style: textMedium.copyWith(color: Colors.white),
                ),
              ),
            )
        ],
      ),
    );
  }
}
