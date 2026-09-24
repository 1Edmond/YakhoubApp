import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/vault/auction_search/domain/repositories/auction_search_repo_interface.dart';
import 'package:multishop_tchad/features/vault/auction_search/domain/services/auction_search_service_interface.dart';

class AuctionSearchService implements AuctionSearchServiceInterface {
  AuctionSearchRepoInterface auctionSearchRepoInterface;
  AuctionSearchService({required this.auctionSearchRepoInterface});

  @override
  Future getAuctionSearchList({
    required int offset,
    String auctionStatus = '',
    String search = '',
    int limit = 10,
    Map<String, dynamic> extraParams = const {},
  }) async {
    return await auctionSearchRepoInterface.getAuctionSearchList(
      offset: offset,
      auctionStatus: auctionStatus,
      search: search,
      limit: limit,
      extraParams: extraParams,
    );
  }

  @override
  Future<void> saveAuctionSearchName(String searchText) async {
    return await auctionSearchRepoInterface.saveAuctionSearchName(searchText);
  }

  @override
  List<String> getSavedAuctionSearchNames() {
    return auctionSearchRepoInterface.getSavedAuctionSearchNames();
  }

  @override
  Future<bool> clearSavedAuctionSearchNames() async {
    return await auctionSearchRepoInterface.clearSavedAuctionSearchNames();
  }

  @override
  Future<ApiResponseModel> getAuctionSuggestionProductName(String name) async {
    return await auctionSearchRepoInterface.getAuctionSuggestionProductName(name);
  }

  @override
  Future<ApiResponseModel> getAuctionPopularTags({int limit = 10}) async {
    return await auctionSearchRepoInterface.getAuctionPopularTags(limit: limit);
  }

}
