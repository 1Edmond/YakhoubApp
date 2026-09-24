import 'package:multishop_tchad/core/enums/data_source_enum.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/data/reposotories/data_sync_repo_interface.dart';
import 'package:multishop_tchad/data/services/data_sync_service_interface.dart';

class DataSyncService implements DataSyncServiceInterface {
  DataSyncRepoInterface dataSyncRepoInterface;

  DataSyncService({required this.dataSyncRepoInterface});

  @override
  Future<ApiResponseModel<T>> fetchData<T>(String uri, DataSourceEnum source) async {
    return await dataSyncRepoInterface.fetchData(uri, source);
  }
}
