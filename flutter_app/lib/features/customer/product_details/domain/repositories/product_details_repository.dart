import 'dart:io';

import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/customer/product_details/domain/repositories/product_details_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';

class ProductDetailsRepository implements ProductDetailsRepositoryInterface {
  final DioClient? dioClient;
  ProductDetailsRepository({required this.dioClient});

  @override
  Future<ApiResponseModel> get(String productID) async {
    try {
      final response = await dioClient!.get('${AppConstants.productDetailsUri}$productID?guest_id=1');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }




  @override
  Future<ApiResponseModel> getCount(String productID) async {
    try {
      final response = await dioClient!.get(AppConstants.counterUri+productID);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> getSharableLink(String productID) async {
    try {
      final response = await dioClient!.get(AppConstants.socialLinkUri+productID);
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
  Future<HttpClientResponse> previewDownload(String? url) async {
    HttpClient client = HttpClient();
    final response = await client.getUrl(Uri.parse(url!)).then((HttpClientRequest request) {
      return request.close();
    },
    );
    return response;
  }


}
