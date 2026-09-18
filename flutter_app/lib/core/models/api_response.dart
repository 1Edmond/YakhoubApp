import 'package:dio/dio.dart';

class ApiResponseModel<T> {
  final T? response;
  final dynamic error;
  final bool isSuccess;

  ApiResponseModel(this.response, this.error, this.isSuccess);

  ApiResponseModel.withError(dynamic errorValue, {T? responseValue}) : response = responseValue, error = errorValue, isSuccess = false;

  ApiResponseModel.withSuccess(T? responseValue)
      : response = responseValue,
        error = null, isSuccess = true;
}

/// Vendor app compatibility - uses Dio Response directly
class ApiResponse {
  final Response? response;
  final dynamic error;

  ApiResponse(this.response, this.error);

  ApiResponse.withError(dynamic errorValue)
      : response = null,
        error = errorValue;

  ApiResponse.withSuccess(Response responseValue)
      : response = responseValue,
        error = null;
}
