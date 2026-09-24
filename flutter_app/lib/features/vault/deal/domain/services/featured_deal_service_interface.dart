import 'package:multishop_tchad/features/shared/enums/data_source_enum.dart';
import 'package:multishop_tchad/core/models/api_response.dart';

abstract class FeaturedDealServiceInterface {
  Future<ApiResponseModel<T>> getFeaturedDeal<T>({required DataSourceEnum source});
}
