import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/vault/compare/domain/repositories/compare_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';

class CompareRepository implements CompareRepositoryInterface {
  final DioClient? dioClient;
  CompareRepository({required this.dioClient});

  @override
  Future<ApiResponseModel> getList({int? offset}) async {
    try {
      final response = await dioClient!.get(AppConstants.getCompareList);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> addCompareProductList(int id) async {
    try {
      final response = await dioClient!.post(AppConstants.addToCompareList, data: {'product_id' : id});
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> removeAllCompareProductList() async {
    try {
      final response = await dioClient!.post(AppConstants.removeAllFromCompareList, data: {'_method':'delete'});
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponseModel> replaceCompareProductList(int compareId, int productId) async {
    try {
      final response = await dioClient!.get('${AppConstants.replaceFromCompareList}?compare_id=$compareId&product_id=$productId');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> getAttributeList() async {
    try {
      final response = await dioClient!.get(AppConstants.attributeUri);
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
