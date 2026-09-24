import 'package:multishop_tchad/core/enums/data_source_enum.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class DataSyncRepoInterface extends RepositoryInterface {
  Future<ApiResponseModel<T>> fetchData<T>(String uri, DataSourceEnum source);
}
