import 'package:multishop_tchad/features/shared/enums/data_source_enum.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class AuctionCategoryRepoInterface extends RepositoryInterface {
  Future<ApiResponseModel<T>> getAuctionCategoryList<T>({required DataSourceEnum source});

  Future<ApiResponseModel<T>> getCategoryProductList<T>({required int categoryId, required int offset, required DataSourceEnum source, String searchProduct});
}
