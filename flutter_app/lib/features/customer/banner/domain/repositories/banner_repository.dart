import 'package:multishop_tchad/features/shared/enums/data_source_enum.dart';
import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/core/di/services/data_sync_service.dart';
import 'package:multishop_tchad/features/customer/banner/domain/repositories/banner_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';

class BannerRepository extends DataSyncService implements BannerRepositoryInterface{
  final DioClient? dioClient;
  BannerRepository({required this.dioClient, required super.dataSyncRepoInterface});

  @override
  Future<ApiResponseModel<T>> getBannerList<T>({required DataSourceEnum source}) async {
    return await fetchData<T>(AppConstants.getBannerList,  source);

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
  Future update(Map<String, dynamic> body, int id) {
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
}
