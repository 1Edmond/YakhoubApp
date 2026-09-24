import 'package:multishop_tchad/core/models/api_response.dart';

abstract class AuctionCheckoutRepositoryInterface {
  Future<ApiResponseModel> claimAuction(Map<String, dynamic> data);
  Future<ApiResponseModel> offlinePaymentList();
}
