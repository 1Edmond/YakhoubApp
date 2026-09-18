import 'package:flutter_sixvalley_ecommerce/features/shared/enums/data_source_enum.dart';
import 'package:flutter_sixvalley_ecommerce/core/models/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_home/domain/auction_enum.dart';
import 'package:flutter_sixvalley_ecommerce/core/interfaces/repo_interface.dart';

abstract class AuctionHomeRepoInterface extends RepositoryInterface {
  Future<ApiResponseModel<T>> getAuctionHomeSection<T>({
    required AuctionEnum section,
    required DataSourceEnum source,
    required int offset,
    int? categoryId,
    int? ownerId,
  });

  Future<ApiResponseModel> getRecentlyViewedAuctionList({int offset = 1});
}
