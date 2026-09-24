import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class UserCreatedAuctionListRepositoryInterface implements RepositoryInterface {
  Future<ApiResponseModel> getMyAuctionList({required int offset, required String auctionStatus, int limit = 10, bool includeCounts = false});
}
