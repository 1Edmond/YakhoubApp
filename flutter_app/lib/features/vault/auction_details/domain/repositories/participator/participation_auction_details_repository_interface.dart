import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class ParticipationAuctionDetailsRepositoryInterface
    implements RepositoryInterface {

  Future<ApiResponseModel> getAuctionProductOverview({
    required String slug,
    String? auctionStatus,
    int productStatus = 0,
  });

  Future<ApiResponseModel> getAuctionBidList({
    required int auctionProductId,
    bool isMyBid = false,
    int offset = 1,
    int limit = 10,
  });
}
