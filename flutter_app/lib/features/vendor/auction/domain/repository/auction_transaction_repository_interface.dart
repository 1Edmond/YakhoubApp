import 'package:flutter_sixvalley_ecommerce/core/models/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/core/interfaces/repo_interface.dart';

abstract class AuctionTransactionRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> getAuctionTransactionList({
    int? searchAuctionId,
    int limit = 10,
    int offset = 1,
    List<String>? transactionTypes,
    String? filterDurationType,
    String? startDate,
    String? endDate,
  });
}
