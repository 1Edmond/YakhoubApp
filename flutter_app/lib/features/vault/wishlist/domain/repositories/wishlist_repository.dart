import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/vault/wishlist/domain/repositories/wishlist_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';

class WishListRepository implements WishListRepositoryInterface{
  final DioClient? dioClient;

  WishListRepository({required this.dioClient});

  @override
  Future<ApiResponseModel> getList({int? offset = 1, String? search = ''}) async {
    try {
      final response = await dioClient!.get('${AppConstants.getWishListUri}?search=$search');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponseModel> getWishList({int? offset = 1, String? search = ''}) async {
    try {
      final response = await dioClient!.get('${AppConstants.getWishListUri}?search=$search');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }




  @override
  Future<ApiResponseModel> addWishList(int productID) async {
    try {
      final response = await dioClient!.post(AppConstants.addWishListUri + productID.toString());
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> delete(int productID) async {
    try {
      final response = await dioClient!.delete(AppConstants.removeWishListUri + productID.toString());
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future get(String id) {
    throw UnimplementedError();
  }


  @override
  Future update(Map<String, dynamic> body, int id) {
    throw UnimplementedError();
  }
}
