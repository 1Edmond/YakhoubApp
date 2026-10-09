import 'package:multishop_tchad/core/di/datasource/remote/dio/dio_client.dart';
import 'package:multishop_tchad/core/di/datasource/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/di/model/response/base/api_response.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';

class TransferAccountRepository {
  final DioClient dioClient;

  TransferAccountRepository({required this.dioClient});

  Future<ApiResponse> getTransferAccounts() async {
    try {
      final response = await dioClient.get('/api/v3/seller/transfer-accounts');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addTransferAccount(Map<String, dynamic> data) async {
    try {
      final response = await dioClient.post('/api/v3/seller/transfer-accounts', data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateTransferAccount(int id, Map<String, dynamic> data) async {
    try {
      final response = await dioClient.put('/api/v3/seller/transfer-accounts/$id', data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> deleteTransferAccount(int id) async {
    try {
      final response = await dioClient.delete('/api/v3/seller/transfer-accounts/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getTransferOperators() async {
    try {
      final response = await dioClient.get('/api/v3/seller/transfer-operators');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}

