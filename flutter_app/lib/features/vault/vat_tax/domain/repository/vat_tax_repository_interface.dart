import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class VatTaxRepositoryInterface implements RepositoryInterface{
  Future<ApiResponseModel> getVatTaxList();
}
