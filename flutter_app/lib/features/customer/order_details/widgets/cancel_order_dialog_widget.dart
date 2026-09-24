import 'package:flutter/material.dart';
import 'package:multishop_tchad/features/customer/order/controllers/order_controller.dart';
import 'package:multishop_tchad/localization/language_constrants.dart';
import 'package:multishop_tchad/core/constants/custom_themes.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:multishop_tchad/core/constants/images.dart';
import 'package:multishop_tchad/core/widgets/base/custom_button_widget.dart';
import 'package:multishop_tchad/core/widgets/base/show_custom_snakbar_widget.dart';
import 'package:provider/provider.dart';

import 'package:multishop_tchad/features/customer/order/domain/models/order_model.dart';

class CancelOrderDialogWidget extends StatefulWidget {
  final int? orderId;
  final Orders? orderModel;
   const CancelOrderDialogWidget({super.key, required this.orderId, this.orderModel});

  @override
  State<CancelOrderDialogWidget> createState() => _CancelOrderDialogWidgetState();
}

class _CancelOrderDialogWidgetState extends State<CancelOrderDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Align(alignment: Alignment.topRight,
          child: InkWell(onTap: (){
              Navigator.pop(context);
            },
            child: Container(decoration: BoxDecoration(shape: BoxShape.circle,
                color: Theme.of(context).cardColor.withValues(alpha:0.5)),
              padding: const EdgeInsets.all(3),
              child: const Icon(Icons.clear)))),
        const SizedBox(height: Dimensions.paddingSizeSmall),


        Container(decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            color: Theme.of(context).cardColor),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(Dimensions.homePagePadding),
          child: Column(children: [
              Image.asset(Images.cancelOrder, height: 60),
              const SizedBox(height: Dimensions.homePagePadding),

              Text(getTranslated('are_you_sure_you_want_to_cancel_your_order', context)!,
                textAlign: TextAlign.center,
                style: titilliumBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge?.color )),
              const SizedBox(height: Dimensions.homePagePadding),
              
              if(widget.orderModel?.orderStatus != 'pending')
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding),
                  child: Text(
                    "Si votre commande est déjà en cours de préparation ou expédiée, des frais d'annulation de 1000 FCFA seront déduits de votre portefeuille.",
                    textAlign: TextAlign.center,
                    style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).colorScheme.error),
                  ),
                ),


              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(child: CustomButton(
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  backgroundColor: Theme.of(context).hintColor.withValues(alpha:0.50),
                  buttonText:  getTranslated('NO', context)!,
                  onTap: () {
                    Navigator.pop(context);})),
                const SizedBox(width: Dimensions.paddingSizeSmall),

                Expanded(child: Consumer<OrderController>(
                  builder: (context, orderController,_) {
                    return CustomButton(
                      buttonText:  getTranslated('YES', context)!,
                      onTap: () {
                        if(!orderController.isLoading){
                          orderController.cancelOrder(context, widget.orderId).then((value) {
                            if (value.response != null && value.response!.statusCode == 200) {
                              orderController.getOrderList(1, orderController.selectedType);
                              if(context.mounted) {
                                Navigator.pop(context);
                                showCustomSnackBarWidget("Commande annulée.", context, isError: false);
                              }
                            }
                          });
                        }
                      },
                    );
                  }
                )),
              ]),
            ],
          ),
        ),
      ],
      ),
    );
  }
}
