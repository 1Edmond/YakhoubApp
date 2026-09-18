import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/core/guest/mock_data.dart';
import 'package:flutter_sixvalley_ecommerce/core/constants/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/features/vendor/utill/app_constants.dart' as v_app_constants;

class GuestModeInterceptor extends Interceptor {
  final bool Function() isGuestMode;

  GuestModeInterceptor({required this.isGuestMode});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (isGuestMode()) {
      if (options.path.contains(AppConstants.configUri) || options.path.contains(v_app_constants.AppConstants.configUri)) {
        return handler.resolve(
          Response(
            requestOptions: options,
            statusCode: 200,
            data: MockData.configResponse,
          ),
        );
      }
      if (options.path.contains(AppConstants.loginUri) || options.path.contains(v_app_constants.AppConstants.loginUri)) {
        return handler.resolve(
          Response(
            requestOptions: options,
            statusCode: 200,
            data: MockData.loginResponse,
          ),
        );
      }
      if (options.path.contains(AppConstants.customerUri)) {
        return handler.resolve(
          Response(
            requestOptions: options,
            statusCode: 200,
            data: MockData.userInfo,
          ),
        );
      }
      if (options.path.contains(v_app_constants.AppConstants.sellerUri)) {
        return handler.resolve(
          Response(
            requestOptions: options,
            statusCode: 200,
            data: MockData.vendorInfo,
          ),
        );
      }
      // Provide generic empty success responses for other requests to prevent crashes
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {},
        ),
      );
    }
    super.onRequest(options, handler);
  }
}
