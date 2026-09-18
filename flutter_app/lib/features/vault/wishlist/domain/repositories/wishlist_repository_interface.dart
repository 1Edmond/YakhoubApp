import 'package:flutter_sixvalley_ecommerce/core/models/api_response.dart';

abstract class WishListRepositoryInterface {
  Future<ApiResponseModel> getWishList({int? offset = 1, String? search = ''});
  Future<ApiResponseModel> addWishList(int productID);
  Future<dynamic> delete(int id);
  Future<dynamic> getList({int? offset = 1});
}
