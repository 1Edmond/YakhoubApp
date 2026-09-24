

import 'package:multishop_tchad/core/di/datasource/remote/dio/dio_client.dart';
import 'package:multishop_tchad/core/di/datasource/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/response/base/api_response.dart';
import 'package:multishop_tchad/features/vendor/barcode/domain/repositories/barcode_reposity_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';

class BarcodeRepository implements BarcodeRepositoryInterface{
  final DioClient dioClient;
  BarcodeRepository({required this.dioClient});

  @override
  Future<ApiResponse> barCodeDownLoad(int? id, int quantity) async {
    try {
      final response = await dioClient.get('${AppConstants.barCodeGenerateUri}?id=$id&quantity=$quantity',
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
  Future get(String id) {
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
