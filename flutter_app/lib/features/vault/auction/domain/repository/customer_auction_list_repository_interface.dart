import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

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
