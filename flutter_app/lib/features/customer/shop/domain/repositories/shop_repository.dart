import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/core/di/services/data_sync_service.dart';
import 'package:multishop_tchad/features/customer/shop/domain/repositories/shop_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'package:multishop_tchad/features/shared/enums/data_source_enum.dart';

class ShopRepository extends DataSyncService implements ShopRepositoryInterface {
  final DioClient dioClient;
  ShopRepository({required this.dioClient, required super.dataSyncRepoInterface});

  @override
  Future<ApiResponseModel> get(String sellerId) async {
    try {
      final response = await dioClient.get("${AppConstants.sellerUri}$sellerId");
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel<T>> getMoreStore<T>({required DataSourceEnum source}) async {
    return await fetchData<T>(AppConstants.moreStore, source);
  }

  @override
  Future<ApiResponseModel<T>> getSellerList<T>({required String type, required int offset, required int limit, required DataSourceEnum source}) async {
    return await fetchData<T>('${AppConstants.sellerList}$type?limit=$limit&offset=$offset', source);
  }



  @override
  Future<ApiResponseModel> getClearanceShopProductList(String type, String offset, String sellerId) async {
    try {
      final response = await dioClient.get(
          '${AppConstants.clearanceShopProductUri}$sellerId/products?guest_id=1&limit=10&offset=$offset&offer_type=$type');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponseModel> getClearanceSearchProduct(String sellerId, String offset, String productId, {String search = '', String? categoryIds="[]", String? brandIds="[]", String? authorIds ='[]', String? publishingIds = '[]', String? productType, String? offerType}) async {
    try {
      final response = await dioClient.get(
          '${AppConstants.clearanceShopSearchProductUri}$sellerId/products?guest_id=1&limit=10&offset=$offset&search=$search&category=$categoryIds&brand_ids=$brandIds&product_id=$productId&product_authors=$authorIds&publishing_houses=$publishingIds&product_type=$productType&offer_type=$offerType');
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
