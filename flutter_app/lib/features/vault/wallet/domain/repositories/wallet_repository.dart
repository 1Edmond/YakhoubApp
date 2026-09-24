import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/customer/splash/controllers/splash_controller.dart';
import 'package:multishop_tchad/features/vault/wallet/domain/repositories/wallet_repository_interface.dart';
import 'package:multishop_tchad/core/helpers/date_converter.dart';
import 'package:multishop_tchad/main.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'package:provider/provider.dart';

class WalletRepository implements WalletRepositoryInterface{
  final DioClient? dioClient;
  WalletRepository({required this.dioClient});


  @override
  Future getList({int? offset = 1, String? filterBy, DateTime? startDate, DateTime? endDate, List<String>? transactionTypes}) async{

    // Build query parameters dynamically
    final Map<String, dynamic> queryParams = {
      'offset': offset,
      'limit': 10,
      if (filterBy != null && filterBy.isNotEmpty) 'filter_by': filterBy,
      if (startDate != null) 'start_date': DateConverter.durationDateTime(startDate),
      if (endDate != null) 'end_date': DateConverter.durationDateTime(endDate),
      if (transactionTypes != null && transactionTypes.isNotEmpty) 'transaction_types': jsonEncode(transactionTypes),
    };

    debugPrint('--------(loyalty_query)----$queryParams');

    try {
      Response response = await dioClient!.get(AppConstants.walletTransactionUri, queryParameters: queryParams);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // @override
  // Future<ApiResponse> getWalletTransactionList(int offset, String types, String startDate, String endDate, String filterByType) async {
  //   try {
  //     Response response = await dioClient!.get('${AppConstants.walletTransactionUri}$offset&transaction_types=$types&start_date=$startDate&end_date=$endDate&filter_by=$filterByType');
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }


  @override
  Future<ApiResponseModel> addFundToWallet(String amount, String paymentMethod, {String? paymentPhone}) async {
    try {
      final response = await dioClient!.post(AppConstants.addFundToWallet,
          data: {'payment_platform': 'app',
            'payment_method' : paymentMethod,
            'payment_phone': paymentPhone,
            'payment_request_from': 'app',
            'amount': amount,
            'current_currency_code': Provider.of<SplashController>(Get.context!, listen: false).myCurrency!.code

          });
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponseModel> getWalletBonusBannerList() async {
    try {
      Response response = await dioClient!.get(AppConstants.walletBonusList);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    throw UnimplementedError();
  }




  @override
  Future update(Map<String, dynamic> body, int id) {
    throw UnimplementedError();
  }
}
