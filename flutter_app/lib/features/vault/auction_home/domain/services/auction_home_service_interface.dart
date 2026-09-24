import 'package:multishop_tchad/features/shared/enums/data_source_enum.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/vault/auction_home/domain/auction_enum.dart';

abstract class AuctionHomeServiceInterface {
  Future<ApiResponseModel<T>> getAuctionHomeSection<T>({
    required AuctionEnum section,
    required DataSourceEnum source,
    required int offset,
    int? categoryId,
    int? ownerId,
  });

  Future<ApiResponseModel> getRecentlyViewedAuctionList({int offset = 1});
}
