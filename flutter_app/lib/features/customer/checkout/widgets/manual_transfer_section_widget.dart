import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multishop_tchad/core/helpers/price_converter.dart';
import 'package:multishop_tchad/core/localization/language_constrants.dart';
import 'package:multishop_tchad/core/widgets/base/custom_button_widget.dart';
import 'package:multishop_tchad/core/widgets/base/ltr_content_widget.dart';
import 'package:multishop_tchad/features/customer/checkout/controllers/checkout_controller.dart';
import 'package:multishop_tchad/core/constants/custom_themes.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:provider/provider.dart';

/// Paiement CDC 3.4.4 : Airtel Money / Moov Money par transfert manuel (preuve + référence).
/// [orderAmount] = total de la commande HORS frais de transfert.
class ManualTransferSectionWidget extends StatefulWidget {
  final double orderAmount;
  const ManualTransferSectionWidget({super.key, required this.orderAmount});

  @override
  State<ManualTransferSectionWidget> createState() => _ManualTransferSectionWidgetState();
}

class _ManualTransferSectionWidgetState extends State<ManualTransferSectionWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CheckoutController>().fetchTransferAccounts(widget.orderAmount);
      }
    });
  }

  Future<void> _pickProof() async {
    final controller = context.read<CheckoutController>();
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(children: [
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: Text(getTranslated('take_photo', context) ?? ''),
            onTap: () => Navigator.pop(context, ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: Text(getTranslated('choose_from_gallery', context) ?? ''),
            onTap: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ]),
      ),
    );
    if (source != null) await controller.pickManualTransferProof(source);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutController>(builder: (context, c, _) {
      final selected = c.selectedTransferAccount;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(getTranslated('select_transfer_account', context) ?? '', style: textBold),
          const SizedBox(height: Dimensions.paddingSizeSmall),

          if (c.isLoadingTransferAccounts)
            const Center(child: CircularProgressIndicator())
          else if (c.transferAccounts.isEmpty) ...[
            Text(getTranslated('no_transfer_account_available', context) ?? ''),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            CustomButton(
              buttonText: getTranslated('retry', context) ?? '',
              onTap: () => c.fetchTransferAccounts(widget.orderAmount),
            ),
          ] else
            ...c.transferAccounts.map((a) {
              final isSelected = selected?.id == a.id;
              return InkWell(
                onTap: () => c.selectTransferAccount(a),
                child: Container(
                  margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).hintColor.withValues(alpha: .4)),
                  ),
                  child: Row(children: [
                    Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                        color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).hintColor),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(a.operatorName, style: textBold),
                      LtrContent(child: Text(a.accountNumber)),
                      Text(a.accountName),
                    ])),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text(getTranslated('transfer_fee', context) ?? ''),
                      LtrContent(child: Text(PriceConverter.convertPrice(context, a.transferFee))),
                    ]),
                  ]),
                ),
              );
            }),

          if (selected != null) ...[
            const SizedBox(height: Dimensions.paddingSizeSmall),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(getTranslated('amount_to_transfer', context) ?? '', style: textBold),
              LtrContent(child: Text(PriceConverter.convertPrice(context, widget.orderAmount + selected.transferFee), style: textBold)),
            ]),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            TextField(
              controller: c.manualTransferRefController,
              onChanged: (_) => c.refreshManualTransfer(),
              decoration: InputDecoration(hintText: getTranslated('transaction_reference', context)),
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            if (c.manualTransferProofImage != null)
              Row(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(File(c.manualTransferProofImage!.path), width: 72, height: 72, fit: BoxFit.cover),
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(child: Text(getTranslated('proof_attached', context) ?? '')),
                IconButton(icon: const Icon(Icons.delete_outline), onPressed: c.clearManualTransferProof),
              ])
            else
              CustomButton(
                isBorder: true,
                buttonText: getTranslated('upload_proof_image', context) ?? '',
                onTap: _pickProof,
              ),
          ],
        ]),
      );
    });
  }
}
