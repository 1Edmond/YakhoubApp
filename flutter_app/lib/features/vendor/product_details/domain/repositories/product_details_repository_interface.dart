import 'dart:io';
import 'package:multishop_tchad/core/di/model/response/base/api_response.dart';

abstract class ProductDetailsRepositoryInterface {
  Future<ApiResponse> getProductDetails(int? productId);
  Future<ApiResponse> productStatusOnOff(int? productId, int status);
  Future<HttpClientResponse> previewDownload(String url);
}
