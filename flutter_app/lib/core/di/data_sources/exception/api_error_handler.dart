
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:multishop_tchad/core/models/error_response.dart';
import 'package:multishop_tchad/features/auth/controllers/auth_controller.dart';
import 'package:multishop_tchad/main.dart';
import 'package:provider/provider.dart';

class ApiErrorHandler {
  static dynamic getMessage(dynamic error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;
            case DioExceptionType.connectionTimeout:
              errorDescription = "Connection timeout with API server";
              break;
            case DioExceptionType.sendTimeout:
              errorDescription = "Send timeout";
              break;
            case DioExceptionType.receiveTimeout:
              errorDescription = "Receive timeout in connection with API server";
              break;
            case DioExceptionType.badResponse:
              final data = error.response?.data;
              final statusCode = error.response?.statusCode;

              if (statusCode == 401) {
                Provider.of<AuthController>(Get.context!, listen: false).clearSharedData();
              }

              if (data is Map<String, dynamic>) {
                if (data['errors'] != null) {
                  try {
                    ErrorResponse errorResponse = ErrorResponse.fromJson(data);
                    if (errorResponse.errors != null && errorResponse.errors!.isNotEmpty) {
                      errorDescription = errorResponse.errors?[0].message ?? '';
                    }
                  } catch (_) {}
                }
                if ((errorDescription == null || errorDescription == "") && data['message'] != null) {
                  errorDescription = data['message'].toString();
                }
              } else if (data is String && data.isNotEmpty) {
                if (!data.trim().startsWith('<')) {
                  errorDescription = data;
                }
              }

              if (errorDescription == "" || errorDescription == null) {
                switch (statusCode) {
                  case 404:
                    errorDescription = "Not found (404)";
                    break;
                  case 500:
                    errorDescription = "Internal server error (500)";
                    break;
                  case 503:
                    errorDescription = "Service unavailable (503)";
                    break;
                  case 429:
                    errorDescription = error.response?.statusMessage ?? "Too many requests";
                    break;
                  default:
                    errorDescription = "Failed to load data - status code: $statusCode";
                }
              }
              break;
            case DioExceptionType.badCertificate:
              errorDescription = "Bad certificate";
              break;
            case DioExceptionType.connectionError:
              errorDescription = "Connection error";
              break;
            case DioExceptionType.unknown:
              errorDescription = "Network request failed";
              break;
            case DioExceptionType.transformTimeout:
              errorDescription = "Connection timeout with API server";
              break;
          }
        } else {
          errorDescription = "Unexpected error occured";
        }
      } catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    return errorDescription;
  }
}
