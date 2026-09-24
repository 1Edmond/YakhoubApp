import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class CompareRepositoryInterface<T> extends RepositoryInterface{

  Future<dynamic> addCompareProductList(int id);
  Future<dynamic> removeAllCompareProductList();
  Future<dynamic> replaceCompareProductList(int compareId, int productId);
  Future<dynamic> getAttributeList();
}
