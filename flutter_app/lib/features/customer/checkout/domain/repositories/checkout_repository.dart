import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sixvalley_ecommerce/core/di/data_sources/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/core/di/data_sources/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/core/models/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/checkout/domain/repositories/checkout_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/core/constants/app_constants.dart';
import 'dart:async';
import 'package:provider/provider.dart';

class CheckoutRepository implements CheckoutRepositoryInterface{
  final DioClient? dioClient;
  CheckoutRepository({required this.dioClient});


  @override
  Future<ApiResponseModel> cashOnDeliveryPlaceOrder(
      {String? addressID,
        String? couponCode,
        String? couponDiscountAmount,
        String? billingAddressId,
        String? orderNote,
        bool? isCheckCreateAccount,
        String? password,
        double? cashChangeAmount,
        String? currentCurrencyCode,
        dynamic doorPhoto,
        double? doorLatitude,
        double? doorLongitude,
        String? deliveryQuarter,
        String? deliveryStreet,
        String? deliveryDescription,
      }) async {
    try {
      final Map<String, dynamic> data = {
        'address_id': addressID,
        'coupon_code': couponCode,
        'coupon_discount': couponDiscountAmount.toString(),
        'billing_address_id': billingAddressId,
        'order_note': orderNote,
        'guest_id': Provider.of<AuthController>(Get.context!, listen: false).getGuestToken(),
        'is_guest': '${Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn() ? 0 : 1}',
        'is_check_create_account': (isCheckCreateAccount ?? false) ? 1 : 0,
        'password': password,
        'bring_change_amount' : cashChangeAmount,
        'current_currency_code': currentCurrencyCode,
        'door_latitude': doorLatitude,
        'door_longitude': doorLongitude,
        'delivery_quarter': deliveryQuarter,
        'delivery_street': deliveryStreet,
        'delivery_description': deliveryDescription,
      };
      
      data.removeWhere((key, value) => value == null || value.toString().isEmpty);

      List<MultipartWithKey> files = [];
      if (doorPhoto != null) {
        if (doorPhoto is File) {
          files.add(MultipartWithKey(
            key: 'door_photo_url',
            multipartFile: await MultipartFile.fromFile(doorPhoto.path),
          ));
        }
      }

      debugPrint('----------(order_place_multipart)-----$data');

      final response = await dioClient!.postMultipart(
        AppConstants.orderPlaceUri,
        data: data,
        files: files,
      );
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponseModel> offlinePaymentPlaceOrder(String? addressID, String? couponCode, String? couponDiscountAmount, String? billingAddressId, String? orderNote, List <String?> typeKey, List<String> typeValue, int? id, String name, String? paymentNote, bool? isCheckCreateAccount, String? password) async {
    try {
      Map<String?, String> fields = {};
      Map<String?, String> info = {};
      for(var i = 0; i < typeKey.length; i++){
        info.addAll(<String?, String>{
          typeKey[i] : typeValue[i]
        });
      }

      int isCheckAccount = isCheckCreateAccount! ? 1: 0;
      fields.addAll(<String, String>{
        "method_informations" : base64.encode(utf8.encode(jsonEncode(info))),
        'method_name': name,
        'method_id': id.toString(),
        'payment_note' : paymentNote??'',
        'address_id': addressID??'',
        'coupon_code' : couponCode??"",
        'coupon_discount' : couponDiscountAmount??'',
        'billing_address_id' : billingAddressId??'',
        'order_note' : orderNote??'',
        'guest_id': Provider.of<AuthController>(Get.context!, listen: false).getGuestToken()??'',
        'is_guest' : Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn()? '0':'1',
        'is_check_create_account' : isCheckAccount.toString(),
        'password' : password ?? '',
      });
      Response response = await dioClient!.post(AppConstants.offlinePayment, data: fields);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponseModel> walletPaymentPlaceOrder(String? addressID, String? couponCode,String? couponDiscountAmount, String? billingAddressId, String? orderNote, bool? isCheckCreateAccount, String? password) async {
    int isCheckAccount = isCheckCreateAccount! ? 1: 0;
    try {
      final response = await dioClient!.get('${AppConstants.walletPayment}?address_id=$addressID&coupon_code=$couponCode&coupon_discount=$couponDiscountAmount&billing_address_id=$billingAddressId&order_note=$orderNote&guest_id=${Provider.of<AuthController>(Get.context!, listen: false).getGuestToken()}&is_guest=${Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn()? 0 :1}&is_check_create_account=$isCheckAccount&password=$password',);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponseModel> offlinePaymentList() async {
    try {
      final response = await dioClient!.get('${AppConstants.offlinePaymentList}?guest_id=${Provider.of<AuthController>(Get.context!, listen: false).getGuestToken()}&is_guest=${!Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn()}');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> digitalPaymentPlaceOrder(
      String? orderNote,
      String? customerId,
      String? addressId,
      String? billingAddressId,
      String? couponCode,
      String? couponDiscount,
      String? paymentMethod,
      bool? isCheckCreateAccount,
      String? password,
      {String? paymentPhone}
      ) async {

    try {
      int isCheckAccount = isCheckCreateAccount! ? 1: 0;
      final response = await dioClient!.post(AppConstants.digitalPayment, data: {
        "order_note": orderNote,
        "customer_id":  customerId,
        "address_id": addressId,
        "billing_address_id": billingAddressId,
        "coupon_code": couponCode,
        "coupon_discount": couponDiscount,
        "payment_platform" : "app",
        "payment_method" : paymentMethod,
        "payment_phone" : paymentPhone,
        "callback" : null,
        "payment_request_from" : "app",
        'guest_id' : Provider.of<AuthController>(Get.context!, listen: false).getGuestToken(),
        'is_guest': !Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn(),
        'is_check_create_account' : isCheckAccount.toString(),
        'password' : password,
      });
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      final error = e as DioException;
      return ApiResponseModel.withError( ApiErrorHandler.getMessage(e), responseValue: (error.response) );
    }
  }

  @override
  Future<ApiResponseModel> getReferralAmount(String? amount) async {
    try {
      final response = await dioClient!.post(
        AppConstants.referralAmountUri,
        data : {'coupon_discount' : amount}
      );
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future add(value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
