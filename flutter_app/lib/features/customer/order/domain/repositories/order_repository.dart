
import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/customer/order/domain/repositories/order_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'dart:async';

class OrderRepository implements OrderRepositoryInterface{
  final DioClient? dioClient;
  OrderRepository({required this.dioClient});


  @override
  Future<ApiResponseModel> getOrderList(int offset, String status, {String? type}) async {
    try {
      final response = await dioClient!.get('${AppConstants.orderUri}$offset&status=$status&type=$type');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponseModel> getTrackingInfo(String orderID) async {
    try {
      final response = await dioClient!.get(AppConstants.trackingUri+orderID);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> cancelOrder(int? orderId) async {
    try {
      final response = await dioClient!.get('${AppConstants.cancelOrderUri}?order_id=$orderId');
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
