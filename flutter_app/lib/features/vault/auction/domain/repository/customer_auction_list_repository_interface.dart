import 'package:flutter_sixvalley_ecommerce/core/models/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/core/interfaces/repo_interface.dart';

abstract class CustomerAuctionListRepositoryInterface implements RepositoryInterface {
  Future<ApiResponseModel> getCustomerAuctionList({
    required int limit,
    required int offset,
    String? status,
    String? auctionStatus,
  });

  Future<ApiResponseModel> getCustomerSavedAuctionList({
    required int limit,
    required int offset,
  });
}
