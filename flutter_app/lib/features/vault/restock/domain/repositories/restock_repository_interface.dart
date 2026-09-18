import 'package:flutter_sixvalley_ecommerce/core/interfaces/repo_interface.dart';

abstract class RestockRepositoryInterface<T> extends RepositoryInterface{

  Future<dynamic> reorder(String orderId);

  Future<dynamic> getRestockProductList(String offset, bool getAll);

  Future<dynamic> deleteRestockProduct(String? type, String? id);
}
