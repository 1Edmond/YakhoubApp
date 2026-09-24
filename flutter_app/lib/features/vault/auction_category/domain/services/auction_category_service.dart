import 'package:multishop_tchad/features/shared/enums/data_source_enum.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/vault/auction_category/domain/repositories/auction_category_repo_interface.dart';
import 'package:multishop_tchad/features/vault/auction_category/domain/services/auction_category_service_interface.dart';

class AuctionCategoryService implements AuctionCategoryServiceInterface {
  AuctionCategoryRepoInterface auctionCategoryRepoInterface;
  AuctionCategoryService({required this.auctionCategoryRepoInterface});

  @override
  Future<ApiResponseModel<T>> getList<T>({required DataSourceEnum source}) async {
    return await auctionCategoryRepoInterface.getAuctionCategoryList(source: source);
  }

  @override
  Future<ApiResponseModel<T>> getCategoryProductList<T>({
    required int categoryId,
    required int offset,
    required DataSourceEnum source,
    String searchProduct = '',
  }) async {
    return await auctionCategoryRepoInterface.getCategoryProductList(categoryId: categoryId, offset: offset, source: source, searchProduct: searchProduct);
  }
}
