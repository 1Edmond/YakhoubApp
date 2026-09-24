
import 'dart:async';
import 'dart:convert';

import 'package:multishop_tchad/core/di/datasource/remote/dio/dio_client.dart';
import 'package:multishop_tchad/core/di/datasource/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/response/base/api_response.dart';
import 'package:multishop_tchad/features/vendor/product/domain/models/product_model.dart';
import 'package:multishop_tchad/features/vendor/restock/domain/repositories/restock_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';

class RestockRepository implements RestockRepositoryInterface{
  final DioClient? dioClient;
  RestockRepository({required this.dioClient});


  @override
  Future<ApiResponse> getRestockProductList(Map<dynamic, dynamic> data) async {
    try {
      //final response = await dioClient!.get('${AppConstants.getRestockList}?search=$_searchText&category_id=$_categoryId&limit=10&offset=$offset');
      final response = await dioClient!.post(AppConstants.getRestockList, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> deleteRestockProduct(String? type, String? id) async {
    try {
      final response = await dioClient!.post(
        AppConstants.getRestockList,
        data: {
          "type" : type,
          "id" : id
        }
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getRestockBrandList() async {
    try {
      final response = await dioClient!.get(AppConstants.restockBrandListUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> deleteRestockItem(int id) async {
    try {
      final response = await dioClient!.get(AppConstants.restockRequestDelete+id.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> updateRestockProductQuantity(int? productId,int currentStock, List <Variation> variation) async {
    try {
      final response = await dioClient!.post(AppConstants.restockUpdateProductQuantity,
          data: {
            "product_id": productId,
            "current_stock": currentStock,
            "variation" : jsonEncode(variation),
            // "_method":"put"
          }
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> updateProductQuantity(int? productId,int currentStock, List <Variation> variation) async {
    try {
      final response = await dioClient!.post(AppConstants.updateProductQuantity,
          data: {
            "product_id": productId,
            "current_stock": currentStock,
            "variation" : variation,
            "_method":"put"
          }
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
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
