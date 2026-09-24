import 'package:multishop_tchad/features/shared/enums/data_source_enum.dart';
import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/core/di/services/data_sync_service.dart';
import 'package:multishop_tchad/features/customer/brand/domain/repositories/brand_repo_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';

class BrandRepository extends DataSyncService implements BrandRepoInterface {
  final DioClient dioClient;
  BrandRepository(
      {required this.dioClient, required super.dataSyncRepoInterface});

  @override
  Future<ApiResponseModel<T>> getBrandList<T>({int offset = 1, required DataSourceEnum source}) async {
    return await fetchData<T>(
        '${AppConstants.brandUri}&limit=24&offset=$offset', source);
  }

  @override
  Future<ApiResponseModel> getSellerWiseBrandList(String slug) async {
    try {
      final response =
          await dioClient.get('${AppConstants.sellerWiseBrandList}$slug');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
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
  Future update(Map<String, dynamic> body, int id) {
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset = 1}) {
    throw UnimplementedError();
  }
}
