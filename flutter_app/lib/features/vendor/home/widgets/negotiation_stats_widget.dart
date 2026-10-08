import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multishop_tchad/features/vendor/order_details/controllers/vendor_reduction_controller.dart';
import 'package:multishop_tchad/core/localization/language_constrants.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:multishop_tchad/core/constants/custom_themes.dart';
import 'package:multishop_tchad/features/vendor/home/widgets/order_type_button_head_widget.dart';
import 'package:multishop_tchad/core/helpers/route_helper.dart';
import 'package:multishop_tchad/features/vendor/negotiation/screens/vendor_negotiations_screen.dart';

class NegotiationStatsWidget extends StatelessWidget {
  const NegotiationStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VendorReductionController>(
      builder: (context, controller, child) {
        if (controller.allRequests.isEmpty && !controller.isLoading) return const SizedBox();
        
        return Container(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(color: Theme.of(context).primaryColor.withValues(alpha: .05), spreadRadius: -3, blurRadius: 12, offset: Offset.fromDirection(0,6))
            ],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
              child: Row(children: [
                  const Icon(Icons.handshake_rounded, size: 24, color: Color(0xFF1976D2)),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Text(getTranslated('negotiations', context) ?? 'Négociations', style: robotoBold.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeLarge,
                  )),
                ],
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,0, Dimensions.paddingSizeSmall,Dimensions.fontSizeSmall),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: (1 / .75),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VendorNegotiationsScreen())),
                    child: Container(
                      margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                      ),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(controller.pendingCount.toString(), style: robotoBold.copyWith(fontSize: 30, color: Colors.orange)),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        Text(getTranslated('pending_negotiations', context) ?? 'En attente', style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color)),
                      ]),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VendorNegotiationsScreen())),
                    child: Container(
                      margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                      ),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(controller.historyRequests.where((r) => r.status == 'accepted').length.toString(), style: robotoBold.copyWith(fontSize: 30, color: Colors.green)),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        Text(getTranslated('accepted', context) ?? 'Acceptées', style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color)),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}
