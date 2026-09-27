import 'package:multishop_tchad/core/di/datasource/remote/dio/dio_client.dart';
import 'package:multishop_tchad/core/di/datasource/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';

class VendorReductionRepository {
  final DioClient? dioClient;
  VendorReductionRepository({required this.dioClient});

  Future<ApiResponseModel> getReductionRequests() async {
    try {
      final response = await dioClient!.get('/api/v3/seller/reduction-requests');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponseModel> acceptReduction(int requestId) async {
    try {
      final response = await dioClient!.put('/api/v3/seller/reduction-requests/$requestId/accept');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponseModel> refuseReduction(int requestId) async {
    try {
      final response = await dioClient!.put('/api/v3/seller/reduction-requests/$requestId/refuse');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponseModel> counterOffer(int requestId, double counterAmount) async {
    try {
      final response = await dioClient!.put(
        '/api/v3/seller/reduction-requests/$requestId/counter-offer',
        data: {'counter_amount': counterAmount},
      );
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
