// import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/core/models/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/core/models/error_response.dart';

class ApiChecker {
  static void checkApi(dynamic apiresponse, [BuildContext? context]) {
    final int? statusCode = apiresponse is ApiResponseModel ? apiresponse.response?.statusCode : (apiresponse.response as Response?)?.statusCode;
    final dynamic error = apiresponse.error;

    if (statusCode != 200 && context != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error?.toString() ?? 'Erreur'),
        backgroundColor: Colors.red,
      ));
    }
  }

  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      return error.message ?? 'Erreur réseau';
    }
    return error.toString();
  }

  static ErrorResponse getError(dynamic apiResponse) {
    ErrorResponse error;
    try {
      if (apiResponse is ApiResponseModel && apiResponse.error is String) {
        error = ErrorResponse(errors: [Errors(code: '', message: apiResponse.error.toString())]);
      } else if (apiResponse is ApiResponseModel && apiResponse.error is ErrorResponse) {
        error = apiResponse.error;
      } else if (apiResponse.error is Map<String, dynamic>) {
        error = ErrorResponse.fromJson(apiResponse.error);
      } else {
        error = ErrorResponse(errors: [Errors(code: '', message: apiResponse.error.toString())]);
      }
    } catch (e) {
      error = ErrorResponse(errors: [Errors(code: '', message: e.toString())]);
    }
    return error;
  }
}
