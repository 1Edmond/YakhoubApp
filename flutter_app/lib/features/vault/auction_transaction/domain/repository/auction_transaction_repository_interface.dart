import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class AuctionTransactionRepositoryInterface implements RepositoryInterface {
  Future<ApiResponseModel> getAuctionTransactionList({
    int? searchAuctionId,
    int limit = 10,
    int offset = 1,
    String? filterBy,
    String? filterDurationType,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<ApiResponseModel> getSalesReport({required String dateType, String? startDate, String? endDate});
}
