import 'package:flutter_sixvalley_ecommerce/features/shared/enums/data_source_enum.dart';
import 'package:flutter_sixvalley_ecommerce/core/models/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/core/interfaces/repo_interface.dart';

abstract class CategoryRepoInterface extends RepositoryInterface{
  Future<dynamic> getSellerWiseCategoryList(String slug);

  Future<ApiResponseModel<T>> getCategoryList<T>({required DataSourceEnum source});


}
