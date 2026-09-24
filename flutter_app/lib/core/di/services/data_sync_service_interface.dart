import 'package:multishop_tchad/core/enums/data_source_enum.dart';
import 'package:multishop_tchad/core/models/api_response.dart';

abstract class DataSyncServiceInterface {
  Future<ApiResponseModel<T>> fetchData<T>(String uri, DataSourceEnum source);
}
