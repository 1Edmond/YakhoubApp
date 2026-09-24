import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class AuctionProductQueueRepositoryInterface implements RepositoryInterface {
  Future<ApiResponseModel> getAuctionProductQueueList({
    required int offset,
    required String approvalStatus,
    int limit = 10,
  });

  Future<ApiResponseModel> deleteAuctionProduct(int id);
}
