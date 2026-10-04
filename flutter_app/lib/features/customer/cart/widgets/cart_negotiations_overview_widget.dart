import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:multishop_tchad/core/constants/custom_themes.dart';
import 'package:multishop_tchad/core/helpers/price_converter.dart';
import 'package:multishop_tchad/core/localization/language_constrants.dart';
import 'package:multishop_tchad/core/widgets/base/custom_image_widget.dart';
import 'package:multishop_tchad/features/customer/cart/controllers/cart_controller.dart';
import 'package:multishop_tchad/features/customer/cart/domain/models/cart_model.dart';
import 'package:multishop_tchad/features/customer/cart/widgets/cart_product_negotiation_bottom_sheet.dart';

class CartNegotiationsOverviewWidget extends StatefulWidget {
  const CartNegotiationsOverviewWidget({super.key});

  @override
  State<CartNegotiationsOverviewWidget> createState() => _CartNegotiationsOverviewWidgetState();
}

class _CartNegotiationsOverviewWidgetState extends State<CartNegotiationsOverviewWidget> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, cartProvider, _) {
        final List<CartModel> negotiatedItems = cartProvider.cartList.where((item) {
          final s = item.negotiationStatus;
          return s != null && s.isNotEmpty && s != 'none';
        }).toList();

        if (negotiatedItems.isEmpty) {
          return const SizedBox.shrink();
        }

        final int pendingCount = negotiatedItems.where((i) => i.negotiationStatus == 'pending').length;
        final int counterOfferCount = negotiatedItems.where((i) => i.negotiationStatus == 'counter_offer').length;

        return Container(
          margin: const EdgeInsets.only(
            left: Dimensions.paddingSizeDefault,
            right: Dimensions.paddingSizeDefault,
            top: Dimensions.paddingSizeSmall,
            bottom: Dimensions.paddingSizeExtraSmall,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            border: Border.all(
              color: counterOfferCount > 0
                  ? Colors.blue.withValues(alpha: 0.5)
                  : Theme.of(context).primaryColor.withValues(alpha: 0.25),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              InkWell(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault,
                    vertical: Dimensions.paddingSizeSmall,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.handshake_rounded,
                          size: 18,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              getTranslated('my_negotiations', context) ?? 'Mes négociations',
                              style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${negotiatedItems.length}',
                                style: robotoBold.copyWith(
                                  color: Colors.white,
                                  fontSize: Dimensions.fontSizeExtraSmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (counterOfferCount > 0)
                        Container(
                          margin: const EdgeInsets.only(right: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '$counterOfferCount ${getTranslated('counter_offer_received', context) ?? 'Offre!'}',
                            style: robotoBold.copyWith(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      Icon(
                        _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: Theme.of(context).hintColor,
                      ),
                    ],
                  ),
                ),
              ),

              // Expanded items list
              if (_isExpanded) ...[
                const Divider(height: 1, thickness: 0.8),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault,
                    vertical: Dimensions.paddingSizeSmall,
                  ),
                  itemCount: negotiatedItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: Dimensions.paddingSizeSmall),
                  itemBuilder: (context, index) {
                    final item = negotiatedItems[index];
                    return _buildNegotiationItem(context, item, cartProvider);
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildNegotiationItem(BuildContext context, CartModel item, CartController cartProvider) {
    final status = item.negotiationStatus ?? 'none';
    final String imagePath = item.thumbnailFullUrl?.path ?? item.image ?? '';

    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (status) {
      case 'accepted':
        statusColor = Colors.green;
        statusText = '${getTranslated('negotiation_accepted', context) ?? 'Acceptée'}: -${PriceConverter.convertPrice(context, item.negotiationReduction ?? 0)}';
        statusIcon = Icons.check_circle_rounded;
        break;
      case 'counter_offer':
        statusColor = Colors.blue;
        statusText = '${getTranslated('counter_offer_received', context) ?? 'Contre-proposition'}: -${PriceConverter.convertPrice(context, item.counterOfferAmount ?? 0)}';
        statusIcon = Icons.swap_horiz_rounded;
        break;
      case 'refused':
        statusColor = Colors.redAccent;
        statusText = getTranslated('negotiation_refused', context) ?? 'Refusée';
        statusIcon = Icons.cancel_rounded;
        break;
      case 'pending':
      default:
        statusColor = Colors.amber[800]!;
        statusText = '${getTranslated('waiting_for_vendor', context) ?? 'En attente'}: -${PriceConverter.convertPrice(context, item.negotiationReduction ?? 0)}';
        statusIcon = Icons.access_time_rounded;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        border: Border.all(color: statusColor.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  width: 44,
                  height: 44,
                  child: CustomImageWidget(image: imagePath),
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(statusIcon, size: 13, color: statusColor),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            statusText,
                            style: robotoBold.copyWith(
                              fontSize: Dimensions.fontSizeExtraSmall,
                              color: statusColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Action buttons if counter offer
          if (status == 'counter_offer' && item.negotiationId != null) ...[
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    cartProvider.respondToProductNegotiation(item.negotiationId!, false);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.red.withValues(alpha: 0.4)),
                    ),
                    child: Text(
                      getTranslated('refuse', context) ?? 'Refuser',
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: Colors.red[800],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    cartProvider.respondToProductNegotiation(item.negotiationId!, true);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      getTranslated('accept', context) ?? 'Accepter',
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
