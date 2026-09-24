
import 'package:multishop_tchad/core/models/response/base/api_response.dart';
import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class BarcodeRepositoryInterface implements RepositoryInterface{
  Future<ApiResponse> barCodeDownLoad(int? id, int quantity);
}
