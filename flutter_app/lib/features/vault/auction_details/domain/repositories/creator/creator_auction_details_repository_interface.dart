import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/vault/auction_details/domain/enum/creator/auction_delivery_status_enum.dart';
import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class CreatorAuctionDetailsRepositoryInterface implements RepositoryInterface {
  Future<ApiResponseModel> getAuctionDetails(String slug);

  Future<ApiResponseModel> getAuctionBidList({required int auctionProductId, int offset = 1, int limit = 10});
  Future<ApiResponseModel> uploadTrackingUrl(int auctionProductId, String trackingUrl);
  Future<ApiResponseModel> updateDeliveryStatus(int auctionProductId, AuctionDeliveryStatus status);
}
