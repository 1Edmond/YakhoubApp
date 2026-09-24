import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/customer/coupon/domain/repositories/coupon_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';

class CouponRepository implements CouponRepositoryInterface{
  final DioClient? dioClient;
  CouponRepository({required this.dioClient});

  @override
  Future<ApiResponseModel> get(dynamic coupon) async {
    try {
      final response = await dioClient!.get('${AppConstants.couponUri}$coupon');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> getList({int? offset}) async {
    try {
      final response = await dioClient!.get('${AppConstants.couponListApi}$offset');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> getAvailableCouponList() async {
    try {
      final response = await dioClient!.get(AppConstants.availableCoupon);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> getSellerCouponList(String slug, int offset) async {
    try {
      final response = await dioClient!.get('${AppConstants.sellerWiseCouponListApi}$slug/seller-wise-coupons?limit=100&offset=$offset');
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

}
