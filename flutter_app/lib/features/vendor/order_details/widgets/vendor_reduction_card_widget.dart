import 'package:flutter/material.dart';
import 'package:multishop_tchad/core/constants/custom_themes.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:multishop_tchad/features/customer/order_details/domain/models/price_reduction_model.dart';
import 'package:multishop_tchad/features/vendor/order_details/controllers/vendor_reduction_controller.dart';
import 'package:provider/provider.dart';

class VendorReductionCardWidget extends StatelessWidget {
  final int orderId;

  const VendorReductionCardWidget({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<VendorReductionController>(
      builder: (context, controller, child) {
        final PriceReductionModel? reduction = controller.getReductionForOrder(orderId);
        if (reduction == null) {
          return const SizedBox.shrink();
        }

        final status = reduction.status ?? 'pending';
        final requested = reduction.requestedReduction?.toStringAsFixed(0) ?? '0';

        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault,
            vertical: Dimensions.paddingSizeSmall,
          ),
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            border: Border.all(
              color: status == 'pending'
                  ? Colors.orange.withValues(alpha: 0.5)
                  : status == 'accepted'
                      ? Colors.green.withValues(alpha: 0.5)
                      : status == 'refused'
                          ? Colors.red.withValues(alpha: 0.5)
                          : Colors.blue.withValues(alpha: 0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).hintColor.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_offer_outlined,
                          color: status == 'accepted'
                              ? Colors.green
                              : status == 'refused'
                                  ? Colors.red
                                  : Colors.orange,
                          size: 20,
                        ),
                        const SizedBox(width: Dimensions.paddingSizeSmall),
                        Expanded(
                          child: Text(
                            'Demande de réduction',
                            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: status == 'accepted'
                          ? Colors.green.withValues(alpha: 0.1)
                          : status == 'refused'
                              ? Colors.red.withValues(alpha: 0.1)
                              : Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      status == 'accepted'
                          ? 'Acceptée'
                          : status == 'refused'
                              ? 'Refusée'
                              : status == 'counter_offer'
                                  ? 'Contre-offre'
                                  : 'En attente',
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: status == 'accepted'
                            ? Colors.green
                            : status == 'refused'
                                ? Colors.red
                                : Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              Text(
                'Réduction demandée par le client : - $requested FCFA',
                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
              ),

              if (status == 'counter_offer' && reduction.counterOfferAmount != null)
                Padding(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                  child: Text(
                    'Votre contre-proposition : - ${reduction.counterOfferAmount?.toStringAsFixed(0)} FCFA (en attente du client)',
                    style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Colors.blue,
                    ),
                  ),
                ),

              if (status == 'pending') ...[
                const SizedBox(height: Dimensions.paddingSizeDefault),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: controller.isLoading
                            ? null
                            : () => controller.acceptReduction(reduction.id!, orderId, context),
                        child: const Text('Accepter'),
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: controller.isLoading
                            ? null
                            : () => controller.refuseReduction(reduction.id!, orderId, context),
                        child: const Text('Refuser'),
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: controller.isLoading
                            ? null
                            : () => _showCounterOfferDialog(context, controller, reduction.id!, orderId),
                        child: const Text('Contre-offre'),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _showCounterOfferDialog(BuildContext context, VendorReductionController controller, int requestId, int orderId) {
    int? selectedTier;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              title: const Text('Faire une contre-proposition'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Choisissez un palier alternatif à proposer au client :'),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: controller.tiers.map((tier) {
                      final isSelected = selectedTier == tier;
                      return ChoiceChip(
                        label: Text('- $tier FCFA'),
                        selected: isSelected,
                        onSelected: (selected) {
                          setDialogState(() {
                            selectedTier = selected ? tier : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Annuler'),
                ),
                ElevatedButton(
                  onPressed: selectedTier == null
                      ? null
                      : () async {
                          Navigator.pop(ctx);
                          await controller.sendCounterOffer(
                            requestId,
                            orderId,
                            selectedTier!.toDouble(),
                            context,
                          );
                        },
                  child: const Text('Proposer'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
