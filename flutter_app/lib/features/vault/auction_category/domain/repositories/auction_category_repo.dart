import 'package:multishop_tchad/features/shared/enums/data_source_enum.dart';
import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/core/di/services/data_sync_service.dart';
import 'package:multishop_tchad/features/vault/auction_category/domain/repositories/auction_category_repo_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';

class AuctionCategoryRepository extends DataSyncService implements AuctionCategoryRepoInterface {
  final DioClient? dioClient;
  AuctionCategoryRepository({required this.dioClient, required super.dataSyncRepoInterface});

  @override
  Future<ApiResponseModel> getList({int? offset}) async {
    try {
      final response = await dioClient!.get(AppConstants.auctionCategoriesUri);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel<T>> getCategoryProductList<T>({
    required int categoryId,
    required int offset,
    required DataSourceEnum source,
    String searchProduct = '',
  }) async {

    final String searchQuery = searchProduct.isNotEmpty ? '&search=$searchProduct' : '';
    final String cacheUrl = '${AppConstants.auctionCategoryProductListUri}?category_id=$categoryId&offset=1&limit=10$searchQuery';

    if (offset == 1 && source == DataSourceEnum.local) {
      return await dataSyncRepoInterface.fetchData<T>(cacheUrl, DataSourceEnum.local);
    }

    try {
      final Map<String, dynamic> fields = {};
      fields['category_id'] = categoryId;
      fields['limit'] = 10;
      fields['offset'] = offset;
      if (searchProduct.isNotEmpty) fields['search'] = searchProduct;

      final response = await dioClient!.post(
        AppConstants.auctionCategoryProductListUri,
        data: fields,
      );
      return ApiResponseModel.withSuccess(response) as ApiResponseModel<T>;
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
  Future update(Map<String, dynamic> body, int id) {
    throw UnimplementedError();
  }

  @override
  Future<ApiResponseModel<T>> getAuctionCategoryList<T>({required DataSourceEnum source}) async {
    return await fetchData<T>(AppConstants.auctionCategoriesUri, source);
  }
}
