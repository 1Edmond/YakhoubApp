
import 'package:multishop_tchad/core/di/model/response/base/api_response.dart';
import 'package:multishop_tchad/features/vendor/product/domain/models/filter_model.dart';
import 'package:multishop_tchad/features/vendor/interface/repository_interface.dart';

abstract class ProductRepositoryInterface implements RepositoryInterface{
  Future<ApiResponse> getSellerProductList({
    required String sellerId,
    required int offset,
    required String languageCode,
    required String search,
    FilterModel? filterModel,
  });

  Future<ApiResponse> getPosProductList(int offset, List <String> ids);
  Future<ApiResponse> getStockLimitStatus();
  Future<ApiResponse> getSearchedPosProductList(String search, List <String> ids);
  Future<ApiResponse> getStockLimitedProductList(int offset, String languageCode );
  Future<ApiResponse> getMostPopularProductList(int offset, String languageCode );
  Future<ApiResponse> getTopSellingProductList(int offset, String languageCode );
  bool isShowCookies();
  Future<void> setIsShowCookies();
  Future<void> removeShowCookies();
  Future<ApiResponse> getBrandList(String languageCode);


}
