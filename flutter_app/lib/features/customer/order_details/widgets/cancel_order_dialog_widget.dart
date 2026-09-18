import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order/controllers/order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/core/constants/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/core/constants/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/core/constants/images.dart';
import 'package:flutter_sixvalley_ecommerce/core/widgets/base/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/core/widgets/base/show_custom_snakbar_widget.dart';
import 'package:provider/provider.dart';

class CancelOrderDialogWidget extends StatefulWidget {
  final int? orderId;
   const CancelOrderDialogWidget({super.key, required this.orderId});

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
              const SizedBox(height: Dimensions.homePagePadding),


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
                        showDialog(context: context, builder: (context) => AlertDialog(
                          title: const Text("Frais d'annulation (1000 FCFA)"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Veuillez payer les frais d'annulation de 1 000 FCFA pour confirmer l'annulation. Le montant de votre commande sera remboursé dans votre Wallet."),
                              const SizedBox(height: 10),
                              const TextField(
                                obscureText: true,
                                keyboardType: TextInputType.number,
                                maxLength: 4,
                                decoration: InputDecoration(border: OutlineInputBorder(), hintText: "Code PIN Mobile Money"),
                              )
                            ]
                          ),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Retour")),
                            TextButton(onPressed: () {
                              Navigator.pop(context);
                              if(!orderController.isLoading){
                                orderController.cancelOrder(context, widget.orderId).then((value) {
                                  if (value.response!.statusCode == 200) {
                                    orderController.getOrderList(1, orderController.selectedType);
                                    if(context.mounted) {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      showCustomSnackBarWidget("Paiement réussi. Commande annulée. Remboursement transféré dans votre Wallet.", context, isError: false);
                                    }
                                  }
                                });
                              }
                            }, child: const Text("Payer & Annuler")),
                          ]
                        ));
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
