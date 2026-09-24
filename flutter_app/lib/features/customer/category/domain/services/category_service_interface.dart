
import 'package:multishop_tchad/features/shared/enums/data_source_enum.dart';
import 'package:multishop_tchad/core/models/api_response.dart';

abstract class CategoryServiceInterface {

  Future<dynamic> getSellerWiseCategoryList(String slug);
  Future<ApiResponseModel<T>> getList<T>({required DataSourceEnum source});


}
