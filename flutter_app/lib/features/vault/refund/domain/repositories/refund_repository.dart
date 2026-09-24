import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/auth/controllers/auth_controller.dart';
import 'package:multishop_tchad/features/vault/refund/domain/repositories/refund_repository_interface.dart';
import 'package:multishop_tchad/main.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';



class RefundRepository implements RefundRepositoryInterface{
  final DioClient? dioClient;
  RefundRepository({required this.dioClient});


  @override
  Future<http.StreamedResponse> refundRequest(int? orderDetailsId, double? amount, String refundReason, List<XFile?> file) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.baseUrl}${AppConstants.refundRequestUri}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer ${Provider.of<AuthController>(Get.context!, listen: false).getUserToken()}'});
    for(int i=0; i<file.length;i++){
      Uint8List list = await file[i]!.readAsBytes();
      var part = http.MultipartFile('images[]', file[i]!.readAsBytes().asStream(), list.length, filename: basename(file[i]!.path), contentType: MediaType('image', 'jpg'));
      request.files.add(part);
    }
    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      'order_details_id': orderDetailsId.toString(),
      'amount': amount.toString(),
      'refund_reason':refundReason
    });
    request.fields.addAll(fields);
    http.StreamedResponse response = await request.send();
    return response;
  }



  @override
  Future<ApiResponseModel> getRefundInfo(int? orderDetailsId) async {
    try {
      final response = await dioClient!.get('${AppConstants.refundRequestPreReqUri}?order_details_id=$orderDetailsId');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponseModel> getRefundResult(int? orderDetailsId) async {
    try {
      final response = await dioClient!.get('${AppConstants.refundResultUri}?id=$orderDetailsId');
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
  Future getList({int? offset = 1}) {
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    throw UnimplementedError();
  }

}
