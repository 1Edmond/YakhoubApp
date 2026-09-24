import 'dart:developer';
import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/auth/controllers/auth_controller.dart';
import 'package:multishop_tchad/features/vault/shipping/domain/repositories/shipping_repository_interface.dart';
import 'package:multishop_tchad/main.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'package:provider/provider.dart';

class ShippingRepository implements ShippingRepositoryInterface{
  final DioClient? dioClient;
  ShippingRepository({required this.dioClient});



  @override
  Future<ApiResponseModel> getShippingMethod(int? sellerId, String? type) async {
    try {
      final response = await dioClient!.get('${AppConstants.getShippingMethod}/$sellerId/$type?guest_id=1');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponseModel> addShippingMethod(int? id, String? cartGroupId) async {
    log('===>${{"id":id, "cart_group_id": cartGroupId}}');
    try {
      final response = await dioClient!.post(AppConstants.chooseShippingMethod,
          data: {"id":id, 'guest_id' : Provider.of<AuthController>(Get.context!, listen: false).getGuestToken(),
            "cart_group_id": cartGroupId});
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> getChosenShippingMethod() async {
    try {
      final response =await dioClient!.get('${AppConstants.chosenShippingMethod}?guest_id=${Provider.of<AuthController>(Get.context!, listen: false).getGuestToken()}');
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
  Future update(Map<String, dynamic> body, int id) {
    throw UnimplementedError();
  }


  @override
  Future getList({int? offset}) {
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    throw UnimplementedError();
  }
}
