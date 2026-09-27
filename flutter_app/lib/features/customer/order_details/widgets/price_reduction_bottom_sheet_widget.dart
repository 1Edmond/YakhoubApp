import 'package:flutter/material.dart';
import 'package:multishop_tchad/core/constants/custom_themes.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:multishop_tchad/core/widgets/base/custom_button_widget.dart';
import 'package:multishop_tchad/features/customer/order_details/controllers/price_reduction_controller.dart';
import 'package:provider/provider.dart';

class PriceReductionBottomSheetWidget extends StatelessWidget {
  final int orderId;
  final double orderAmount;

  const PriceReductionBottomSheetWidget({
    super.key,
    required this.orderId,
    required this.orderAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PriceReductionController>(
      builder: (context, controller, child) {
        return Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.paddingSizeDefault)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).hintColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),

              Text(
                'Demander une réduction',
                style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              Text(
                'Montant de la commande : ${orderAmount.toStringAsFixed(0)} FCFA',
                style: titilliumRegular.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context).hintColor,
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              Text(
                'Sélectionnez un palier de réduction autorisé :',
                style: robotoRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.tiers.map((tier) {
                  final isSelected = controller.selectedTier == tier;
                  return ChoiceChip(
                    label: Text(
                      '- $tier FCFA',
                      style: robotoMedium.copyWith(
                        color: isSelected ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: Dimensions.fontSizeDefault,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                      side: BorderSide(
                        color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).hintColor.withValues(alpha: 0.3),
                      ),
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        controller.selectTier(tier);
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),

              if (controller.selectedTier != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                  child: Container(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Nouveau prix proposé :', style: robotoRegular),
                        Text(
                          '${(orderAmount - controller.selectedTier!).clamp(0, double.infinity).toStringAsFixed(0)} FCFA',
                          style: robotoBold.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      buttonText: 'Envoyer la demande',
                      onTap: controller.selectedTier == null
                          ? null
                          : () async {
                              final success = await controller.sendReductionRequest(
                                orderId: orderId,
                                requestedReduction: controller.selectedTier!.toDouble(),
                                context: context,
                              );
                              if (success && context.mounted) {
                                Navigator.pop(context);
                              }
                            },
                    ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
            ],
          ),
        );
      },
    );
  }
}
