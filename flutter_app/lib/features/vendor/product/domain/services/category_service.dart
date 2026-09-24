import 'package:multishop_tchad/features/vendor/product/domain/repositories/category_repository_interface.dart';
import 'package:multishop_tchad/features/vendor/product/domain/services/category_service_interface.dart';

class CategoryService implements CategoryServiceInterface{
  final CategoryRepositoryInterface categoryRepositoryInterface;
  CategoryService({required this.categoryRepositoryInterface});


  @override
  Future getCategoryList(String languageCode) {
    return categoryRepositoryInterface.getCategoryList(languageCode);
  }


}
