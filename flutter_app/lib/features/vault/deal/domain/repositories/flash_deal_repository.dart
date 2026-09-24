import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/vault/deal/domain/repositories/flash_deal_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';

class FlashDealRepository implements FlashDealRepositoryInterface{
  final DioClient? dioClient;
  FlashDealRepository({required this.dioClient});

  @override
  Future<ApiResponseModel> getFlashDeal() async {
    try {
      final response = await dioClient!.get(AppConstants.flashDealUri);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> get(String productID, {int offset = 1, int limit = 10}) async {
    try {
      final response = await dioClient!.get(
        '${AppConstants.flashDealProductUri}$productID?limit=$limit&offset=$offset',
      );
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
  Future getList({int? offset = 1}) {
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    throw UnimplementedError();
  }
}
