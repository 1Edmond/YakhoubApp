import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/core/di/services/data_sync_service.dart';
import 'package:multishop_tchad/features/customer/product/domain/repositories/seller_product_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'package:multishop_tchad/features/shared/enums/data_source_enum.dart';

class SellerProductRepository extends DataSyncService implements SellerProductRepositoryInterface {
  final DioClient dioClient;
  SellerProductRepository({required this.dioClient, required super.dataSyncRepoInterface});

  @override
  Future<ApiResponseModel> getSellerProductList(
      String slug, String offset, String productId,
      {String search = '',
        String? categoryIds = "[]",
        String? brandIds = "[]",
        String? authorIds = '[]',
        String? publishingIds = '[]',
        String? productType,
      }) async {
    try {
      final response = await dioClient.get(
          '${AppConstants.sellerProductUri}$slug/products?guest_id=1&limit=10&offset=$offset&search=$search&category=$categoryIds&brand_ids=$brandIds&product_id=$productId&product_authors=$authorIds&publishing_houses=$publishingIds&product_type=$productType');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> getSellerWiseBestSellingProductList(String slug, String offset) async {
    try {
      final response = await dioClient.get(
          '${AppConstants.sellerWiseBestSellingProduct}$slug/seller-best-selling-products?guest_id=1&limit=10&offset=$offset');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> getSellerWiseFeaturedProductList(String slug, String offset) async {
    try {
      final response = await dioClient.get('${AppConstants.sellerWiseBestSellingProduct}$slug/seller-featured-product?guest_id=1&limit=10&offset=$offset');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponseModel> getSellerWiseRecommendedProductList(String slug, String offset) async {
    try {
      final response = await dioClient.get(
          '${AppConstants.sellerWiseBestSellingProduct}$slug/seller-recommended-products?guest_id=1&limit=10&offset=$offset');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel<T>> getShopAgainFromRecentStore<T>({required DataSourceEnum source}) async {
    return await fetchData<T>(AppConstants.shopAgainFromRecentStore, source);
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
