import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/vault/restock/domain/repositories/restock_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'dart:async';

class RestockRepository implements RestockRepositoryInterface{
  final DioClient? dioClient;
  RestockRepository({required this.dioClient});

  @override
  Future<ApiResponseModel> reorder(String orderId) async {
    try {
      final response = await dioClient!.post(AppConstants.reorder, data: {'order_id': orderId});
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponseModel> getRestockProductList(String offset, bool getAll) async {
    try {
      final response = await dioClient!.get('${AppConstants.productRestockList}${getAll ? '' : 'limit=10&'}offset=$offset');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponseModel> deleteRestockProduct(String? type, String? id) async {
    try {
      final response = await dioClient!.post(
        AppConstants.productRestockDelete,
        data: {
          "type" : type,
          "id" : id
        }
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

  @override
  Future get(String id) {
    throw UnimplementedError();
  }




}
