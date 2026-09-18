import 'package:flutter_sixvalley_ecommerce/core/models/api_response.dart';

abstract class AuctionCheckoutRepositoryInterface {
  Future<ApiResponseModel> claimAuction(Map<String, dynamic> data);
  Future<ApiResponseModel> offlinePaymentList();
}
