import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';

class PriceReductionRepository {
  final DioClient? dioClient;
  PriceReductionRepository({required this.dioClient});

  Future<ApiResponseModel> getReductionTiers() async {
    try {
      final response = await dioClient!.get('/api/v1/reduction-tiers');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponseModel> requestReduction(int orderId, double requestedReduction) async {
    try {
      final response = await dioClient!.post(
        '/api/v1/customer/orders/$orderId/request-reduction',
        data: {'requested_reduction': requestedReduction},
      );
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponseModel> getMyReductionRequests() async {
    try {
      final response = await dioClient!.get('/api/v1/customer/reduction-requests');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponseModel> respondToCounterOffer(int requestId, bool accept) async {
    try {
      final response = await dioClient!.put(
        '/api/v1/customer/reduction-requests/$requestId/respond',
        data: {'accept': accept},
      );
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
