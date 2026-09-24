
import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/vault/reorder/domain/repositories/re_order_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'dart:async';

class ReOrderRepository implements ReOrderRepositoryInterface{
  final DioClient? dioClient;
  ReOrderRepository({required this.dioClient});

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
