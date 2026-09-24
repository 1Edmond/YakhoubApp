import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/core/di/services/data_sync_service.dart';
import 'package:multishop_tchad/features/vault/deal/domain/repositories/featured_deal_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'package:multishop_tchad/features/shared/enums/data_source_enum.dart';

class FeaturedDealRepository extends DataSyncService implements FeaturedDealRepositoryInterface {
  final DioClient dioClient;
  FeaturedDealRepository({required this.dioClient, required super.dataSyncRepoInterface});

  @override
  Future<ApiResponseModel<T>> getFeaturedDeal<T>({required DataSourceEnum source}) async {
    return await fetchData<T>(AppConstants.featuredDealUri, source);
  }

  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset = 1}) {
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    throw UnimplementedError();
  }
}
