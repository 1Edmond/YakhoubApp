import 'package:flutter_sixvalley_ecommerce/features/shared/enums/data_source_enum.dart';
import 'package:flutter_sixvalley_ecommerce/core/models/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/core/interfaces/repo_interface.dart';

abstract class BannerRepositoryInterface<T> implements RepositoryInterface{
  Future<ApiResponseModel<T>> getBannerList<T>({required DataSourceEnum source});


}
