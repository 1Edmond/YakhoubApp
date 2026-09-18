import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/core/widgets/base/custom_toast.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/core/constants/dimensions.dart';
import 'package:fluttertoast/fluttertoast.dart';

 void showCustomSnackBar(String? message, BuildContext context, {bool isError = true, bool isToaster = false}) {
   Fluttertoast.showToast(
     msg: message!,
     toastLength: Toast.LENGTH_SHORT,
     gravity: ToastGravity.BOTTOM,

     timeInSecForIosWeb: 1,
     backgroundColor: isError ? const Color(0xFFFF0014) : const Color(0xFF1E7C15),
     textColor: Colors.white,
     fontSize: 16.0
   );
}

enum SnackBarType {
  error,
  warning,
  success,
}

void showCustomSnackBarWidget(String? message, BuildContext? context, {
  SnackBarType snackBarType = SnackBarType.success,
  SnackBarType sanckBarType = SnackBarType.success, // vendor app compat (typo)
  bool isError = false,
  bool isToaster = false,
}) {
  // Use sanckBarType if it was explicitly set (vendor compat), otherwise snackBarType
  final effectiveType = isError ? SnackBarType.error : sanckBarType;
  final scaffold = ScaffoldMessenger.of(context ?? Get.context!);
  scaffold.showSnackBar(
    SnackBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      content: CustomToast(text: message ?? '', sanckBarType: effectiveType),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

void showOverlaySnackBar(BuildContext context, String? message,
    {SnackBarType snackBarType = SnackBarType.success, Duration duration = const Duration(seconds: 3)}) {
  final overlay = Overlay.of(context);
  if (message == null || message.isEmpty) return;

  final bottomInset = MediaQuery.of(context).viewInsets.bottom;

  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, bottom: bottomInset + Dimensions.paddingSizeDefault,
      child: Material(color: Colors.transparent, child: CustomToast(text: message, sanckBarType: snackBarType))),
  );

  overlay.insert(overlayEntry);

  Future.delayed(duration, () {
    overlayEntry.remove();
  });
}

void showCustomToast({bool isSuccess = true, required String message, required BuildContext context}) {
  showCustomSnackBarWidget(message, context, snackBarType: isSuccess ? SnackBarType.success : SnackBarType.error);
}
