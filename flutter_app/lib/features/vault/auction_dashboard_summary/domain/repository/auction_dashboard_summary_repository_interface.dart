import 'package:flutter_sixvalley_ecommerce/core/models/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/core/interfaces/repo_interface.dart';

abstract class AuctionDashboardSummaryRepositoryInterface implements RepositoryInterface {
  Future<ApiResponseModel> getAuctionDashboardSummary();
}
