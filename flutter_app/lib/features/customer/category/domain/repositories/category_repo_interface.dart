import 'package:multishop_tchad/features/shared/enums/data_source_enum.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class CategoryRepoInterface extends RepositoryInterface{
  Future<dynamic> getSellerWiseCategoryList(String slug);

  Future<ApiResponseModel<T>> getCategoryList<T>({required DataSourceEnum source});


}
