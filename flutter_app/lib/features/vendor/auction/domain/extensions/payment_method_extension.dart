import 'package:flutter/material.dart';
import 'package:multishop_tchad/core/localization/language_constrants.dart';

extension PaymentMethodLabelExtension on String? {
  String toPaymentMethodLabel(BuildContext context) {
    return getTranslated(this ?? '', context) ?? this ?? '';
  }
}
