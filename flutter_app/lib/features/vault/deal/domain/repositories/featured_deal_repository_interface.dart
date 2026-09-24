import 'package:multishop_tchad/features/shared/enums/data_source_enum.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class FeaturedDealRepositoryInterface implements RepositoryInterface {
  Future<ApiResponseModel<T>> getFeaturedDeal<T>({required DataSourceEnum source});
}
