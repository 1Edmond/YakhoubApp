import 'package:flutter/material.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'package:multishop_tchad/core/constants/custom_themes.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:multishop_tchad/core/helpers/price_converter.dart';
import 'package:multishop_tchad/core/localization/language_constrants.dart';
import 'package:multishop_tchad/core/widgets/base/custom_button_widget.dart';
import 'package:multishop_tchad/core/widgets/base/custom_image_widget.dart';
import 'package:multishop_tchad/features/customer/cart/controllers/cart_controller.dart';
import 'package:multishop_tchad/features/customer/cart/domain/models/cart_model.dart';
import 'package:provider/provider.dart';

class CartProductNegotiationBottomSheet extends StatefulWidget {
  final CartModel cartModel;
  final int index;

  const CartProductNegotiationBottomSheet({
    super.key,
    required this.cartModel,
    required this.index,
  });

  @override
  State<CartProductNegotiationBottomSheet> createState() =>
      _CartProductNegotiationBottomSheetState();
}

class _CartProductNegotiationBottomSheetState
    extends State<CartProductNegotiationBottomSheet> {
  int? _selectedTier;

  @override
  void initState() {
    super.initState();
    // Default select first tier smaller than price
    final double price = widget.cartModel.price ?? 0;
    for (int tier in AppConstants.reductionTiers) {
      if (tier < price) {
        _selectedTier = tier;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double unitPrice = widget.cartModel.price ?? 0;
    final int quantity = widget.cartModel.quantity ?? 1;
    final double reduction = (_selectedTier ?? 0).toDouble();
    final double proposedUnitPrice = (unitPrice - reduction).clamp(0, double.infinity);
    final double totalSavings = reduction * quantity;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Dimensions.radiusLarge),
        ),
      ),
      padding: EdgeInsets.only(
        left: Dimensions.paddingSizeDefault,
        right: Dimensions.paddingSizeDefault,
        top: Dimensions.paddingSizeDefault,
        bottom: MediaQuery.of(context).viewInsets.bottom + Dimensions.paddingSizeDefault,
      ),
      child: Consumer<CartController>(
        builder: (context, cartProvider, _) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    ),
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),

                // Title row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.handshake_outlined,
                          color: Theme.of(context).primaryColor,
                          size: 22,
                        ),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        Text(
                          getTranslated('negotiate_product_price', context) ??
                              'Négocier le prix de l\'article',
                          style: textBold.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const Divider(),

                // Product summary card
                Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                        child: CustomImageWidget(
                          image: '${widget.cartModel.thumbnailFullUrl?.path}',
                          height: 50,
                          width: 50,
                        ),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cartModel.name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textMedium.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${getTranslated('unit_price', context) ?? 'Prix unitaire'}: ${PriceConverter.convertPrice(context, unitPrice)} (x$quantity)',
                              style: textRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                // Section instruction
                Text(
                  getTranslated('select_reduction_tier', context) ??
                      'Choisissez un palier de réduction (FCFA) :',
                  style: titilliumSemiBold.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                Text(
                  getTranslated('negotiation_tier_hint', context) ??
                      'Le vendeur pourra accepter, refuser ou contre-proposer.',
                  style: textRegular.copyWith(
                    fontSize: Dimensions.fontSizeExtraSmall,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),

                // Tiers selection grid
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: AppConstants.reductionTiers.map((tier) {
                    final bool isEligible = tier < unitPrice;
                    final bool isSelected = _selectedTier == tier;

                    return ChoiceChip(
                      label: Text(
                        '- $tier FCFA',
                        style: titilliumSemiBold.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: !isEligible
                              ? Theme.of(context).disabledColor
                              : isSelected
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: Theme.of(context).primaryColor,
                      backgroundColor: Theme.of(context).cardColor,
                      disabledColor: Theme.of(context).disabledColor.withValues(alpha: 0.1),
                      side: BorderSide(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : isEligible
                                ? Theme.of(context).primaryColor.withValues(alpha: 0.3)
                                : Theme.of(context).disabledColor.withValues(alpha: 0.2),
                      ),
                      onSelected: isEligible
                          ? (selected) {
                              setState(() {
                                _selectedTier = selected ? tier : null;
                              });
                            }
                          : null,
                    );
                  }).toList(),
                ),
                const SizedBox(height: Dimensions.paddingSizeLarge),

                // Calculation recap box
                Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslated('current_unit_price', context) ?? 'Prix unitaire actuel',
                            style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                          ),
                          Text(
                            PriceConverter.convertPrice(context, unitPrice),
                            style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslated('requested_reduction', context) ?? 'Réduction demandée',
                            style: textRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          Text(
                            '- ${PriceConverter.convertPrice(context, reduction)}',
                            style: textBold.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslated('proposed_unit_price', context) ?? 'Nouveau prix unitaire proposé',
                            style: textBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                          ),
                          Text(
                            PriceConverter.convertPrice(context, proposedUnitPrice),
                            style: textBold.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      if (quantity > 1) ...[
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${getTranslated('total_savings', context) ?? 'Économie totale'} ($quantity art.)',
                              style: textRegular.copyWith(
                                fontSize: Dimensions.fontSizeExtraSmall,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              '- ${PriceConverter.convertPrice(context, totalSavings)}',
                              style: textBold.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeLarge),

                // Submit button
                CustomButton(
                  isLoading: cartProvider.isNegotiationLoading,
                  buttonText: getTranslated('send_negotiation_request', context) ??
                      'Envoyer la proposition au vendeur',
                  onTap: (_selectedTier != null && !cartProvider.isNegotiationLoading)
                      ? () async {
                          final success = await cartProvider.requestProductNegotiation(
                            widget.cartModel.id!,
                            _selectedTier!.toDouble(),
                          );
                          if (success && context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      : null,
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
              ],
            ),
          );
        },
      ),
    );
  }
}
