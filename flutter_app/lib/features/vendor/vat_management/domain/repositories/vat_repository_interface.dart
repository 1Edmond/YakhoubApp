import 'package:multishop_tchad/core/models/response/base/api_response.dart';
import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class VatRepositoryInterface implements RepositoryInterface {

  Future<ApiResponse> getVatReport(int? limit, int? offset, String? startDate, String? endDate);

}
