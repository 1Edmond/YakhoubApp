import 'package:flutter/material.dart';
import 'package:multishop_tchad/core/constants/custom_themes.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:multishop_tchad/features/customer/order/domain/models/order_model.dart';
import 'package:multishop_tchad/features/customer/order_details/controllers/price_reduction_controller.dart';
import 'package:multishop_tchad/features/customer/order_details/widgets/price_reduction_bottom_sheet_widget.dart';
import 'package:provider/provider.dart';

class CustomerReductionSectionWidget extends StatelessWidget {
  final Orders? orderModel;

  const CustomerReductionSectionWidget({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    if (orderModel == null || orderModel!.id == null) {
      return const SizedBox.shrink();
    }

    return Consumer<PriceReductionController>(
      builder: (context, controller, child) {
        final reduction = controller.getReductionForOrder(orderModel!.id!);

        // If a reduction request exists
        if (reduction != null) {
          final status = reduction.status ?? 'pending';
          final requested = reduction.requestedReduction?.toStringAsFixed(0) ?? '0';

          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeSmall,
              vertical: Dimensions.paddingSizeExtraSmall,
            ),
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
              color: status == 'accepted'
                  ? Colors.green.withValues(alpha: 0.08)
                  : status == 'refused'
                      ? Colors.red.withValues(alpha: 0.08)
                      : status == 'counter_offer'
                          ? Colors.blue.withValues(alpha: 0.08)
                          : Colors.orange.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              border: Border.all(
                color: status == 'accepted'
                    ? Colors.green.withValues(alpha: 0.4)
                    : status == 'refused'
                        ? Colors.red.withValues(alpha: 0.4)
                        : status == 'counter_offer'
                            ? Colors.blue.withValues(alpha: 0.4)
                            : Colors.orange.withValues(alpha: 0.4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.local_offer,
                      size: 18,
                      color: status == 'accepted'
                          ? Colors.green
                          : status == 'refused'
                              ? Colors.red
                              : status == 'counter_offer'
                                  ? Colors.blue
                                  : Colors.orange,
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(
                      child: Text(
                        status == 'accepted'
                            ? 'Réduction acceptée (- $requested FCFA)'
                            : status == 'refused'
                                ? 'Demande de réduction refusée (- $requested FCFA)'
                                : status == 'counter_offer'
                                    ? 'Contre-proposition du vendeur'
                                    : 'Demande de réduction en cours (- $requested FCFA)',
                        style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: status == 'accepted'
                              ? Colors.green
                              : status == 'refused'
                                  ? Colors.red
                                  : status == 'counter_offer'
                                      ? Colors.blue
                                      : Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
                if (status == 'counter_offer' && reduction.counterOfferAmount != null) ...[
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Text(
                    'Le vendeur propose une réduction de ${reduction.counterOfferAmount?.toStringAsFixed(0)} FCFA.',
                    style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                          onPressed: controller.isLoading
                              ? null
                              : () => controller.respondToCounterOffer(
                                    requestId: reduction.id!,
                                    orderId: orderModel!.id!,
                                    accept: true,
                                    context: context,
                                  ),
                          child: const Text('Accepter'),
                        ),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                          onPressed: controller.isLoading
                              ? null
                              : () => controller.respondToCounterOffer(
                                    requestId: reduction.id!,
                                    orderId: orderModel!.id!,
                                    accept: false,
                                    context: context,
                                  ),
                          child: const Text('Refuser'),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        }

        // Only allow request if order is pending
        if (orderModel!.orderStatus != 'pending') {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor,
              side: BorderSide(color: Theme.of(context).primaryColor),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
              minimumSize: const Size(double.infinity, 45),
            ),
            icon: const Icon(Icons.discount_outlined),
            label: const Text(
              'Demander une réduction de prix',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => PriceReductionBottomSheetWidget(
                  orderId: orderModel!.id!,
                  orderAmount: orderModel!.orderAmount ?? 0,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
