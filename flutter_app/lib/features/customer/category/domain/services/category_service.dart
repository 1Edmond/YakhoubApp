import 'package:multishop_tchad/features/shared/enums/data_source_enum.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/customer/category/domain/repositories/category_repo_interface.dart';
import 'package:multishop_tchad/features/customer/category/domain/services/category_service_interface.dart';

class CategoryService implements CategoryServiceInterface{
  CategoryRepoInterface categoryRepoInterface;
  CategoryService({required this.categoryRepoInterface});

  @override
  Future<ApiResponseModel<T>> getList<T>({required DataSourceEnum source}) async{
    return await categoryRepoInterface.getCategoryList(source: source);
  }

  @override
  Future getSellerWiseCategoryList(String slug) async{
    return await categoryRepoInterface.getSellerWiseCategoryList(slug);
  }

}
