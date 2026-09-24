import 'package:multishop_tchad/core/di/model/response/base/api_response.dart';
import 'package:multishop_tchad/features/vendor/interface/repository_interface.dart';

abstract class CategoryRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> getCategoryList(String languageCode);

}
