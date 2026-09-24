import 'dart:developer';

import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'dart:io';
import 'package:multishop_tchad/core/di/data_sources/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/features/auth/controllers/auth_controller.dart';
import 'package:multishop_tchad/features/vault/review/domain/models/review_body.dart';
import 'package:multishop_tchad/features/vault/review/domain/repositories/review_repository_interface.dart';
import 'package:multishop_tchad/main.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ReviewRepository implements ReviewRepositoryInterface{
  final DioClient dioClient;
  ReviewRepository({required this.dioClient});

  @override
  Future<ApiResponseModel> get(String productID, {int offset = 1, int limit = 10}) async {
    try {
      final response = await dioClient.get('${AppConstants.productReviewUri}$productID?limit=$limit&offset=$offset');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<http.StreamedResponse> submitReview(ReviewBody reviewBody, List<File> files,  bool update) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(update?'${AppConstants.baseUrl}${AppConstants.updateOrderWiseReview}':'${AppConstants.baseUrl}${AppConstants.submitReviewUri}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer ${Provider.of<AuthController>(Get.context!, listen: false).getUserToken()}'});
    for(int index=0; index <files.length ; index++) {
      if(files[index].path.isNotEmpty) {
        request.files.add(http.MultipartFile(
          'fileUpload[$index]',
          files[index].readAsBytes().asStream(),
          files[index].lengthSync(),
          filename: files[index].path.split('/').last,
        ));
      }
    }
    if(update){
      request.fields.addAll(<String, String>{
        "id" : reviewBody.id!,
        "order_id" : reviewBody.orderId!,
        'product_id': reviewBody.productId!,
        'comment': reviewBody.comment!,
        '_method' : "put",
        'rating': reviewBody.rating!});
    }else{
      log("----repo===>${reviewBody.orderId}");
      request.fields.addAll(<String, String>{
        "order_id" : reviewBody.orderId?? "100264",
        'product_id': reviewBody.productId!,
        'comment': reviewBody.comment!,
        'rating': reviewBody.rating!});
    }

    log("Here is Body==> ${request.fields.toString()}===>");
    http.StreamedResponse response = await request.send();
    log("Here is Body==> ${request.fields.toString()}===> ${response.statusCode}/${response.stream.asBroadcastStream()}");
    return response;
  }



  @override
  Future<ApiResponseModel> getOrderWiseReview(String productID, String orderId) async {
    try {
      final response = await dioClient.get("${AppConstants.getOrderWiseReview}$productID/$orderId");
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> deleteOrderWiseReviewImage(String id, String name) async {
    try {
      final response = await dioClient.post(AppConstants.deleteOrderWiseReviewImage, data: {
        "id" : id,
        "name" : name,
        "_method" : "delete"
      });
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> getDeliveryManReview(String orderId) async {
    try {
      final response = await dioClient.get("${AppConstants.getDeliveryManReview}$orderId");
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> submitDeliveryManReview(String orderId, String comment, String rating) async {
    try {
      final response = await dioClient.post(
        '${AppConstants.submitDeliveryManReview}$orderId',
        data: {
          'comment': comment,
          'rating': rating,
        },
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
